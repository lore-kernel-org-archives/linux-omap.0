From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: Remove DEBUGFS dependency for mux name
 checking
Date: Wed, 17 Feb 2010 11:24:24 -0800
Message-ID: <20100217192423.GA21755@atomide.com>
References: <1266427021-10990-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="U+BazGySraz5kW0T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59225 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0BQTXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 14:23:36 -0500
Content-Disposition: inline
In-Reply-To: <1266427021-10990-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Ranjith Lohithakshan <ranjithl@ti.com> [100217 09:14]:
> The check for a valid mux name should be performed regardless of whether
> DEBUGFS is enabled or not.
> 
> This fixes the issue currently seen with boards not booting up
> if DEBUGFS is not enabled in defconfig.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Thanks, I've updated the description a bit to include the error
and added the patch into omap-fixes-for-linus.

Updated patch below.

Regards,

Tony

--U+BazGySraz5kW0T
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-mux-debufs.patch"

From: Ranjith Lohithakshan <ranjithl@ti.com>
Date: Wed, 17 Feb 2010 17:17:01 +0000
Subject: [PATCH] omap: Remove DEBUG_FS dependency for mux name checking

The check for a valid mux name should be performed regardless of whether
DEBUG_FS is enabled or not. Otherwise without DEBUG_FS, we get:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc8 #10)
PC is at strcmp+0x18/0x40
LR is at omap_mux_init_signal+0x68/0x14c
...

This fixes the issue currently seen with boards not booting up
if DEBUG_FS is not enabled in defconfig.

Note that the earlier ifndef + ifdef now becomes simpler ifdef else:
If CONFIG_OMAP_MUX is selected, we use pin names. If it's not selected,
we only want the GPIO to mux register mapping.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 5fedc50..5fef73f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -961,16 +961,14 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 	while (superset->reg_offset !=  OMAP_MUX_TERMINATOR) {
 		struct omap_mux *entry;
 
-#ifndef CONFIG_OMAP_MUX
-		/* Skip pins that are not muxed as GPIO by bootloader */
-		if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
+#ifdef CONFIG_OMAP_MUX
+		if (!superset->muxnames || !superset->muxnames[0]) {
 			superset++;
 			continue;
 		}
-#endif
-
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
-		if (!superset->muxnames || !superset->muxnames[0]) {
+#else
+		/* Skip pins that are not muxed as GPIO by bootloader */
+		if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
 			superset++;
 			continue;
 		}

--U+BazGySraz5kW0T--
