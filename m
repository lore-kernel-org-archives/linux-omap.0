From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: New build warnings
Date: Sat, 8 Sep 2012 09:38:49 +0100
Message-ID: <20120908083849.GA1603@n2100.arm.linux.org.uk>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56358 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab2IHIiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Sep 2012 04:38:54 -0400
Content-Disposition: inline
In-Reply-To: <20120730164444.GO6802@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Mon, Jul 30, 2012 at 05:44:44PM +0100, Russell King - ARM Linux wrot=
e:
> Okay, so last night's build run shows some new warnings...
>=20
> drivers/regulator/twl-regulator.c: In function 'twlreg_probe':
> drivers/regulator/twl-regulator.c:1151: warning: assignment discards =
qualifiers from pointer target type
> drivers/regulator/twl-regulator.c:1160: warning: assignment discards =
qualifiers from pointer target type
>=20
> These two look like missing const - looks like they were introduced b=
y:
>=20
> commit 98d7bbb9929bcc14e11ac8a55245a4f2dc174e17
> Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Date:   Thu Jun 7 12:20:14 2012 +0200
>=20
>     of: add const to struct *of_device_id.data
>=20
>     Drivers should never need to modify the data of a device id. So i=
t can
>     be const which in turn allows more consts in the driver.
>=20
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>

I notice this one is still present in the kernel.  Uwe, what's happenin=
g
with it?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
