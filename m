Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CB4CCDD7
	for <linux-omap@vger.kernel.org>; Tue, 15 Sep 2026 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503362; cv=pass; b=uRNTY6a7Jnu46Vpv7a8DzIjnubYwLhu3IVYRC1g+Ay076rqY+HzHm41kInEvOcQhmS5itY4mnKshvgNg7I2dEC5e2hTGHA12rIHfVerO2IgmFlvbgyHz8tQOvYuvbDM3lRyHiwEH8gFjiFu7Aum8KR45E0EWCge1Stv1Fdm0QSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503362; c=relaxed/simple;
	bh=tIo4II1d9ForEs6449DJ6tBTc4LuD50qTRo8+K+5e2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1htbb4cTNjP89lJEohTuQUJG9fWIm5x5zUAonueEoHBrP0Exv+rqkee0MAs6w6BBHeIgdKBZQClgQQEwR3yJwhTcMVs4lqdUlJZQ7bbh/QWLveqpHZifKe7yP7RzxvVqw0z6n6VTunD5KYrQlc8iO09rlTWq6J2GK83Q/bMfFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMFK/xdh; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMFK/xdh"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293d3da33bso3576766b.3
        for <linux-omap@vger.kernel.org>; Tue, 15 Sep 2026 13:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789503350; cv=none;
        d=google.com; s=arc-20260327;
        b=Xbo/iLHWQzd6qjIhLA11vSsZoliLAiIXZ3ea20+cg4Nllav9C6zPOr//Cb+GyuuBW6
         S01qBs9VHnC1X1tQOy67f4WZmSJ1WcYk9RmcB8Ph7jx1VFNgVcqCI119lbsNqWozRJq4
         Wjntn1nuDadRFw1upgx4+Vaz+qypmU8O529n8TWHcLYf6mmJhCyFLyGZoPdKaQMi9U+2
         5wT9Dk1dPBQQfEV+aBzUgRmfOF8kq/y+FoxFtY0i9oB/fkYUZLT3iJLMdDIuArQZuEuE
         vUr0fw73qmOfcud9XfOmK6ISqN0bRUpLUmu/F+IYa/6srkWR6e+WHkX3ALhnerpW4CWH
         slww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EMk9jyFcs1z/vsVIU7tgrrT3h1+jFXhNZlrTV/0Lq28=;
        fh=jdWe02o/zpvQtPsNlC2AW0Q/J0ncPzEcDLMVxozpK14=;
        b=QJ7Yg9uNpuGEo/xsA8VW5cWy3GDN9W+LJlXVTJAde1fyP3VVT0WGVJZxlAaMx/SHQA
         MmbMNZeoG22kQD/69qS8+x2EavE4JQe3rPAdVjFcgLQORHAiDUToY+dkze+sqS/YkBh0
         pNBg8+AeTadJLYvf/dnHWNmCBMScDkth+h5KqWldvUIohvRqdQUn+W/VtXsEnqYEnB/N
         vAojwMoX8/GE+Kq78WHrxyY6F/r117mnE9JEUktcp4P9vHnQ8Rqd7o1L8bFTcPbMpWKY
         ndAnEEaMI0uDe4hg/2u6rIT1Fq47AyZEp/1f6V1JUMXyLNFvDZgpRTdS9F9cjK+kBk61
         +INw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789503350; x=1790108150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMk9jyFcs1z/vsVIU7tgrrT3h1+jFXhNZlrTV/0Lq28=;
        b=kMFK/xdhuVPYWFau0SVnAOI0dP1+C/ya4QEGqAnK+/WVuj4My0qAoQvVI+BKoY1ZwI
         NNABdWF+rnRpE/BFKhqhZ/72374Gy9eqKQpfsepDHKgixJYqiLHKeF7uqSuwRIr+AFw7
         8JTPpKKSxCJQVvxWu8uSG9skZAQ2M3M9ggXG2ixYT19P0Ks5ehXSvpBZtpa4O59JsnUE
         AEmjUlBrtixnd++kPKKOnZG0n0ogjzJEPniFUASQttiJrfpK73sW0IsgwVTbUlIwDL83
         B8pt1JK0UJ20OQjry6Fy4j7Drm8AoJ0UIWSLyNEBfmWDCEDeQ0whVitGHVB5nO2aKI8B
         vaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789503350; x=1790108150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMk9jyFcs1z/vsVIU7tgrrT3h1+jFXhNZlrTV/0Lq28=;
        b=Nq0sQj/V6Dpp9Lw0Dc4c88ChZQd85rW0Ej5e43hkiLMMSEpuS4BCjk1GtoVmVG2jMN
         GZZQxP3SKxdEuQqyG8yj5aadUFPwB7vxY6qhxBQmVfogW5/0yQadPf4bjx5xTNeoH8XH
         pNKS/RAO3x+lKsvXa6vgEq3h2pebW9qsgLuyTDhLLVFwJkbGoa9ZZMyhCKHYNAOWfSaV
         FQU8r+Ki/54Z2trFkHjxCPCD+sysLMJIKGJzgyX9f3h5iHk45wQ0mS8cU0ex4Y0EOyzo
         5MvcvTW+L4b7RVrzb04u2UZkWAEG93SwHydY58vJiSO1IqX6v+kiPbkKKAIZepQnShTg
         yFDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdYGtJNccBGOaERMb5wwyHNH9ugKcSDolZVWmxH2cbQWuJ+Ze6BLxnOu4IBdDEMHrczDc4HPB1ZwiF@vger.kernel.org
