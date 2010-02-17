From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: Remove DEBUGFS dependency for mux name checking
Date: Wed, 17 Feb 2010 15:46:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E5774A31@dbde02.ent.ti.com>
References: <1266387487-27588-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab0BQKQW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 05:16:22 -0500
In-Reply-To: <1266387487-27588-1-git-send-email-ranjithl@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lohithakshan, Ranjith" <ranjithl@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Lohithakshan, Ranjith
> Sent: Wednesday, February 17, 2010 11:48 AM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Lohithakshan, Ranjith
> Subject: [PATCH] omap: Remove DEBUGFS dependency for mux name checking
> 
> The check for a valid mux name should be performed regardless 
> of whether
> DEBUGFS is enabled or not.
> 
> This fixes the issue currently seen with boards not booting up
> if DEBUGFS is not enabled in defconfig.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Ranjith,

For better readability, I suggest the following:

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 19001dd..7c0c4ad 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -960,16 +960,14 @@ static void __init omap_mux_init_list(struct omap_mux *sup
        while (superset->reg_offset !=  OMAP_MUX_TERMINATOR) {
                struct omap_mux *entry;

-#ifndef CONFIG_OMAP_MUX
-               /* Skip pins that are not muxed as GPIO by bootloader */
-               if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
+#ifdef CONFIG_OMAP_MUX
+               if (!superset->muxnames || !superset->muxnames[0]) {
                        superset++;
                        continue;
                }
-#endif
-
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
-               if (!superset->muxnames || !superset->muxnames[0]) {
+#else
+               /* Skip pins that are not muxed as GPIO by bootloader */
+               if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
                        superset++;
                        continue;
                }

Best regards,
Sanjeev


> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 986077f..1a6ff8f 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -969,7 +969,7 @@ static void __init 
> omap_mux_init_list(struct omap_mux *superset)
>  		}
>  #endif
>  
> -#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
> +#ifdef CONFIG_OMAP_MUX
>  		if (!superset->muxnames || !superset->muxnames[0]) {
>  			superset++;
>  			continue;
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 