From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Wed, 27 Jun 2012 07:19:58 +0300
Message-ID: <1340770798.1972.4.camel@lappyti>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	 <1340372890-10091-6-git-send-email-rnayak@ti.com>
	 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
	 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
	 <1340630090.3395.85.camel@deskari> <20120627004709.GA22766@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IKr2dmi1G4UGv7F1Nm1d"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:51010 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929Ab2F0EUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 00:20:10 -0400
Received: by lban1 with SMTP id n1so1032386lba.24
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 21:20:07 -0700 (PDT)
In-Reply-To: <20120627004709.GA22766@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org


--=-IKr2dmi1G4UGv7F1Nm1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 17:47 -0700, Mike Turquette wrote:
> On 20120625-16:14, Tomi Valkeinen wrote:
> > A question about clk_prepare/unprepare, not directly related: let's say
> > I have a driver for some HW block. The driver doesn't use clk functions=
,
> > but uses runtime PM. The driver also sets pm_runtime_irq_safe().
> >=20
> > Now, the driver can call pm_runtime_get_sync() in an atomic context, an=
d
> > this would lead to the underlying framework (hwmod, omap_device, I don'=
t
> > know who =3D) enabling the func clock for that HW. But this would happe=
n
> > in atomic context, so the underlying framework can't use clk_prepare.
> >=20
> > How does the underlying framework handle that case? (sorry if that's a
> > stupid question =3D).
> >=20
>=20
> I think it's a good question!
>=20
> If we're going to call clk_prepare_enable from within a runtime pm
> callback then I think we'll need to check if _irq_safe() is set and
> conditionally call only clk_enable in such a case.
>=20
> I'm not a runtime pm expert, but if the driver owns the responsibility
> of calling pm_runtime_irq_safe then the driver has the proper context
> to know that it should call clk_prepare BEFORE calling
> pm_runtime_get_sync.

That's not quite what I meant. If it's the driver that does clk_enable,
be it in runtime PM callback or not, it's driver's responsibility.

But some clocks are not handled by the driver, but the hwmod/omap_device
framework. Mainly I think this is for the functional and interface
clocks. The driver has no visibility to those, they are implicitly
enabled via pm_runtime_get.

 Tomi


--=-IKr2dmi1G4UGv7F1Nm1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6onuAAoJEPo9qoy8lh71bKAP/0Rh5VQiioIGddHgKhLP6Mz3
Ea671TWLW5lepuIunpXTkSNIylx4GzulM+sUTo4UWVS8tlJyEeyzMP5ZdFbtg3zM
NuZ6iGBgFG7qYthGKYGA/jiPA60qLxeGMqlouUpZ4/lhWju2SP0m9eV/zUdkXAh8
E6FuKgxAeUXYbL85u9wW6TC7HS6zAQReJCabSFHN26MRwXZVrGRmPRRcD8Pucu3L
5m0ds/Zo/imlHxSGqiuaexgmxn3Uuemkfwc758IbjNi+0k+BW4wHcpvuWIPC80OI
GU353mLQkTKfxLqLhLD4Op2o6JsJwulvbHSZSUikcKWfUDVLuP8bL9ptmHLpwOBK
rPIqfhbIfpl70yKQ83Gt9HR2FVIytsBytJUxXa/t5gu8SabEoA+S1OttRKpLUtnb
Aus2QhCkOnM/QygodjJUbA2XgButswpPrC5QkiPTBvDu48irid5WvzoMLGCzjCrX
23lz/XJpdJYVUfwhko8iF/afrxkjw34M44Cur8bBmOdl5rxwK4JtupIx07qL54tF
/azVndDJK6lY+2aif+onxREcJP/sb/tjoPL5QKad4KCju37FzMzFAhuYK7SkMHtH
GiAwMiNP2eO68x/rmP8hV15wrH84e5tBcytS2PO4B/R9waAJ7ITc/y24iFNWXpoe
rpluyATAri7HE8CHiRMq
=lpj8
-----END PGP SIGNATURE-----

--=-IKr2dmi1G4UGv7F1Nm1d--

