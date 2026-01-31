Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B02AD10;
	Sat, 31 Jan 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885030; cv=none; b=Op5TEo2sMEJyXe96iYFIYV0n264kW2Um/z4VpZe585LxSsHOFo0BxoC9G++8qCjK3rEwnosGq1dykCLeQIK6gczpGprRPs5WODKHTvqm45KkSkCOlvxpOh1N0Xwul3CiRzURvOC0XWodjXcukf7D3yEjfc1lR89Pp2HLvaBygIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885030; c=relaxed/simple;
	bh=V230ZpS3Au27KXeL9VcKAnrRH++doZJxrRUndqwRCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPwrzlnUq6GWCd1AdfSTt18OzmS49JkI1y0SrsqraP0kXTrPqgm8Rz8oAeU0VtmvinTHnDyrR3QUsDPl2Jkb4jaXu1jG7zJXkCQx7Ljv90RhUBKMs1MV6uVgqCytNydgFEX/bHbyj5jDpE82n6Mg5uDleXeAQexftPDBdAJPMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3A5UimO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3A5UimO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC4C4CEF1;
	Sat, 31 Jan 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769885030;
	bh=V230ZpS3Au27KXeL9VcKAnrRH++doZJxrRUndqwRCGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3A5UimOzbnOf0E0TMf0I/u9xQp8IbAYPFGgAAe96j3D2AhB1OXTsShSoBCjAitcX
	 jaD8i3kRWQajw7rC8kZi6A8rHN0dm4WAjUkTdI7yHMPJDjOZN3+ZQqRl4XMyLB3QF8
	 8AK1siBeUcVVpkG3yFmGAijtR6Qcb8CUwN/0cCOEXtu4GkW1WEwPnNOcJtn13+zMDD
	 W4s97FECeTHiwMO5uDxi4X/Pxn2QQIA5UamChcZyijpm/tCfEbMkvcuMhnpEXQOQIu
	 NM1Aa8VzzKkQPKfPle+qqgaBES43Rb+KOLg3qbTxutEGl4R0AHdnyGVjXRjx93mXqT
	 SYLNNnmTYeiXw==
Date: Sat, 31 Jan 2026 18:43:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "akemnade@kernel.org" <akemnade@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack preventing irq
 storms
Message-ID: <20260131184337.6e48c759@jic23-huawei>
In-Reply-To: <FR3P281MB1757D391A1747D25E58471BBCE9FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-1-08ecf085c4ae@kernel.org>
	<20260111123003.450bec98@jic23-huawei>
	<FR3P281MB1757D391A1747D25E58471BBCE9FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 16:17:58 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >________________________________________
