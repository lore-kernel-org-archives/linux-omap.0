Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C22325705
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194858; cv=pass; b=PF4nNdqG2rvBzP5AJzwj1vflxNiRDNUnoe4mM8VLco5XYTzDpGJmIIKCieZF40H7/2v+ZRORnspalc5Nd+9Nxl3DSIixd1aPqDZWJuKgNFR0U33+HtiGbQisGwdez78B4HJ5ro+IH3gblN4M9GIjfvyDK/8KRwWKwii61w+hYnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194858; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snJuYo3fqbl8fSS2MTeR2h0QCBqMI4PFpTX0JXMSxpU3yQotrOwLb6sBbfeFpFtoCHlCWb1Fi5/bYUGBNRhcPIlWrNItXe1NU3/Wm2hZE9SuL2+wHkY0gAqfj/rAf6ocZ+INmUrmV04ZsVUvVl9Mi5hiDnaVe97L1v4YUpKnblE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SqpOgAb4; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqpOgAb4"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so4703785e87.3
        for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2026 19:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=ko54jM21IZGZ0eVpT4ShBFqGT7/GR8C8OAWkvSQPPVTfUZpKWcyhmYpnc24HWpzZJC
         flYvGd1L4TpYvw8Fp51dweXO8Q2qF5uCKJvzlWF/Wp14dCUJhpicfuDqiI/ks7Q32avS
         fRITyE2uAV5ok8/3dQpLtAJ/9amhspF1gUvAWlB2Pe+C0ZkyGBi8s00wOgwEin4oUgsn
         iy5W9tw4FIRdqJ/RbiBvkcXfOiLPGDyIgsGpyn2oq5L/Mzi1SssN15W1rOlEUnI3IPS/
         CTFi/IY8Q/5EEctKwqaKOfjRcJLkWbkJvrhGnr1odEXsmg1PWKdOZhwiVFGN0z6H/c7e
         SxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=sObCB4Uh1GHI1emaHRQt3VfSi4fjRixjlTDE3EhJyg8=;
        b=J9SAjgERz72YPGMG8utUqoE7xdH/q8xBwf1sZIyDmy78OAxuSf5y3aKjr6J2rDuByd
         9kYSSQFbDqG55lbGBYPdkdktVUmBno8YU4Z5p8wqbiy/R1i70srEKtB6Qwci+vbI2y/B
         qsuJ8mDHkVdZn7Yc6Aqu6EgxtOmOEWTt5WPPoHh+WDtDsN2quiwD4CJQGHe2oGqiiHBn
         lvCSD/bJJo0zr4WqrG11pf6vH3i0ysGcquNN3iLo21cVwp3jBNTy4KmVo40eHcNurzLQ
         FqBBG0asec0bBOtT37kLFfnAh2wJUhuZ7bY+7EwejBjhvGnNaY8iwmvOxNoGmwwCN8Na
         rTNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=SqpOgAb4CQOCp6QT1IhDiJXNOENCCAthmmQiQ2Xm1LqdH6AuNnr9pWEOxoaM6J2EHp
         TaZvrNsWvEAAdeAh3rGZCGLrxzU767HUy57VJt43+079ae3+2kuAr2+JBVbU8T9+l/BT
         vjjO+GANIyds0bGFgUhdgNG0FnF3NJi/nWQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=lJRzjjBKeqDuJjD0pb9MtA4xpSw/qJbaPXdOTk+qYU/fnjN8PxoqYz/7FmBpaeV6BK
         4MFOlf2qdsIEY0MupXiqkfjHBMuuJcJ2EMKSLM7Zuvbqz/smU2EJ/0uxzxgUEoAX3aSx
         itfEj6/wj8YPvcl2eGWtAbrzrUa+NPKrGJ39qXRodWcHiy/V+KpmdsWlJkb1LimXHGLO
         t/djx6fRASDodcoBpz6HVfpLqPVvG43gdZHGeVPKW3JvKjOSFE9gJDhDei1tyv3lReUk
         ews23maFWZ13WxCaicAtlkgB/rJTTtOD7MdzYfoweLhOpSiMSJ+HnBYck3e/QWICADHn
         H/0w==
X-Forwarded-Encrypted: i=1; AJvYcCWyxZxCHl4FbLwajgbUxVbDPvUkRvrcX4wfP37Ku65wbnW7f79mIaQZ945o+BszngJhytRn6oG2AQKz@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTSp0g7dzXjYBMgtCGAV/pLmilHyMT4AwZ0HFPqmYXXRTD4a+
	cLcGo6qxeOoxgqJc0x2DEekZk8nksIQGF+H0eE7kfpRlN43mnixp3a6H1yv3DW3ZW37oBHEnZB5
	6gIkM7OY8L3CptPjGGMQSQ9DQyuaLeTwd1iKR4ms3
X-Gm-Gg: ATEYQzyo2r8ShGIPUl224TRrCU0t0XHIaHtCtSp40Ela21pRNaQt/NGAtLuLIaJnYy0
	NxKS2vobY9YEsR3Ll9saYPmc3wcrmvLt7UNlaQzahcdobiTu/QEa1KoKshQ0BJc/3O7QTdtzYM3
	7yZbfAtbCQeMlVfa7VVxR7iSP2CVFY7d2c0hxCu7yuf0kVRRG8eGjh1dxH8yCtrSl56DeN1YpFA
	h7KoAabOzx7CEQAQk04xqM5NcJNoAtonpMzXE+N+D7Xse+0S6PmTol/9Hwrqe7oAEvzjwqb7Gsv
	1SAZxoSntQ==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
