Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2B3A75A2
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878743; cv=none; b=hkL/Nd5KSbgBWF+rBapgnOsuAaMD+Grr9EtO9Nq0MjxN28iYY/4ycvO5WX6StWDEW54VsvUXsYorLaS/eAqspXdAcapkcvY6yoQMMh+pv/r/Vo8eSEGq5WHVlgAq6KS18dbPWyWTDDexQ1/nfnOWaVDjar5+VuLuKBpGqaxWS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878743; c=relaxed/simple;
	bh=L3VXBQUY2/EFN+ebLxUXYbj0kJUaO8DCP5kVnC5RKr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unZPoetj9CNhDzdK1Rr25Hsh9HrN6wkzjoMKVUQY0pvYbsgILqyv0yLG/UgkupPQ/JIcylee9MoeENBE/KOMyqa9r126g5suiTdsDh/FqL0BaqOU12RHL3NUcffBiPQwNLsR7fFVrxidmG+cvWnuMer7rJ6kfaFU+ar1IOfGEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkA7JSdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkA7JSdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE2C2BCC6
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774878742;
	bh=L3VXBQUY2/EFN+ebLxUXYbj0kJUaO8DCP5kVnC5RKr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kkA7JSdcoHzcBOhLsyqSCdNSyjvMqP0zCSOe2nolL88XiL2Dge3SDpLlwXmkiz3NL
	 bt6hmbuFf3pnyvIIbQUp7U4euzasvd5MHt1JRSHBWf5nwJdrH6JmNdGQiQiMWr+FEK
	 uG/uq45gW7jrJb11uLo8V8+FjotGddogMfNROXCj0q9sUeeFmClucjx0ReAaj1yJAI
	 bXzJrDAwNQ+ztdRAbr8hRL3ox9wKG/3yrEOweFpSrXEqIcCtxfF0lBk8bDsbyrhb8v
	 ZbMNjKuZtofDP6qS4qjL4QZj7Q0oB9mngMlYBzreWKZoNrOcbiAscfRpjimX7PeXSh
	 9w+5t09NHTzdw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-386b553c70eso36090141fa.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 06:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVydwJjuuQ+Yi232Z252AU+f+nK72RZxLUxSi5DDK/93N58nqTdi7PGgM6FYuUGwGcXlPqMos5T8/U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pay1/Za3w1yWEIGk2zf+BqI+Omw/HqDloqgfgKA3ttxt/Yc8
	m8J4Tf5k1epJKxQGPGf69L/Bxu5np3RuNqENvUN2/wj1gBoK7egx7XJDV12Q+EE2EIu7rIQwDwV
	+btwdZ/9rAozNbOsBbUWVSWElQoAuacwFPOkRyuMdUg==
X-Received: by 2002:a2e:9a11:0:b0:38b:f0f0:e3f7 with SMTP id
 38308e7fff4ca-38c7310232cmr39514361fa.7.1774878740944; Mon, 30 Mar 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <DHG5OX85I4LL.39U0RRBS0JXFP@kernel.org>
In-Reply-To: <DHG5OX85I4LL.39U0RRBS0JXFP@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 30 Mar 2026 15:52:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfG1ZF=4T2WAw71Zb+4BFD2_4VSNRQZQsoGLE8gZxWcHg@mail.gmail.com>
X-Gm-Features: AQROBzBsrEPDG8YUUE_t5P-kX_9D2aMQwVqcM1UV6Hiu3mOg0TdUxoDMofvLMMA
Message-ID: <CAMRc=MfG1ZF=4T2WAw71Zb+4BFD2_4VSNRQZQsoGLE8gZxWcHg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:37=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Mar 30, 2026 at 2:40 PM CEST, Bartosz Golaszewski wrote:
> > Bartosz Golaszewski (3):
> >       kernel: ksysfs: initialize kernel_kobj earlier
> >       driver core: make software nodes available earlier
> >       ARM: omap1: enable real software node lookup of GPIOs on Nokia 77=
0
>
> Looks good to me overall (one minor nit in the first patch); which tree s=
hould
> this go through?

If the first two patches can make v7.1 then I'm fine with postponing
patch 3 until v7.2. Maybe Dmitry's changes allowing passing
unregistered software nodes to new platform devices (where are we with
this?) would also make it in and patch 3/3 could be smaller as a
result.

Bart
