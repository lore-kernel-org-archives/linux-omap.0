From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCHv3] DSPBRIDGE: Include missing info in MMU Fault debugging trace
Date: Thu, 10 Jun 2010 17:24:33 -0500
Message-ID: <1276208673-6251-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53618 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927Ab0FJWVw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 18:21:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, felipe.contreras@nokia.com, Ernesto Ramos <ernesto@ti.com>

Some execution info is missing at the beginning of the
trace buffer printout. This fix is to include this information
according to the buffer contents description and
also couple of cosmetic changes to make the traces more
readable.

This fix also uses DYNEXTBASE address to filter symbols that
match low addresses in the hash table and are not useful to
print. Any address below DYNEXTBASE is not valid for the DSP.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/core/io_sm.c |   72 +++++++++++++++++++++++++++++----------
 1 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 53753ce..0f9e1b1 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -1948,9 +1948,9 @@ int print_dsp_trace_buffer(struct bridge_dev_context *hbridge_context)
 		if (DSP_FAILED(status))
 			goto func_end;
 		/* Pack and do newline conversion */
-		pr_info("%s: DSP Trace Buffer Begin:\n"
+		pr_info("DSP Trace Buffer Begin:\n"
 			"=======================\n%s\n",
-			__func__, psz_buf);
+			psz_buf);
 
 
 		/* convert to offset */
@@ -2057,8 +2057,10 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 		u32 size;
 	} mmu_fault_dbg_info;
 	u32 *buffer;
+	u32 *buffer_beg;
 	u32 *buffer_end;
 	u32 exc_type;
+	u32 dyn_ext_base;
 	u32 i;
 	u32 offset_output;
 	u32 total_size;
@@ -2066,6 +2068,7 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 	const char *dsp_regs[] = {"EFR", "IERR", "ITSR", "NTSR",
 				"IRP", "NRP", "AMR", "SSR",
 				"ILC", "RILC", "IER", "CSR"};
+	const char *exec_ctxt[] = {"Task", "SWI", "HWI", "Unknown"};
 	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *dev_object = bridge_context->hdev_obj;
 
@@ -2135,8 +2138,6 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 			total_size = MAX_MMU_DBGBUFF;
 
 		buffer = kzalloc(total_size, GFP_ATOMIC);
-		buffer_end =  buffer + total_size / 4;
-
 		if (!buffer) {
 			status = -ENOMEM;
 			pr_debug("%s: Failed to "
@@ -2144,6 +2145,9 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 			goto func_end;
 		}
 
+		buffer_beg = buffer;
+		buffer_end =  buffer + total_size / 4;
+
 		/* Read bytes from the DSP trace buffer... */
 		status = (*intf_fxns->pfn_brd_read)(bridge_context,
 				(u8 *)buffer, (u32)trace_begin,
@@ -2154,8 +2158,8 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 			goto func_end;
 		}
 
-		pr_err("Aproximate Crash Position:\n");
-		pr_err("--------------------------\n");
+		pr_err("\nAproximate Crash Position:\n"
+			"--------------------------\n");
 
 		exc_type = buffer[3];
 		if (!exc_type)
@@ -2163,15 +2167,42 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 		else
 			i = buffer[80];         /* NRP */
 
-		if ((*buffer > 0x01000000) && (node_find_addr(node_mgr, i,
+		status =
+		    cod_get_sym_value(code_mgr, DYNEXTBASE, &dyn_ext_base);
+		if (DSP_FAILED(status)) {
+			status = -EFAULT;
+			goto func_end;
+		}
+
+		if ((i > dyn_ext_base) && (node_find_addr(node_mgr, i,
 			0x1000, &offset_output, name) == 0))
 			pr_err("0x%-8x [\"%s\" + 0x%x]\n", i, name,
 							i - offset_output);
 		else
 			pr_err("0x%-8x [Unable to match to a symbol.]\n", i);
 
-		pr_err("Execution Info:\n");
-		pr_err("---------------\n");
+		buffer += 4;
+
+		pr_err("\nExecution Info:\n"
+			"---------------\n");
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
+		pr_err("\nCPU Registers\n"
+			"---------------\n");
 
 		for (i = 0; i < 32; i++) {
 			if (i == 4 || i == 6 || i == 8)
@@ -2188,8 +2219,8 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
 		pr_err("B1 0x%x\n", *buffer++);
 		pr_err("B2 0x%x\n", *buffer++);
 
-		if ((*buffer > 0x01000000) && (node_find_addr(node_mgr, *buffer,
-			0x1000, &offset_output, name) == 0))
+		if ((*buffer > dyn_ext_base) && (node_find_addr(node_mgr,
+			*buffer, 0x1000, &offset_output, name) == 0))
 
 			pr_err("B3 0x%-8x [Function Return Pointer:"
 				" \"%s\" + 0x%x]\n", *buffer, name,
@@ -2204,27 +2235,32 @@ int dump_dsp_stack(struct bridge_dev_context *bridge_context)
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
 
+		pr_err("\nStack:\n"
+			"------\n");
+
 		for (i = 0; buffer < buffer_end; i++, buffer++) {
-			if ((*buffer > 0x01000000) && (node_find_addr(node_mgr,
-				*buffer , 0x600, &offset_output, name) ==
-				0))
+			if ((*buffer > dyn_ext_base) && (
+				node_find_addr(node_mgr, *buffer , 0x600,
+				&offset_output, name) == 0))
 				pr_err("[%d] 0x%-8x [\"%s\" + 0x%x]\n",
 					i, *buffer, name,
 					*buffer - offset_output);
 			else
 				pr_err("[%d] 0x%x\n", i, *buffer);
 		}
-		kfree(buffer - total_size / 4);
+		kfree(buffer_beg);
 	}
 func_end:
 	return status;
@@ -2289,8 +2325,8 @@ void dump_dl_modules(struct bridge_dev_context *bridge_context)
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

