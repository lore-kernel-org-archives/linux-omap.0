From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 09:24:38 -0600
Message-ID: <20141226152438.GE17430@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <20141226043719.GA7661@saruman>
 <549D4FAA.1040207@compulab.co.il>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbaLZPZZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Dec 2014 10:25:25 -0500
Content-Disposition: inline
In-Reply-To: <549D4FAA.1040207@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 26, 2014 at 02:08:10PM +0200, Igor Grinberg wrote:
> >> I think we should move omap2plus_defconfig to be mostly modular and
> >> usable for distros as a base. Most distros prefer to build almost
> >> everything as loadable modules. And my preference is that we should
> >> only keep the minimum rootfs for devices and serial support as
> >> built-in and rely on initramfs for most drivers. And slowly move
> >> also the remaining built-in drivers to be loadable modules.
> >>
> >> The reasons for having drivers as loadable modules are many. It
> >> allows distros to use the same kernel for all the devices without
> >> bloating the kernel. It makes developing drivers easier as just the
> >> module needs to be reloaded. And loadable modules protect us from
> >> cross-framework spaghetti calls in the kernel as the interfaces are=20
> >> clearly defined.
> >>
> >> Are there people really using SATA as rootfs right now on omaps?
> >=20
> > not that we know :-) The only platforms available today with SATA are
> > OMAP5432 uEVM and DRA7x EVM,
>=20
> I'm sorry... that is not true.

That's not what you have said thus far. So far you only said it *can*
have, you have not explicitly said a customer really *is* using rootfs
on SATA.

Personally, I really don't care. It's just a defconfig patch and
kernel configuration is very, very easy to change at any time. You can
even have an out of tree config fragment just turning SATA=3Dy again.

Have a look at scripts/kconfig/merge_config.sh

> > the latter being mostly used by TIers as of
> > now (at least from mainline point of view).
>=20
> the keyword is mostly... And I'm also not sure this is true these days...
>=20
> But, really, don't mind me. We will find our solutions (we always did).
> I mean, Felipe wants it out so badly...
> Who am I to say anything...

cute :-)

--=20
balbi

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnX22AAoJEIaOsuA1yqRE4sUQAJFyE4jJs1ufD2IpuNWmuEpd
TiLeoNAZCXejLuWD9cAEXpXPxYtwsNYJDvNNzOjWoE0S+t4cPQqxLfXvnFGShd5c
hZxxpOW6MGi1o89HPphd9nhX1k8GveUR7VZ2BaL+994HzTX6jkTP073K5twAuViX
tUBUhfzH5ffghmaoLaO6JbPQ9dip2HDvLAGIN+754A4sK1atJKSPQDlIpU0vGsbg
Qfqf8uZLMNNtSnq790ddWO9G45T62E91je0H1wbziAmjjTaFBpxGTj5lXlciWA14
Dzfb3oQFA15VSDFD0Htw8Huiki3ogr5EYNShH3QKNKhP+R/rDZGeHL5bB/POaotN
lu6BJXWZFi2xV+0OnEneL0rN6/dscvShnPss9byIMxtH7RsgN9RKNvtOBane88rf
zhTSZNfwLFedYb9fxK7O94ATU+27RCozx8Nko7L/vxLEr604FRMqbxmwZSz9aCca
3WoC87L5z4jewVxuyHsBM1OkZYJbFG2nWT99Sc1gUUgSR1vaAHPEGEqALsp+MpLq
gNWK7LlkaOdwW3yos77tNr8gadhJLoeygRKviHe6WItNx8Sjzo56i0Gbeiu690u4
+qFkaaFWau9MDXLwZ/0+exuQMHTx68E9NvPRdUUWX6hjj+s7rycld/qfeWxxYBCk
UGPxStUgEbYHp7XGp5sp
=YYcv
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
