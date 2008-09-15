From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Mon, 15 Sep 2008 15:04:33 +0300
Message-ID: <20080915120433.GU31563@intune.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com> <1221476854.6312.37.camel@tubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39414 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbYIOMEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 08:04:11 -0400
Content-Disposition: inline
In-Reply-To: <1221476854.6312.37.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "ext Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2008 at 02:07:34PM +0300, ext Tomi Valkeinen wrote:
> Also I still don't quite know how to present displays to user space.
> Currently my omapfb just uses the first display, and that's it. I think
> in the end the user (be it X server, or perhaps some entity over it),
> needs to have some understanding of what OMAP offers and how it can use
> the displays. And there probably needs to be some product spesific
> configuration regarding this in userspace.

All of which sound very poorly suited to fbdev and very well suited to
DRM modesetting. :)

Cheers,
Daniel

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjOT1EACgkQ68xJuWtYYdWnGQCfawhBxsuYIzQOdT7E7EoKBJ2i
uqkAnRNPjzBPCSOoSAajJGUJu34e5BqS
=VBjZ
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
