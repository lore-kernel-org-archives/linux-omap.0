From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Query ISP1301 with OMAP
Date: Thu, 15 May 2008 17:46:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087012929E715@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC356087012929E676@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43004 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYEOMQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 08:16:51 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087012929E676@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Query ISP1301 with OMAP

Another observation:
There is a comment in isp1301_omap.c file:

static void power_up(struct isp1301 *isp)
        /* do this only when cpu is driving transceiver,
         * so host won't see a low speed device...
         */

Could anyone give more details as to what this means?
When will OHCI host see a low speed device (even when no device is connected)?

In this state, the OHCI portsc register is: reg-0x48064454 => 0x10301
And ISP1301 register value is:
ISP1301_INTERRUPT_SOURCE= 1a => DM_HI

I have ensured in h/w that DM line is not pulled high at all.

>
>
> I am facing issues with configuring ISP1301 in 3-pin Host only mode.
>
> I have a board with ISP1301 connected in 3-pin mode to OMAP3430-OHCI
> controller.
> I am trying to reuse the file: drivers/i2c/chips/isp1301_omap.c to
> configure in HOST only mode.
>
> I have setup the OHCI HCD successfully, but what I observe is that with or
> without the device,
> OHCI is getting a "LOW SPEED" device attach interrupts.
>
> I am suspecting something going wrong with ISP1301. Any clues from logs?
>
> Logs:
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> usb usb1: Product: OMAP OHCI
> usb usb1: Manufacturer: Linux 2.6.24.5-omap1-arm2 ohci_hcd
> usb usb1: SerialNumber: ohci-omap.0
>
> >
> >usb 1-1: new low speed USB device using ohci-omap and address 2
> >
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
>
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
>
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
> usb 1-1: device descriptor read/64, error -62
>
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
>
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
>
>  OHCI-IRQ 46
>
>  OHCI-IRQ 44
> usb 1-1: device descriptor read/64, error -62
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
