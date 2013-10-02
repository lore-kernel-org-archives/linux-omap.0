From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] dma: cppi41: move -EAGAIN in tear_down
Date: Wed, 02 Oct 2013 12:25:11 +0200
Message-ID: <524BF487.20105@linutronix.de>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <1380634271-27588-4-git-send-email-zonque@gmail.com> <20131002082914.GA16680@linutronix.de> <524BE518.8060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41816 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab3JBKZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 06:25:14 -0400
In-Reply-To: <524BE518.8060008@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 10/02/2013 11:19 AM, Daniel Mack wrote:
> Hi Sebastian,

Hi Daniel,

> On 02.10.2013 10:29, Sebastian Andrzej Siewior wrote:
>> * Daniel Mack | 2013-10-01 15:31:11 [+0200]:
>=20
> Thanks a lot for having a look! As I'm going to be off for a couple o=
f
> days now, and only be able to read my mails sporadically, maybe you c=
an
> also try the musb suspend functions on your hardware. I'll give you a
> quick wrap-up of how my test setup looks like.
>=20
> On an AM33xx board, I have a host-only (type A) connector with a USB
> memory stick plugged in. The relevant config settings are:
>=20
> CONFIG_USB_MUSB_HDRC=3Dm
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> CONFIG_USB_MUSB_DUAL_ROLE=3Dy
> # CONFIG_USB_MUSB_TUSB6010 is not set
> # CONFIG_USB_MUSB_OMAP2PLUS is not set
> # CONFIG_USB_MUSB_AM35X is not set
> CONFIG_USB_MUSB_DSPS=3Dm
> # CONFIG_USB_MUSB_UX500 is not set
> CONFIG_USB_MUSB_AM335X_CHILD=3Dm
> # CONFIG_MUSB_PIO_ONLY is not set
> CONFIG_USB_TI_CPPI41_DMA=3Dy
> CONFIG_TI_CPPI41=3Dy
>=20
> Once the system is booted up and the USB media is detected, I send th=
e
> system to sleep mode with "cat mem >/sys/power/state". After wakeup, =
I
> access the media by mounting and unmounting it once, then send the
> system back to sleep.

Okay. Going to sleep is probably easy, I need to figure out how to
wakeup=E2=80=A6

> Repeating the above cycle multiple times will sooner or later make th=
e
> warning kick in without the discussed patch. Sometimes it happened on
> first try, sometimes it took me up to ~20 cycles to make it happen.

Ah. Okay.

> I'd be curious whether you see the same behavior on your board as wel=
l,
> and whether the fix work for you, too.
>=20
> For reference, I just pushed my current working tree here:
>=20
>   https://github.com/zonque/linux/tree/am33xx-3.12

Thanks.

>=20
>=20
> Thanks,
> Daniel
>=20
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
