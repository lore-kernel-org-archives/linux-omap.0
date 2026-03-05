Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFB3947B0
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715554; cv=none; b=QS09y+NW4cnct3+gAxhSRD5oSfU0VG9s6Qe2AFGCM9G6JFCE8QMLBITjSilB5wcl9fm8C0OKhp7Jnn7EOXdFcYizpBPF6d9lxXAZ+XiXuCe2xTEUiA3Zyq/dpym7Nhc8GoP0cSG5xVwgPhmEZs3K7NqVvX2QMJ8dG/t3UhyiLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715554; c=relaxed/simple;
	bh=YaGVklJM6+vPIj268YCQDL+2pOq40VD8YhdiP3Qx7ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay26URWLBnps7pkwx5Y9Ia15BsVoeK43v3CYjTLGw2geNn4gJGhI088hzLsdDIFTOUcPSgfeVWZcGe27evmy6gyl46cR/wpc6gs/UgieQvUQbEw28CCVqq81BaQ8iwuHxeHbIQ6TRGENsx+RL4o3h1duVIHa/QyumLyWt7fVHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZq1Z6aA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZq1Z6aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14674C4AF09
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715554;
	bh=YaGVklJM6+vPIj268YCQDL+2pOq40VD8YhdiP3Qx7ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iZq1Z6aAZsNPTZUWXayW2+CZWMYispH1xOGtx8AYAJla15to9gh69vT9bGXLGCuVv
	 jmt74rVorEON70lhZrHcxV04hXq3jfVaXVygsecWQXnpZfeR3SKWhbro7eO6+ixCDn
	 XfO6yrM1lWVa7hExX5d0+cXkODNVF94RuzrAlPo/LGVl2vFYI9HPihWieynuIWZnQD
	 8zxRxXnOc5MAJYmrba88RchU7dWioPCRMtHkdt/sGSO3cBOArdpy3/nj04DwRMfFcU
	 lxgz2H2dRssYWFoSCKO0Qt5Gn/Rh3m6hAKFMSD+Fz6utd9yc4iMXolceOcUmodt6jK
	 YCzToqoeLdULg==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ca6595c8aso7737747d50.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 04:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwo8mmYvhHLnmB/ygxuCw+ykfRzAOGTbrh3xgcbz/71IgMRF68PzA9AeOR1OniTAMBbINg2PYWzdaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFstxnaqRzap/EvFOWEJZlbAkbKLEnjzFpBrIUT+hxqpY5pqv
	jvC35HfewfRq1h9cVoCfu6Il1uAIeV5j3l9XBw4EI8bnfwYW8Rz+nmTxGCf9sPI82QhK+MUWrQg
	MXhk8DM6NkYjAl+yvgPErEcWQl+3fDrc=
X-Received: by 2002:a05:690e:1a8d:b0:645:591a:cb6a with SMTP id
 956f58d0204a3-64cf9bdb7admr3241706d50.70.1772715553372; Thu, 05 Mar 2026
 04:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:59:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLnhYc2YN2zmPG1zz8DLG1bFNFrWSL23SL1frvPDWnWMxQ@mail.gmail.com>
X-Gm-Features: AaiRm50ObTyChLnzlvD-tHjXe2KnZ0D-eRgdIfSDib-lDXFEA4x4oaLfvc_xPUI
Message-ID: <CAD++jLnhYc2YN2zmPG1zz8DLG1bFNFrWSL23SL1frvPDWnWMxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] gpio: move hogs into GPIO core
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
>
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

It's a work of art.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
