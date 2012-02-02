From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 7/7] MFD: TWL6040: Add regulator support for
 VIO, V2V1 supplies
Date: Thu, 2 Feb 2012 12:52:50 +0000
Message-ID: <20120202125250.GJ7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7424103933356858824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
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


--===============7424103933356858824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBdJBemW82xJqIAr"
Content-Disposition: inline


--gBdJBemW82xJqIAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 02:16:59PM +0200, Peter Ujfalusi wrote:

> +	twl6040->vio = regulator_get(&client->dev, "vio");
> +	if (IS_ERR(twl6040->vio)) {
> +		ret = PTR_ERR(twl6040->vio);
> +		dev_err(&client->dev, "Failed to request VIO supply: %d\n",
> +			ret);
> +		goto regulator_get_err;
> +	}
> +	twl6040->v2v1 = regulator_get(&client->dev, "v2v1");
> +	if (IS_ERR(twl6040->v2v1)) {
> +		ret = PTR_ERR(twl6040->v2v1);
> +		dev_err(&client->dev, "Failed to request V2V1 supply: %d\n",
> +			ret);
> +		regulator_put(twl6040->vio);
> +		goto regulator_get_err;
> +	}

Looks like you want regulator_bulk_get() here.  Or (better yet though
it'd be a potential issue for merge via MFD and the benefits aren't that
exciting since you still need to disable) devm_regulator_bulk_get().

> +	ret = regulator_enable(twl6040->vio);
> +	if (ret != 0) {
> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
> +		goto power_err;
> +	}
> +	ret = regulator_enable(twl6040->v2v1);
> +	if (ret != 0) {
> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
> +		regulator_disable(twl6040->vio);
> +		goto power_err;
> +	}

Similarly regulator_bulk_enable() here, and it'll fix...

>  gpio1_err:
> +	regulator_disable(twl6040->v2v1);
> +	regulator_disable(twl6040->vio);

...the fact that if you fail to enable the v2.1 regulator you don't
disable vio.

--gBdJBemW82xJqIAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKocbAAoJEBus8iNuMP3dZ34P/0eSJ5nReLPQ7l+MLlZHOY/Q
Z993OIDFDzV1VpQqU0FcrVZOhHQ/FAnzjUYQLHU6K974ZwF5ZbgE3OGTklhFSp5N
3XovWeyaf4vWlYNtXjOlCtXdjTGmmxKeN69IGUsijy6Wc9+NDnYIdqwS/FYmcJRS
ygGzpdsSFM7/AexQSlbW1GVCkX264MrnkoC84ucO+stmAVrhvthLm7591AMmkJNn
EkzaSID0VZWYACIt+s0ANHR2cBER7/tPK8pkJKqMDXCW0SCnlpfsp2b7iudwkRX2
Ua6vxCN7Y31wfpD/OKn8VMtayPutF0hJYSRibFZ8crgAHS/ctw0Mf4YXgtGLGBLU
EAKL88xZF15TqMMT6fcnKWrIC9FKAgukfsuHnhxTLqxHyTdLS1B2xYQbjpvboUq6
Mnqj8NhlAHxVee9mAb8onMQuzdXxsyWgZwehtIlQkW0AbZtuVU4Ah4DG7++K/iad
hBC6sD7mH4HYpxcYw26fIuZdoM8gakAunV963uHHYoQUkSBYhyPotjbuXSZFs6J0
N9OFfKZdbh/5hEbHWV5bJftrT0XzfekN66Rvle7s9WjpUMV6RTZhGRHpM8C+MhT1
8yFcZhr+RqDCpbWV9jL7wQqrB2NdqJpneIZtI7nAd13KAIFglz/OvZ0DLi7LJo+y
hBTmYQNy1Um9O4ZioqRd
=278o
-----END PGP SIGNATURE-----

--gBdJBemW82xJqIAr--

--===============7424103933356858824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7424103933356858824==--
