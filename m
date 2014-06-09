From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Mon, 9 Jun 2014 23:51:42 +0100
Message-ID: <20140609225142.GA5099@sirena.org.uk>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <3122018.iBNBjMKNbN@vostro.rjw.lan>
 <20140609194917.GH5099@sirena.org.uk>
 <1976508.Da0u8DZI5B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fYgRtaZIy+F1uhp1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34553 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbaFIWw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2014 18:52:26 -0400
Content-Disposition: inline
In-Reply-To: <1976508.Da0u8DZI5B@vostro.rjw.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Michal Simek <michal.simek@xilinx.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>


--fYgRtaZIy+F1uhp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2014 at 12:22:07AM +0200, Rafael J. Wysocki wrote:
> On Monday, June 09, 2014 08:49:17 PM Mark Brown wrote:

> > Yes, looks like it is.

> But it doesn't apply for me on top of the current Linus' tree.

> Can you please rebase?

It probably depends on other people's trees too, I just killed all the
usages in -next - I gather the SH trees added some new ones for example.
I'd expect it'll apply after the merge window, if not that's the time to
look at it.

--fYgRtaZIy+F1uhp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTljp7AAoJELSic+t+oim9QC8P/3w9XEK6EwCiwETt/HFnpg9z
7tmkG9zSRbhmjmih8aAI7FEe3oTsu9ApteYjrKO5wgwhLDrRweDiY5dZwPJIUQfT
zKS8vPf39eXOmrXyfvqJ5MzYHmZC8p4VVJgJxdke6BwtCALz0Xg5zsfI1vt2oFwR
FGfW/+zQrp0N+AoKuR2l11GeDJudlb7MjkdQZtYZ/ApzLpZOQoDhAu5hYeEUWqtE
RRijtt4ORQpIBD8tfKbH/Qll7jokVjffxiJuCaphDshV+mTSo3/tEbttftexCwAC
DkHt+xorAF8Am4WYlMk1z5QFya4REGqzebyeZg7cVW3yXVvF4Mx0a2PTwN5Y6g6r
u3MBI+zhywMVbh4ffY+qAGpwdsLS/2u6eWIH8C9lllMuNnsdkALIdNmD+yoh17g4
r+wqPrh7NlcZsqX0XCiHlkXoowrkE1ivVLVMwXM7K87BYojtuQq9fTe+qJfenHnW
gbiTp9a9WEeUm5SbsfPxIepuUIDGpBHZnoqYtwA8uoY2GKNYpHsjTyUpRENL0DW+
pHrrBOqtivke1lM9nwbRJbdGBji4mos7alRo1TBM7ewU6l2ictTV+sxvq0IVQgn4
mSTHGF8e7/VtMSzAkJsII+LSB8tPvMTd1l4+U4RVWB7g5Wlb1A6IXtScHYUESpoD
VfWW4OyorYf+FjjgC3vo
=eswP
-----END PGP SIGNATURE-----

--fYgRtaZIy+F1uhp1--
