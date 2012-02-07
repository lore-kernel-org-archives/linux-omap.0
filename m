From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 7/7] MFD: TWL6040: Add regulator support
 for VIO, V2V1 supplies
Date: Tue, 7 Feb 2012 13:16:57 +0000
Message-ID: <20120207131657.GL3332@opensource.wolfsonmicro.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
	<1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8792861670143903095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328619678-26080-8-git-send-email-peter.ujfalusi@ti.com>
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


--===============8792861670143903095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Content-Disposition: inline


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2012 at 03:01:18PM +0200, Peter Ujfalusi wrote:
> twl6040 has three power supply source:
> VBAT needs to be connected to VBAT, VIO, and V2V1.
> Add regulator support for the VIO, V2V1 supplies.
> Initially handle the two supply together with bulk commands.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +	twl6040->supplies = devm_kzalloc(&client->dev,
> +					 sizeof(struct regulator_bulk_data) *
> +					 TWL6040_NUM_SUPPLIES, GFP_KERNEL);
> +	if (!twl6040->supplies) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +

though I'd be inclined to just embed this structure into the twl6040
struct directly, you're always going to need to allocate it and it saves
a tiny bit of error handling and whatnot.

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMSRDAAoJEBus8iNuMP3dynEP/ixDQp/g4HRQThsELFNjhkI9
uO4Rt1mK5kZg7OgioD0QfX8nNOO0cCxvBVX3Aaa49RnmgEtUWcYJSumW3ZAj4yIy
4dwsMR0eemJnrnKQczOKDprKpds0OIWxd79WfsREV2jU6QhyrmHl38mRW31uLrDD
Ab2y9sT6ZT+m7EnyAIr7K8d9z4ye+y04slOqwBNCnUZNBHqBF6XvMK78cffa/Icm
WtO639Y32YXsO3QbaNxN2e4SDG5J6q2jrouxKm3+aukSe4ppieVM15ZbHIfE3C3k
Q36clC/nQ6wmC+3hMkCcSFUH7zjfsW6T6rTUCgh7CJwj1HU2bhAzGnBARdQ3lqHh
mMcXSnZd83QlhK4pUbgWfmCY3fG24XzMDS70Z0dG9s7E129Hou8eZMJjj4ivmCFW
2vHBLa/zjSl8RHRe4VacMwWIknb7NoCX7DANWoWPhSGGYdvc4X1mjLQ2MYu0eUC7
Gzr7l9o5xvLe5P+UQZDKguBrEXSNBNu7teBSZHbwvKTONA1WgKqLP7JR3pwrbx6v
1weOnQN8oAGR8ce9rvxv2jsAB+CPPskw15BqW6dbUSYUZpBi46XhphegWcOubEPh
jLogAmxTS5Oln/pJQFQzJRPc7TOdqZDLM4b75cxEklzvUNiAAgJyM6EEgfh2JGdy
cmBuuLMzR/FdzZ1dDa2R
=ucmh
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--

--===============8792861670143903095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8792861670143903095==--
