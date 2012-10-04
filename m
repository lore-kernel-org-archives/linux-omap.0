From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ASoC: omap-mcpdm: Remove OMAP revision check
Date: Thu, 04 Oct 2012 11:22:33 +0300
Message-ID: <506D4749.4020405@ti.com>
References: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com> <1349338509-3440-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50904 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932554Ab2JDIVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 04:21:17 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so192640obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 01:21:16 -0700 (PDT)
In-Reply-To: <1349338509-3440-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 10/04/2012 11:15 AM, Peter Ujfalusi wrote:
> The OMAP revision check is not needed since the watchdog bit is not i=
n use
> on 4430 ES1.0 and have no effect when we set the bit. The watchdog ne=
ed to
> be enabled on all other revisions.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-mcpdm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.=
c
> index fdf655e..8f5edc8 100644
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -40,7 +40,6 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> =20
> -#include <plat/cpu.h>
>  #include "omap-mcpdm.h"
>  #include "omap-pcm.h"
> =20
> @@ -258,14 +257,9 @@ static int omap_mcpdm_dai_startup(struct snd_pcm=
_substream *substream,
>  	mutex_lock(&mcpdm->mutex);
> =20
>  	if (!dai->active) {
> -		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
> -		if (omap_rev() !=3D OMAP4430_REV_ES1_0) {
> -			u32 ctrl =3D omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
> +		u32 ctrl =3D omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
> =20
> -			omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL,
> -					 ctrl | MCPDM_WD_EN);
> -		}
> -		omap_mcpdm_open_streams(mcpdm);
> +		omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl | MCPDM_WD_EN);

Oops. I have removed the omap_mcpdm_open_streams() as well...
Will resend :(

>  	}
>  	mutex_unlock(&mcpdm->mutex);
> =20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
