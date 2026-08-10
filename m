Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5E3AF66E;
	Mon, 10 Aug 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368243; cv=pass; b=OkOHkzfkPotRj3QxSdJAOCUwte68u4whwzqXSWxK0jWT4mP0/Kt9lDA/ADhuPvVarFqCw37y7rAItgXfO8R7KKiy9Osf6WdmVIOpLLxDG/5rDxu5znwci1aX+pIC1KUkA1dB2IbsVfuSb46P+eGpI8cOcd5F1gx+oiTwcAjiRtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368243; c=relaxed/simple;
	bh=UVLS94Nu/msDhoAOREJ/lL1zoSphEtNktL21sATk4oE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VUYej7fRZCsNZygSAo4IkpSE506oDJ8HFdBeUbTfjou0VY+A71EztfClz/gH8/wddKAnJ5XGNCb3p4748gVazVPjJUTzobDkV1tEl/2yU/XT91tkC6FrAfrBy/sAWEcUgJYOnNxe3uUNHzFI433/gqlrfjRyhFYAdQpPpzxQ+K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=kcm8+Fr2; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=pxqtwYZ9; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kcm8+Fr2";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="pxqtwYZ9"
ARC-Seal: i=1; a=rsa-sha256; t=1786368204; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oZwvfMJaGTBBjkBPR3xlmWs35zo06s0Dr8YQKH8QljmQ9uAQdJb0dY4ii2Po47oqP8
    067G+NpNbtO6GzHie7kkZdJTYt6Sd/NqrS/d1kcJEpNgrGkAkZ8SIwtvWeBKmS5k9Fac
    vXkiKYUJC6PYF/p4Pr6dw8zr2scRUYMyKsl8UHdgG4Ib47RrdCxnMfsi9AyxIyyZy37Y
    PPOcJHoF24PexYjubN31MwQUiqAh4gI3eb2/fC/OwHW2ATBlmHcxoT/jNBezdwGCEOa8
    rJcBzx3XdhhgBSzEwK56xxGuGT3NJWjcI0NlYpdmHNrHCap6ovCeOLaxVM4LstkqLLyD
    Jr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786368204;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UVLS94Nu/msDhoAOREJ/lL1zoSphEtNktL21sATk4oE=;
    b=C+1GfriRL03PaVpEB/BoflZAnOd1yR2ZtLYd5i6MPiLflpvEskSs3khOWLyKqzxH/j
    o2QKHBwtRaQKj6ThIeRV8BD0v3Qj6ZUYjFKsyERDoXujHTKyJrFUiKNZGT0s4WYueo4+
    wP/MVZu0RTQW2af+92csK9Or6YeqTXyWrRPZtM3SsYsAdcT3x3f0Y2VmFWlegE73pJ5q
    X2QeBYDtap1kxHY5EaWbcfPhZGX73KBDLOO3DeBFEHbmLihuSnJHfI+pG4b/2W7MRbU7
    k/A0WKcFkqDzvTL04qHhwJvalDaSv5DG28OCW8zt6KvjYDNtZ4H86NoUasppqu5z8ZvL
    Cauw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786368204;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UVLS94Nu/msDhoAOREJ/lL1zoSphEtNktL21sATk4oE=;
    b=kcm8+Fr2dZean0JggFaM7FX7eCQ0l72pYub+jaEsPSUSWMe5O3ysbVty9J/EXJPTjz
    P3QnSXXXzPz91KM1By7JeVtoVQNQpopVNNfjMIZbYX/MCCauNFwRSIcaZmEdlx/wh9Qm
    k08PgQNTXbHTQuYQglOPk7Me9jnJJ6E2H8DfMaZ/lmqBFLQdLaBOUbbmQuwjjueQdIBa
    KBeKcD4QTIZp3HGCkhIynZd7/lGowSgsPZuEPHgHAOSTfb5mOfjIxI+wNQzFRIbkQn9V
    PK1vLEnuTXXYtSkK0NQ+W+uEATtNy4pdSGza6qp8Ao+U63HGKfaId3RvGDZeWVKQOgkI
    yTPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786368204;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UVLS94Nu/msDhoAOREJ/lL1zoSphEtNktL21sATk4oE=;
    b=pxqtwYZ9vplpgSt/sU0OClyffqzbWrotFPpsUMsIZ9OtbvV0CemIGBSKQDjB4znVj4
    LlouQyDfsJrsM2TlRSDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrTipoGmsiNZ9v/oGyp26o/Wi+pVFrZX1Db5b3z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac27ADNMhHH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 10 Aug 2026 15:23:22 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 15/16] backlight: remove pandora_bl
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260810143914.64d29a5c@kemnade.info>
Date: Mon, 10 Aug 2026 15:23:12 +0200
Cc: Daniel Thompson <danielt@kernel.org>,
 Grond <grond66@riseup.net>,
 Stefan Leichter <sle85276@gmx.de>,
 Grazvydas Ignotas <notasas@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>,
 letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com,
 mfd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C9844A3-3C4C-48E6-863D-BF8328CEE540@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
 <anmpiADsvzW39DNx@aspen.lan>
 <DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
 <20260810143914.64d29a5c@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81.1.8)



> Am 10.08.2026 um 14:39 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Mon, 10 Aug 2026 12:45:16 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi Daniel,
>>=20
>>> Am 10.08.2026 um 12:35 schrieb Daniel Thompson <danielt@kernel.org>:
>>>=20
>>> On Sat, Jul 11, 2026 at 08:02:02AM +0200, H. Nikolaus Schaller =
wrote: =20
>>>> Retire the platform specific pandora backlight driver since
>>>> it can now be replaced by twl_pm and device tree.
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com> =20
>>>=20
>>> Yay!
>>>=20
>>> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> =20
>>=20
>> Well, there were some good comments by Sahiko to the prerequisites of =
this patch,
>> because it has one speciality the PWM BL driver does not handle =
(avoid
>> interpretation of PWM signals as W1 protocol).
>>=20
>> I haven't found time to work on this, so we can't remove this yet.
>>=20
>> In the end it may either remain a pandora_bl driver (converted to DT)
>> or become a patch for something else.
>>=20
> But then it is a TPS61161 on top of PWM, not a pandora driver.
> And then there might be just a quirk for that chip in the pwm_bl using
> triggered by a compatible. I guess the quirk is this:
>=20
>=20
> if (priv->old_state =3D=3D PANDORABL_WAS_OFF) {
> - /*
> - * set PWM duty cycle to max. TPS61161 seems to use this
> - * to calibrate it's PWM sensitivity when it starts.
> - */
> - twl_i2c_write_u8(TWL_MODULE_PWM, MAX_VALUE, TWL_PWM0_OFF);
> -
> - /* first enable clock, then PWM0 out */
> - twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
> - r &=3D ~PWM0_ENABLE;
> - r |=3D PWM0_CLK_ENABLE;
> - twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
> - r |=3D PWM0_ENABLE;
> - twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
> -
> - /*
> - * TI made it very easy to enable digital control, so easy that
> - * it often triggers unintentionally and disabes PWM control,
> - * so wait until 1 wire mode detection window ends.
> - */
> - usleep_range(2000, 10000);
> - }
>=20

Yes that is what I mean. It needs to be ported somewhere. If it can be =
ported to
some compatible =3D "pwm_bl_for_tps61161" or what fits best it will be =
fine. Or it
could be in some compatible =3D "pandora_bl" driver.

Has to be worked out when the development machines are not blocked by 3 =
or 4 other
projects already running in parallel :)

BR,
Nikolaus


