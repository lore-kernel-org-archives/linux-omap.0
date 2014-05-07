From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/4] OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
Date: Wed, 7 May 2014 11:15:12 +0300
Message-ID: <5369EB90.8060007@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0027326360646278318=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398815562-24113-3-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0027326360646278318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE"

--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/04/14 02:52, Tony Lindgren wrote:
> Using gpiod will make it easier to add device tree support
> for this panel in the following patches.
>=20
> Note that all the GPIOs for this panel are optional, any
> of the the GPIOs could be configured with external pulls
> instead of GPIOs, so let's not error out if GPIOs are not
> found to make the panel more generic.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 92 +++++++++-----=
--------
>  1 file changed, 38 insertions(+), 54 deletions(-)

<snip>

> +static struct gpio_desc *
> +sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
> +		  char *desc)
> +{
> +	int r;
> +
> +	r =3D devm_gpio_request_one(dev, gpio, flags, desc);
> +	if (r) {
> +		dev_err(dev, "no %s gpio\n", desc);

As it's fine to not have a gpio, I guess this error print should be remov=
ed.

Also, if the error is EPROBE_DEFER, the driver should fail and return
that. The same goes for the DT version in the next patch.

 Tomi



--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaeuQAAoJEPo9qoy8lh711swP/0Z8usacElSZgblnBscYXQV+
abLMe+nOUiSyUJ9JRe5uVW7oRWIlulOJsAUAXMg85UGya12RhW8jmmfyqLoWAuN3
ym8794Hqy/CMLcgwhhybP3RZjxykk/WHQCTo5bOZ7/R+TpIZWyobd48aGYS7r0bU
dXpl4URUSy6MPkWAT9dG+GG7sZTnHjdJ6AeUxFTbey25rtobWIQ8WohFA2mOwt8W
WREGSRP5SS0P+r5vKneYyarETpYgtMbHV++RPnbQaOceOeo379q386wQ/u/C+Tc1
Sx/ED6QrYYduKf44f8fEq3GqsLi4HZ2pueNscXadKIrFBMnXcMP3TMW6KO4wbv9v
0+NgtXaiT17VhpySvIG+AroThzzQoY0yhf4OOlVMKPfgTklKFUC4AVgTpuEx1FjZ
vABIkYgI5JFPIrbXBG6hYenTtrk/LmgltKN9p/0vVoyfEr1bB6ks8ZxmF2EpRJwd
WMeXdjhId3epmTNATIWjaOyFx+8kEfQucOmmp0JDyKw/1zv/zrgUzc/AfxIckmEy
MioBAskQwk1ZxGwFxpL7u7FidNunjzHPW9/MIck9N3MoyF04XQMZ5j8x1ulqbNs/
yXRwkhartj6Zw08YXOD6XqnmBc2/uk0iQFgRlbI1MvTJ9bWa8ehmGDaPz3bxVVWX
5z3HSiylVq2XORKECNln
=Ns5W
-----END PGP SIGNATURE-----

--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE--


--===============0027326360646278318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0027326360646278318==--
