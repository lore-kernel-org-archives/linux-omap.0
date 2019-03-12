From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 33/42] drivers: gpio: tegra: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 12:30:04 +0100
Message-ID: <20190312113004.GF31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-33-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-33-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:12PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmDwACgkQ3SOs138+
s6F7Qw/+Ig2XXOoqc2QD68SQdohFVyykTnyHy3+Un2OUtPW8/Qj/zr6kpRbpEtXF
yyVZ5vYXGJmaSYSYjPRGHdXwy7UDCtFoEdrP7vElVJgZRtWS9aeodcIqy+s39i86
DrCuskY+baZpX4HBHL0EWs+2JF4QBVL8wRPneCsIB5hQZnIevxBkCaxxhzVp6lXE
LSMRF45aDp01RrGT700sctdvC/MzL6wWPLcb1f9RtCQpdMFtEzv38MpsK6WH7TeX
ezjPiuPss2tmC4pf8wWQ3YDoJi1TjqFpfvbeUviezvwtGq0lW66j6jXpC6QwmcSb
7un7Yxsm9lInxRWxTA3+ZjPRnDF8Ln32uGr9UuzGYE49ImIRBrX+7LRMcosDEIlu
538Ggsf8UFsGfMITCvIOHCamOZFpNTdgLYHCBNt6UcL1IKAJJezoDL5QvU9Nipgt
p9+As3hfvqId1Z3UAu0LPmWcHWhdYr1og21X6pjQC3ynMZoWW2w9F8ceWBFpDf2h
ug2aWWqT8UgQw8dT4chcokFVWABRLhScukWtFg1jmLG1TkvZm/hs3YyyTrdb4yKX
gAHznvIqom40DPcA8oF5DjSH2n8OTQTvoQVroXeX5HF3BXkW39LuahWmuDWSJMmF
ZucmkgTcF9CC+wv/dbWzgGzBs6Ec8Zcvd3AIBvgjggsLlcOFJhA=
=Pzrs
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
