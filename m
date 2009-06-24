From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 11:00:41 -0700
Message-ID: <87tz251ph2.fsf@deeprootsystems.com>
References: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:40283 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761392AbZFXSAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 14:00:41 -0400
Received: by pzk27 with SMTP id 27so799077pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 24 Jun 2009 11:00:43 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com> (Vikram Pandita's message of "Wed\, 24 Jun 2009 22\:32\:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Wednesday, June 24, 2009 10:32 AM
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
>>
>>Rather than simply setting force-idle mode on boot, do a reset of the
>>OTG module.  This really ensures that any bootloader/bootstrap code
>>that leaves it active will not prevent future retention.  After reset,
>>OTG module will be in force-idle, force-standby mode.
>>
>>In addition, ensure that the iclk is enabled before attempting a write
>>to the module SYSCONFIG register.
>
> This patch solves MUSB issue, but is not generic for all IP blocks on omap.
>
> ROM code or u-boot could leave the module sysconfig in a non-idle state.
>
> I recommend just like CONFIG_OMAP_RESET_CLOCKS for clocks, same could be done generically for all SYSCONFIG registers in some prcm code and not driver specific.
>
>>
>>Problem reported by Mike Chan <mikechan@google.com>
>>
>>Tested-by: Mike Chan <mikechan@google.com>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>>Updates from v1
>>- use ioremap()+__raw_write instead of deprecated omap_write()
>>- Re: defines in omap2430.h, this header is not exported outside
>>  drivers/usb, so define it locally yere
>>
>> arch/arm/mach-omap2/usb-musb.c |   31 +++++++++++++++++++++++++++----
>> 1 files changed, 27 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
>>index d85296d..31adbe6 100644
>>--- a/arch/arm/mach-omap2/usb-musb.c
>>+++ b/arch/arm/mach-omap2/usb-musb.c
>>@@ -26,18 +26,41 @@
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
>
> This is already defined in drivers/usb/musb/omap2430.h
> Could we reuse? 

See comment above in the 'Updates from v1' section.

>
> #if     defined(CONFIG_ARCH_OMAP2430)
> #define OMAP_HSOTG_BASE         (OMAP243X_HS_BASE)
> #elif   defined(CONFIG_ARCH_OMAP3430)
> #define OMAP_HSOTG_BASE         (OMAP34XX_HSUSB_OTG_BASE)
> #endif
> #define OMAP_HSOTG(offset)      (OMAP_HSOTG_BASE + 0x400 + (offset))
> #define OTG_REVISION            OMAP_HSOTG(0x0)
> #define OTG_SYSCONFIG           OMAP_HSOTG(0x4)
>
>
>>
>> static void __init usb_musb_pm_init(void)
>> {
>>-	/* Ensure force-idle mode for OTG controller */
>>-	if (cpu_is_omap34xx())
>>-		omap_writel(0, OTG_SYSCONFIG);
>>+	struct clk *iclk;
>>+	void __iomem *otg_base;
>>+
>>+	if (!cpu_is_omap34xx())
>>+		return;
>
> Why is this sys-config reset done only for omap34xx()
> This should be valid for any old 24xx() as well as new 44xx() omaps

You're correct.  Good catch.

The force-idle "fix" that this is replacing was only being done on
34xx due to the smart-idle errata.  However, this reset should be
done even without any errata.

Thanks for review,  will respin.

Kevin

>>+
>>+	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
>>+	if (WARN_ON(!otg_base))
>>+		return;
>>+
>>+	iclk = clk_get(NULL, "hsotgusb_ick");
>>+	if (WARN_ON(!iclk))
>>+		return;
>>+
>>+	clk_enable(iclk);
>>+
>>+	/* Reset OTG controller.  After reset, it will be in
>>+	 * force-idle, force-standby mode. */
>>+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
>>+
>>+	clk_disable(iclk);
>>+	clk_put(iclk);
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
