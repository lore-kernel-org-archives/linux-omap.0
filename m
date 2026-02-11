Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9336B07C
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814402; cv=none; b=uT6fFNQNJ0QDhqWvPJYa1K+v3774mn9ZLCIOYL/0nUZIenGPfFaZG5NgkkeBNLzID6FXUYAiJnDjwgBKto1BhVbWe0WB3o4wN2QxrSmfRYI57+81XmEMAaI0vR7jwisiwKT/Jue2kJ8uAKOoGmrgl1emWCOSFZKlH8siEYSC2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814402; c=relaxed/simple;
	bh=ECY4SrJPSqDkIQ4i6WcKtyKEPZ0FhwYjfRkaSNPqFK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkqEZ2CELjZAGB/WqwWftZ3cSyKa4mX1lGv4+ji5831HSnO7ab6c23j8LGsNwUHvt1JGbrQEIqzIFtpztihjFDpZTevXAemjiC8XbneC1bRSEGMLD6yGosnnk8CyFV2AU2Osjd/cdjTz8JohShnoeIT1dEzL/cZONRciyOFKx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgZ3TLGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgZ3TLGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C90C2BCAF
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814402;
	bh=ECY4SrJPSqDkIQ4i6WcKtyKEPZ0FhwYjfRkaSNPqFK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgZ3TLGhJRe+d7bCq02qVPhgkVZMtqwFY8Eiey7YWW5mTf6yy4GfxXlEmE+7buqrW
	 9KqdfVGy/kz+M6cTF83RucUSwPlohnClSSA+srnYdbJiT4g8KsOM5s7PfHEfnvOnGR
	 wlR/24q6ow9Z3xXF9QYG4I+UjespQpp5Ju+cTAbtYpuQ5DLFwsOjlPGsnWP9Pg8b18
	 Pc7SOAtSKJDO/W/QR0iVjXExAYItLvT4GrzV9OcGVvA9n0zyKr7EfOdE9MsCSUUPX1
	 myNDhYbYEz7WtgRaQwHqyJedrjRlGnArvGFa6yzPLXOLivI5eaYfaocQSa2SReoB/Z
	 ERFMq5xmvq4Vg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382fd45a1feso9914011fa.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 04:53:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUewWNA+vQQm+sNYBtd97+JgzpBEQv2B14Fssi7T4WAe+V+AnQOoUo9Y2mb6a8S9BeyAfZEmOYkwjw0@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCLVQWIbV7O9UlsUf0tSapa1v6L41jdyJM6rjS1jZ1qJJFCKc
	y+ia3BH4AgQ5zz2pYDH2Z5/4yqvQRvR9P457/cXLQIoaTsRShhZ7bLPvdg0KlnEcKIeclzVa9Ac
	Fl0gA09C/g4kxq21wysqCuEMoyZPyvBxrUlXR94tWNA==
X-Received: by 2002:a05:651c:1442:b0:386:fd3b:f911 with SMTP id
 38308e7fff4ca-386fd3bf989mr11619741fa.8.1770814400911; Wed, 11 Feb 2026
 04:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211111449.122593-1-bartosz.golaszewski@oss.qualcomm.com> <aYxrQDFxcQ6G-tbB@darkstar.musicnaut.iki.fi>
In-Reply-To: <aYxrQDFxcQ6G-tbB@darkstar.musicnaut.iki.fi>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 11 Feb 2026 13:53:06 +0100
X-Gmail-Original-Message-ID: <CAMRc=MddAA6+=rT1WO3ttGLLN0WqXhStoEBFUWW-fsCjUMWkJQ@mail.gmail.com>
X-Gm-Features: AZwV_QgfmOgTu8_Ue1SXKCoMiqcbhAje3Iezhin27cUQawGgl0nfdhO1O13SMss
Message-ID: <CAMRc=MddAA6+=rT1WO3ttGLLN0WqXhStoEBFUWW-fsCjUMWkJQ@mail.gmail.com>
Subject: Re: [RFT PATCH] ARM: omap1: enable real software node lookup of GPIOs
 on Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:43=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.f=
i> wrote:
>
> Hi,
>
> On Wed, Feb 11, 2026 at 12:14:49PM +0100, Bartosz Golaszewski wrote:
> > Currently the board file for Nokia 770 creates dummy software nodes not
> > attached in any way to the actual GPIO controller devices and uses the
> > fact that GPIOLIB matching swnode's name to the GPIO chip's label durin=
g
> > software node lookup. This behavior is wrong and we want to remove it.
> > To that end, we need to first convert all existing users to creating
> > actual fwnode links.
> >
> > Create real software nodes for GPIO controllers on OMAP16xx and
> > reference them from the software nodes in the nokia board file.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> > This is a follow up to the following discussion[1]. I don't have the
> > hardware for testing so only build-tested it.
>
> I won't build with CONFIG_I2C_CBUS_GPIO - the CBUS is mandatory, otherwis=
e
> the board will power off 30 seconds after the reset.
>

Ah, dang it, that's why I didn't see the build failure. Let me send a
v2 shortly.

Bart
