Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079103AD52A
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860632; cv=none; b=QujNRWq33rLC/4h6cJYOh8CU5wTxTaN6evoT+XnsWk254AUJeD1t1m6E2ubnu79x71tc4nc6jt5uhLl4V+oFU+vJETbXhRTawNNvMwPbxZh2AerDi5Va0YSAtJlEi/I+qvInVHe2zJDg/AshAG0W9GmmZ3ilVuSaRRB5FuqGm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860632; c=relaxed/simple;
	bh=tf5ULwJrTl2cI7z19tJ0FBIFsHUeLlxW6VqIecnfacY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7/HfrBol6v2m4djCayTqOGxRWayzBPPfazk5rTvxrxO8QReXrG0J/KBoadm8HYXkQWWXFdGaRvs8p3r9uZlBOq2Cs/ettFEbEZTaZSeGGjrLmZJPqd1PXgOOInf4dWkh2DWyJkcuw5R6jFttV6Pa23blxh9HtdHN2eCX9Ctm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf92L5Xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf92L5Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BAC2BCB1
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774860631;
	bh=tf5ULwJrTl2cI7z19tJ0FBIFsHUeLlxW6VqIecnfacY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xf92L5XvfS6DOe68A+aTIVoyPlxdhPE3UBegn5Kf6obJ/Wf7BzMALvcuIeBMoLGaz
	 d4giXxl1iaJYrSAJwJw2SE22at6710VnXhIlhRzG6MKp9msdUKsmHvhiBQ8GUSMijn
	 EL2pfdKbZ9LZgbz9Dd19d2NVzMSynP13HCUpOlWBwRxCQ29+1Q5sL56WYwwoFhZK4/
	 VCXxHqZL82p6W75XyD7El0+gm2WPUrE3V1Fz7Q19U+UqUirwHgGt6x3SN9Nm2ipY4P
	 mDyonlqLpQPjNf+h54ixGxFw33harvnWSUcL+8kVmLscG7ZW2FY3M9X8q4mbqfOeHY
	 kvBSTVvPncWyA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so755919e87.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 01:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6tspSuL7Zcryj5Zx7NJK1nk37IOId0hlWMDEdkfpiysR4EF08JRqL6bgddI72uYyxphNqrrRq/UiU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AbxOkZmy2CvNhLgwgwAJp7SMaJyyzB5uNt7z3UPT60FSFBe3
	jt+OR4tTE2KDh2MOFd5FQ81wlwLy9xABJuwSYHD2tLn9dMncEndwNAENaZX1ykkUHeYNLPjWkVY
	Nw0kDyzMLLfhsxYFMWKkLIrnHAk/BKtZDVU+xv8gMAg==
X-Received: by 2002:a05:6512:3b0b:b0:5a1:1885:69d7 with SMTP id
 2adb3069b0e04-5a2ab5fa3e9mr3943952e87.4.1774860630515; Mon, 30 Mar 2026
 01:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi> <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi> <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
 <ackRzly0mXHReI7V@ashevche-desk.local> <aco3YBCQsT2BN2_N@kuha>
In-Reply-To: <aco3YBCQsT2BN2_N@kuha>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 30 Mar 2026 10:50:16 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdEL-_od0wJbwA1Q=GDFjm94Ca47FfNR-koDpjumQrMdA@mail.gmail.com>
X-Gm-Features: AQROBzAwfgAKKxJI4l4teSRtVg5dwLEFgmM7zFWj_0HkeLpVMZ1ljd0TW90H9VA
Message-ID: <CAMRc=MdEL-_od0wJbwA1Q=GDFjm94Ca47FfNR-koDpjumQrMdA@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 10:43=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> > > Thanks. This makes sense. Both omap16xx_gpio_init() and
> > > software_node_init() run as postcore_initcall() so if the order is no=
t
> > > right, it will fail.
> > >
> > > Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
> > > reason to run software_node_init() as a postcore initcall? It only
> > > allocates the kset, can we move it to core_initcall() by any chance?
> >
> > Good question. I don't know why it's chosen like this.
> > Let ask Heikki, who is the author of the code.
>
> I don't remember why it was it made a postcore initcall (I only
> remember that there was some reason at the time). It's probable
> fine to just make it a core initcall.
>

Thanks, I think I'll do as Dmitry suggested and make the exact moment
software nodes are initialized deterministic by moving it into the
driver core initialization.

Bart
