From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] mfd: twl6040: Fix deferred probe handling for clk32k
Date: Fri, 18 Sep 2015 11:40:02 -0500
Message-ID: <20150918163949.GA6549@saruman.tx.rr.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-2-git-send-email-tony@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8757800879236603299=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442593745-16725-2-git-send-email-tony@atomide.com>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8757800879236603299==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 09:29:04AM -0700, Tony Lindgren wrote:
> Commit 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
> added clock handling for the 32k clock from palmas-clk. However, that
> patch did not consider a typical situation where twl6040 is built-in,
> and palmas-clk is a loadable module like we have in omap2plus_defconfig.
>=20
> If palmas-clk is not loaded before twl6040 probes, we will get a
> "clk32k is not handled" warning during booting. This means that any
> drivers relying on this clock will mysteriously fail, including
> omap5-uevm WLAN and audio.
>=20
> Note that for WLAN, we probably should also eventually get
> the clk32kgaudio for MMC3 directly as that's shared between
> audio and WLAN SDIO at least for omap5-uevm. It seems the
> WLAN chip cannot get it as otherwise MMC3 won't get properly
> probed.
>=20
> Fixes: 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/twl6040.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -647,6 +647,8 @@ static int twl6040_probe(struct i2c_client *client,
> =20
>  	twl6040->clk32k =3D devm_clk_get(&client->dev, "clk32k");
>  	if (IS_ERR(twl6040->clk32k)) {
> +		if (PTR_ERR(twl6040->clk32k) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
>  		dev_info(&client->dev, "clk32k is not handled\n");
>  		twl6040->clk32k =3D NULL;
>  	}
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/D5iAAoJEIaOsuA1yqREzMwP/iAXyH6u7kDLhCbxYe+VQI/d
5iEP94Wgef/nUAnkrAKblOJflQkpqzNjQwqM/6zuuvXOZ+RTxYwyqlvsOJdB+QRG
nyexXJA3v3YqGm71OSfLzDDnMU7RxQRYOeStVnWoghQMWPao+s2A6oLyuYRzaeH4
cS/IE4fclBrNvLUFib01ukDY5xhqaIN9pvRdjMD67y+76qE8lN+bk9uiElK154D7
4M19LAPbibK3aM7riT0xl4trWE6g+RC5jEJEdenoq2zI4lgeARYg/niYVuwQ6HJQ
vch6Mhih7NuqGgoiGaEGQPCtGzZmOhQkYTHan/jGfbLjmS+UrsrcT4uujZ0svhz5
KcDr1CQJU6is1U0ewOZ1aqVSS0vLo+km7SdEx7lt+bJ8tzIz14Lf7cI8cFdeWpjO
VV7KIytXiNQTpi3S4hmSRQBQav4A5WunrCKx5qtErHyVvkeuZ5at6leH2nzvhwIf
5MVlXCC5HhPF26KCW85ILuTYEQRWnlj3ggu/oeUZ0QjuKK+tmNWO4qAKfLTjgwZR
wvel4U1ThYt5LpTlY2fxD48mG0YtgtMNxaJEgR6kebbbEPBxPKBmDAcJHo4QiZFB
eXHcpMUuuKAb+a0BCmZypIuahOsglfYOiZT1o/1IjxGZtoRrSaPslKj44NcEHocS
TvOSKlevZjUAEuaBXBuz
=+Qkn
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--


--===============8757800879236603299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8757800879236603299==--
