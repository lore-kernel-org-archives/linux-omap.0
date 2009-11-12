From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 11/11] OMAP3: PM: Disable OTG autoidle when waking up
 from off-mode
Date: Thu, 12 Nov 2009 10:42:07 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D6F1F6D@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-10-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-11-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-12-git-send-email-tero.kristo@nokia.com>
 <878wecy6g8.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C829A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20580 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbZKLJmN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 04:42:13 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C829A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gadiyar@ti.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Gadiyar, Anand [mailto:gadiyar@ti.com] 
>Sent: 12 November, 2009 08:25
>To: Kevin Hilman; Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: RE: [PATCH 11/11] OMAP3: PM: Disable OTG autoidle 
>when waking up from off-mode
>
>Kevin Hilman wrote:
>> Tero Kristo <tero.kristo@nokia.com> writes:
>> 
>> > From: Tero Kristo <tero.kristo@nokia.com>
>> >
>> > OMAP3 sleep can be prevented in some cases where OTG 
>autoidle is enabled.
>> > This patch force disables autoidle during wakeup from 
>off-mode. See omap
>> > errata 1.164.
>> >
>> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> 
>> This one needs a refresh against current PM branch.
>> 
>> > ---
>> >  arch/arm/mach-omap2/pm34xx.c          |    6 ++++++
>> >  arch/arm/mach-omap2/usb-musb.c        |   14 ++++++++------
>> >  arch/arm/plat-omap/include/mach/usb.h |    3 +++
>> 
>> mach/usb.h moved to plat/usb.h
>> 
>> >  3 files changed, 17 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> > index 5eb7321..070a0a2 100644
>> > --- a/arch/arm/mach-omap2/pm34xx.c
>> > +++ b/arch/arm/mach-omap2/pm34xx.c
>> > @@ -39,6 +39,7 @@
>> >  #include <mach/gpmc.h>
>> >  #include <mach/dma.h>
>> >  #include <mach/dmtimer.h>
>> > +#include <mach/usb.h>
>> >  
>> >  #include <asm/tlbflush.h>
>> >  
>> > @@ -496,6 +497,11 @@ void omap_sram_idle(void)
>> >  			omap3_prcm_restore_context();
>> >  			omap3_sram_restore_context();
>> >  			omap2_sms_restore_context();
>> > +			/*
>> > +			 * Errata 1.164 fix : OTG autoidle can prevent
>> > +			 * sleep
>> > +			 */
>> > +			usb_musb_disable_autoidle();
>> 
>> NAK.  This belongs in the MUSB driver, not in the idle path.
>> 
>
>Kevin,
>
>When we exit off-mode, the autoidle will get enabled, and needs
>an explicit disable. If the MUSB driver is not loaded, there will
>be no one to do this.

Also, even if the driver is loaded, it doesn't disable this bit each sleep cycle.

>
>- Anand
>
>> Kevin
>> 
>> >  		}
>> >  		omap_uart_resume_idle(0);
>> >  		omap_uart_resume_idle(1);
>> > diff --git a/arch/arm/mach-omap2/usb-musb.c 
>b/arch/arm/mach-omap2/usb-musb.c
>> > index 8dde0b7..f4b86c0 100644
>> > --- a/arch/arm/mach-omap2/usb-musb.c
>> > +++ b/arch/arm/mach-omap2/usb-musb.c
>> > @@ -44,10 +44,11 @@ static struct platform_device dummy_pdev = {
>> >  	},
>> >  };
>> >  
>> > +static void __iomem *otg_base;
>> > +static struct clk *otg_clk;
>> > +
>> >  static void __init usb_musb_pm_init(void)
>> >  {
>> > -	void __iomem *otg_base;
>> > -	struct clk *otg_clk;
>> >  	struct device *dev = &dummy_pdev.dev;
>> >  
>> >  	if (!cpu_is_omap34xx())
>> > @@ -74,12 +75,13 @@ static void __init usb_musb_pm_init(void)
>> >  			cpu_relax();
>> >  	}
>> >  
>> > -	if (otg_clk) {
>> > +	if (otg_clk)
>> >  		clk_disable(otg_clk);
>> > -		clk_put(otg_clk);
>> > -	}
>> > +}
>> >
>> >  
>> > -	iounmap(otg_base);
>> > +void usb_musb_disable_autoidle(void)
>> > +{
>> > +	__raw_writel(0, otg_base + OTG_SYSCONFIG);
>> >  }
>> >  
>> >  #ifdef CONFIG_USB_MUSB_SOC
>> > diff --git a/arch/arm/plat-omap/include/mach/usb.h 
>b/arch/arm/plat-omap/include/mach/usb.h
>> > index a4068a4..310ee17 100644
>> > --- a/arch/arm/plat-omap/include/mach/usb.h
>> > +++ b/arch/arm/plat-omap/include/mach/usb.h
>> > @@ -46,6 +46,9 @@ extern void usb_musb_init(void);
>> >  
>> >  extern void usb_ehci_init(struct 
>ehci_hcd_omap_platform_data *pdata);
>> >  
>> > +/* This is needed for OMAP3 errata 1.164: enabled 
>autoidle can prevent sleep */
>> > +extern void usb_musb_disable_autoidle(void);
>> > +
>> >  #endif
>> >  
>> >  void omap_usb_init(struct omap_usb_config *pdata);
>