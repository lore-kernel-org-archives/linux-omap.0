Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EC3A0B3B
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301336; cv=none; b=XXpv3TGs2KerUU6X21L9odmMnaL8QbVtK6VVUx595Hk3ShgAkrqWT7mF2JzbVKFbPtkLjbzbOcHg8XVjiJ8XDM864/NBHydt5HbZW2lInWhQh34AUjXqCciSz71OoBG8I8BDeCgzHI4Ib7OjD2Xq8D1v4dl4Gh9PTEuoDHR5rN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301336; c=relaxed/simple;
	bh=Pivra0dD6dxuVk6jiUhcTWB6azirh6PayWgsBS+7sdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLQnA3O/PlWKMWBD/qVLrOS/rdlzga2CCLWSUwXUk67748gRQXCaZPFkOmVjYiFSWqlBZsH8Dbk/WVB9CfFA9iM2LpQIjlIHKs7vHsUsp6Espc4apORW9w4rtS2SFWaCaPkwF/lv3E6SM/TO5TTPaOu1EgdvDV/u0r0joJtNU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um7n/Bld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um7n/Bld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A2CC2BCF4
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301336;
	bh=Pivra0dD6dxuVk6jiUhcTWB6azirh6PayWgsBS+7sdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Um7n/BldGaHdI5YsZuBD6mnPGecgj0Co4typQAHhIkR6wXxcux8rf3oYgg91MzC4k
	 Er4FwbpGnI+RpvC+zeE4eG+0ZftmR7TadRwNZkbop2Z8o25GzWcXImx1S+lCFvu3B7
	 Bg46qORATvWJHg1vatdQoIKHv3FftKqVqWWoNzTSWm61Hny5PZgu12ghGjw/aYt1/e
	 O7mi/sLGAa7y03dOehgh+VoG5QE9LWmP/ZwHb23OQi6Glt4/0jGzJNKG3kekopf3nz
	 JrxPPsOz+GQl9Xb80/QpXQOl5nbVv0fT/x3UTqK4n+KCD986i+ZUaFNOesSSkD8Pl8
	 6CfukgAeG01Lw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so101609021fa.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 07:48:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9gUJmPMTN+EeS9UJ+QV353kIjxsAKP6/Nnd/8Co6EthQi5PT0+7MmcFZFureb31AOam7qr1rcWvdR2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Px3BtNFwFSEy795a9TKdgBTEXUvzaWo3wkHphR8wJRueslnc
	v6R6jTTnlMtw6TTWB/IGi5MZBPRjpBT0F2GdUvC5V5XlNp7eBxMpVYL3ExdJ1HHmvoCl5mXs89W
	g8yIE3FVvjWgbG72GDRTVtlRC7WnY/Tnyz/Se70bDOA==
X-Received: by 2002:a05:651c:41ce:b0:38e:49e6:a363 with SMTP id
 38308e7fff4ca-38ec7859815mr124271121fa.15.1777301334471; Mon, 27 Apr 2026
 07:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
 <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com> <ae92LAOy6nRsFb9w@ashevche-desk.local>
In-Reply-To: <ae92LAOy6nRsFb9w@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 27 Apr 2026 16:48:42 +0200
X-Gmail-Original-Message-ID: <CAMRc=Md8M=vvUstt=4X-gW1_gBhtKCGC+xQae_J_TKZWKaLJ2w@mail.gmail.com>
X-Gm-Features: AVHnY4JN1VGD7u4dI33kaRwq7CQuc8nHx5eCojDJgeZv_b43IhasKnBB-_UjTHE
Message-ID: <CAMRc=Md8M=vvUstt=4X-gW1_gBhtKCGC+xQae_J_TKZWKaLJ2w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ARM: omap1: use platform_device_register_full()
 for GPIO devices on OMAP 16xx
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 12:46:33PM +0200, Bartosz Golaszewski wrote:
> > Ahead of changes attaching GPIO controller's software nodes referenced
> > from the Nokia 770 board files to their target devices, switch the
> > method for registering the platform devices to the
> > platform_device_register_full() variant. This is done to leverage the
> > new swnode field of struct platform_device_info which automate the
> > software node's registration and assignment.
>
> ...
>
> >       for (i =3D 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> > -             pdev =3D omap16xx_gpio_dev[i];
> > +             pdevinfo =3D omap16xx_gpio_dev[i];
> >
> > -             res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +             res =3D &pdevinfo->res[0];
> >               if (unlikely(!res)) {
> >                       dev_err(&pdev->dev, "Invalid mem resource.\n");
> >                       return -ENODEV;
>
> >               base =3D ioremap(res->start, resource_size(res));
> >               if (unlikely(!base)) {
> > -                     dev_err(&pdev->dev, "ioremap failed.\n");
> > +                     pr_err("ioremap failed.\n");
> >                       return -ENOMEM;
> >               }
>
> Isn't this a stray change? Or why then? And why the previous dev_err() is=
 left untouched?
>

We need this because we no longer have a struct device to pass to
dev_err() before calling platform_device_register_full(). And you're
right about the other instance of dev_err(), thanks.

Bart
