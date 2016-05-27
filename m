From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/14] ASoC: omap-mcpdm: Add support for pdmclk clock
 handling
Date: Fri, 27 May 2016 21:31:40 +0100
Message-ID: <20160527203140.GD29837@sirena.org.uk>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 18, 2016 at 04:46:36PM +0300, Peter Ujfalusi wrote:

> +	clk_prepare_enable(mcpdm->pdmclk);

Should really check the return value here.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSK6nAAoJECTWi3JdVIfQgLgH/1n87ZBxKwq4fE9xWWzz7VSe
g/1vKGI7TcRkGSrC3jnotjQV/Nn8p3HYm19VBxdiQyR6gBRduGi5KFq1S9G6cimk
ZF2a7er96t8SeCHplP7obU3slnpuAitBRrUnDQJ7Xb+ZGJJjyeDoETFV7XHYMglX
/PTce4gJkxtTG7WSaru49540J4nU7YKtwOsOY8pmyC2eRxMekfO9HPq92565Y3bT
hYpjb4HzBgcfL3OID5OWScBVJBZ4lZx/A69wb7lxeR+DWc+uu2XStqojQ1tSpDMv
4/4Tw0xJ8aXDjQZqr6D6e0gu7jOBp2rOt4kmSJTCKetPrxf+ROcSEjB/IYc3ff0=
=IO6m
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
