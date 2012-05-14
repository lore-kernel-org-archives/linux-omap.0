From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 15:47:58 +0300
Message-ID: <20120514124757.GL22242@arwen.pp.htv.fi>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+0mKm/ENadSkQxF+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58867 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755830Ab2ENMts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 08:49:48 -0400
Received: by lbbgk8 with SMTP id gk8so3631026lbb.12
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 05:49:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120514122920.GK22242@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>


--+0mKm/ENadSkQxF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2012 at 03:29:21PM +0300, Felipe Balbi wrote:
> On Mon, May 14, 2012 at 03:24:11PM +0300, Tomi Valkeinen wrote:
> > On Mon, 2012-05-14 at 15:15 +0300, Felipe Balbi wrote:
> >=20
> > > looks like MUSB is probing before transceiver driver... could it be ?
> > > Can you check transceiver has actually probed ? I guess panda's using
> > > twl6030-usb.c
> >=20
> > Ah. Perhaps it's then about this?
> >=20
> > [    0.352905] Skipping twl internal clock init and using bootloader va=
lue (unknown osc rate)
> > [    0.354034] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
> > [    0.356079] VUSB: 3300 mV normal standby
> > [    0.358123] genirq: Threaded irq requested with handler=3DNULL and !=
ONESHOT for irq 356
> > [    0.358215] twl6030_usb twl6030_usb: can't get IRQ 356, err -22
> > [    0.358398] twl6030_usb: probe of twl6030_usb failed with error -22
>=20
> sounds about right. Now, why can't it get the IRQ... Benoit, is this
> related to your sparse irq/irq_domain changes ?

Looks like twl6030-irq still missed conversion to threaded IRQ. It still
has that ugly ass kthread to handle the IRQs. Oh well, yet another
broken OMAP driver...

--=20
balbi

--+0mKm/ENadSkQxF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsP79AAoJEIaOsuA1yqREGBAP/1B9esLtsk2FrD3bgYl4aPx1
yFcmBSWcZnqAVIOrlXbaltXemfEcBia1Zvx72Ztdbnc8fKu2UrtB0v5j2L70KOe/
bz4oWDUllwttQPKZKKIKOicyNW0r+m8DjC9mVMvpVVwi5Omsk5CRsNmAC6ir55WI
k4wPD86N79Zgs9OPKoP8PH+G/+aspVsT0owU0PdqFKTs+TTJ8zzqknzMtevSUtdx
9Fj1SWbif7tz4b24+fH6s/1Mpz8a4307O2+QT18aMqHoIkVQI8P4WPpGB70g+mk+
KcYW3W2QpzK1ugMSQjJjlwQIZf70zDTV75+dcor8U8uTs/YcM8CQBWBHGgFAo6LK
M+9OcnYc+X+OnHArEIbbND7HRlIefg111tDKjR8w+Au8CErtW22choZhJfSUUPlm
w/peKtRZ/It2/di9HpMMNTWkq5tG/HtFozMOsDSLJ5oB8JjBeC9y+VRlZEe9SkMx
uAEJugsIZAVo7/4cncz3KoHNUY12Slrztzi9Qc1J2/wHNeIZkmDV3fEUtw2j/bT9
4852+Wj/sEHLH723Tzs9YLLiidNgi6G9XBEQy6wY/AUUAPskmHjzKL3NWMAeI9gE
LFPYHBeQjZbXtHdua1MX7E9EQHgGGAsuXa5XwoI54GBleROzj7Ix13YciUn4GH7n
ERSm6BPOvJtaPGuENDEw
=5RMA
-----END PGP SIGNATURE-----

--+0mKm/ENadSkQxF+--
