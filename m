From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 7/7] MFD: TWL6040: Add regulator support for
 VIO, V2V1 supplies
Date: Thu, 2 Feb 2012 14:19:04 +0000
Message-ID: <20120202141904.GC22048@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
	<20120202125250.GJ7428@opensource.wolfsonmicro.com>
	<4F2A8D11.9010705@ti.com>
	<20120202133207.GN7428@opensource.wolfsonmicro.com>
	<4F2A96B8.2030004@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5720246932586257630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4F2A96B8.2030004@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============5720246932586257630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 03:59:20PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 03:32 PM, Mark Brown wrote:
> > That's not a problem for using the bulk get - the array is part of the
> > API so you can use regulator_bulk_get() and still look at individual
> > supplies within the array later on when enabling and disabling them.

> For some reason I have associated the use of regulator_bulk_get with the
> use of regulator_bulk_enable/disable. It did not even crossed my mind
> that I can still use regulator_enable on the individual regulators.

They do normally end up going together since a very large proportion of
devices need all their supplies on when active but don't care about
sequencing so you end up with a common pattern.  It's not required,
though.

> Will convert the regulator_get/put to bulk operations. It will make the
> code a bit cleaner.

Good stuff.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKptHAAoJEBus8iNuMP3du/sP/2z53bmPM+Ks96P0MkL7ehgw
PY3god+WXmcnvRvbSw3mcEkg9/BcbSm4SjjMvVyIjXoLJmOOoHtb/PlFBCpuVrtI
v+LTUnbQqqaq3d0JuGG4ttCNd05/0VcKTGcluzvBqtDj5saXbhPKXIUa/jQUGZ4C
l4itnlvjFqjJf0Uh+PiwlrDu6g6JS8iM9j7gr/bEBkgeqZDThNqfjo+mV3Wm1PEu
8Dp0rGPWh8pC8Pl1W8xMBawRYTG8rTqzegaAm6iL36lAQWXFfD+hInj1hv1CmYUb
Bg0E2TwYxor9YeccZ2WTLTwFWanFUrKb7VCWBQy87blHuBud+md0LE+lKDXlhYw7
a06gPgiiYkcP5jnYp49lIy/x9sxGPuhCYOQ1vvDdDgNc569LyinY2thudmG4u6PA
LXvBuqzJvCHqPIuixPlwG8jHnZL1OdiEb+3bszZtHTOCEfxbw8Qf/xhKKfmlAqQy
/TGaLaU+ooRW08Sayd+rbarzHoJQMXqxNfQp0R+cnx4JPBR9Fie7P6KHO7gu+/Zz
Agj8o10hR14vGBZpzHQ/BULY+YXiK4tyKaFKScDGGa8X3ecRBa4DUq0Wgx0nl8wK
cHo1QgCFjX/f4PKj+pZSnmNLDjitovL5UCzMo9hB5iD3AF8h31fjnBCKRHOY29DE
DptYmdznFwFq0jKEcMuN
=a45s
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

--===============5720246932586257630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5720246932586257630==--
