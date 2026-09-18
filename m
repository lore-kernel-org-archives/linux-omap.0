Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48032525A96
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764812; cv=pass; b=H7L8IxFaMq6tx0kfjSVkfOMLor2aMzCVQfo4NE7eAfNBXhtQcVnqI2OGIAuqXg4fS8I8fnxhkC6TOuPfFqvaxefy3srgNBXRwNYaHNB5YbFCsoN/oGQkGuvD2oG1+jzNlpBxE6vw9+uBE/mEKMT7uY8csF/b3m0cvujDvAMoF/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764812; c=relaxed/simple;
	bh=luig+1o1M/fsF9vaNIsARo6CqC/xBHmV9/YvD0slYb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8c/PrOtNc6XL/xDLsvbP/9ZgXnrKa5IT7cUZhH5UUr2cepcgZgn6paLsW/RkORSB9K8ntSMWyUaRerRM/NgPrx0zxag0W94V6t7mUIlcs8MBLrBRECePIc1gnASUGbGtH3ZsS9iBC3QxPUcofryNV0AO5bvnX/a62NvUx73y8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGw2d+7L; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGw2d+7L"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484399babcaso140977f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2026 13:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764808; cv=none;
        d=google.com; s=arc-20260327;
        b=nSqPuxhlmKrsPVll5gt4EFcf71pzwhwvSGjLfRIg4R8R4djyL4rbG8kSfflgM+wRqL
         gSPuv7CnlZfop1wLIZtJ9Km+aNFKpUQLBsHHg7t+6GdQbGdh7uOvnGPtPemx4gm8vf1a
         5amzRoXInVYuUgOh3sjiUZPdWGinhNFrdkHHxWsTZYM6tGkKkvZY3PyXh8WNOaPpgTII
         Alo+A9earP/jNG3SPLotWXJM1DiEmk9zeiKm/BDHhO95jLuInCKZl5NqvsIYZw6V3Oje
         zrWT4TfEW8kot+gVdf+pKduRvqNNxKK5cDDmX+qAag0gLZe9q0FfY2SR9621IO96JMag
         HznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgTcRorf9vWGoUo+DaV05plknDxMZzVIVIvRR476748=;
        fh=4Sf9xLk6v9CrAUbNaUFPMEWYU+X3VitHHz/t60j0Pno=;
        b=E6+uzYWzw4y8htpQmVtMcjPER1tq7IOpzicK1d2sqFWjfABCxvNMBJ+4GdC+UfgeMi
         YDaUgrqL20DhxPMbRglytW4TWFVSWSyt+SnCUEi6ADM97MWg490YVKITeAycfgHqG7pq
         5x3xKSXBlQGLYpckahgWzw7RJfziTlrJ4ARIn5LIGujtMkbvy+vEF2lzX2wS2IyDeuHB
         n0XXqcCbcd45sqTDADpp6a4FUyWqemBT729jmVkk+VffaLyJK9rHBAbdYk5XBMXJzsmA
         8HAbl51Z+DayBOadcjooL7F9icfOhWB5x20QXQJgJ3boNgPHtNX5R4SedLZk/hsKOyfk
         ZGHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789764808; x=1790369608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sgTcRorf9vWGoUo+DaV05plknDxMZzVIVIvRR476748=;
        b=PGw2d+7LCXGpFRgce2pQrMPex2ONmymjB4wMc101C8ZNM1LdY5O7I1Rx0WTuSc2NtI
         Zitp6OrbrRoynk9SAe8xoUdRNSQm2cwlophdOeOWjJ853LCpA4Oh3sg+4yr4zU//e95t
         dtA/yVgZc5b8Sh2wknJQvioNwVspmH95QcwPBkEwmANXZppOA3sZMfpv+hsI2DlYdPEd
         B9BnuNWWAEwODF9Iw7zc7Cd3kgxNTgxVuNQjSOAizfm/n1PVZXHkbfqENF6Lj4n8kfXz
         Sr5w7sleNShnortkfhSftYNnZYz2/DTxmWkC7BZ7X04vtqij8nzmV7DFpp1GD02rszsE
         n5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789764808; x=1790369608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgTcRorf9vWGoUo+DaV05plknDxMZzVIVIvRR476748=;
        b=OmjWEh5N+64+kZ9uJZb3iEuPP3V8PWb/EvFa2lhW2m86LZ0bPykKQbPk8Q2Xg9tk6c
         7VsgMGltkXg9U4aOBwp6S2JBh5nA4l5VSvAnWsovZ4pS0tAc4Ult7Xq3vaUJ8d5crgst
         LktlizKv5YZ3Q3kkAX3ONmiuX2KaTYyKWqG/k32z+ho9hLKwPMhT9IyF+jz6qvigcm+X
         RKj03rhxrhIr1O3zzz0GMMj/crAQv2+tg0/UZoCJRD6OdDy/5xrFRVAq4IHgTTKYsLSK
         OPyAlnAgvWNvtmVtCJWJDfg5Z+vOogvC7f6CWDzAssWVvK8pwJlKztv2BDezgPx9v5P3
         vQ5w==
