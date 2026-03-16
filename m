Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6A23EA83
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651017; cv=none; b=mGJJ2o6HK/Wo5jkT16DATaQ2MFCwc2qG6rHHiiCYkJlqjVz+Wyyzgo6fdEMbI9Zpbx98osVz/nTR6IcO6H97/KgmjkSdQeuSiY1scGKv9nE4ieB1Ox4xU0ax2+bpKkKk1+RJIGyv5Ci6+IgvMwEYqzfFBfvAmhvqxc0wuSEsnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651017; c=relaxed/simple;
	bh=qDc+ENwbAbe68zpCCEGtW6OQg3kQWQQDNZqXFv5hQBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUj5Ff2sWOV5KEEV6Ze1p5bgUxuKCHQ6sB6AwXbT8z3dqdKUC7DP3LbMFMLeAPRzNAzaTYsT0zsJjcePGHFVjvTAITqiuwGWzEXO9URChlnzR9DrkXeSDEnEmW/e4bcw3HOTA7Zn4M8tYGb/BthIO2c+b8pcTsARQbZQm8YA2bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuWUq8FX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuWUq8FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BADC19425
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773651016;
	bh=qDc+ENwbAbe68zpCCEGtW6OQg3kQWQQDNZqXFv5hQBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MuWUq8FXxLPxY+XteU3IOmSq1UxFDXSFpJrNueU8I8tkoX8d2dlk45YN3u8Ib/Ku0
	 0SIFPD7ID28VM1pjzEeICw4mYJ9t85lfe5j68IL/6WP2Ub5OarkTzK7ik22yysPqcm
	 tzpcavDyjZKHcrgITfYq1CWYa6lMIqL6i+WUqNJPZ7HeprFBsETgprO7ah7AJsoz4g
	 AWhwqXcIGtHlSVNd2ccXdsHGPc+sACARDNud4gQNiG9VINmTlHdSTe0Hagx1BGaIum
	 f9r06ymov1cpmh7dzPPhiJ0TLtVu+2Z62YCUihSmafn+QHuIYDcmTDnzn0+Jf3fiRc
	 Tj54pz+mtKpbQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13323ba85so4970160e87.3
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 01:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV93BtoZ1loCj/mYfhhqtLiabaU/1vbSFq/aUaOVlNd+E394Ycyhc0RKumHiHe2PV/bHessfIjyoqIf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1diXyreTaCsnjNimrDy6cSP7kj93yl69pT426+RpH8VACmBRS
	C6HnzCCvNCiAjvEkjRxbPE/Po682tgAPWr/NsGuOUyGgOgfj0gxGUXQWBp4d2lpZESrmWIDvgAm
	TJ6/V2BwmkoFYQhh7utzIS1gLLXP0Z1vpC52PzFtAuQ==
X-Received: by 2002:a05:6512:800c:10b0:59e:50e7:1260 with SMTP id
 2adb3069b0e04-5a16270ee83mr2968213e87.13.1773651015617; Mon, 16 Mar 2026
 01:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com> <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com>
In-Reply-To: <7h1phxpzml.fsf@baylibre.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 16 Mar 2026 09:50:04 +0100
X-Gmail-Original-Message-ID: <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
X-Gm-Features: AaiRm53z1DOvTtNKXCy1fIu4lbFzIVIPbz40ntl-1EmbNnUOhCRTC9Gz1o8LFWs
Message-ID: <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:31=E2=80=AFAM Kevin Hilman <khilman@kernel.org> wr=
ote:
>
> Bartosz Golaszewski <brgl@kernel.org> writes:
>
> > On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
> >>
> >> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> >> > Currently the board file for Nokia 770 creates dummy software nodes =
not
> >> > attached in any way to the actual GPIO controller devices and uses t=
he
> >> > fact that GPIOLIB matching swnode's name to the GPIO chip's label du=
ring
> >> > software node lookup. This behavior is wrong and we want to remove i=
t.
> >> > To that end, we need to first convert all existing users to creating
> >> > actual fwnode links.
> >> >
> >> > Create real software nodes for GPIO controllers on OMAP16xx and
> >> > reference them from the software nodes in the nokia board file.
> >> >
> >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
.com>
> >>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Aaro, Janusz: Can you please pick it up for v7.1?
>
> I can take this via the OMAP tree once I have confirmation from
> Aaro/Janusz that they've tested.
>
> Kevin

Gentle ping.

Bart
