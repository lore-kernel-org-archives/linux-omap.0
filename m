From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] PM: Disable usb host HW save and restore
Date: Fri, 5 Jun 2009 18:36:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030591A50C@dbde02.ent.ti.com>
References: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55476 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZFENHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 09:07:04 -0400
In-Reply-To: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Kalle,

I just found an issue with the  pwrdm_enable_hdwr_sar function which
would actually leave the SAVEANDRESTORE bit unchanged in the PWSTCTRL
register.
http://marc.info/?l=linux-omap&m=124420689003913&w=2

The issue you were seeing with USBHOST might not really be with enabling the SAR
on USBHOST but something else.

regards,
Rajendra

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kalle Jokiniemi
>Sent: Thursday, April 23, 2009 4:29 PM
>To: tony@atomide.com
>Cc: khilman@deeprootsystems.com; paul@pwsan.com; 
>linux-omap@vger.kernel.org; Menon, Nishanth; Woodruff, 
>Richard; Kalle Jokiniemi; Kalle Jokiniemi
>Subject: [PATCH] PM: Disable usb host HW save and restore
>
>The hardware SAVEANDRESTORE mechanism seems to leave
>USB HOST power domain permanently into active state
>after one transition from off to active state.
>Disabling for now.
>
>Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
>---
> arch/arm/mach-omap2/powerdomains34xx.h |    8 +++++++-
> 1 files changed, 7 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/powerdomains34xx.h 
>b/arch/arm/mach-omap2/powerdomains34xx.h
>index 4dcf94b..aa557b2 100644
>--- a/arch/arm/mach-omap2/powerdomains34xx.h
>+++ b/arch/arm/mach-omap2/powerdomains34xx.h
>@@ -338,7 +338,13 @@ static struct powerdomain usbhost_pwrdm = {
> 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
> 	.pwrsts		  = PWRSTS_OFF_RET_ON,
> 	.pwrsts_logic_ret = PWRDM_POWER_RET,
>-	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBHOST 
>ctrlr only */
>+	/*
>+	 * REVISIT: Enabling usb host save and restore 
>mechanism seems to
>+	 * leave the usb host domain permanently in ACTIVE mode after
>+	 * changing the usb host power domain state from OFF to 
>active once.
>+	 * Disabling for now.
>+	 */
>+	/*.flags	  = PWRDM_HAS_HDWR_SAR,*/ /* for 
>USBHOST ctrlr only */
> 	.banks		  = 1,
> 	.pwrsts_mem_ret	  = {
> 		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
>-- 
>1.5.4.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>