X-Forwarded-Encrypted: i=1; AKwUvBzb7oUfZjRl8Hb5S+9fnWrEwqc8qDIERWOFTfKkQkOaIglwZy9ug3JFik5FAGtvfwXCgY/TcZylcnNs@vger.kernel.org
X-Gm-Message-State: AFuF++n5khXZqVTerM2R1lNW03uNoQ2jIqUYrl/7iOauHV7FFI2dpL0q
	Sz+ZVaCIraMW5c6kYNpDz08sm041+tbQlTa2BZNJluIJXkeuZabyu4puiX118oMqlgAYoN7R179
	LJLp0AIOyBL747Rf330MOQOY8EsccmUdsXSCo
X-Gm-Gg: AYBFou3gcpbc7cHtQ5PlVMAq3QFuKPrvdenjSolEVry1/eUjICm4uBxMGsGt59Iob0P
	wmxYreHbOBUobD57lFC7vjDnc0eH8KwJjYdji/DT7x3+xJo19dUP5fBbc68xCZxx1NWv0E3Yke6
	w9p79Fun42xpz8mkg8qaib+SSTZ++oiHOBGaikA7ecnI0KN7oCkv/pp9n5KLuPnUTBOBsqBkSoM
	yXwKBPuwDrhrAodmhmfhSU9t+LvHpM9keu+G96EhB8e7vCwmb1O6WUlSa68o7dHxAueU2gmsQu8
	4ygfXJ2z5iq749iCdurCR+AM5ENqnovZ7cHVw7gUzkyS9zJ3ssX8j/sdUHJzyjRLth5qy+pv2Nn
	okVqeobkKW0wOHKx5hNa15oM=
X-Received: by 2002:a17:907:d02:b0:c25:3ccf:bd9c with SMTP id
 a640c23a62f3a-c2a1a8e09e8mr331776566b.2.1789764477295; Fri, 18 Sep 2026
 13:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-ti-dra7-omap-sham-fix-v2-0-4eadb60081e5@gmail.com>
 <20260916-ti-dra7-omap-sham-fix-v2-2-4eadb60081e5@gmail.com> <20260918144224.4dfb8515@kemnade.info>
In-Reply-To: <20260918144224.4dfb8515@kemnade.info>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 19 Sep 2026 02:17:44 +0530
X-Gm-Features: AcwNN1WKvA-fdN2xNZdCXGZd1cxpuLrv71RZ7MqA3wlpHyScvRfY20wc8pzPN-Q
Message-ID: <CAOWyW_5GU__FE25POrjKH=CmOHaeBRJPw4xS2cdodePm3LydhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: ti: omap: dra7: Remove clocks from
 crypto nodes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Animesh Agarwal <animeshagarwal28@gmail.com>, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 6:12=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> On Wed, 16 Sep 2026 02:29:39 +0530
