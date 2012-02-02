From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 7/7] MFD: TWL6040: Add regulator support for
 VIO, V2V1 supplies
Date: Thu, 2 Feb 2012 13:32:08 +0000
Message-ID: <20120202133207.GN7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
	<20120202125250.GJ7428@opensource.wolfsonmicro.com>
	<4F2A8D11.9010705@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2549223136589674730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4F2A8D11.9010705@ti.com>
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


--===============2549223136589674730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DH4/xewco2zMcht6"
Content-Disposition: inline


--DH4/xewco2zMcht6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 03:18:09PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 02:52 PM, Mark Brown wrote:

> > Looks like you want regulator_bulk_get() here.  Or (better yet though
> > it'd be a potential issue for merge via MFD and the benefits aren't that
> > exciting since you still need to disable) devm_regulator_bulk_get().

> I need separate control for the two power source since we can hit
> different power levels depending on which is powered/not powered:
> power down: vio, v2v1 is OFF
> deep sleep: vio is ON, v2v1 is OFF
> sleep/power on: vio, v2v1 is ON

> And we have certain sequence to move between power states.

That's not a problem for using the bulk get - the array is part of the
API so you can use regulator_bulk_get() and still look at individual
supplies within the array later on when enabling and disabling them.

> >> +	ret = regulator_enable(twl6040->vio);
> >> +	if (ret != 0) {
> >> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
> >> +		goto power_err;
> >> +	}
> >> +	ret = regulator_enable(twl6040->v2v1);
> >> +	if (ret != 0) {
> >> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
> >> +		regulator_disable(twl6040->vio);

> I disable the vio here, if the v2v1 enable fails.

Oh, that's quite confusing when mixed in with the goto/unwind - it'd be
clearer to have the extra lable to jump to.

--DH4/xewco2zMcht6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKpBPAAoJEBus8iNuMP3dWiIP/jfLytqSvCZ5b+fQqMD5mmiX
Ui7K7iYXKaSyXJSoAuBJXNzFoUOV998rYwanhJXhsVfGKYJzfoidEsWVQamVVS7x
BModtw7453/5DzNan47UJFRJ1/iqG/kJw20Jq625TbAiVtT1vEF1B9zfqN3JbczR
iYqzU7/9+SRqdUQt9rvXR5iJI22v801b05Dxe1WrPP2X1y8lzZ7cl2gFCLjjdrit
ngEAqBwLewX01NEpkJU52a+TAr6Ag4joA6mRX4Um7THWwuYrNPehXDdBr8hEmKgi
GNBtzizk7KSScXKjabD+ZzLmIc0AAMOKKRNdjtsMKJBTR0d7CpNHebf1CQbqj7so
K3nev50sHy2HqYfuWxUbFImYN3GuWp5eoIj37q9iOSqPHhgRYgodGOWX5kmkBZ6/
EC7m3K4JOoXhoK87ImbSWUQI7++u0ewlvVFbtzTHMh1kTLdNnqCVU9Cg+UEGzG8n
cZLwRgYuKoMuuXvcrHKGMtPGFychZiZFSokt8/1poW6E8P6NzPoRBmA5+gqczIWa
7PSbLuv1zNPESbKLhgoaSD3l3CCNHPUwWaidGBSmk0Y0R3kVgLfb5wsEIjWlY30f
wT/LqPOoHFYj8IGzMF3JP4uYYKlugorB6Lic3RchYGV73c/VzHHNA5tpj5+QVLuW
uJETdo51CBITFvimrWgY
=kH0B
-----END PGP SIGNATURE-----

--DH4/xewco2zMcht6--

--===============2549223136589674730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2549223136589674730==--
