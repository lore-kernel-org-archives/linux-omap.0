From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH] ASoC: AIC23: Fixing infinite loop in resume path
Date: Fri, 27 Nov 2009 18:15:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC348A@dbde02.ent.ti.com>
References: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
 <e7c6a05e0911270424k17df4f20leb53aeef970ddcdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33468 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZK0MpW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:45:22 -0500
In-Reply-To: <e7c6a05e0911270424k17df4f20leb53aeef970ddcdf@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

> > @@ -625,11 +625,10 @@ static int tlv320aic23_resume(struct
> platform_device *pdev)
> > =A0{
> > =A0 =A0 =A0 =A0struct snd_soc_device *socdev =3D platform_get_drvda=
ta(pdev);
> > =A0 =A0 =A0 =A0struct snd_soc_codec *codec =3D socdev->card->codec;
> > - =A0 =A0 =A0 int i;
> > =A0 =A0 =A0 =A0u16 reg;
> >
> > =A0 =A0 =A0 =A0/* Sync reg_cache with the hardware */
> > - =A0 =A0 =A0 for (reg =3D 0; reg < ARRAY_SIZE(tlv320aic23_reg); i+=
+) {
> > + =A0 =A0 =A0 for (reg =3D 0; reg < TLV320AIC23_RESET; reg++) {
> ARRAY_SIZE() shouldn't be preserved?
[Aggarwal, Anuj] No, since registers 0x0A - 0x0E are not present.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 val =3D tlv320aic23_read_reg_cac=
he(codec, reg);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tlv320aic23_write(codec, reg, val);
> > =A0 =A0 =A0 =A0}
> > --
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
