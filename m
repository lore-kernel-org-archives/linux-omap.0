Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01B517BD7
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561404; cv=none; b=IzPlhQRMw2powrGCX2qBlC1V6Nvhg66aQq55wUQG5gKby8aKfi8oFKMJ8+Iub5mWKakZrkOnS/jLOzjnZILJQKCqYRymwSGTymd7yyfWa5tCph1Z98yJ7EZRaSRhp+0gHUKGtzoD24s/b+yz/UR2d39BCUjlchJs8++VL04hzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561404; c=relaxed/simple;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qExVOdfUXyPoWYrYILs9GLXzirnGWEMZo4DnGphhqfd1eNp6UhJoOg06Us3NuDG5PAS5hxgCNnFjyvMXghUAN3g+dKZIzwutnxY5jY6J1uZ87v8PqWVTwfChNvEgmX2Pkf1hHN+YdinBGLHZh9k6WNbHNAAmdcHdQ1GIpQBiyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLtTYf4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLtTYf4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6471F01574
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561403;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lLtTYf4uxxXxajwhPucCVZnP4cLlC27gVTBtxi3KbE8tvJGytfaXJZPn4dzzuHTf0
	 /ybspuVH8kciv61euxbEMT3U5Y8HKNkTPtr5aX1NOxzzcWhkww0mRiJnPFGQBf4Zkr
	 IgFgLNF+Kw9fO41fwehzs1h9eLabrrUdIQCE2uafivdjRtO7MQtOemsGbsJfkItJ+P
	 m+pb1c/YtLihlXXwVH1xPtA9LH2xw+TDE71prvWTGoOMzEDWZuxc4FhGmdtIg1BfUO
	 FZ4UgWtT+IYJJcjIvGyEr0LUg1HbDpR94DWXCcxRCZQwIbRCmySpu+mGuRAw3FnVC1
	 6mpvHNFsbQ4gA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso13831871fa.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 15:36:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYOEi7WBJ4vigukLLg/JGKgrYNJLEGbTs+FBxA9jdAym+MBNWAaDUwIW42Jc+a3COcrV07xX3NR3QO@vger.kernel.org
X-Gm-Message-State: AFuF++mHv1Cqq+3Az0xJ9U7yuyCJpoDVicqqejfn4ZLXyVxFvG7LsNri
	buX8B5nSY6AH7LCv08/FV7hzVRP75Zqed0wBvy7HdrntN5Xf+UsXo4mLR/KfIqZH7zyTiKsK9j6
	YKOn0Z3vfRabXUVTDLr3JtdHlY/NenFM=
X-Received: by 2002:a05:6512:250e:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b616f3215dmr1620442e87.21.1788561401588; Fri, 04 Sep 2026
 15:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-22-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-22-s-vadapalli@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:36:29 +0200
X-Gmail-Original-Message-ID: <CAD++jL=c7Hbfwbngr2HQ_RTUizL=hwQbTa=C-oZNu2BAjLh0yQ@mail.gmail.com>
X-Gm-Features: AcwNN1U9I_dDB3NJSseFrC3_GFY1Eb30_yQ91aHRnm5hTr_W3IoNAFdaYoLTgAE
Message-ID: <CAD++jL=c7Hbfwbngr2HQ_RTUizL=hwQbTa=C-oZNu2BAjLh0yQ@mail.gmail.com>
Subject: Re: [PATCH net-next 21/33] net: dsa: realtek: rtl8366rb: Remove comma
 after sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	luizluca@gmail.com, alvin.sipraga@analog.com, clement.leger@bootlin.com, 
	justin.chen@broadcom.com, dlan@kernel.org, rogerq@kernel.org, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	opendmb@gmail.com, andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, 
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, 
	horms@kernel.org, vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:39=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
