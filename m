From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 18:32:07 +0200
Message-ID: <20130220163207.GM16652@arwen.pp.htv.fi>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
 <20130220152940.GE16652@arwen.pp.htv.fi>
 <5124F3D4.1060307@ti.com>
 <20130220162722.GL16652@arwen.pp.htv.fi>
 <5124FA53.8000808@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab3BTQcP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 11:32:15 -0500
Content-Disposition: inline
In-Reply-To: <5124FA53.8000808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 10:01:15PM +0530, Santosh Shilimkar wrote:
> On Wednesday 20 February 2013 09:57 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Wed, Feb 20, 2013 at 09:33:32PM +0530, Santosh Shilimkar wrote:
> >>>>  	default:
> >>>>  		/* Unknown default to latest silicon rev as default*/
> >>>>-		omap_revision =3D OMAP5430_REV_ES1_0;
> >>>>+		omap_revision =3D OMAP5430_REV_ES2_0;
> >>>
> >>>how about we default to 0xffffffff ? That's the highest possible
> >>>version, just not sure if our revision macros can cope with it.
> >>>
> >>:D
> >>For record, it was decided that we will always have latest silicon
> >>spin as default and hence OMAP5_ES2
> >
> >but then this line will forever be modified. Every year or so :-p
> >
> No... Unless and until we spin new silicon revision for OMAP5
> every year. This is OMAP5 specific ID code function.

oh, right. nevermind then

--=20
balbi

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJPqHAAoJEIaOsuA1yqREXskQAK8oAJ435njgzDuAmrmTUqiG
fMqEwGawKo6ssU4aTSoDo67/nSNntG1P1R1eorQGZYCR3eQetlEPZAzHx9WpAv74
QjJBBNke13g8mN+AlTtJmFiysZNYfcL0iVTvJrGD83IGvzjOX1XdDH3YNOnhycvT
z7CBrXiL9FVVHrsUlQHH4XpeobnJ1C02M6/aaUAsjuOSZ88uX9BU4JHDwutgXvI3
kc/JCQX3/SS8DaRwJh0WiAeSptmS5l59Llp36BDj18abFHjsPcgB05yOeIrKEP+r
sAdOZ7UAebBNQk7ciqXBRxq0nh1gF/mU5Bfg0qAboSvvYDZaI5eRClWx5QKv4zSH
Dcd7OfCaTEo/ok0Qw5mwYBESPGPAK8EcQ8dZv1hS3ID5q9LinSUIhvtMW7Ngpmlh
Ch97diXZj5JimwZZQQqCf0/R3pNy8M6saawZ6CmF5ugGYbYYIWVhkPsGn0zF9zyH
bD20RhvAKOWrXZSonfeJXdwiutZ/OG1Cx2L3WUtGGuZIojj5KFhD0ApVtHVT9zvC
SE2nFpNsbt8IupNkm6CLXk1fOBLfV64i4rDGTVA+8vT6nLbALNgAbllc8YcLy9my
8/dUopcMSujI/bosjeOMd7f52PcrHjrZkkW/hytIW32c6UBUUgLfiqFEAYEPi2xl
qDqDvb9qMJZHrVeH+hQO
=Ooxm
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
