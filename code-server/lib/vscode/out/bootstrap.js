"use strict";(function(c,t){typeof exports=="object"?module.exports=t():c.MonacoBootstrap=t()})(this,function(){const c=typeof require=="function"?require("module"):void 0,t=typeof require=="function"?require("path"):void 0,u=typeof require=="function"?require("fs"):void 0;Error.stackTraceLimit=100,typeof process!="undefined"&&process.on("SIGPIPE",()=>{console.error(new Error("Unexpected SIGPIPE"))});function _(n){if(!t||!c||typeof process=="undefined"){console.warn("enableASARSupport() is only available in node.js environments");return}let e=n?t.join(n,"node_modules"):void 0;e?process.platform==="win32"&&(e=__dirname.substr(0,1)+e.substr(1)):e=t.join(__dirname,"../node_modules");const o=`${e}.asar`,r=c._resolveLookupPaths;c._resolveLookupPaths=function(p,a){const s=r(p,a);if(Array.isArray(s)){for(let i=0,l=s.length;i<l;i++)if(s[i]===e){s.splice(i,0,o);break}}return s}}function h(n,e){let o=n.replace(/\\/g,"/");o.length>0&&o.charAt(0)!=="/"&&(o=`/${o}`);let r;return e.isWindows&&o.startsWith("//")?r=encodeURI(`${e.scheme||"file"}:${o}`):r=encodeURI(`${e.scheme||"file"}://${e.fallbackAuthority||""}${o}`),r.replace(/#/g,"%23")}function g(){const n=N();let e={availableLanguages:{}};if(n&&n.env.VSCODE_NLS_CONFIG)try{e=JSON.parse(n.env.VSCODE_NLS_CONFIG)}catch(o){}if(e._resolvedLanguagePackCoreLocation){const o=Object.create(null);e.loadBundle=function(r,p,a){const s=o[r];if(s){a(void 0,s);return}S(e._resolvedLanguagePackCoreLocation,`${r.replace(/\//g,"!")}.nls.json`).then(function(i){const l=JSON.parse(i);o[r]=l,a(void 0,l)}).catch(i=>{try{e._corruptedFile&&v(e._corruptedFile,"corrupted").catch(function(l){console.error(l)})}finally{a(i,void 0)}})}}return e}function f(){return(typeof self=="object"?self:typeof global=="object"?global:{}).vscode}function N(){if(typeof process!="undefined")return process;const n=f();if(n)return n.process}function d(){const n=f();if(n)return n.ipcRenderer}async function S(...n){const e=d();if(e)return e.invoke("vscode:readNlsFile",...n);if(u&&t)return(await u.promises.readFile(t.join(...n))).toString();throw new Error("Unsupported operation (read NLS files)")}function v(n,e){const o=d();if(o)return o.invoke("vscode:writeNlsFile",n,e);if(u)return u.promises.writeFile(n,e);throw new Error("Unsupported operation (write NLS files)")}function y(){if(typeof process=="undefined"){console.warn("avoidMonkeyPatchFromAppInsights() is only available in node.js environments");return}process.env.APPLICATION_INSIGHTS_NO_DIAGNOSTIC_CHANNEL=!0,global.diagnosticsSource={}}return{enableASARSupport:_,avoidMonkeyPatchFromAppInsights:y,setupNLS:g,fileUriFromPath:h}});

//# sourceMappingURL=bootstrap.js.map