X-Gm-Message-State: AFuF++mFWA8SyLTeG3ZXGQd1vzcwH6IfKfy1ERY50FHazT1peh7ZE3md
	Oy0igmd5RnLB01QcLGoaAggMXv2UlCmMyrZ+Y3nQ9btfhPaMNsaJQ9qUlZvoogkd1m1a4sDgIm1
	G3VqyU1LphHii0iFYM+rDhRXLUJJlVOs=
X-Gm-Gg: AYBFou3BpcbQH9aihAus4oKq/QssvlI6dqbsTBaig3GMJog9AaJcLnmBEqAy0EtdENW
	lfObYv6IMPRyUlXy9vqbs3nvNLFny3TO2L+z+LJ5Sd2KFSpVb7MafT1tyLRmsLo0kAU5WHDnyzi
	b1zP63OhqxoNwt3WulVucH7g3yC3iB//aBYlzPTB5MdeFQgZ9sXAJtiUJ3WToc29gFZnYTARjHs
	EJ6YPbWmE12W+xFv2R52B7/+Jfp/hLQu9GYLTxCzDIuPh2O3moeRQSTuTcdcKPfy+bQSe74RBdc
	+meW8SAaxv7EFMBu8d9feT0C6a4Xd55VbjRxm/iXukZszH5A2ZNAhz8=
X-Received: by 2002:a17:907:94c1:b0:c21:7bf1:2c88 with SMTP id
 a640c23a62f3a-c29b86f6a30mr608631966b.2.1789503349926; Tue, 15 Sep 2026
 13:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-ti-dra7-omap-sham-fix-v1-0-c430f01b4e13@gmail.com>
 <20260911-ti-dra7-omap-sham-fix-v1-2-c430f01b4e13@gmail.com> <20260911082406.05e2a212@kemnade.info>
In-Reply-To: <20260911082406.05e2a212@kemnade.info>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 16 Sep 2026 01:45:37 +0530
X-Gm-Features: AcwNN1WHlqVruIX69u_0BS3IFoNFccfPURE_yLQbZJm0y0g2wehRCyWKILewqPs
Message-ID: <CAOWyW_5s++Sz6EFEX+zGTca_-xZvK29B88UzoEzsaP+QavF6CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: crypto: ti,omap-sham: Add OMAP3
 compatible and deprecate ti,hwmods
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

On Fri, Sep 11, 2026 at 11:54=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
>
> On Fri, 11 Sep 2026 03:41:58 +0530
> Bhargav Joshi <j.bhargav.u@gmail.com> wrote:
>
> > The OMAP SHAM driver supports OMAP3 SoCs, and "ti,omap3-sham" is
> > actively used in existing dts. However, it was previously missing from
> > binding. Add "ti,omap3-sham" to the list of valid compatibles.
> >
> > The legacy "ti,hwmods" property is no longer needed as TI OMAP mirgrate=
d
> > to "ti-sysc". Mark it as deprecated and remove it from the required
> > properties.
> >
> > Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
>
> What about also removing ti,hwmods usage while you are deprecating it?

Omap 4, 5 and dra7 already use ti,sysc wrapper and don't actually use ti,hw=
mods.
but legacy omap 2 and 3 still use ti,hwmods but I don't have hardware
to test changes.

Since omap 4,5 etc don't use it,hwmods keeping it in required causes warnin=
gs,
Deprecating it and removing it from "required" fixes the warnings for
modern SoCs without
breaking the legacy ones.

Best Regards,
Bhargav

>
> Regards,
> Andreas
> > ---
> >  Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml=
 b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > index d69b50228009..3ef05890e13a 100644
> > --- a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > @@ -13,6 +13,7 @@ properties:
> >    compatible:
> >      enum:
> >        - ti,omap2-sham
> > +      - ti,omap3-sham
> >        - ti,omap4-sham
> >        - ti,omap5-sham
> >
> > @@ -32,6 +33,7 @@ properties:
> >      description: Name of the hwmod associated with the SHAM module
> >      $ref: /schemas/types.yaml#/definitions/string
> >      enum: [sham]
> > +    deprecated: true
> >
> >  dependencies:
> >    dmas: [dma-names]
> > @@ -40,7 +42,6 @@ additionalProperties: false
> >
> >  required:
> >    - compatible
> > -  - ti,hwmods
> >    - reg
> >    - interrupts
> >
> >
>