> >From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> >Sent:=C2=A0Sunday, January 11, 2026 13:30
> >To:=C2=A0akemnade@kernel.org <akemnade@kernel.org>
> >Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; David =
Lechner <dlechner@baylibre.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Sh=
evchenko <andy@kernel.org>; Aaro Koskinen <aaro.koskinen@iki.fi>; Andreas K=
emnade <andreas@kemnade.info>; Kevin Hilman <khilman@baylibre.com>; Roger Q=
uadros <rogerq@kernel.org>; Tony Lindgren <tony@atomide.com>; Rob Herring <=
robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <c=
onor+dt@kernel.org>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; linux-=
iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.o=
rg <linux-kernel@vger.kernel.org>; linux-omap@vger.kernel.org <linux-omap@v=
ger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>
> >Subject:=C2=A0Re: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack prevent=
ing irq storms
> >=C2=A0
> >On Wed, 31 Dec 2025 22:=E2=80=8A14:=E2=80=8A16 +0100 akemnade@=E2=80=8Ak=
ernel.=E2=80=8Aorg wrote: > From: Andreas Kemnade <andreas@=E2=80=8Akemnade=
.=E2=80=8Ainfo> > > IRQ needs to be acked. for some odd reasons, reading fr=
om irq status does > not reliable help, enable acking from
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >ZjQcmQRYFpfptBannerEnd
> >On Wed, 31 Dec 2025 22:14:16 +0100
> >akemnade@kernel.org wrote:
> > =20
> >> From: Andreas Kemnade <andreas@kemnade.info>
> >>=20
> >> IRQ needs to be acked. for some odd reasons, reading from irq status d=
oes
> >> not reliable help, enable acking from any register to be on the safe s=
ide
> >> and read the irq status register. Comments in the code indicate a known
> >> unreliability with that register.
> >> The blamed commit was tested with mpu6050 in lg,p895 and lg,p880 accor=
ding
> >> to Tested-bys. But with the MPU9150 in the Epson Moverio BT-200 this l=
eads
> >> to irq storms without properly acking the irq.
> >>=20
> >> Fixes: 0a3b517c8089 ("iio: imu: inv_mpu6050: fix interrupt status read=
 for old buggy chips")
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
> >Jean-Baptiste,
> >
> >If you have time to look at this that would be great.
> >
> >Whilst here I'll note the defines in this driver could really do with co=
nsistency
> >improvements. =C2=A0I'd like to see GENMASK() and BIT() used everywhere.
> >Currently it's mostly the style used in this patch with a few fields in
> >the newer style. =C2=A0
> >
> >Thanks
> >
> >Jonathan =20
>=20
> Hello Jonathan,
>=20
> sorry for the late response. This is a very old chip, I'm sorry I won't be
> able to check the modification on my side.
>=20
> By looking at it, it seems correct if it is indeed fixing the issue. I'm
> giving my acknowledgement to the patch.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Good enough for me.
Applied to my local tree for now as we are close to the merge window
and I'll probably rebase before pushing these out.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
> > =20
> >> ---
> >> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =C2=A0 =C2=A0| 8 ++++=
++++
> >> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h =C2=A0 =C2=A0 | 2 ++
> >> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 ++++-
> >> =C2=A03 files changed, 14 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_core.c
> >> index b2fa1f4957a5b..5796896d54cd8 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> @@ -1943,6 +1943,14 @@ int inv_mpu_core_probe(struct regmap *regmap, i=
nt irq, const char *name,
> >> =C2=A0			irq_type);
> >> =C2=A0		return -EINVAL;
> >> =C2=A0	}
> >> +
> >> +	/*
> >> +	 * Acking interrupts by status register does not work reliably
> >> +	 * but seem to work when this bit is set.
> >> +	 */
> >> +	if (st->chip_type =3D=3D INV_MPU9150)
> >> +		st->irq_mask |=3D INV_MPU6050_INT_RD_CLEAR;
> >> +
> >> =C2=A0	device_set_wakeup_capable(dev, true);
> >> =C2=A0
> >> =C2=A0	st->vdd_supply =3D devm_regulator_get(dev, "vdd");
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_iio.h
> >> index 211901f8b8eb6..6239b1a803f77 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> >> @@ -390,6 +390,8 @@ struct inv_mpu6050_state {
> >> =C2=A0/* enable level triggering */
> >> =C2=A0#define INV_MPU6050_LATCH_INT_EN	0x20
> >> =C2=A0#define INV_MPU6050_BIT_BYPASS_EN	0x2
> >> +/* allow acking interrupts by any register read */
> >> +#define INV_MPU6050_INT_RD_CLEAR	0x10
> >> =C2=A0
> >> =C2=A0/* Allowed timestamp period jitter in percent */
> >> =C2=A0#define INV_MPU6050_TS_PERIOD_JITTER	4
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/i=
io/imu/inv_mpu6050/inv_mpu_trigger.c
> >> index 10a4733420759..22c1ce66f99ee 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> @@ -248,7 +248,6 @@ static irqreturn_t inv_mpu6050_interrupt_handle(in=
t irq, void *p)
> >> =C2=A0	switch (st->chip_type) {
> >> =C2=A0	case INV_MPU6000:
> >> =C2=A0	case INV_MPU6050:
> >> -	case INV_MPU9150:
> >> =C2=A0		/*
> >> =C2=A0		 * WoM is not supported and interrupt status read seems to be =
broken for
> >> =C2=A0		 * some chips. Since data ready is the only interrupt, bypass =
interrupt
> >> @@ -257,6 +256,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(i=
nt irq, void *p)
> >> =C2=A0		wom_bits =3D 0;
> >> =C2=A0		int_status =3D INV_MPU6050_BIT_RAW_DATA_RDY_INT;
> >> =C2=A0		goto data_ready_interrupt;
> >> +	case INV_MPU9150:
> >> +		/* IRQ needs to be acked */
> >> +		wom_bits =3D 0;
> >> +		break;
> >> =C2=A0	case INV_MPU6500:
> >> =C2=A0	case INV_MPU6515:
> >> =C2=A0	case INV_MPU6880:
> >>  =20
> >
>  =20

