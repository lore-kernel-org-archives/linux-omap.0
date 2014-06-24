From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/1] sound/soc/omap/mcbsp.c: remove unnecessary null test
 before kfree
Date: Tue, 24 Jun 2014 10:48:25 +0300
Message-ID: <53A92D49.9060306@ti.com>
References: <1403541221-10619-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403541221-10619-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Fabian,

On 06/23/2014 07:33 PM, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: kfree(NULL) is safe this check is probably not required

can you send the same patch to alsa-devel with subject:
ASoC: mcbsp:  remove unnecessary null test before kfree

You can add my:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  sound/soc/omap/mcbsp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 86c7538..68a1252 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -621,8 +621,7 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
>  	mcbsp->reg_cache =3D NULL;
>  	spin_unlock(&mcbsp->lock);
> =20
> -	if (reg_cache)
> -		kfree(reg_cache);
> +	kfree(reg_cache);
>  }
> =20
>  /*
>=20


--=20
P=E9ter
