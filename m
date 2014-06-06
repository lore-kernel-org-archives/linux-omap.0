From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 6 Jun 2014 14:08:50 +0100
Message-ID: <20140606130850.GO2520@sirena.org.uk>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <20140606111411.GD25896@verge.net.au>
 <CANqRtoTy_LwSiZgRFEw5Ly4ojfinoCichxrX7cO6m2XB9JGoww@mail.gmail.com>
 <20140606125003.GA13332@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cU9XODsizZBnwgll"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140606125003.GA13332@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Michal Simek <michal.simek@xilinx.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--cU9XODsizZBnwgll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 09:50:06PM +0900, Simon Horman wrote:
> On Fri, Jun 06, 2014 at 09:14:01PM +0900, Magnus Damm wrote:

> > I'm not sure about the expected merge order for this kind of change vs
> > queued up stuff in the renesas git tree, but I believe the following
> > patch selects ARCH_HAS_OPP:

> > [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable

> I propose that we fix that up by adding an incremental patch to
> mach-shmobile via my renesas tree once the dependency (assuming there is
> one) is in Linus's tree.

Yes, the conversion to make ARCH_HAS_OPP unused is in Raphael's tree for
the merge window.  I'd expect this patch to end up going after the merge
window (or at the end I guess).

--cU9XODsizZBnwgll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkb1fAAoJELSic+t+oim9ksoP+wUlNxCCTSQ9UrzvZfjNPynK
oVQNuAvD0dlyrOaE/OnY3QuJOp/1FaVnWIr/kJO/N1KlSetg6Pz7n9I5W0/4zlQ/
CtV50+Kj799fLTNAuFU5ftinugVHZCqccgqZuCGng/XR+/eJ4mq1PBSgQHVyrNxm
PXyCXIjSlVIX84YW4zA+5en/Tts74zzH3w8R27AVj6oW0Au6VIgjKEoeBYlgWD/g
b1j7ShJ9ykUlel8XtggfrddRo1u9UmLsyilFrWKEPFmpfbCPKCIwoAg/xsszLqgo
6nUx7f4gRPLBcDGAyRmlH32LdKDnce3N0Bxxgiz9rfYyoOPJia/ZITMPnUyHiezZ
vrQjrdx/V5A1GXSjXO9I/GdrJORmX+TmFajhyZGasCduxHT7TJhFjFEVtcaeVad1
1jBhKKonWmLdiFq454UCFSStBW0JoGCoho19df/lGloUDHG8JQgd5Fm0izhPn0bC
mTWmc3KuxYukXVY8sko0sdlu50wtBMSknxm/bYI3Q/LBrxRtTRIoBbxwFnyHUs+N
ZRDyeym6iiu1MRECKOWJZ8jnrQei5v5pjmuOTpQyZTbOmecT/TEwz2mUQDir/5Wb
Bda+Jrh+I4ut81r2vdE6FLzHvWxtW0ijkXvMtXVwhW4yYsmpvPc+YAW4VpcasxiG
lzTDIush25LhobKeaccI
=iMA5
-----END PGP SIGNATURE-----

--cU9XODsizZBnwgll--
