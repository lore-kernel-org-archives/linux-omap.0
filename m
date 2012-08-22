From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+
 clock parenting code to ASoC driver
Date: Wed, 22 Aug 2012 20:10:44 +0100
Message-ID: <20120822191043.GH7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1968721904901407734=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============1968721904901407734==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IIdFmnBmmFp+Aeao"
Content-Disposition: inline


--IIdFmnBmmFp+Aeao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:00PM +0300, Peter Ujfalusi wrote:
> Move the McBSP CLKS re-parenting code to ASoC driver from
> arch/arm/mach-omap2.
> The call fort the re-parenting has been already limited to OMAP2+ SoC in
> the ASoC driver. There is no longer need to have callback function for it.

Applied, thanks.

--IIdFmnBmmFp+Aeao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS6tAAoJEFJkBDiqVpZ4ypgP+QHvkaPltipdOy9lHnJAP6s8
ABmXKk4i5QBoB/Bqh9DYXhiI7sp0/W8s3mUXRrsM4STsxWJtq2hyzBj+Au0pDJeW
CsPlDK4ioq5h3TnlJgbitaEV9Yemi6Sm5XA7EfYEKYP+O2sCbrw4xlcyXjsw+pO/
McziGT2iIw3e07Z38izLNLqFZIk8e2pksJEf+UxGd8AyGtw2GcnKXWLmXMRmxpKG
ihPoZz72ylpZEYU8pZR1AsCbv5NQnM/j3Nk+GRuSSFOYOqWSaGA+SoObFIAPYkdC
uxck20nM5RHaFsN7DltJ2JZIF98lp6l6w1ljDpfRG47KYBwm6H37aB9aDmppwlWU
byO8gpPQ5acB1xGksrtXVflg5iNxfYnROeDipZYdtI7xElZV1SsQ7Z1NFLgqBC6E
+gPWc4rqCiyYs4FDr7hPJu5Pk5n3dO9JraU6QwQXLzhXXhouEFd+5rYtm6R7UELT
ndCYwzDaBqSZbpdbHFcY2pcbKy/pfaHNLwaJvuJnNHDKQDngNqtoTXaTo9okE1Ti
x140I8tPqDs4GENmm6awgaA3hTqqv86SNapOA8RkD4YNCOm7b7BY4PIw0JGZzosK
AKghKGt59I0pbXDciaAEPbuDCtkJW2qmwDwJa+76A4A7O07JMiTWnEsU8nYjD8t4
DgyerSL/HhlUs9VJzTKu
=8XGd
-----END PGP SIGNATURE-----

--IIdFmnBmmFp+Aeao--

--===============1968721904901407734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1968721904901407734==--
