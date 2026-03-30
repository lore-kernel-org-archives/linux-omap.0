Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85693CB2FE
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873609; cv=none; b=UeIjJ2/KXOiunR9QBGGP6/sTvobcofKoyC6adeKVD7kreP5Uas3dIW5uMg2ff1nYTW8YuXTQqM1sj52Kauq9vn5/UmUQzDi5SIiXzf0KUdk8srp0sfJ0RzIHoMCgZiJCMFdzvNOOQQf4Cg5s01IHcQn6vTvdp5JgqkCOiRHX3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873609; c=relaxed/simple;
	bh=AHtCIKj55eWGE7GRtpfrjZZg4gF/iBOryNVSD/NH+Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIf5ylE1p6s8gZRMbKVazIqFUmAjBluuuEVf9feiIwKtgJW3HLVLZnx3knVR/bluSlIAntMVBwLVvnWrWfJD+uekzuj/lykEExJaCTfsiqokve23Wg+Yfz1Mi7uBiUAjiqojds1ZDJBpM9JyIU+3j46EAtaXuwlQRz5gJGWrZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cewle8kP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cewle8kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E524C2BCB0
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774873609;
	bh=AHtCIKj55eWGE7GRtpfrjZZg4gF/iBOryNVSD/NH+Mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cewle8kPhz/ya3s+FO5WMYymxCjawPAP+TTgf+1eMEvF3NPyddME9vK5ylZL/pKd7
	 tQeb8LjGVvbSO/yUaYq5aVRkG7zJzxl5dVxcYOvmy0/o3l0aUyOp2HlJhU9Hxdybbx
	 lvTGq9AeVEmGIij76A8LMpR+UWqBzzrxkjafi7fytYKkwuHmcWtm1HjueFDjPpZ8CG
	 3DtRR7IfPdzsQMSWue+bzSsLi8UCt25ulv3cnqheF6fPfQb6VXt2nfwY6SDfFFnvfF
	 Qqkl6HXoSAYMlv+IrsOxzZHCmyKf1R/GOAqYkXqFUj2vAzHbK+TY/nf81mpdF60V0d
	 JfSuW2STfuGtA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so5265004e87.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 05:26:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP7bipalwP+dvbt6h7dQcogXOWSdjIbtfoUybp3qv4u4oQl7KDoVMpT37jO2/DScJGSDKndo6Z1ObT@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/Wglmfr8+AtM/+7bjqCW9HTlHSSDV3rH7XOH048wxAU2dhcc
	QiP0nPpJ31dOwUXWOFPUyJWvmWtRv9Sck1hm8WckOSDZrSUZAg0kJb56aCZX1nxpkx1DQ2VFTFd
	Hx92YJwImRp+sQrzOw7MPUFFx+qI9kTkmFE2+gG+bVQ==
X-Received: by 2002:a05:6512:2302:b0:5a1:4017:18d1 with SMTP id
 2adb3069b0e04-5a2ab935ac2mr3963243e87.37.1774873607983; Mon, 30 Mar 2026
 05:26:47 -0700 (PDT)
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
Date: Mon, 30 Mar 2026 14:26:36 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf8+CPU+azcZ-Q=RiAQs8rh40Ex3kE7xhUWAWNDnR8KKQ@mail.gmail.com>
X-Gm-Features: AQROBzBzoMQj_yi1O7GWL1v5KyhSCqt-LPe-BXFuLUoNwr5idSYsB_NYvCAw6-c
Message-ID: <CAMRc=Mf8+CPU+azcZ-Q=RiAQs8rh40Ex3kE7xhUWAWNDnR8KKQ@mail.gmail.com>
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

We can't really make it a core_initcall() either - kernel_kobj on
which software nodes depend is currently initialized in a
core_initcall() which could have been the reason for putting
software_node_init() in a postcore_initcall(). I think both
kernel_kobj and software nodes should be made available earlier.

Bart
