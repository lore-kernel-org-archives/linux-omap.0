From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] AM35xx: Runtime detection of the device
Date: Tue, 10 Nov 2009 12:20:53 +0200
Message-ID: <20091110102053.GL21945@nokia.com>
References: <1256652150-5710-1-git-send-email-premi@ti.com>
 <20091027161115.GA16494@nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCB84@dbde02.ent.ti.com>
 <20091027210853.GA17061@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41659 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZKJKWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:22:54 -0500
Content-Disposition: inline
In-Reply-To: <20091027210853.GA17061@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Tue, Oct 27, 2009 at 10:08:54PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>From: Felipe Balbi <felipe.balbi@nokia.com>
>Subject: [PATCH] arm: omap: code cleanup to id.c
>
>Cleanup the coding style in id.c while avoiding unneeded switch()
>statements.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>---
>
>diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>index 1c15112..dbdeb09 100644
>--- a/arch/arm/mach-omap2/id.c
>+++ b/arch/arm/mach-omap2/id.c
>@@ -53,11 +53,11 @@ int omap_type(void)
> {
> 	u32 val = 0;
>
>-	if (cpu_is_omap24xx())
>+	if (cpu_is_omap24xx()) {
> 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
>-	else if (cpu_is_omap34xx())
>+	} else if (cpu_is_omap34xx()) {
> 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>-	else {
>+	} else {
> 		pr_err("Cannot detect omap type!\n");
> 		goto out;
> 	}
>@@ -224,24 +224,14 @@ void __init omap3_check_revision(void)
> 			omap_revision = OMAP3430_REV_ES3_0;
> 			break;
> 		case 4:
>-			omap_revision = OMAP3430_REV_ES3_1;
>-			break;
>+		/* FALLTHROUGH */
> 		default:
> 			/* Use the latest known revision as default */
> 			omap_revision = OMAP3430_REV_ES3_1;
> 		}
> 		break;
> 	case 0xb891:
>-		/* Handle 36xx devices */
>-		switch (rev) {
>-		case 0:
>-			omap_revision = OMAP3630_REV_ES1_0;
>-			break;
>-		default:
>-			/* Use the latest known revision as default */
>-			omap_revision = OMAP3630_REV_ES1_0;
>-		}
>-		break;
>+	/* FALLTHROUGH */
> 	default:
> 		/* Unknown default to latest silicon rev as default*/
> 		omap_revision = OMAP3630_REV_ES1_0;
>@@ -266,19 +256,17 @@ void __init omap3_cpuinfo(void)
> 	 * on available features. Upon detection, update the CPU id
> 	 * and CPU class bits.
> 	 */
>-	if (cpu_is_omap3630())
>+	if (cpu_is_omap3630()) {
> 		strcpy(cpu_name, "3630");
>-	else if (omap3_has_iva() && omap3_has_sgx())
>+	} else if (omap3_has_iva() && omap3_has_sgx()) {
> 		strcpy(cpu_name, "3430/3530");
>-	else if (omap3_has_sgx()) {
>+	} else if (omap3_has_sgx()) {
> 		omap_revision = OMAP3525_REV(rev);
> 		strcpy(cpu_name, "3525");
>-	}
>-	else if (omap3_has_iva()) {
>+	} else if (omap3_has_iva()) {
> 		omap_revision = OMAP3515_REV(rev);
> 		strcpy(cpu_name, "3515");
>-	}
>-	else {
>+	} else {
> 		omap_revision = OMAP3503_REV(rev);
> 		strcpy(cpu_name, "3503");
> 	}
>@@ -297,8 +285,7 @@ void __init omap3_cpuinfo(void)
> 		strcpy(cpu_rev, "3.0");
> 		break;
> 	case OMAP_REVBITS_40:
>-		strcpy(cpu_rev, "3.1");
>-		break;
>+	/* FALLTHROUGH */
> 	default:
> 		/* Use the latest known revision as default */
> 		strcpy(cpu_rev, "3.1");
>@@ -325,18 +312,18 @@ void __init omap2_check_revision(void)
> 	 * At this point we have an idea about the processor revision set
> 	 * earlier with omap2_set_globals_tap().
> 	 */
>-	if (cpu_is_omap24xx())
>+	if (cpu_is_omap24xx()) {
> 		omap24xx_check_revision();
>-	else if (cpu_is_omap34xx()) {
>+	} else if (cpu_is_omap34xx()) {
> 		omap3_check_features();
> 		omap3_check_revision();
> 		omap3_cpuinfo();
>-	}
>-	else if (cpu_is_omap44xx()) {
>+	} else if (cpu_is_omap44xx()) {
> 		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
> 		return;
>-	} else
>+	} else {
> 		pr_err("OMAP revision unknown, please fix!\n");
>+	}
>
> 	/*
> 	 * OK, now we know the exact revision. Initialize omap_chip bits

how about this patch, any comments ??

-- 
balbi
