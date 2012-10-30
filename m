From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Tue, 30 Oct 2012 17:10:29 +0200
Message-ID: <20121030151029.GD29159@arwen.pp.htv.fi>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
 <508E266C.6090901@ti.com>
 <20121029080523.GC13657@arwen.pp.htv.fi>
 <508E3D09.9090802@ti.com>
 <20121029200328.GE30152@arwen.pp.htv.fi>
 <508F7471.8060402@ti.com>
 <20121030070904.GB1978@arwen.pp.htv.fi>
 <508FE142.2020408@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52126 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab2J3PQY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 11:16:24 -0400
Content-Disposition: inline
In-Reply-To: <508FE142.2020408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: balbi@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Linux OMAP List <linux-omap@vger.kernel.org>

--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 09:16:34AM -0500, Jon Hunter wrote:
> Hi Felipe,
>=20
> On 10/30/2012 02:09 AM, Felipe Balbi wrote:
>=20
> ...
>=20
> >> its bit of an issue to take care. How do you ensure that GPIO
> >> does idle on SOC idle C-state attempts in such cases. Today that
> >> job is done by omap_gpio_[prepare/resume]_for_idle.
> >=20
> > that's only there because we pm_runtime_get_sync() on gpio_request() and
> > pm_runtime_put_sync() only on gpio_free().
> >=20
> > That's the problem IMHO. And that's easy enough to 'fix':
> >=20
> > call pm_runtime_mark_last_busy(); pm_runtime_put_sync_autosuspend();
> > also on gpio_request() and pm_runtime_get_sync() on gpio_free().
>=20
> Sounds like a good approach. I have been discussing with Kevin and I
> need to look more at the resume handler as we are working around some
> old issues in there and with this approach the resume following idle
> will be delayed and we were not sure if there could be any implications
> for omap2. I am hoping not, but we need to look into this.
>=20
> So I am wondering if we should just take Tim's original proposal for now
> and then I will look into improving this long term. I really need to
> clean-up the suspend/resume stuff for gpio and so may be we can make
> that a separate change. What do you think?

that'll cause a regression right ?

> > The difficult part, IMHO, is to figure out what's a good autosuspend
> > timeout to use. Some GPIO lines are used as IRQ lines on some devices,
> > that means that the GPIO will be periodically triggered and, depending
> > on our timeout, we will either loose IRQs or prevent power domain from
> > idling. We could figure out a way to let board code to choose what it
> > wants on a per-bank basis (maybe some extra DT attribute).
>=20
> I have also been bending Kevin's ear on this, this week and we were
> wondering if we should make the default 0 for now as this will have the

I believe you mean -1 here ;-)

> same behaviour that we have today but would allow Tim to customise via
> the sysfs for his specific app.

sysfs might be too late for his platform. What if he needs NFS root
(just wondering, not sure about his use case) ?

--=20
balbi

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj+3lAAoJEIaOsuA1yqRE4L8P+wUo9SvHSzeIntHb2A9TpmQ6
WsqTDcvGOSVon/1C7vTMLVHKLSEfVQ5b1ARI1GqsNxJCnP12ABbeoFAHD8F7fA2z
rWDbBjoYx67it81F1eaiatBTea+V3GuJ1B0VawmoltA98IY21dkdKnzWCxbyh5t9
kBM4Zu1TJgXinBkIkAv8lmZeY8UxyelCCO/efNOmjaUD8wmfsCMSd6Yo+APXRPIE
OEEXiSHh4uKOgXvXvQEknsvmBP63wH2Du8Rq0Cll/Jh5TwEmlGx4BwhoQWddpgEx
ZTd5veN35wKEJZwYBAhNi43p1XstuxwBzgINgQCoMKoAqTHz/bxcoFkziyZ2WAvQ
x8gacfv8bA+55ybWXGkshdUuqmVuqiIUA5TvJNOaC0NK3Td9qwdAcFs0k4VeKnOW
n5yZ3xRpaRuyEJAuidLlk0I7Ybd542iOgULnFHj5hj5jxFybgkg/Tp7H2C3tKH/W
Xf43GJamkGJqPXRJiKJIlTXvSZIXl0Wje4FFTLFc/hOgOi66kjlcQFyWyBH3JPRB
5gemc4d+Vq4qlWPiXckbqZ9/bFoEqlHgMVtAoOJR9jqbwIeda7Eef1tynWJ8Mhkc
UFTyRGfJhXi+X9icxwCPwl4veMLgJHEZivTv4V4fb8E4n12x/Q5I/syS95UoSlAm
zq7LdmUrOWSkNpUSWOEM
=Czsg
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
