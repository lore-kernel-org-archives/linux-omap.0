From: Felipe Balbi <balbi@ti.com>
Subject: Re: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Date: Tue, 24 Feb 2015 08:46:39 -0600
Message-ID: <20150224144639.GE29829@saruman.tx.rr.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
 <20150224030141.GR32521@atomide.com>
 <20150224031547.GB15941@saruman.tx.rr.com>
 <20150224032107.GS32521@atomide.com>
 <20150224032450.GT32521@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbbBXOrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 09:47:33 -0500
Content-Disposition: inline
In-Reply-To: <20150224032450.GT32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 23, 2015 at 07:24:50PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150223 19:29]:
> > * Felipe Balbi <balbi@ti.com> [150223 19:19]:
> > > On Mon, Feb 23, 2015 at 07:01:42PM -0800, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [150223 18:43]:
> > > >=20
> > > > Looks like the address is 0 for "Custom Error". Anyways, reverting
> > >=20
> > > yeah, that's because the error comes from l4per2, not l3 :-)
> >=20
> > Right so it seems :)
> > =20
> > > > a fix for similar issue found on omap3 so far seems to help, that's
> > > > 3d009c8c61f9 ("gpio: omap: Fix bad device access with setup_irq()").
> > >=20
> > > if we revert that, we regress omap3, right ?
> >=20
> > Yes we saw that getting triggered on omap3/4 before 3d009c8c61f9.
> >=20
> > Now looking at the stack trace again, it actually has something:
> >=20
> > ...
> > [<c05999a4>] (__irq_svc) from [<c0599164>] (_raw_spin_unlock_irqrestore=
+0x34/0x44)
> > [<c0599164>] (_raw_spin_unlock_irqrestore) from [<c0027120>] (omap_hwmo=
d_idle+0x34/0x44)
> > [<c0027120>] (omap_hwmod_idle) from [<c00283f8>] (omap_device_idle+0x38=
/0x78)
> > [<c00283f8>] (omap_device_idle) from [<c0028454>] (_od_runtime_suspend+=
0x1c/0x24)
> > [<c0028454>] (_od_runtime_suspend) from [<c03b5214>] (__rpm_callback+0x=
2c/0x60)
> > [<c03b5214>] (__rpm_callback) from [<c03b5268>] (rpm_callback+0x20/0x80)
> > [<c03b5268>] (rpm_callback) from [<c03b56b8>] (rpm_suspend+0xe8/0x55c)
> > [<c03b56b8>] (rpm_suspend) from [<c03b6bdc>] (pm_runtime_work+0x74/0xa8)
> > [<c03b6bdc>] (pm_runtime_work) from [<c0054608>] (process_one_work+0x1b=
0/0x4a0)
> > ...
> >=20
> > If it's the gpio-omap, there's probably some confusion still in
> > the driver regarding the GPIO bank idle status. Anyways, will look
> > more into it tomorrow.
>=20
> And now I'm seeing the error with 3d009c8c61f9 reverted, so it
> does not seem to be that either..

well, that's good :-)

--=20
balbi

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7I7PAAoJEIaOsuA1yqREZvMQAJOds+fvTdEKmHBt+p9djjX0
hP3kgHw+PyU4MtZM13PDyXmd5421QDqJtUvyNULbMJviJjK6ouye2/ar68l+ycYo
dtmkhwEX5XJsUn1jCS3r60IYWBi19dH7Up28A9Ds1NTEPwUw1amcCD1Qav/F5Os1
47i0FkZaA2C77RBvgL3J/ya/XH/stnrxjbwn0HQmyTqMxn1Ar4IVst05s4EX53Xw
lvym7Nmv3DyyBAIXifPLq3BNBS7vrqRdxBlAfKgPC9ZjdXZaXcWGae8WQlY9puQF
NCayiD7Y88RJ7gxvHb2g6JcMemFvOd0av34tlvYajxZcXD+Kp+wW0csCArMO1ahK
yOF8CgwW5cpHzAFjUxMMBzTUVvcm+ESO1R3XnYpqrmCF0lLpcdO/7IYpdLx6iyJC
Vq6K0N9PxHpmFjhyMuUxVVWZGgmuXbIwrvQqID+lo4woRtGW4LyOndY0Y22zigDF
EOvRf3C8b2UW45auPodhA3yJSKLTFZeP2jTv3+pzmXs5htxALUroKNlwxp08AAwf
tGcgumy3VBL7kVyS4gBlXqgzFHCbOLjKiBJfqhkHxAiCwFhcuepFcti4QCfjtN02
RQdGdI5GOZWGDg2QeBIp0Z8MW2BkXwWshvrr41J5AARozxelxGCTqsFZ6EA2xcLX
SwXcGScLD/DBCARThp1K
=nBRR
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
