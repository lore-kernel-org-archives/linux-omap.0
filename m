From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 01/10] spi/spi.h: Add get_buf/put_buf support in spi
 master.
Date: Thu, 19 Dec 2013 13:31:05 +0000
Message-ID: <20131219133105.GC31886@sirena.org.uk>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aHyShe78FfJzbeER"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386339891-32717-2-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--aHyShe78FfJzbeER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2013 at 07:54:42PM +0530, Sourav Poddar wrote:
> Add get_buf, put_buf api support in spi master.

Please add this stuff along with the code implementing it.

> +	void	(*configure_from_slave)(struct spi_device *spi);
> +

I don't understand this API at all - it takes no parameters and doesn't
have a possibility of returning any error codes?

--aHyShe78FfJzbeER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsvUVAAoJELSic+t+oim9CuwP/1XVVgzLmTUrm8IIC25COg2Y
/9TZrDHMotVIOK33eL0Xx7hp2C5Ks1qmJKIoUj6qPzjfzKryS0niM/SGAmTf/zNO
FhgCvwMY/GVUxKwI8sxBgpDTkQSn+gxtHPIvoKcjJMJTpJiodE1QXO5rJtSPX0QF
BHZS24nQaJmxTzcgh8d3dZnvVAAYi5dEqRR8BgilOd0sjHALyRFdngVePY4cWKqG
XxeNMNlr5U8s9WyACa1Dd4SvMpX4Ytb70lSaO6g2+0FqML7zvmEbyoE6ZyVLm8f0
6TiQFCqGDxfRNxoSkJUFmTmh9rd04w5jXZii2aR9aAbUC0sZiaw8UuBolnxg3769
FWD9wb0vxnExrBvGjGqwOR8F21aODIjYCjW3RFi5wmJAFuYD77TTQkx5NgkZseG+
GO0DcO78Jh3nxuMiz2Qqzw8e2hOwCFgtXz3uQLAnyDPDEeJPO0ylvrQWTD47BMrW
7XquP0R2JBlgwXhsSQsP6MUy00KPtaNp66UW9SiI8iNl4fE4No1ZmP9PStmRqUTU
7XPFn7rTWsbfs21AwacGjb/e0k3MDcGKCja/lsnMNLnUSTNmaObMPCrEXThbQyL3
T40sRJqyAjohgJNmpncVLT3nAx8Rt7w0Tff2GK56636J0CVnT/8fHIbwPwZx9gbl
xS+mGxAk4H0y5zkcztEy
=3NTq
-----END PGP SIGNATURE-----

--aHyShe78FfJzbeER--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
