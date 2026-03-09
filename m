Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC453D6695
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068821; cv=pass; b=FTrmEtYjcr07qWiCRMvK7d6CaDTyf2THdURcunszXEVxhbhyrPpYHoAhbhbbCGdGXR3/skSULDHskzBjaEVnMwpzcfvB2Pn3+ifAy9okQKaxLYzsGyRiGH1xGDdQJ0O+joaxw7kkhXQSAdZlsrO2Towl8HNsR8j/Tcsm5SW1QeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068821; c=relaxed/simple;
	bh=JKN2J4kHq0yD8TjxvyPjjgMMFAS3NaA1mJTCXgnPsRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGpDjzEStbG3VcBlzx6ZSd30GMYl5jYK/6wLL73+AnIki56113v2C+yJ/bbTlv6nG+YZ1ibYBKkNNwQvYFD1F8h6f4F+ZBzUL7GBX5VXQT8oGHUWREbNqBeUuy7Http7F6bAKRAep/32iaisMGxM/RQtJvhhzOxfn75EmNOSrGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDCKAWzT; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDCKAWzT"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so3457824e87.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068818; cv=none;
        d=google.com; s=arc-20240605;
        b=hX+JsA9omomyJMGwxaFLBJhx0m3+5QCxVpsV8Mf3HkCcbJcAjuxle/kf1sYMJOG9wq
         5z+0HBQEQPuE9vpNCTG8EG1+YhcPD93VeltC4UKnCsrU5G2jLM6/a2Wo0Vr2ILsA1YBT
         kadNLFYL/tIo2JkdptTN7pwdppMMWsAhHNPCtrvygnCqri9WekxKKKz9jiRfXNcYg7xj
         PNmKBLMvx09onLdRL/+jFHdtTL9QbzJKPHQrYFBAxNAA+epClzQ7KflVcyM0/5NwhBYB
         Mbs91XmYhzsKuPykRk4Ak5R1J2hr69iMklnV0mcBA3ijSZru8dOavqYTVX3jv2f+UKO4
         Pu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        fh=z+ASH/z9tKllxosefXR32DWAeROW8yEcZpxkcp1h368=;
        b=e+9oSFJlgY7DDuz+e/ihxulzYoM/m+cR6rZic+DMIkNCwWoNL29gBH+Q/hGHjcIeng
         GjogePH8qqnsxva8pT9iLYeiribNiyfc7KDB8Lv/i3Q9N6ZAly1nRzA1akDRlfBWrbAf
         a1nhcC1gypUfdkScx9H+nZcZNeBAEQziMCQlJaSWV2jfewoi4789aNfLYQP2xe4iJjQu
         KPVNepAj9dLyDaA7b4LPImcG5AwHjpf/2evhzgICjDzzHtTBmwl6vxJRaN2/YjFaybYk
         dyFvw/GfYi1gNBJ5KXFCu49ONWyaOV7FPKjK1oX/np62aKSvHBTM3j3oRqM5adw9MaqZ
         6TzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068818; x=1773673618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=YDCKAWzTSjoyOKxywxX/89IU//SMk/64iocZQqSPHMm+RZyOKO61dyNWFH8+fDrUSH
         BhsrZMeW8TAfJqMdaAyEkf3OFDA63mDRaFuayeHDpbmqxS6dFezk9eEnH002tQ2OpMEt
         tv4B6QfA+/uuB001aM95V6PbaZdpSB6LnvAC5az3zDD7/Jeo503Erl50y/Z/OQoTmfUB
         gsrXxHQWndpKSnkqBf/TQThoIOiQSSpNSmwWdGp8MIQZC9wRKuXaD5KsunxTNwISM3pU
         +z078T8q/N7b+1nsIPv2gGu4cwBm7Lir78sm8SKWJd+vbaQ/R1qNAs6hWZ9EdoUy7rDb
         S6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068818; x=1773673618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=R96gu12iD/BrsUBTRhLlyOSnzBIT1qM8L6FweVK5Ix+GPSL4f1M9/7h6CYPHnT+uDa
         Ppy2ujNKH3kk65mD4+IZKzMdr6P3E8Zt/WX6zYaXH2z7JH8UiATEDYuJHKR+1HBCazCQ
         Ihs9M96HMaQLk9AQS0eV0JrAMjXqPyeLB1NJwVHZ6kQPfx8v6lZlf+ZM+As4M60r43z6
         i4eTcVQnTCJ9pu1zwuRERGzrg6kv4f/WRLzWhetN0qiu93yXHwgQy77pTTLartvmbLSL
         PpwrDgbJ+Oz6V6Ge7fKPcFgPbSUu2RLwHIDW8NZ5xfsP815o8zMEaaRcka0vCqtffSQh
         1DmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzJxdMiEguxX+yaFwUdNGAPZe42TZ9/sxJXp5nnjf21j1RnBl6ycg6PzW0kyFP466uPcU9764L+WRm@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfqgme/Vmz2XutZw0CA2KhbEbuSZpw50+4E486q4VihFjzyqe
	SgbLKWY2ahFDdGvVc2g37t8XO4mnNwDIZyyB19dACGjrVGhJUs+omPbOCWFaqkiI7nj43CI5QxI
	pV4pJZIBiDAJDR8IbOVUhmfQ6I7HPCHXfBXWilhzCqQ==
