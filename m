From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Fri, 15 Jul 2011 11:37:54 +0300
Message-ID: <20110715083753.GG2611@legolas.emea.dhcp.ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
 <20110715080315.GC2611@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com>
 <20110715081725.GE2611@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107150222400.16606@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33600 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964947Ab1GOIh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 04:37:59 -0400
Received: by mail-yw0-f53.google.com with SMTP id 21so556640ywm.26
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 01:37:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107150222400.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 15, 2011 at 02:23:16AM -0600, Paul Walmsley wrote:
> Hi Felipe,
>=20
> On Fri, 15 Jul 2011, Felipe Balbi wrote:
>=20
> > I see... thanks for clarifying. The comment above the code wasn't really
> > clear about it to me.
>=20
> No worries.  If you propose a clarification, I'll stick that into the=20
> patch.

How about something like:

/*
 * Program target state of all power domains to ON. This is to prevent
 * power domains from hitting low power states during boot up and
 * potentially causing accesses to the address space of an IP while it
 * is disabled.
 *
 * PM late init code will make sure of disabling all unused IPs later.
 */

not sure if it's a lot better though.

--=20
balbi

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/xhAAoJEAv8Txj19kN1qq4H/3cWpMsPw2m20abp9bPj03Pf
bJANrM93sxDRg3kKdw5RoicpECi6AxZtL5hry2Pn0HURakpc9QfdL90NyWl5P3ea
F0sDWkDTSrU1boOuVRCSQpPz1hQCFOlXt8DErJgxPR/zsl02PzJaYuroU+Yjjse3
veRHB3QpporqQiEizDwxJa7fEc5DmaBn+VhxF75IHNl9GSYy7Q1fA6Y3c2nvGd60
NLsqTzJHUe2RY6hPeNZdkJhdJJ6kj46LlnWtIb8WACohOEUgaIkAJ22xS7YewIE7
wvIRVG2gsjljtovx5A24iSSxHaSnPumGpuLOgv/EuTX0xJ4EnxKaGPi5TbA1YjY=
=WMRT
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
