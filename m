From: Sebastian Reichel <sre@debian.org>
Subject: Re: problem with "undefined instruction"
Date: Thu, 23 Jun 2011 21:53:53 +0200
Message-ID: <20110623195353.GA16800@earth.universe>
References: <20110430162357.GA14287@earth.universe>
 <20110606125600.GB20909@earth.universe>
 <20110607115331.GZ8696@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:54424 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932738Ab1FWTyJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 15:54:09 -0400
Content-Disposition: inline
In-Reply-To: <20110607115331.GZ8696@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2011 at 02:53:31PM +0300, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [110606 15:51]:
> > On Sat, Apr 30, 2011 at 06:23:57PM +0200, Sebastian Reichel wrote:
> > > I'm currently trying to get a mainline based kernel running on my pan=
daboard.
> > > The problem is, that it's crashing very early during the init phase b=
ecause of
> > > "undefined instruction" exceptions:
> > >=20
> > > [    1.867980] udevd (56): undefined instruction: pc=3D401e6ed4
> > > [    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > [    1.977752] modprobe (69): undefined instruction: pc=3D400c6ed4
> > > [    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > [    1.978240] init (1): undefined instruction: pc=3D40149ed4
> > > [    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> > > [    2.005706] Kernel panic - not syncing: Attempted to kill init!
> > >
> > > Exactly the same userland boots fine with the original 2.6.35 kernel,=
 so it's
> > > probably not the userland's fault.
> >=20
> > I found the source of this problem. VFPv3 support is not working
> > correctly when OMAP2 (and thus CPU_V6) is enabled in the kernel
> > config.
> >=20
> > I guess this should be mentioned in the kernel config (or fixed if
> > possible).
>=20
> This should be easy to fix now. Do you have a minimal test program that
> triggers this?

Sorry for the delay, here is a minimal test binary, that triggers
the bug: http://elektranox.org/omap-kernel/test

-- Sebastian

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOA5nRAAoJENju1/PIO/qaUHYP/j8ui25SF8WxstRzKZYwPZe+
R3oqZthjP+YevE8BXDsa/jEv2vFrGhOqKSiRjHIl5HTtsavL8u7I/27qw9KVUb3P
54dw/GWnjsOH1l8ev6w8BeKR1TVsEDdyyCAjygXnNroTXYxhVE86L4vZvonQgF/Y
RgckReSHpKapbJ//HPFhEMcUVdIqhTgab776Bx9B5pgoo8gV+SisIG6WxTsmGA+0
44yFpbfEV1xsvm/oyxXBih1AILKxWE/sPCrWYmd4gROLqydLgkxsUbamLNk6PoXe
hucguFADm9tQHiafmEOAMIGzsSlH3CClDXWfrB7DWAA+mxXxr9sMSMTvPptZt1C7
6m8J0IZIAOPVMP/S+727jn86MuZPzCQ8K5nycQ8pOumbtYpAFdNgnBdHQIXzzocC
vjaFwo+kcFpRUYSQV8fOlcYTG3fe13wkEarTFKB7Tf/v/cX/UEfY8CVyCgluMF5X
2UXanyT60p+gEDUjv/s8ozvtNTpbgM8oX+ZMGvHQ87saZigMlPk2Qoul2ZWYL211
dPEI9j0r3UGQoQSE65ajI+GyiqQ+cLhcOSEswUs0cVluB3h8eG6agZV5jaVw4xAR
Pxs4cujQoal15xny8tkLZKeuGUK51FPmqPllMEqkeU32XoB1fxF4XblfNqiyqhW1
kyRZa8KY7ewixCyDyeNx
=Clzi
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
