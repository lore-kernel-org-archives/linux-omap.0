From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 1/2] Triton Battery charger interface driver for
	OMAP3430
Date: Tue, 24 Jun 2008 10:50:59 +0300
Message-ID: <20080624075059.GC11134@atomide.com>
References: <61775.192.168.10.89.1213963421.squirrel@dbdmail.itg.ti.com> <cc28162fe9818299156131c2374c3ba3@felipebalbi.com> <04c401c8d535$ebf53dc0$35f6180a@ent.ti.com> <cbbf72cc022c9baa52230371202fed66@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64598 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYFXHvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 03:51:09 -0400
Content-Disposition: inline
In-Reply-To: <cbbf72cc022c9baa52230371202fed66@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, jouni.hogander@nokia.com, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080623 17:53]:
> Hi,
> 
> On Mon, 23 Jun 2008 19:04:51 +0530, "Madhusudhan Chikkature"
> <madhu.cr@ti.com> wrote:
> 
> >> On Fri, 20 Jun 2008 17:33:41 +0530 (IST), x0070977@dbdmail.itg.ti.com
> >> wrote:
> >>
> >>> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> >>> ===================================================================
> >>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c 2008-06-20
> >>> 15:39:56.000000000 +0530
> >>> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c 2008-06-20
> >>> 15:42:05.000000000
> >>> +0530
> >>> @@ -358,6 +358,22 @@
> >>>  static inline void omap_hdq_init(void) {}
> >>>  #endif
> >>>
> >>> +#ifdef CONFIG_TWL4030_BCI_BATTERY
> >>> +static struct platform_device omap_bci_battery_device = {
> >>> + .name           = "twl4030-bci-battery",
> >>> + .id             = 1,
> >>> + .num_resources  = 0,
> >>> + .resource       = NULL,
> >>
> >> if you pass the struct resources you can use __raw_{read,write} which
> >> would simplify a lot for you, but if you really don't want it, you
> >> don't have to initialize it to NULL. Just because it's static, it's
> >> enough for it to get NULLed.
> > The battery driver uses twl4030_i2c_read_u8 and twl4030_i2c_write_u8 as
> > low level interface(I2C) with
> > standard twl4030.h defines. So no point of  _raw(read,write) and BASE
> > address getting initialized through resource structure. Right?.
> > I agree with your second point of no need to explicitely setting it to
> > NULL though.
> 
> The idea was to actually get rid of the i2c transfers and use
> __raw_read/write
> instead, but I suppose it's ok to use i2c transfers

Hmm, I guess the only way to access twl4030 is via i2c :) So
__raw_read/write would not work for the twl4030 registers.


> >>> +};
> >>> +
> >>> +static inline void omap_bci_battery_init(void)
> >>> +{
> >>> + (void) platform_device_register(&omap_bci_battery_device);
> >>> +}
> >>> +#else
> >>> +static inline void omap_bci_battery_init(void) {}
> >>> +#endif
> >>> +
> 
> don't remember if I said on last mail, but this ifdef should be in
> a header file. Maybe include/linux/i2c/twl4030.h
> 
> >> How about creating a special battery.c for this just like usb-musb.c,
> >> usb-ehci.c
> >> and hsmmc.c, so it's easier to reuse it and add such support only for
> >> boards that
> >> has twl4030.
> >>
> >> It would be useful for omap multiboot, I suppose.
> > I had put these under devices.c as there is not much board level
> > configurations for BCI unlike hsmmc.
> > I guess I can add a simple board file for battery that way it can used
> > based on TWL4030 if it is a good idea.
> 
> I would like to hear from Tony and the others what do they think?
> would it be worthy adding an extra file for bci ??
> 
> Tony, comments?

Well I guess some people are not using the bci, so it could be a
separate module.


> >>        INIT_DELAYED_WORK_DEFERRABLE()???
> > Do you mean INIT_DELAYED_WORK_DEFERRABLE() is a better choice here??
> 
> Yes, as it could be deferred on suspend/resume. I think INIT_DELAYED_WORK
> also blocks dynamic pm ?!?
> 
> Maybe Jouni could clarify this one better. Jouni, any comments?
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
