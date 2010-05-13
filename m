From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Include missing info in MMU Fault debugging trace
Date: Thu, 13 May 2010 10:15:48 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060093592785@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758993Ab0EMPPx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 11:15:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Jansson, Cris" <cjansson@ti.com>

Some execution info is missing at the beginning of the trace buffer printout. This fix is to include this information according to the buffer contents description and also couple of cosmetic changes to make the traces more readable.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |   44 ++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c index 1a5f794..f52c7b3 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1960,9 +1960,9 @@ dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
 		if (DSP_FAILED(status))
 			goto func_end;
 		/* Pack and do newline conversion */
-		pr_info("%s: DSP Trace Buffer Begin:\n"
+		pr_info("DSP Trace Buffer Begin:\n"
 			"=======================\n%s\n",
-			__func__, psz_buf);
+			psz_buf);
 
 
 		/* convert to offset */
@@ -2069,6 +2069,7 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 		u32 size;
 	} mmu_fault_dbg_info;
 	u32 *buffer;
+	u32 *buffer_beg;
 	u32 *buffer_end;
 	u32 exc_type;
 	u32 i;
@@ -2078,6 +2079,7 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 	const char *dsp_regs[] = {"EFR", "IERR", "ITSR", "NTSR",
 				"IRP", "NRP", "AMR", "SSR",
 				"ILC", "RILC", "IER", "CSR"};
+	const char *exec_ctxt[] = {"Task", "SWI", "HWI", "Unknown"};
 	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *dev_object = wmd_context->hdev_obj;
 
@@ -2147,6 +2149,7 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 			total_size = MAX_MMU_DBGBUFF;
 
 		buffer = mem_calloc(total_size, MEM_NONPAGED);
+		buffer_beg = buffer;
 		buffer_end =  buffer + total_size / 4;
 
 		if (!buffer) {
@@ -2166,7 +2169,7 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 			goto func_end;
 		}
 
-		pr_err("Aproximate Crash Position:\n");
+		pr_err("\nAproximate Crash Position:\n");
 		pr_err("--------------------------\n");
 
 		exc_type = buffer[3];
@@ -2182,7 +2185,27 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 		else
 			pr_err("0x%-8x [Unable to match to a symbol.]\n", i);
 
-		pr_err("Execution Info:\n");
+		buffer += 4;
+
+		pr_err("\nExecution Info:\n");
+		pr_err("---------------\n");
+
+		if (*buffer < ARRAY_SIZE(exec_ctxt)) {
+			pr_err("Execution context \t%s\n",
+				exec_ctxt[*buffer++]);
+		} else {
+			pr_err("Execution context corrupt\n");
+			kfree(buffer_beg);
+			return -EFAULT;
+		}
+		pr_err("Task Handle\t\t0x%x\n", *buffer++);
+		pr_err("Stack Pointer\t\t0x%x\n", *buffer++);
+		pr_err("Stack Top\t\t0x%x\n", *buffer++);
+		pr_err("Stack Bottom\t\t0x%x\n", *buffer++);
+		pr_err("Stack Size\t\t0x%x\n", *buffer++);
+		pr_err("Stack Size In Use\t0x%x\n", *buffer++);
+
+		pr_err("\nCPU Registers\n");
 		pr_err("---------------\n");
 
 		for (i = 0; i < 32; i++) {
@@ -2216,16 +2239,21 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 			if (i == 4 || i == 6 || i == 8)
 				pr_err("B%d 0x%-8x [Function Argument %d]\n",
 							i, *buffer++, i-2);
-			else if (i == 15)
+			else if (i == 14)
 				pr_err("B14 0x%-8x [Data Page Pointer]\n",
 								*buffer++);
 			else
 				pr_err("B%d 0x%x\n", i, *buffer++);
 		}
 
+		pr_err("\n");
+
 		for (i = 0; i < ARRAY_SIZE(dsp_regs); i++)
 			pr_err("%s 0x%x\n", dsp_regs[i], *buffer++);
 
+		pr_err("\nStack:\n");
+		pr_err("------\n");
+
 		for (i = 0; buffer < buffer_end; i++, buffer++) {
 			if ((*buffer > 0x01000000) && (node_find_addr(node_mgr,
 				*buffer , 0x600, &offset_output, name) == @@ -2236,7 +2264,7 @@ dsp_status dump_dsp_stack(struct wmd_dev_context *wmd_context)
 			else
 				pr_err("[%d] 0x%x\n", i, *buffer);
 		}
-		kfree(buffer - total_size / 4);
+		kfree(buffer_beg);
 	}
 func_end:
 	return status;
@@ -2301,8 +2329,8 @@ void dump_dl_modules(struct wmd_dev_context *wmd_context)
 	pr_debug("%s: dll_module_header 0x%x %d\n", __func__, module_dsp_addr,
 								module_size);
 
-	pr_err("%s: \nDynamically Loaded Modules:\n"
-		"---------------------------\n", __func__);
+	pr_err("\nDynamically Loaded Modules:\n"
+		"---------------------------\n");
 
 	/* For each dll_module structure in the list... */
 	while (module_size) {
--
1.5.4.5

