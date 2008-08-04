From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] TWL4030 bugfixes and cleanups: version 2
Date: Mon, 4 Aug 2008 17:16:00 +0300
Message-ID: <20080804141559.GI8885@atomide.com>
References: <20080722234351.16719.89367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64489 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbYHDOQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:16:10 -0400
Content-Disposition: inline
In-Reply-To: <20080722234351.16719.89367.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Peter De Schrijver <peter.de-schrijver@nokia.com>

* Paul Walmsley <paul@pwsan.com> [080723 08:11]:
> [ This is the second version of these patches - they now check the
> SIH_CTRL.COR bit to determine whether to read or write to clear ]
>=20
> At boot, twl_init_irq() tries to mask off all TWL4030 secondary
> interrupts and clear them, since no secondary interrupt handlers are
> registered yet (that happens later in the boot).
>=20
> However, this code is flawed.  MADC, BCI, keypad, and GPIO ISRs are
> either not cleared or are incompletely cleared.  Some BCI register
> addresses are nonsensical.  And some code attempts to clear ISRs
> before masking IMRs, which is race-prone (an interrupt could occur
> after the ISR clear, but before the mask).
>=20
> These problems can cause large numbers of boot messages similar to
> this:
>=20
>     TWL4030 module irq 368 is disabled but can't be masked!
>=20
> and I2C transmit overflows, both observed during boot on the
> BeagleBoard here.  The actual IRQ number sometimes varied depending o=
n
> which interrupt was unacknowledged.
>=20
> This series fixes these issues and does some code cleanup, saving 272
> bytes.
>=20
> Thanks to Philip Balister <philip@balister.org>, Koen Kooi
> <k.kooi@student.utwente.nl>, M=E5ns Rullg=E5rd <mans@mansr.org>, Stev=
e
> Sakoman <sakoman@gmail.com> and others on #beagle for help tracing
> these problems.
>=20
> Thanks also to Peter De Schrijver <peter.de-schrijver@nokia.com> for
> help with this second version, allowing several unnecessary I2C
> transactions to be elided from twl_init_irq().
>=20
> Tested on BeagleBoard rev B4 (3530ES2.2).

Pushing this series today.

Tony

>=20
>=20
> - Paul
>=20
> ---
>=20
> size:
>    text    data     bss     dec     hex filename
> 3076157  142840  104248 3323245  32b56d vmlinux.beagle.orig
> 3075885  142840  104248 3322973  32b45d vmlinux.beagle
>=20
> diffstat:
>=20
>  drivers/i2c/chips/twl4030-core.c   |  383 ++++++++++++++++++++++----=
----------
>  drivers/i2c/chips/twl4030-gpio.c   |   48 -----
>  drivers/i2c/chips/twl4030-pwrirq.c |   15 +
>  include/linux/i2c/twl4030-gpio.h   |   76 +++++++
>  include/linux/i2c/twl4030-pwrirq.h |   37 +++
>  5 files changed, 359 insertions(+), 200 deletions(-)
>  create mode 100644 include/linux/i2c/twl4030-gpio.h
>  create mode 100644 include/linux/i2c/twl4030-pwrirq.h
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