X-Gm-Gg: ATEYQzyGX9WPRRfu4rcCjGbHYu2y9z8vMtg1kv9Duu22/AW+vvRfYXAksaSlpkK+Tpz
	HhdALGSAoROxbp3l791ynjf30lCZ6kYv5p+BSS4hrZs8HkEKGwKorO/haQPiKkWedQQJwLwqYxJ
	/Q4PrH48Nkavqzig11C91rWC4LwjL+YR278lTebGIG9FN2MfUfcvdhNlSkgp7o0Pf4SwjlMXZ8e
	yIlEpRoHarcdDSE9rt2+AC4BYApZDxWX8VpjjcnhZg1rVHxrqALkjh2d4vBJ3BB5lqwIWgWjIkX
	xTtCMZto
X-Received: by 2002:ac2:4644:0:b0:5a1:3ab6:6de2 with SMTP id
 2adb3069b0e04-5a13cce183dmr2793114e87.37.1773068817703; Mon, 09 Mar 2026
 08:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com> <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
In-Reply-To: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:20 +0100
X-Gm-Features: AaiRm51gPNstmfmPCbGsevKfnVyHAve3znxWrnZO7sNkn4-s9OVpM21rgVmHXjc
Message-ID: <CAPDyKFqyUsKbp9pgKHsMoOd5Qe_0f9rxsX6C61adQC344eA9Lw@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>, Peter Rosin <peda@axentia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 17:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
> >
> > This series has evolved over time from adding generic mux support for
> > renesas sdhi driver, to partial rewrite of the mux framework.
> >
> > Several drivers have started implementing driver-local managed and
> > unmanaged helper functions for getting and selecting a mux-state object.
> >
> > mmc maintainers have requested that new code shall intreoduce and use
> > generic helper functions that can be shared by all drivers, avoiding
> > code duplication.
> >
> > This series is structured in 5 parts, each of which is self-sufficient
> > depending only on the previous patches. This shall allow the first N
> > patches to be applied even if the last ones need further discussion.
> >
> > 1. Rename driver-local helper functions to avoid name collision with
> >    global version to be introduced later.
> >
> > 2. Implement generic device-managed helper functions in mux core.
> >
> > 3. Convert driver local code from similar patterns to use the newly
> >    added global helpers.
> >
> > 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
> >    without an explicit "select" dependency from other drivers.
> >
> > 5. add dt bindings and driver support for mux in renesas sdhi driver.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> > Changes in v11:
> > - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
> >   user-visible wrapper for menuconfig.
> >   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> > - dropped the "default m if COMPILE_TEST".
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - improved kerneldoc line wrapping.
> > - removed unnecessary changes to original devm_mux_control-get.
> > - fix "reference preceded by free" in mux_state_get function
> > - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
> >
>
> [...]
>
> To me, this looks ready for a new try. Unless I hear some objections,
> I intend to apply this as material for v7.1 via my mmc tree on Monday.
>
> The complete series will be available on an immutable branch, for
> other subsystem maintainers to pull in if that turns out to be needed.
> I let you know of more details on Monday.

I have now queued up this series for v7.1 via my next branch.

The series is also available at the immutable "mux" branch (based on
v7.0-rc1) via my mmc tree, which other subsystem maintainers can pull
in if needed.

Kind regards
Uffe
