From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] OMAP3+: boards: Fix the __initconst build error for
 devicetree/test branch
Date: Fri, 19 Aug 2011 17:40:15 +0300
Message-ID: <20110819144014.GU23101@legolas.emea.dhcp.ti.com>
References: <4E4E7200.6080202@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yC91f7qSViS67v3c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:32974 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754161Ab1HSOkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 10:40:19 -0400
Received: by mail-bw0-f50.google.com with SMTP id zu5so2252017bkb.9
        for <linux-omap@vger.kernel.org>; Fri, 19 Aug 2011 07:40:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E4E7200.6080202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Fri, Aug 19, 2011 at 04:24:00PM +0200, Cousson, Benoit wrote:
> Hi Grant,
>=20
> The current devicetree/test branch is broken due to the introduction
> of the __initconst for dt_compat table.
>=20
> My original basic fix is the following one, but Felipe figured out the
> root cause. So it can be fixed by adding an extra const to make the
> whole table const:
> -	const char		**dt_compat;	/* array of device tree
> +	const char		* const *dt_compat; /* array of device tree
>=20
> That fix will require fixing all the current users of dt_compat with
> something like that:
>=20
> -static const char *omap3_beagle_dt_match[] __initconst =3D {
> +static const char * const omap3_beagle_dt_match[] __initconst =3D {
>=20
> A couple of of_XXX APIs will have to updated as well, that's why I was
> wondering if you wanted to go that way.
>=20
> Any thought?

the funny thing is that this was not happening with CodeSourcery 2011.03
when I sent the patch.

Maybe it's either a compiler bug on one of the toolchains or newer GCCs
are smart enough to create another section ??

But then again, 2011.03 isn't compiling sleep34xx.S:

arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does not sup=
port ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:418: Error: selected processor does not sup=
port ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:429: Error: selected processor does not sup=
port ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:454: Error: selected processor does not sup=
port ARM mode `smc #0'
arch/arm/mach-omap2/sleep34xx.S:460: Error: selected processor does not sup=
port ARM mode `smc #0'
arch/arm/mach-omap2/sleep34xx.S:465: Error: selected processor does not sup=
port ARM mode `smc #0'
make[1]: *** [arch/arm/mach-omap2/sleep34xx.o] Error 1

so it might be better to keep 2010.09 working.

--=20
balbi

--yC91f7qSViS67v3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOTnXOAAoJEAv8Txj19kN1dUIH/1O2q0txu/5aZJjEL7rDwBq1
lgYPrSgyJ+XUZWbzH8jZxnBsCpuuL21aEasH2iJokstBV9GpQfnWlPx3BA77lQpG
TMJtYeORrCTzorbNcMJczWp4OwwnL4DGdvJID/Puwdnn3YoiZrSqRra3IpeSOy8Y
am0gFsvlaQqXIuj5agqERbW3TOGmEgala5GBedKxR8kpfwRp2FgR27hGPZFIfcf3
Ct9pl97BGzP72Infcymux7M7baiuZC/y/NpCcSx+kIH6ekRzkDvTld3cjXSoTX2x
MgsHzhwt5O7qxuYE3PN2p0Vl+oqmIAXOtDDLSWlCQ35bgoYlke3KGQErxBuwhz0=
=O8mC
-----END PGP SIGNATURE-----

--yC91f7qSViS67v3c--
