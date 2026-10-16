Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22633A9C1
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125505; cv=pass; b=YdpgR0YWv8PEVQQlrKQ6PdAwP+xsot/DlwfEurPTl8Bb4JJiwzjAoDlqZNmMjlY/ro15FDN2qBwzdV6nZ6hVjBLh08iymsLNx28/lP+ODkvvQeracBbOdELFZUtwfkHeYm2uJ61ZCGvDywatjbLIzT4WfjJ7JxurdX1DaKzpz78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125505; c=relaxed/simple;
	bh=2rlenAEdNau3gkuJLtqbh74S+Iv9a38jmstY8ig7buo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN+eADyMU3KqelVFztEcetvBaTJBshag3F7HWrXYYyXUHyrj3P+yKTA24lLWHVxlUh8DSZOXD0QA7WbMs98dMwbcFJMHATvQKhcVqbEBMDm0v9kiuGMpivWTWX1SZggap8VldclCEpaHlfyuh8ZNxso3RUYjBEWdN9fr5jE4LPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5Ys0i8E; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Ys0i8E"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so2766818a12.3
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 21:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792125502; cv=none;
        d=google.com; s=arc-20260327;
        b=bl2a3KK7sElrkbx4Hwp8JjehHc68X8YomtuxQgrOonC1DEP4n4WEB2NfH4sRWjl1At
         HsRVyL81ic6N+MiUGpxWmXJdwsB7h9fhPKa2z9ls4I7vnQRt57EJU3P9ixxvQDo6Sk64
         Pd1LxdmL19eTNuO/gFcOmVnd4noFOwyVNl7ntPXPy8aAe6/KYfvhU9ub2pBKRFFbUBUq
         LHromVCo4vfMh1nRFu5hPr8N4vJieBlqXbPB3DX9WVthQSkLfepyumoxbEM/1bPKCSwq
         e+W4f3691Gs9qxbojgqJfDidLdXsio9wHqnkzr8YmY+P4f9kPlugMxD0i9oRFSNp1DeP
         wa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k50iRYZEHIeglzuFdsPLFoaxWBDTeuPE91tn2Q2sZzI=;
        fh=m/KcoVP0SMGmE+7W96v+08qkL6lOB7PLghbRZNqnZyk=;
        b=N7MyneoBa0NnZ5MxWRenLWd4uTHb+W0LBK/DdEr4QPRHwhOq4xGIv35BTBM+Un4AU1
         m4RGMf5imGAsnPqWYAQdcA5Op4zoFZzhl8TQYlNSn3vCIobWh88qOEBgx2VfFhk1qvRr
         3UjvVmv3o05ZO01onQO61O13Slyn3Zp9CivV+Jea5Lptvi0OPRpLzUAiuH/FLa606P8N
         TKYuh5E8s+9yT0jiQfwfMFhvg5wRmFQP2usI0ITgsDA2f+i3Z6EGai6x1IqNm7HvgXMk
         XQGRG7q7bctzRgh8I3FdTbrJeHLqV8Vt8NPVSd4uGF36Qty2EAJYWeuWHxLK9MG+6YEr
         Z4mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792125502; x=1792730302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k50iRYZEHIeglzuFdsPLFoaxWBDTeuPE91tn2Q2sZzI=;
        b=D5Ys0i8EXobxcO6CYJeolom//0atFkVfdkFrmLbWuBgVoo6fk0UgcGC66TZdfx3fHV
         s4/RJONSNPM3Fud9BWx3yWW6BpPYHprURdtnYySBhsGesb2glv1bL8cKkfETW7IHXRkm
         S2z7D/W+i2JYHZwgc6XDevQbec0ZxJegz1fB0gCo7gRHJCMg6tM7I7aTwI0dGzTwycal
         cYUjA80gp2YzKK3syWA4J72RINrdRjd1v5r8vE+DrHPPZmkmLW/JXxwEGiJCCS6jTOpQ
         dPW6Ean78mtPlduViQNiVnUupBpwOFjvMY/kzFF4ZXuOEZv/X/32nw/+aK/h4h0GOmSe
         TfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125502; x=1792730302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k50iRYZEHIeglzuFdsPLFoaxWBDTeuPE91tn2Q2sZzI=;
        b=Y8zjcE+xj3JPzxEbIq1pPouJPjN7qvO4iVkoM7l1EeVJvmkhiahTd2N3WGZDNXcYqG
         AK51SJj8E2LR1mhweqU9a0WQYRwXTpAIHrQRtqgR4eAvz0nFsfcqZ7nw0zNVlLXsKpRX
         sBHusUsukBfS/RT6sHDkxzVRFa1my2R1ZBdEraY8Cz67kH9EhO01U6L95+i6EqGtQCgV
         UlnqXxXBoa6VS3F/fdM4lvdTsT0AW752+GzOvb7fxsMM1J9yvevFRmbGRQDL1f/HXQKM
         B16pXnF2vQiF82FPRGqwywEMW9VrHzp6Cobdeoz+32MCMuUB3fWN+PWpFKCdMId7mZf0
         4ZeA==
