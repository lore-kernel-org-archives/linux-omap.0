From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: OMAP3530 EVM latest sources uploaded on linux.omap.com
Date: Fri, 15 Aug 2008 19:50:07 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C1652B@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00208C16525@dbde02.ent.ti.com>
 <20080815135444.GP16231@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:51827 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689AbYHOOUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 10:20:22 -0400
In-Reply-To: <20080815135444.GP16231@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Friday, August 15, 2008 7:25 PM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP3530 EVM latest sources uploaded on linux.omap.com
> 
> On Fri, Aug 15, 2008 at 06:57:45PM +0530, Syed Mohammed, Khasim wrote:
> > Hi all,
> >
> > I have uploaded latest version of kernel, u-boot and x-loader for OMAP3530 EVM on linux.omap.com,
> >
> > http://linux.omap.com/pub/kernel/3530evm/2.6_kernel-v2.tar.gz
> > http://linux.omap.com/pub/bootloader/3530evm/u-boot-v2.tar.gz
> > http://linux.omap.com/pub/xloader/3530evm/x-load-v2.tar.gz
> >
> > The kernel source should contain support for following drivers:
> >
> > - Audio
> > - OneNAND Driver
> > - NAND Driver
> > - USB Driver
> > - Display Driver with DVI support
> > - Resizer Driver
> > - Capture Driver
> > - Ethernet Driver
> > - MMC/SD Driver
> > - Touch Screen Driver
> > - Keypad driver
> > - Power Management
> 
> No tv out ??
> 

TV-out is still there, I just populated it based on driver set than devices itself, I specifically marked DVI to give a hint as I found many requests for the same.

> I see you have omap_dispc_enable_digit_out() but there's nothing using
> it :-s
> 
> Is there an easy way to test it ?
>
You mean DVI?

Following shows an example of how to switch to DVI output and how to set the 720P mode on DVI and how to direct output of graphics to channel0.

echo DVI > /sys/class/display_control/omap_disp_control/ch0_output
echo 720P > /sys/class/display_control/omap_disp_control/ch0_mode
echo channel0 > /sys/class/display_control/omap_disp_control/graphics

This is new method of switching between DVI, LCD and S-Video with different modes associated with respective devices

Here we are treating each overlay as a channel. So there are two channels available. It creates four new attributes in sysfs, ch0_output, ch1_output, ch0_mode, ch1_mode. This sysfs attributes are setting/getting output device and modes on that channel. For channel-0, there are two possible outputs, LCD and DVI. Modes supported for DVI output are 720P and 480P and VGA for LCD output. Channel-1 supports SVIDEO as the output, which supports all NTSC and PAL modes. Application can write name of output device and mode to appropriate channels (overlay) to set them on that channel. Moreover, when we change the output of the channel, default mode on that output will be set by default. Each of the pipelines can be directed to either channel0 or channel1.

I will try to find out a user guide to share with all, should give more info per driver.

Regards,
Khasim

