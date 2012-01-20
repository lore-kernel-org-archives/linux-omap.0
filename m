From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 13:07:24 +0200
Message-ID: <1327057644.1921.59.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-g9/gtZoXQoQ2mO+4miM3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55794 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733Ab2ATLHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 06:07:31 -0500
Received: by lagw12 with SMTP id w12so300354lag.0
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 03:07:28 -0800 (PST)
In-Reply-To: <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-g9/gtZoXQoQ2mO+4miM3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-20 at 16:19 +0530, Govindraj wrote:
> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Hi,
> >
> > I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
> > related to PM.
> >
> > First, when I boot up, the console (via USB serial) is very laggy, it
> > often takes many seconds until the key pressed appears so it's more or
> > less unusable.
>=20
> can you try enabling CONFIG_CPU_IDLE ?

Enabling CPU_IDLE does remove the problems. I don't know what it's
supposed to do, but it seems to keep the MPU and DSS in ON state all the
time, so the problem disappears.

 Tomi


--=-g9/gtZoXQoQ2mO+4miM3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGUrrAAoJEPo9qoy8lh7157gQAI1Pd8fmLsSG5yPIHkSr+Z9Z
T/qppHWIjjFc3qKoHT7mKBmRj2wiVa4qlK9z+HwAgjg87ofGH47sinMoljjYWqyO
FAZBh2CNfCBSYDmgXFSYwjXPR0//9V0UXNX2QcCXUzk+PrL/UMxDBkRIUQUypuW3
U3SHSsSxbLfDLxaTurKXfD8173SFNOxxDRedKKlShiJYJwzKolx14MoAZVHBx9Gc
Fro2NB6AwuFldCIwQAwe60HfoZayl4rqFGv/6DGuBkJ6sPyTEvKgga1EXBgOGLey
lKobYvH2Y3ftu+EkX4OKA1GVx1ul2/ahqi8RlL/6SOzO1+N7XIeZYDyRruxJV2cq
iXGylTtG+o/KMzR6dgYXsOHHsdkVnGKvlDAE2cgoDBs0NRQyG2NnI9zgXZLl1obw
V96rQW//gpoljBII2TeQctrqqrKwYHPRuJJb/OtoNZom/iqzjWj2+kuNhTz4Ig1V
KvmJq8FK7X6yXuZ7LqMpThfS/U7WmFP8h84ov4rZticKO4ppZPZzsgcmmPTCJ/zs
MptxFxbVKR/r745YWqAYtiyhHx/bULfWs//+3SiQgwQiWWiBckySo0NFstg1QeuQ
kLya9xuNutvGiFbFmnJRxFORY1IJtX68coGaBZun9WtsIeEi3iEoTn6MrPKGKPZG
ZMUB9z50dTG31arzGVNr
=m7YP
-----END PGP SIGNATURE-----

--=-g9/gtZoXQoQ2mO+4miM3--