X-Forwarded-Encrypted: i=1; AKwUvBx3UtcWwYCRPBt9NSvSm0ehHAPwQNAEvWgIM1Ul1xcHnFZCub7hNcvg+9Sr3uz5SottnuIxrre+gqm/@vger.kernel.org
X-Gm-Message-State: AFq9FYKHwgP0SWYOhoZT8jUNTpm0dnD39BMal+LTXLOtjM3LzwwRiD07
	RMQE4oD9wugidHJvXzoZdbdSLBQQocnNc+errIYF/vaqS+o1pYxM/BJXXFJkC0ZjNAQ5hZMpZCE
	/X4dT10dXFJmOeIBAJiCIKhSgMMx6yS0=
X-Gm-Gg: AYBFou0stBQxA89CXOzqa7MZzcV0AG4hOVsKFEzO2v3SboPw7eniVbNow9GGcUIE2Mb
	eATrgNI88J2LPXMfLuC6AFU+LeoRlB4ec63PL5DYAMMdvgR8eDylrI9OfepTYFHVNd8Yb0nvQyA
	rJ0EGlokLMY38WFKMjpz5Yp0s0QGQZ4NxPlX0Nd17K0G1OQ0Qan235BaUlHbZoYDLL166UIwy/Y
	ASvfcBXqCvVQPKEetYZNYYPNRYn7vT3FA+RFeqPrBFUMzTPslz//r93j+7cRy0bDxp3VqdRJran
	xK95o7g0wnKDthx47YyGFSRwKIyxTrOK/1B1aGzrn+7pvAJytqo9SsxgT6YdsPDFgx9GamHXrJH
	63GAlBJlIczik4SSEQMlvJcOj/6UtkwB9paT7zgI6ZEazbyr/BlAnwuxKIur5CY9AdUHlvplVK9
	Z0/N088r9HXYQJSSxmw2fvqqihuFUAVLsHHvVEymSoXullB/cSgKDXRf3pVtQe9ObxKw==
X-Received: by 2002:a05:6402:c51a:10b0:6b1:801e:e01b with SMTP id
 4fb4d7f45d1cf-6b1801ee296mr11816181a12.20.1792125501771; Thu, 15 Oct 2026
 21:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926013325.75073-1-rosenp@gmail.com> <179198497618.839288.9266863610003754798@kernel.org>
In-Reply-To: <179198497618.839288.9266863610003754798@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 15 Oct 2026 21:38:10 -0700
X-Gm-Features: AclHuK_rJlPsw1gibHYA5u1PE6PZtVa-1YcLBoIsKBrVYTa4gD5TkF2K5Ui3F8s
Message-ID: <CAKxU2N_b-wxOuugVm7wzgh4RN9oUCNf1jnHYkKN0--MxHHA_tQ@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: twl-core: Allocate modules with twl_private
To: Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	"OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:05=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 25 Sep 2026, Rosen Penev wrote:
>
> > Use a flexible array member to allocate the twl_client array together
> > with struct twl_private. This removes a separate devm_kcalloc() and
> > keeps the module data tied to the main private structure.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v3: Capitalize Allocate.
> >  v2: don't use twl_get_num_slaves().
> >  drivers/mfd/twl-core.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index f86df356d658..0b78fe30e047 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -159,7 +159,7 @@ struct twl_private {
> >       unsigned int twl_id;
> >
> >       struct twl_mapping *twl_map;
> > -     struct twl_client *twl_modules;
> > +     struct twl_client twl_modules[];
> >  };
> >
> >  static struct twl_private *twl_priv;
> > @@ -770,7 +770,9 @@ twl_probe(struct i2c_client *client)
> >               goto out;
> >       }
> >
> > -     twl_priv =3D devm_kzalloc(&client->dev, sizeof(struct twl_private=
),
> > +     num_slaves =3D (id->driver_data & TWL6030_CLASS) ? 3 : 4;
>
> What's wrong with twl_get_num_slaves()?
It relies on twl_priv already being allocated.
>
> > +     twl_priv =3D devm_kzalloc(&client->dev,
> > +                             struct_size(twl_priv, twl_modules, num_sl=
aves),
> >                               GFP_KERNEL);
> >       if (!twl_priv) {
> >               status =3D -ENOMEM;
> > @@ -787,16 +789,6 @@ twl_probe(struct i2c_client *client)
> >               twl_regmap_config =3D twl4030_regmap_config;
> >       }
> >
> > -     num_slaves =3D twl_get_num_slaves();
> > -     twl_priv->twl_modules =3D devm_kcalloc(&client->dev,
> > -                                      num_slaves,
> > -                                      sizeof(struct twl_client),
> > -                                      GFP_KERNEL);
> > -     if (!twl_priv->twl_modules) {
> > -             status =3D -ENOMEM;
> > -             goto out;
> > -     }
> > -
> >       for (i =3D 0; i < num_slaves; i++) {
> >               struct twl_client *twl =3D &twl_priv->twl_modules[i];
> >
> > --
> > 2.55.0
> >
>
> --
> Lee Jones
