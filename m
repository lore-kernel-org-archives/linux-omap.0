From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
Date: Tue, 4 Aug 2015 16:52:36 +0100
Message-ID: <20150804155236.GS20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
 <20150731181903.GN20873@sirena.org.uk>
 <55BEF5D1.1050608@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DNbkntcEGyiBe7B+"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55BEF5D1.1050608-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--DNbkntcEGyiBe7B+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 10:32:09AM +0530, Vignesh R wrote:
> On 07/31/2015 11:49 PM, Mark Brown wrote:

> >> -			reg = <0x47900000 0x100>;
> >> +			reg = <0x47900000 0x100>,
> >> +			      <0x30000000 0x3ffffff>;
> >> +			reg-names = "qspi_base", "qspi_mmap";

> > The DT binding document for the controller needs to be extended to
> > document this change in the binding.

> DT bindings are already documented at
> Documentation/devicetree/bindings/spi/ti_qspi.txt. Did you mean to add
> this node as an example in that file?

No, I mean you're changing the binding to add this new memory region -
that new region needs to be added to the documentation.

--DNbkntcEGyiBe7B+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwN/DAAoJECTWi3JdVIfQDmgIAIR4xT4J2eYaCKDeCNkOZR0Z
oGMLIpACnU+bu9wiAPbfQMq43bQOdP7XSZAHrxKkXmLVZpVUPeGpOmN4Wa99U25W
whmSIjwJf73efIv8N8K4Y4QUiU73JL1RAfIDl2moe2708e4sFEJGN0NufeHcppHr
vZdjKfIfhVnZ6DuF7TkItapDBq6E5BVMXLoIr1RCN11gYcupBqBiqQGEhrY6fQsy
bVzX1OjtJoGtTaybt1or9KPgMWcP2EapqBJ8qTwcLdnAlsMr8Jb1qxS89in82Q6q
QqwahNKtFSNzzVtds/Mc7YOEGUBdl9qWc669cKTwJClNmbHv4chkuXAPCnkf7uU=
=Hgzf
-----END PGP SIGNATURE-----

--DNbkntcEGyiBe7B+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