> Bhargav Joshi <j.bhargav.u@gmail.com> wrote:
>
> > The omap-sham, omap4-des and omap2-aes crypto drivers do not use
> > "clocks" and "clock-names" properties. Clock management is handled by
> > the ti-sysc interconnect parent wrapper. The dt-bindings for
> > ti,omap-sham and ti,omap-aes don't define these clock properties. Havin=
g
> > them in the child nodes causes dtbs_check warnings.
> >
> > Remove the "clocks" and "clock-names" properties from the sham, des and
> > aes nodes.
> >
> > Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> > Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
>
> I was a bit too fast here, clocks here are different from what is
> used in the ti-sysc block. So some more thought and argumenting is needed=
.
Clocking is handled by ti-sysc parent block, furthermore other dtsi
such as omap5,
omap4, am4372 which uses the same hardware doesn't define any clock in
the child node.
parent block defines a clock with clock-name: fck
clocks =3D <&l4sec_clkctrl DRA7_L4SEC_AES2_CLKCTRL 0>;
clock-names =3D "fck";
and child main part as
clocks =3D <&l3_iclk_div>;
clock-names =3D "fck";
If child node needs this separate clock  in child node then binding
for aes and sham needs
to be updated to allow clocks and clock-names leaving des binding as it is.

Best Regards,
Bhargav
>
> Regards,
> Andreas
>
> > ---
> >  arch/arm/boot/dts/ti/omap/dra7-l4.dtsi | 2 --
> >  arch/arm/boot/dts/ti/omap/dra7.dtsi    | 8 --------
> >  2 files changed, 10 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts=
/ti/omap/dra7-l4.dtsi
> > index a595745afe59..bca035fd7e62 100644
> > --- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
> > @@ -2086,8 +2086,6 @@ des: des@0 {
> >                               interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL=
_HIGH>;
> >                               dmas =3D <&sdma_xbar 117>, <&sdma_xbar 11=
6>;
> >                               dma-names =3D "tx", "rx";
> > -                             clocks =3D <&l3_iclk_div>;
> > -                             clock-names =3D "fck";
> >                       };
> >               };
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti=
/omap/dra7.dtsi
> > index 711ce4c31bb1..0784c6d9cbe4 100644
> > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > @@ -1012,8 +1012,6 @@ aes1: aes@0 {
> >                               interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL=
_HIGH>;
> >                               dmas =3D <&edma_xbar 111 0>, <&edma_xbar =
110 0>;
> >                               dma-names =3D "tx", "rx";
> > -                             clocks =3D <&l3_iclk_div>;
> > -                             clock-names =3D "fck";
> >                       };
> >               };
> >
> > @@ -1043,8 +1041,6 @@ aes2: aes@0 {
> >                               interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL=
_HIGH>;
> >                               dmas =3D <&edma_xbar 114 0>, <&edma_xbar =
113 0>;
> >                               dma-names =3D "tx", "rx";
> > -                             clocks =3D <&l3_iclk_div>;
> > -                             clock-names =3D "fck";
> >                       };
> >               };
> >
> > @@ -1073,8 +1069,6 @@ sham1: sham@0 {
> >                               interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL=
_HIGH>;
> >                               dmas =3D <&edma_xbar 119 0>;
> >                               dma-names =3D "rx";
> > -                             clocks =3D <&l3_iclk_div>;
> > -                             clock-names =3D "fck";
> >                       };
> >               };
> >
> > @@ -1103,8 +1097,6 @@ sham2: sham@0 {
> >                               interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVE=
L_HIGH>;
> >                               dmas =3D <&edma_xbar 165 0>;
> >                               dma-names =3D "rx";
> > -                             clocks =3D <&l3_iclk_div>;
> > -                             clock-names =3D "fck";
> >                       };
> >               };
> >
> >
>
