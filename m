From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] ASoC: AIC23: Fixing infinite loop in resume path
Date: Fri, 27 Nov 2009 13:24:40 +0100
Message-ID: <e7c6a05e0911270424k17df4f20leb53aeef970ddcdf@mail.gmail.com>
References: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:62555 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZK0MZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:25:10 -0500
Received: by iwn1 with SMTP id 1so914688iwn.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 04:25:15 -0800 (PST)
In-Reply-To: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com

On Fri, Nov 27, 2009 at 1:10 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> w=
rote:
> This patch fixes two issues:
> a) Infinite loop in resume function
> b) Writes to non-existing registers in resume function
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =C2=A0sound/soc/codecs/tlv320aic23.c | =C2=A0 =C2=A03 +--
> =C2=A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320=
aic23.c
> index 6b24d8b..90a0264 100644
> --- a/sound/soc/codecs/tlv320aic23.c
> +++ b/sound/soc/codecs/tlv320aic23.c
> @@ -625,11 +625,10 @@ static int tlv320aic23_resume(struct platform_d=
evice *pdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_soc_device *socdev =3D platform=
_get_drvdata(pdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_soc_codec *codec =3D socdev->ca=
rd->codec;
> - =C2=A0 =C2=A0 =C2=A0 int i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 reg;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Sync reg_cache with the hardware */
> - =C2=A0 =C2=A0 =C2=A0 for (reg =3D 0; reg < ARRAY_SIZE(tlv320aic23_r=
eg); i++) {
> + =C2=A0 =C2=A0 =C2=A0 for (reg =3D 0; reg < TLV320AIC23_RESET; reg++=
) {
ARRAY_SIZE() shouldn't be preserved?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 val =3D tl=
v320aic23_read_reg_cache(codec, reg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tlv320aic23_wr=
ite(codec, reg, val);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Marek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
