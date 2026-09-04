Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AA51FCB1
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561387; cv=none; b=MKBD1Zo/onpxb6z7scloJ071Y/kLnIo13zJYSVMzYUbaZ1D4Rd9BEqGU0E9be4x/BBgISSVA9JhYaP2NoXZ2fVnr+KeaJoViuMmLxfYu6ypTeOHHIqXIEIBL3jbbAMiXtprtyA3yyTS5pwHxJzmZ0sbY/u5GEzmwLySpW3Qo+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561387; c=relaxed/simple;
	bh=/oXwqSl9Gxhd9ASYzU33CVNwSksmytljDqKt0iBuLvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AndHm0V3Au8mMBIuRG8wwiqMaz6Vvq9VqUUiX91c+qov6k5G3mNW6ZR5aHVhFOg9z8SS/IXWpjh2bNdjY8/ImAHMK+AiErdALY8SzzhAzDUbWKxlhq/1OuvoPNz2ybKWOkFN8Q6F3UQDWTrJk818lLI85bAmzKYRYN+0/sPMRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlVbCwxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlVbCwxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD6B1F0156B
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561385;
	bh=/oXwqSl9Gxhd9ASYzU33CVNwSksmytljDqKt0iBuLvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GlVbCwxddIH2dGDoJPIA/h2Tst/6qBA1KGZqh+6T+wL3wdW8xpNgyzaSqPTvBO3IW
	 dmWsdWcd/TE+zleN5SMZD9rLM8nV3rxKKRQIlCABrM8elVbNhL6ZG6n1LB+RpwiAMR
	 mWEEHJ2ijqefgTMOVlyCe6A4bK22tcocp1M1amhMsGRuSaSdQeiKrQjGl8ma2dSnqI
	 7iGskWVDBlHW02icgqAP7VeQOEbWbRAIUSZMRyRq8VivPjFPHzPGt2yYzma34ys9Tp
	 2OOnvpmEk8u59IFhysAtgxkO25ylitmXa46S7QuFOChTDJs0sRRb3d7WqqybV3DH0y
	 vPUw1DQqB7/xA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b01910b499so1428491e87.0
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 15:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzOex1kGVyuPwc7qB5OMGRuPV8c+SyVsJwyppzkwLFzEH2wm+qFvwNFzDndvz8G+8dWn6I3Qybv5Mng@vger.kernel.org
X-Gm-Message-State: AFuF++nk0aEkudTMfv9yzIikFtIvryxB4QS51a11jVjxDGQQ6klWaoeM
	XbuUcDeXV/5QHjArvSE7/aQTv1/4JXuqvZcwzcuQQaHWKFwHS6br8gkRuJya4O77cEqzNqoCTAB
	GWLJUBUlSp9bAwt3ulfaQsj3A2MlkvEs=
X-Received: by 2002:a05:6512:a86:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b60e8f8b8dmr2291058e87.17.1788561384171; Fri, 04 Sep 2026
 15:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-19-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-19-s-vadapalli@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:36:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLn+fsxrH2YvJSnaYhHg2EQiUnjMX5BFE_MDAzvvJjY3Bw@mail.gmail.com>
X-Gm-Features: AcwNN1WIrbJQES4aWl5_UIygFkf4p6tsLt1aSuz1HDzaVFgsk_a2nVa_8mNAHm8
Message-ID: <CAD++jLn+fsxrH2YvJSnaYhHg2EQiUnjMX5BFE_MDAzvvJjY3Bw@mail.gmail.com>
Subject: Re: [PATCH net-next 18/33] net: dsa: mv88e6xxx: Remove comma after
 sentinel-entry in match-table
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

On Fri, Sep 4, 2026 at 6:38=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
