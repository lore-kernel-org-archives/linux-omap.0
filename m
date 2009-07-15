From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 02/13] DSPBRIDGE: PROCWRAP_Load function cleanup in a complete mess
Date: Wed, 15 Jul 2009 17:56:25 +0300
Message-ID: <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35436 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbZGOO4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:42 -0400
In-Reply-To: <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

If you followed some failure paths, it was entirely possible that
you'd attempt to MEM_Free a user-space pointer, because it wouldn't
have been replaced with a kernel-space copy yet. Now ensure there's
a NULL pointer to stop the cleanup at the position of the first error.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |  114 +++++++++++++++++++++++-----------------
 1 files changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index b8adb41..8111b60 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -880,99 +880,115 @@ u32 PROCWRAP_Load(union Trapped_Args *args)
 {
 	s32 i, len;
 	DSP_STATUS status = DSP_SOK;
-       char *temp;
-	s32 argc = args->ARGS_PROC_LOAD.iArgc;
+	char *temp;
+	s32 count = args->ARGS_PROC_LOAD.iArgc;
 	u8 **argv, **envp = NULL;
 
+	DBC_Require(count > 0);
+	DBC_Require(count <= MAX_LOADARGS);
 
-	DBC_Require(argc > 0);
-	DBC_Require(argc <= MAX_LOADARGS);
-
-	argv = MEM_Alloc(argc * sizeof(u8 *), MEM_NONPAGED);
-	if (argv == NULL)
+	argv = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
+	if (!argv) {
 		status = DSP_EMEMORY;
+		goto func_cont;
+	}
 
-	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, argc);
-	if (DSP_FAILED(status))
+	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, count);
+	if (DSP_FAILED(status)) {
+		MEM_Free(argv);
+		argv = NULL;
 		goto func_cont;
+	}
 
-	for (i = 0; DSP_SUCCEEDED(status) && (i < argc); i++) {
-		if (argv[i] != NULL) {
-                        /* User space pointer to argument */
-                       temp = (char *) argv[i];
+	for (i = 0; DSP_SUCCEEDED(status) && (i < count); i++) {
+		if (argv[i]) {
+			/* User space pointer to argument */
+			temp = (char *) argv[i];
 			/* len is increased by 1 to accommodate NULL */
 			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
 			argv[i] = MEM_Alloc(len, MEM_NONPAGED);
-			if (argv[i] == NULL) {
+			if (argv[i]) {
+				cp_fm_usr(argv[i], temp, status, len);
+				if (DSP_FAILED(status)) {
+					MEM_Free(argv[i]);
+					argv[i] = NULL;
+					goto func_cont;
+				}
+			} else {
 				status = DSP_EMEMORY;
-				break;
-			}
-			cp_fm_usr(argv[i], temp, status, len);
-			if (DSP_FAILED(status))
 				goto func_cont;
+			}
 		}
 	}
 	/* TODO: validate this */
-	if (args->ARGS_PROC_LOAD.aEnvp != NULL) {
+	if (args->ARGS_PROC_LOAD.aEnvp) {
 		/* number of elements in the envp array including NULL */
-		len = 0;
+		count = 0;
 		do {
-			len++;
-                       get_user(temp, args->ARGS_PROC_LOAD.aEnvp);
-               } while (temp);
-		envp = MEM_Alloc(len * sizeof(u8 *), MEM_NONPAGED);
-		if (envp == NULL) {
+			get_user(temp, args->ARGS_PROC_LOAD.aEnvp + count);
+			count++;
+		} while (temp);
+		envp = MEM_Alloc(count * sizeof(u8 *), MEM_NONPAGED);
+		if (!envp) {
 			status = DSP_EMEMORY;
 			goto func_cont;
 		}
 
-		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, len);
-		if (DSP_FAILED(status))
+		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, count);
+		if (DSP_FAILED(status)) {
+			MEM_Free(envp);
+			envp = NULL;
 			goto func_cont;
-		for (i = 0; DSP_SUCCEEDED(status) && (envp[i] != NULL); i++) {
-                        /* User space pointer to argument */
-                       temp = (char *)envp[i];
+		}
+		for (i = 0; DSP_SUCCEEDED(status) && envp[i]; i++) {
+			/* User space pointer to argument */
+			temp = (char *)envp[i];
 			/* len is increased by 1 to accommodate NULL */
 			len = strlen_user((char *)temp) + 1;
 			/* Kernel space pointer to argument */
 			envp[i] = MEM_Alloc(len, MEM_NONPAGED);
-			if (envp[i] == NULL) {
+			if (envp[i]) {
+				cp_fm_usr(envp[i], temp, status, len);
+				if (DSP_FAILED(status)) {
+					MEM_Free(envp[i]);
+					envp[i] = NULL;
+					goto func_cont;
+				}
+			} else {
 				status = DSP_EMEMORY;
-				break;
-			}
-			cp_fm_usr(envp[i], temp, status, len);
-			if (DSP_FAILED(status))
 				goto func_cont;
+			}
 		}
 	}
 	GT_5trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_Load, hProcessor: 0x%x\n\tiArgc:"
-		 "0x%x\n\taArgv: 0x%x\n\taArgv[0]: %s\n\taEnvp: 0x%0x\n",
-		 args->ARGS_PROC_LOAD.hProcessor,
-		 args->ARGS_PROC_LOAD.iArgc, args->ARGS_PROC_LOAD.aArgv,
-		 argv[0], args->ARGS_PROC_LOAD.aEnvp);
+		"PROCWRAP_Load, hProcessor: 0x%x\n\tiArgc:"
+		"0x%x\n\taArgv: 0x%x\n\taArgv[0]: %s\n\taEnvp: 0x%0x\n",
+		args->ARGS_PROC_LOAD.hProcessor,
+		args->ARGS_PROC_LOAD.iArgc, args->ARGS_PROC_LOAD.aArgv,
+		argv[0], args->ARGS_PROC_LOAD.aEnvp);
 	if (DSP_SUCCEEDED(status)) {
 		status = PROC_Load(args->ARGS_PROC_LOAD.hProcessor,
-				  args->ARGS_PROC_LOAD.iArgc,
-				  (CONST char **)argv, (CONST char **)envp);
+				args->ARGS_PROC_LOAD.iArgc,
+				(CONST char **)argv, (CONST char **)envp);
 	}
 func_cont:
-	if (envp != NULL) {
+	if (envp) {
 		i = 0;
-		while (envp[i] != NULL)
+		while (envp[i])
 			MEM_Free(envp[i++]);
 
 		MEM_Free(envp);
 	}
-	if (argv != NULL) {
-		for (i = 0; i < argc; i++) {
-			if (argv[i] != NULL)
-				MEM_Free(argv[i]);
 
-		}
+	if (argv) {
+		count = args->ARGS_PROC_LOAD.iArgc;
+		for (i = 0; (i < count) && argv[i]; i++)
+			MEM_Free(argv[i]);
+
 		MEM_Free(argv);
 	}
+
 	return status;
 }
 
-- 
1.6.2.4

