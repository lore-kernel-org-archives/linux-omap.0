Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1E3C5558
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925832; cv=none; b=VY1Vy4gHhnpO/KL6ffd2xRofWvo6q1vfvmfOUYiEsZT4WYRTuqvs/gh9k7lqmlP1RrL+/rEToIZGDLiLtR2b0TYM5Vd4fCzzrddhv+9n4VegCf7sVO9j1zEWk41aDd715GkXIr9/avE3IL6WldRQHRcC1Sm2s+lLkSwfNbkM/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925832; c=relaxed/simple;
	bh=/z6FEu0IUK6nCL3Uiqn1iq1VRQstHdDNDk6ymaE5UrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD6zvjOL7P/WMC8lq2AsMq9XPabnbcr+Z6hsf0P3NexOoMCwm4uNPhPWLx+VyJx0noIBwEkNzl7eRS04VvU7MoT1X3shSnQ6sB07MdIEho7QxEV52l07sGbH1Rcg422rb9ifMvnHJmt0lZfNoaVP49hFcZc9fvUY+MzLG5TANXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo01snnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo01snnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0174FC2BCB7
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925832;
	bh=/z6FEu0IUK6nCL3Uiqn1iq1VRQstHdDNDk6ymaE5UrI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Bo01snnRFCsVSU9jXLHYlBSQbxAuKL8IlZztOzE7GGenHwqVix5ssfwMi9T3optQG
	 d+gdZbHjid/FAQoMdnnvLy7M2K/MKgAstWlXld4NzDhgAaD4vtKGHzQIdX788cS21V
	 dFWydrgXzY/v9glSzQoEPDrKsVEti1U+5GfLE/NEDAwz+HH1o3l/SSY5ICwNs7lfQE
	 SgYxMuBjZ2CuTOrkXPv4s5eyPP1f6e/bZWIElN+S6x7LjeGeeI3xFgd0/YAfwDebPv
	 qUmCFKkrzQXaTuT5I2A/RKhCEe1nrU8iKbsxLH3L/Inc4Pn/eW0rhPQhZNZyKFwJJv
	 5fv/h7nyjmQUQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a27a2fc113so859882e87.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 06:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFuSW1yqhW77LJ3k89p0IpMJcCzRc3MTJT2cWblfgt3C5Hrs8MU20rWGSzBMot1/xZWOfj0hOA+aDk@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOLhHmx6gSwvBy6+fUqVspi3MvgdzoL0jdZflNs+hGwg9rjBI
	ivA2cn5cO1c2L2ezL76pnkjwNoMjUOO/Gp0CsJ1zvF9nnyS4TQDqj0lYHp5xLhDopNpyiyhpYNf
	VWvJYSnA6q8mqDL1I7injWMiWXouhxDE=
X-Received: by 2002:ac2:4303:0:b0:5a1:49a0:af35 with SMTP id
 2adb3069b0e04-5a27958560emr2184109e87.10.1773925830317; Thu, 19 Mar 2026
 06:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319105947.6237-1-wsa+renesas@sang-engineering.com> <20260319105947.6237-15-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260319105947.6237-15-wsa+renesas@sang-engineering.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 19 Mar 2026 21:10:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v668mhN7XnjbA5Zg4ExRXLVqn8d9kDjap4wVNEEL780p7g@mail.gmail.com>
X-Gm-Features: AaiRm53ZA49QZnlP2rMulPZJ-bDSE_dydGwTankSFX-RnHDx5Riad08-AOxumlo
Message-ID: <CAGb2v668mhN7XnjbA5Zg4ExRXLVqn8d9kDjap4wVNEEL780p7g@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] hwspinlock: refactor provider.h from public header
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Wilken Gottwalt <wilken.gottwalt@posteo.net>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-remoteproc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 7:00=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Factor out the entries only needed for providers from the generic public
> header. This allows for a clean separation between providers and
> consumers. All providers are in the hwspinlock subsystem currently and
> are trivially converted here as well.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  MAINTAINERS                           |  1 +
>  drivers/hwspinlock/hwspinlock_core.c  |  1 +
>  drivers/hwspinlock/omap_hwspinlock.c  |  2 +-
>  drivers/hwspinlock/qcom_hwspinlock.c  |  2 +-
>  drivers/hwspinlock/sprd_hwspinlock.c  |  2 +-
>  drivers/hwspinlock/stm32_hwspinlock.c |  2 +-

>  drivers/hwspinlock/sun6i_hwspinlock.c |  2 +-

Acked-by: Chen-Yu Tsai <wens@kernel.org> # for sun6i
