From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv8 1/2] drivers: spi: Add qspi flash controller
Date: Thu, 1 Aug 2013 17:07:06 +0300
Message-ID: <20130801140706.GT7918@radagast>
References: <1375365602-31321-1-git-send-email-sourav.poddar@ti.com>
 <1375365602-31321-2-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zd8I2GZVcdxtyaG/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375365602-31321-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Zd8I2GZVcdxtyaG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 01, 2013 at 07:30:01PM +0530, Sourav Poddar wrote:
> +static int ti_qspi_setup(struct spi_device *spi)
> +{

[snip]

> +	pm_runtime_mark_last_busy(qspi->dev);
> +	ret =3D pm_runtime_put_autosuspend(qspi->dev);
> +	if (ret < 0) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");

wrong error message.

> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *=
t)
> +{
> +	int ret;
> +
> +	if (t->tx_buf) {
> +		ret =3D qspi_write_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");
> +			return -ETIMEDOUT;

return ret;

> +		}
> +	}
> +
> +	if (t->rx_buf) {
> +		ret =3D qspi_read_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");
> +			return -ETIMEDOUT;

return ret;

--=20
balbi

--Zd8I2GZVcdxtyaG/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR+muKAAoJEIaOsuA1yqREbksP/2eGxzCF6eL9Pp7mrV+lmLUo
QlUUwHecFFkRK+eN/OvEq0PJtWTDoNUtKOj+au3PhIWFndj11vwSY8CYotsMvBoj
S9XLjV8gD7tMqun74dqZ8GAV+tvX+0iI9hHrX++KcuQlqnMcSqYfL4fDMiZc0fNy
mAq/LHN4iaHISxOYiqEmKhK5mFvaYT1Muc8W0uD2Eqqyck6d3hAWN9xJmCMbXIFo
1FqCsLwL9XRDLHYexDPZVYGUqo0igwlRcrBANozpR8NtqTDX22hXfPsrdzXJ73UL
9LP1yP638w7UB4UE++E5pMj+yp4W1CgM9RVeJMgPV7Y9W2ZFo5ayLhfSqbpB52ft
waluXiO8QphOczIdhKvsPwYEAgqQzFaCKdNrScWpO0zgNtQPgEMTWzdOKtt73Zrx
twjoLPhUjc7QaSyuoW5TqlJskp1iXhkgeBEQTWL+huFrxJbLC++K2pZX3xaay/Xe
vRqDsL5tNjxhafT09kKVSo7Y2ytsVPFJAyY6CiW9NqIX0uDThf2uBlOk86q8C4uZ
9poODj8mF1H8WqP+Iy4WpYPi2nxTvq9wn2e+wZc5s7GA1pdUsQvOiFcUXUzY0eSv
p+3/v6czY3Zu7yauYMrizPFEAQRRnT6mF/Wo9MoiyBCFDQU2pKSt6UW/sUZqojjr
XA8yp6k6SZFKxLFIHl2H
=NR8W
-----END PGP SIGNATURE-----

--Zd8I2GZVcdxtyaG/--
