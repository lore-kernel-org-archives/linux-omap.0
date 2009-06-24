From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP2/3/4: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 14:08:54 -0700
Message-ID: <87hby51grd.fsf@deeprootsystems.com>
References: <1245868054-20375-1-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F546235B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:52097 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZFXVIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 17:08:53 -0400
Received: by wf-out-1314.google.com with SMTP id 26so358012wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 14:08:56 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F546235B@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 25 Jun 2009 00\:42\:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

> Kevin
>
>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Wednesday, June 24, 2009 1:28 PM
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH v3] OMAP2/3/4: PM: reset USB OTG module on boot
>>
>
> Have some more comments that I should have given before the re-spin v3 !!
>

sigh, sending these too quickly... thanks for the reviews.

>>Rather than simply setting force-idle mode on boot, do a reset of the
>>OTG module.  This really ensures that any bootloader/bootstrap code
>>that leaves it active will not prevent future retention.  After reset,
>>OTG module will be in force-idle, force-standby mode.
>>
>>In addition, ensure that the iclk is enabled before attempting a write
>>to the module SYSCONFIG register.
>>
>>Problem reported by Mike Chan <mikechan@google.com>
>>
>>Tested-by: Mike Chan <mikechan@google.com>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>>Updates from v2
>>- reset for OMAP2 as well (needs update for OMAP4, see FIXME)
>>
>> arch/arm/mach-omap2/usb-musb.c |   37 +++++++++++++++++++++++++++++++++----
>> 1 files changed, 33 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
>>index d85296d..1ea2ac7 100644
>>--- a/arch/arm/mach-omap2/usb-musb.c
>>+++ b/arch/arm/mach-omap2/usb-musb.c
>>@@ -26,18 +26,47 @@
>>
>> #include <linux/usb/musb.h>
>>
>>+#include <asm/sizes.h>
>>+
>> #include <mach/hardware.h>
>> #include <mach/irqs.h>
>> #include <mach/mux.h>
>> #include <mach/usb.h>
>>
>>-#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
>>+#define OTG_SYSCONFIG	   0x404
>>+#define OTG_SYSC_SOFTRESET BIT(1)
>>
>> static void __init usb_musb_pm_init(void)
>> {
>>-	/* Ensure force-idle mode for OTG controller */
>>-	if (cpu_is_omap34xx())
>>-		omap_writel(0, OTG_SYSCONFIG);
>>+	struct clk *iclk;
>>+	u32 phys_base;
>>+	void __iomem *otg_base;
>>+
>>+	if (cpu_is_omap243x())
>>+		phys_base = OMAP2_OTG_BASE;
>>+	else if (cpu_is_omap34xx())
>>+		phys_base = OMAP34XX_HSUSB_OTG_BASE;
>>+	else
>>+		/* FIXME: add OMAP4 support */
>>+		return;
>>+
>>+	otg_base = ioremap(phys_base, SZ_4K);
>>+	if (WARN_ON(!otg_base))
>>+		return;
>>+
>>+	iclk = clk_get(NULL, "hsotgusb_ick");
>>+	if (WARN_ON(!iclk))
>
> Need to iounmap(otg_base); and clk_put() in case of error
> Goto error;

actually just need to iounmap in case clk_get fails.

>>+		return;
>>+
>>+	clk_enable(iclk);
>>+
>>+	/* Reset OTG controller.  After reset, it will be in
>>+	 * force-idle, force-standby mode. */
>>+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
>>+
>>+	clk_disable(iclk);
>
> error:
>>+	clk_put(iclk);

and error: should go here.

>>+	iounmap(otg_base);
>> }
>>
>> #ifdef CONFIG_USB_MUSB_SOC
>>--
>>1.6.3.2
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
