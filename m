Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366173321A1
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440352; cv=none; b=e+SYe2iZZNkqlLOh06XyGBF0XOFfCfC1Sew6tehGEhouq2oBYLrPVqMWw7RxFK/2sNDOela694MCL75ualmoC5DD2UG6cVF+Pxf9yqDV209jJEDWN9cGly4nSYb5vbVI/H+fXwgHySwpj6sYMT9E6sJCDUJQ3wq+aSdZUn8i2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440352; c=relaxed/simple;
	bh=K9PttO+DsOQ4IfjyBkw4K8QMocRbbjrmHypk7fmZKMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfcKulDlvnWFAMHU+XiZ8mExFaV/kuymgW4z0pgbF5tqmkCUm2LO2tH2QZr8fqVJgoRFJMPwS7fqDHLo+DZD921fKqRR4DCUoKI6qmdnRO0KBv4baFVBDlrqWKpNDsmGXYIhAp+0xkw5haEHCGbSX8LMtQf0ubwVGRVPyPW+sNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQe61Ug3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQe61Ug3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D803CC2BCB1
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772440351;
	bh=K9PttO+DsOQ4IfjyBkw4K8QMocRbbjrmHypk7fmZKMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PQe61Ug3ZavnRImXrsLH+1Fikmeed951TWdXfXunIEoh8CM5bsgR8Ikul2AZVVNGg
	 Tgu/v20AeRVpbmCYH+7PXAajkVIFTlNMT0WbwTGsrfxDRTzcbmCBNtqaHo3miIDbGs
	 ZJlPjbOHIiujLYbuEbqT3LvSUB/wrBqDCMaI1dabt6+TIObnR6bM/bLykm+/jChrwf
	 jE7gbAMAdayceL0erzoUwToMU0e0l4w7J+p+OcpnDFqma4KhUZZ7TxmR4HxcZsng97
	 xqYcVbHjMkAE/44rO9dSDf8+XVTmDV7oxIvbwusOw5HET08Tzg+ORs95zDNt397GW3
	 aee0n/C6d9izQ==
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732e6a123so4873676c88.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2026 00:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1NtTUTnaafFswWm8PbpkzVfTMgwklxXx2O7wm96yfLbPfxFlegw/YNgskNGeIqajD93edOaLi1t5p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Q6a+0pLcitvjfshmA5IMIFajMkvi/864R1hyG+EPliBR9Vvu
	YQmPDK5wYR2YxlGiwUkDOMWkGTdT9t2W5GhPp+KxmGXO0WdM+ImD0VDF1FL9vFRgthEBvsKJmCP
	OZPcVONgnClj1aD1226Wt3ip09Bfi52lWhCJdf7vovg==
X-Received: by 2002:a05:7022:ea48:20b0:127:9c17:985a with SMTP id
 a92af1059eb24-1279c1798bfmr1713176c88.5.1772440351223; Mon, 02 Mar 2026
 00:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com> <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
In-Reply-To: <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 2 Mar 2026 09:32:15 +0100
X-Gmail-Original-Message-ID: <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
X-Gm-Features: AaiRm51iq8ZjzU7QM8JcGyVZhGJ_5IzqG8SaybThwCwM5_ZyOCcQpJBUfsUFGw0
Message-ID: <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
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

On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
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
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Aaro, Janusz: Can you please pick it up for v7.1?

Bart
