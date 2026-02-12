Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0A1A76DE
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896455; cv=none; b=O/tVGHh14JLphIn+w6PKhCoWCzcxAcEx11oLZXIB7qnXkMlwk1Prq6Qi/TG5NnTC8rW85VtR7OLirqLX54KP2Vf7umvqz2RZcls1iQIopNYfMMlyICtZCP9Lc6Q0z6a7VspJiVaE/HSGtf0z+6y2AR4W/pls9OJvqo3V7LvFNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896455; c=relaxed/simple;
	bh=cR0ZtIgPDyATIxSFGdaV+xz08Ci/kVnvO0ZEE6vgbao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5bVKmRzlG/Du7HAPcJ478bJcsR+zNcvc9PBsU8FUsBsuAZ/39AQ9mf1zrj71aJ1mjelY7rBJ5+Tl70E5inwaVIOksnl6qXD9T+XX+Uay/HX92w80d0SqqP47AgaJv3++MxeRjz6QlXoxiaX/ayMqIDPr0umrt+R3frM2w/iymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKzFnfac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKzFnfac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF00C4AF0B
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896455;
	bh=cR0ZtIgPDyATIxSFGdaV+xz08Ci/kVnvO0ZEE6vgbao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oKzFnfac63N7IG/adifXiKpS9V4EL5jHB5s9q/PFCbmVLeLH0qm7ILehYV3NwTwL8
	 EIpPf3vYk6i5jeTdNOktfPjph/gw6K2rsfBFBnqcSwXd1VPPpua/Bmc4lqZSKgfRcU
	 9ReNdK8Gecu4e6e2QNCXzoKbhW6fLXIKbCLlhz6LBv1N+J+dcaCZezUi11Ooct2J8w
	 o+LuTahFdOP+WRcSKTf+y6UP/mxCpvUk0I3rHTTWM6kSvQL5FCat+PVZtESFxMRaPu
	 nDiCTgMF23JSFJZOETZy/HxoLnM07GKD1Oq1MLEH645Wa9whd13ZUHOO4+W/UQTrgN
	 lg58yZjQR731Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-385e7cafef9so67700011fa.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 03:40:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrrvh65OMRx/J/Bmt8hsqounFGsybo/9ZVz9HxDsJOBii4jivU07eGCDxPeFmrTrZyR23vdFwbq9Mx@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDXJjECW53Mv/vbHiWhvKhl51exNnc2FeIR2pnX/sDMWYU3Vp
	xhVt2cgH0LesLaOI8R0aWmPBKOhqsYqohc6S8zm/sGTnE5Yq/vgLap3VCjl4oRGIvPTN62dU5Y+
	FRtMCBxJGOeXGH0MYa6nntmOS5+EX+OGamIWAiu56zg==
X-Received: by 2002:a2e:8a95:0:b0:383:1d66:c1fa with SMTP id
 38308e7fff4ca-38710f142dbmr8770101fa.10.1770896453688; Thu, 12 Feb 2026
 03:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com> <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>
In-Reply-To: <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 12 Feb 2026 12:40:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeWgo3b8DTG3w8U2bxR6ejd2UmFVGASvRe7_tJkK2f4ug@mail.gmail.com>
X-Gm-Features: AZwV_Qgc-yqBkaOF0yHyRhNZKzkVUTOEMiYSQPwa0VrLdPcUMMJ-QQP2mbVSAbo
Message-ID: <CAMRc=MeWgo3b8DTG3w8U2bxR6ejd2UmFVGASvRe7_tJkK2f4ug@mail.gmail.com>
Subject: Re: [RFT PATCH v2] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 5:32=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> On Wed, Feb 11, 2026, at 14:13, Bartosz Golaszewski wrote:
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
>
> I don't see mistakes here, and I don't want to throw a wrench in
> this patch, but I wonder if there is a way to take this one step further:
>
> > @@ -244,6 +263,14 @@ static int __init omap16xx_gpio_init(void)
> >               iounmap(base);
> >
> >               platform_device_register(omap16xx_gpio_dev[i]);
> > +
> > +             ret =3D device_add_software_node(&omap16xx_gpio_dev[i]->d=
ev,
> > +                                            omap16xx_gpio_swnodes[i]);
> > +
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "Failed to add software node.=
\n");
> > +                     return ret;
> > +             }
>
> I was planning to go through the remaining 'static struct platform_device=
'
> definitions in arch/arm/ after the planned board file removal and
> try to convert these to 'platform_device_info' or similar, using
> platform_device_register_full(). Since that function already contains
> code to dynamically allocate the software_node, I had hoped that
> a lot of this would just go away.
>
> However, I see that your patch creates pointers to those software_node
> instances, so  think that would become a bit harder, but I have not
> actually tried it.
>
> Do you know if there is a good way to do this without using static
> platform devices?
>

Add a pointer to const struct software_node to platform_device_info
and then use this if it's set and there's no fwnode? It's in line with
what MFD does with its cells.

In any case, I'd prefer to not overcomplicate this patch, let's do it
separately?

Bart
