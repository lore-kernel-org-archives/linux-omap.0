Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601C3BF69C
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632223; cv=none; b=jAd4WqPgWXf5mbrAnPYNWKu0PcCZA7UrystlkxKq9KkzHZjzIxkLTTab5QNkTluutzlmnaq9x072RrnxffDmcEgcleNenAoWYFpEUrRnICanVYc7574nnx4mB7yCghb1qrZztmZ0dUrSjIF7+GiYRRZCxDNAc0ShUaNvp0fnKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632223; c=relaxed/simple;
	bh=B0QJFzHz4fHnDQOwI9Isf399xfwKPSgQhgYZDJhjLV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFk7RtrY15ZL9Z+yStO3NFm0EALQcdcrtU5gUUhdQcIAxsGGMLgPy/+WwXkKnYU+8rN+45L2K0Ix+8hLJBiI1O3Vu2qATVY9bos5C+aBzc1LdOlBsykdbRNSVx6bmAKgyfYD9/mQojEk0L/QGRXU9KZ2l2xfu7hgxfjN5HwwBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COFyM9L+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COFyM9L+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3968C2BCB4
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774632222;
	bh=B0QJFzHz4fHnDQOwI9Isf399xfwKPSgQhgYZDJhjLV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=COFyM9L+/KahIBnEjYxn1SjsJZ+r9JR1KOekoKVWEK1Nh4Mq3BAtHUgdL2w4CmWMm
	 VVU10cA4ARopLIboGd5FGaN5Vf9njYvq27i6hpe7L5HrHWiOTPD9oW60kjEXP87PJG
	 t7S6R5VDNt/7erEOutKHrRQMJbcml7n1S1ozqzUICXr32+DJPMvU213PJjqNvuUxD0
	 Ppu0eu4NPQib9Thzhpm2Tz8g9QhGaMo1uOfOPHABHnBC1k+5oykpRSWKRX5C7kICsc
	 HaGEuCvaIxRHuzdcZO0mz7GRmFoYOo+zV98IDZvtTnLPDTswweEn7wMI7yktRESrLB
	 3eq9RjEBCMmPg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a723b2b29so20698121fa.2
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 10:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBlmlzEadJDbc2oEocspQNFnitDuvCDlR6S9xFWqwrkUShQerD5oPy1rC3CmQRVzOLgaZbdlHhL+/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XDklXMUw9hIsNPBQFk7NI69wdND9l6aLpUIj95GL7ZWLrRaL
	1zCgjqd+T6Hom4shTz91htXy1qls/sXxrHSA7QNQuGX8p4OawyT5eWYhyTp4lAIViozdpmFUT7e
	QwcJAreQJlt0zX+2gAF2mev/2P1T9VN2F8qDxhfNRZg==
X-Received: by 2002:a05:651c:1508:b0:38c:5b99:a32 with SMTP id
 38308e7fff4ca-38c73114706mr11731611fa.10.1774632221372; Fri, 27 Mar 2026
 10:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com> <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com> <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi> <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
 <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi>
In-Reply-To: <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 27 Mar 2026 18:23:29 +0100
X-Gmail-Original-Message-ID: <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
X-Gm-Features: AQROBzAizA0aFS4zAgRW_NoeIPz_y40ntaHCdZia8dk6252Ylj_RriHyNCKXnHc
Message-ID: <CAMRc=McVPskF4pMQSz=hR8CkyZhoPmCU_yJFT66vgTCPJd3-Vw@mail.gmail.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:59=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:
>
> Hi,
>
> On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
> > Hmm, I'm wondering if there's a race with consumers already requesting
> > the GPIOs after the controller device is registered but before the
> > software node is added. I'll send a version with software nodes being
> > registered first, then passes as firmware nodes to the platform device
> > API before the device is registered.
>
> It crashes early, I was able to get an UART log from OSK (another
> 16xx board):
>
> [    1.001525] Register r12 information: 2-page vmalloc region starting a=
t 0xc2808000 allocated at kernel_clone+0xa4/0x20c
> [    1.013092] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
> [    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
> [    1.024230] 9ec0:                                     c072d000 c052947=
4 c06b3aa0 c050a3cc
> [    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c072d00=
0 00000000 c0503160
> [    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 fffffff=
f 00010000 946f70b5
> [    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c072d00=
0 c04da8f8 c0060a18
> [    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c081612=
0 00000002 c052582c
> [    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 0000000=
2 00000000 c0502400
> [    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 0000000=
0 00000000 00000000
> [    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 0000000=
0 00000000 00000000
> [    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0 00000000 00000000
> [    1.111206] Call trace:
> [    1.111328]  software_node_to_swnode from device_add_software_node+0x2=
0/0x80
> [    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8/0xe=
4
> [    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
> [    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
> [    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
> [    1.148864]  kernel_init from ret_from_fork+0x14/0x28
> [    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
> [    1.159820] 9fa0:                                     00000000 0000000=
0 00000000 00000000
> [    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0
> [    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000)
> [    1.191040] ---[ end trace 0000000000000000 ]---
> [    1.196350] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x0000000b ]---
>

Thanks. This makes sense. Both omap16xx_gpio_init() and
software_node_init() run as postcore_initcall() so if the order is not
right, it will fail.

Cc'ing Andy who's a reviewer for software nodes. Andy: is there any
reason to run software_node_init() as a postcore initcall? It only
allocates the kset, can we move it to core_initcall() by any chance?

Bart
