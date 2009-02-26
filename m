From: "Kang, Minkyu" <mk7.kang@samsung.com>
Subject: RE: [PATCH 2/2] twl: usb: Add the resume() and suspend() methods	to
 twl4030-usb.c (re)
Date: Thu, 26 Feb 2009 10:33:41 +0900
Message-ID: <001101c997b2$417613c0$c4623b40$%kang@samsung.com>
References: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486@mail.gmail.com>
 <49A5DA3E.6040608@samsung.com> <20090226001219.GJ4639@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52467 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZBZBdt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 20:33:49 -0500
In-reply-to: <20090226001219.GJ4639@gandalf>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: 'Kim Kyuwon' <chammoru@gmail.com>, linux-usb@vger.kernel.org, 'OMAP' <linux-omap@vger.kernel.org>, 'David Brownell' <david-b@pacbell.net>, q1.kim@samsung.com

> I mean, what you're doing here is that you would allow twl4030 to enter
> low power mode even though we're connected to host side, meaning we
> would never get awaken by the host side, right ?

Yes, right.
If usb is connected to host side, our system never sleep because of usb
interrupts by host.
We don't want this.
We want to enter sleep mode quietly without any disturbance even if usb is
connected to host side.(And we need to reduce power consumption)
This patch gives option for these reasons.
If you don't want this option, please set suspend_enabled = false in the
board specific configuration.

> Is that really wanted ? I mean, how would you then wake the device ?

Our system is waked when get wake-up interrupts such as IO pad wake-up
events and other wake-up events from peripheral devices.
When it wakes up devices, usb device will be waked too.

---
Minkyu Kang.

-----Original Message-----
From: Felipe Balbi [mailto:me@felipebalbi.com] 
Sent: Thursday, February 26, 2009 9:12 AM
To: Minkyu Kang
Cc: Kim Kyuwon; me@felipebalbi.com; linux-usb@vger.kernel.org; OMAP; David
Brownell; q1.kim@samsung.com
Subject: Re: [PATCH 2/2] twl: usb: Add the resume() and suspend() methods to
twl4030-usb.c (re)

On Thu, Feb 26, 2009 at 08:54:38AM +0900, Minkyu Kang wrote:
> The MPU module can be waked up by the unexpected USB
> interrupt(HSUSB_MC_NINT). For instance, if the MUSB is working as
> peripheral mode and connected to a host PC, it can never enter the low
> power mode due to interrupts from the host PC. This patch added the
> feature that a board specific file can determines that TWL4030
> supplies the USB power or not in the low power mode. Disabling the USB
> power may save the power consumption.
> 
> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
> ---
>  drivers/usb/otg/twl4030-usb.c |   25 +++++++++++++++++++++++++
>  include/linux/i2c/twl4030.h   |    1 +
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index 416e441..b725be2 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -256,6 +256,7 @@ struct twl4030_usb {
>  	u8			linkstat;
>  	u8			asleep;
>  	bool			irq_enabled;
> +	bool			suspend_enabled;

before we ack it and let it go through, could you please explain a bit
more the necessity of this ?

I mean, what you're doing here is that you would allow twl4030 to enter
low power mode even though we're connected to host side, meaning we
would never get awaken by the host side, right ?

Is that really wanted ? I mean, how would you then wake the device ?

-- 
balbi

