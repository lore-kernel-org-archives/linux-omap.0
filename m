From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Tue, 18 Nov 2014 07:42:04 -0800
Message-ID: <20141118154204.GI7046@atomide.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com>
 <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16516 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbaKRPmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 10:42:24 -0500
Content-Disposition: inline
In-Reply-To: <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

* Enric Balletbo Serra <eballetbo@gmail.com> [141118 01:04]:
> Hi Tony,
> 
> 2014-11-17 19:04 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> >
> > Just tested v3.18-rc5 with beagleboard xm, and the host mode
> > enumerates the devices, then may fail with "insufficient bus power"
> > at least for the WLAN device I tried with.
> >
> 
> Is this with following options ?
> 
> CONFIG_USB_MUSB_DUAL_ROLE=y
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> 
> Because with these options doesn't work for me. It only works if I
> don't use dual role mode
> 
> CONFIG_USB_MUSB_HOST=y
> CONFIG_USB_MUSB_DUAL_ROLE is not set

Weird. Yes I have CONFIG_USB_MUSB_DUAL_ROLE. AFAIK there's actually
no way to disable the role switching in MUSB hardware, the hardware
tries to do things on it's own anyways. So it's probably best to always
set it to CONFIG_USB_MUSB_DUAL_ROLE=y unless size of the code is an
issue.

> > I noticed that this only works with CONFIG_USB_MUSB_HDRC and
> > CONFIG_TWL4030_USB built into the kernel. No luck so far with them
> > as loadable modules for some reason. Looks like also USB gadgets
> > fail with MUSB as modules.

I found the core issue with loadable modules, we currently need to
have just one platform glue layer module compiled in. I have a
fix coming up for that..

> It's weird, for me fails in both cases, built-in and with loadable
> modules. Connecting the OTG Cable Adapter with a pendrive reports
>
> [   51.462432] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   51.470916] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> twl4030_usb_runtime_resume
> [   51.487274] musb-hdrc musb-hdrc.0.auto: ID GND
> [   52.480712] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   53.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> 
> And then polls until I disconnect the OTG Cable Adapter with the pendrive.
> 
> [   71.488983] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x54/84; link 1
> [   71.778930] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x50/80; link 4
> [   71.787536] musb-hdrc musb-hdrc.0.auto: VBUS Disconnect
> [   72.489044] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> HW_CONDITIONS 0x50/80; link 4
> [   74.088714] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
> twl4030_usb_runtime_suspend

Looks like the twl4030-usb is producing interrupts alright. Maybe
check your MUSB configuration one more time. See the attached
patch, but note you need to only select the glue layer for the
CONFIG_USB_MUSB_OMAP2PLUS option and disable other glue layer
module options.

Also, you may want to monitor the VBUS line in host mode. If the
VBUS does not come up fast enough, MUSB hardware will give up as
it's again trying to do things on its own. 
 
> > And on the 37xx EVM, I've never had any luck getting any twl4030_usb
> > interrupts for some reason.

Turns out the 37xx EVM is using an isp1507 phy instead of the
twl4030 phy. The proper fix for that will be to start using the
usb-nop-xceiv or phy-ulpi when we have drivers/phy/ driver for
it. Right now trying to use it seems to fail with the following
error:

HS USB OTG: no PHY configured

Regards,

Tony

8< -------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 17 Nov 2014 07:53:59 -0800
Subject: [PATCH] ARM: omap2plus_defconfig: Enable USB as loadable modules

NOTE: Currently only one MUSB glue layer can be selected
below because of the ifdefs, I'll do a fix for that.

--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -270,17 +270,92 @@ CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_OTG=y
 CONFIG_USB_MON=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_USB_MUSB_AM35X=m
+CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_DWC3=m
-CONFIG_USB_TEST=y
-CONFIG_AM335X_PHY_USB=y
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_SIMPLE=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_USB_EMI62=m
+CONFIG_USB_EMI26=m
+CONFIG_USB_ADUTUX=m
+CONFIG_USB_SEVSEG=m
+CONFIG_USB_RIO500=m
+CONFIG_USB_LEGOTOWER=m
+CONFIG_USB_LCD=m
+CONFIG_USB_LED=m
+CONFIG_USB_CYPRESS_CY7C63=m
+CONFIG_USB_CYTHERM=m
+CONFIG_USB_IDMOUSE=m
+CONFIG_USB_FTDI_ELAN=m
+CONFIG_USB_APPLEDISPLAY=m
+CONFIG_USB_SISUSBVGA=m
+CONFIG_USB_SISUSBVGA_CON=y
+CONFIG_USB_LD=m
+CONFIG_USB_TRANCEVIBRATOR=m
+CONFIG_USB_IOWARRIOR=m
+CONFIG_USB_TEST=m
+CONFIG_USB_EHSET_TEST_FIXTURE=m
+CONFIG_USB_ISIGHTFW=m
+CONFIG_USB_YUREX=m
+CONFIG_USB_EZUSB_FX2=m
+CONFIG_USB_HSIC_USB3503=m
+CONFIG_USB_LINK_LAYER_TEST=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_AM335X_PHY_USB=m
+CONFIG_TWL6030_USB=m
+CONFIG_USB_GPIO_VBUS=m
+CONFIG_USB_ISP1301=m
+CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_ZERO=m
+CONFIG_USB_ZERO_HNPTEST=y
+CONFIG_USB_AUDIO=m
+CONFIG_GADGET_UAC1=y
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_EEM=y
+CONFIG_USB_G_NCM=m
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FUNCTIONFS=m
+CONFIG_USB_FUNCTIONFS_ETH=y
+CONFIG_USB_FUNCTIONFS_RNDIS=y
+CONFIG_USB_FUNCTIONFS_GENERIC=y
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_USB_G_SERIAL=m
+CONFIG_USB_MIDI_GADGET=m
+CONFIG_USB_G_PRINTER=m
+CONFIG_USB_CDC_COMPOSITE=m
+CONFIG_USB_G_ACM_MS=m
+CONFIG_USB_G_MULTI=m
+CONFIG_USB_G_MULTI_CDC=y
+CONFIG_USB_G_HID=m
+CONFIG_USB_G_DBGP=m
+CONFIG_USB_LED_TRIG=y
 CONFIG_MMC=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
@@ -310,6 +385,7 @@ CONFIG_PWM_TWL=y
 CONFIG_PWM_TWL_LED=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_TWL4030_USB=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
