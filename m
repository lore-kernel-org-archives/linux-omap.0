From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3530 EVM Sources are on linux.omap.com
Date: Thu, 15 May 2008 10:35:00 -0700
Message-ID: <20080515173500.GP8928@atomide.com>
References: <0680EC522D0CC943BC586913CF3768C001578E8398@dbde02.ent.ti.com> <814dfab70805150832x4f1ffb04ue24a591497ec8cb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:63122 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbYEORfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 13:35:00 -0400
Content-Disposition: inline
In-Reply-To: <814dfab70805150832x4f1ffb04ue24a591497ec8cb4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Remith Ravi <remith@mistralsolutions.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Remith Ravi <remith@mistralsolutions.com> [080515 08:34]:
> Khasim,
> 
> After running the power management command ' echo "mem" >
> /sys/power/state '  the OMAP3430EVM entered into suspend state.
> 
> Now what I have to do to make the system resume the normal state? I
> tried pressing some keys but it didn't help.

You need to configure some wakeup events. For GPIO pins this requires
setting the wakeup flags with enable_irq_wake(). Also to wake from an
external module like smc91x, the external module's functional clock
needs to be powerred on.

It could also be that suspend does not yet wake properly in general
as we don't yet have realy PM code 3430 integrated.

Tony


> 
> Regards,
> Remith
> Mistral Solutions.
> 
> 
> On Mon, May 12, 2008 at 4:29 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
> > Hello all:
> >
> > We have uploaded OMAP3530 EVM sources on linux.omap.com
> >
> > x-loader               : http://linux.omap.com/pub/xloader/3530evm/
> > u-boot-1.1.4           : http://linux.omap.com/pub/bootloader/3530evm/
> > Linux Kernel 2.6.22-18 : http://linux.omap.com/pub/kernel/3530evm/
> > Tool Chain used        : Code Sourcery arm-2007q3
> >
> > Few important features supported in kernel are listed below:
> >
> > *       ALSA Audio Driver.
> > *       Power Management
> > *       Supports for NFS file system.
> > *       Ethernet.
> > *       Frame buffer (FBDEV).
> > *       Debug UART port.
> > *       DMA framework.
> > *       TWL4030 (T2) RTC.
> > *       Watchdog driver.
> > *       Support T2 Core GPIO.
> > *       GPIO.
> > *       V4L2 Based Video driver.
> > *       Keypad.
> > *       HS-I2C.
> > *       McBSP.
> > *       McSPI.
> > *       TouchScreen.
> > *       UART library.
> > *       High-speed MMC
> > *       NAND
> > *       USB OTG
> > *       TV out.
> > *       Clock framework with device driver adaptation
> >
> > Platform description can be found here,
> > http://focus.ti.com/general/docs/wtbu/wtbusplashcontent.tsp?templateId=6123&contentId=4750#omap3530
> >
> > Regards,
> > Khasim
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
