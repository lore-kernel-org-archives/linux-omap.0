Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE32D879E
	for <linux-omap@vger.kernel.org>; Wed,  4 Feb 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219265; cv=pass; b=eK5vCM28h/QNR3iPEjY/OWMG8ZG9vJTcFHLg/l+CvtrrwlxgR4f1AJQ3g73p9Ys0fctM2nSFP+lGI+3U+eNnBeQgwFKWwg9yPOqINGrRvloM2UutCCL5Qvr9O4F9JWiH0opHlGdnK4N0DILVCWGDQ0OX9QdVmu5Ac0US0KTsTVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219265; c=relaxed/simple;
	bh=nlKsoL4i0v+dpEX8d/w92v6q3wSKthXMOjn4z01pwP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj3F2pV/vfsZzzlezksF+hsg/P6LdZMWC2WQ8piT/F6w/5vfVYQQM5ciz2t0N2DL+ASrOyyTihh+fR+h4h+zXpN2c6YshlWrPDn/ZjZwhfIsAzSeUkqQmwjUSSAhLzGpPhPIv4/TjDiJix4Iyo+8m5DCKO8SBEXwMnKRPU40gpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBanTtoM; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBanTtoM"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b710d46ceso6637922e87.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2026 07:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770219263; cv=none;
        d=google.com; s=arc-20240605;
        b=gdtTwOm4aJ4Ea8xI1nEdBulTxhrkhyjz1XZCTUwouupt1rfNUQu3vJpbN4+fsMx9ss
         2YV26Nw5+0tbxbp1fNDNOSR5CcB1eTeSP5Fvi+sIA+Em95ETXeMumWchn/S0A17sWmF8
         fwPnXrlMv/wJL8TYlO7rtX+gVhbmogz+tXDVv89+K9XAVyJ+CbZxZfGnVYZeqPe0rQg3
         SHP0GxuIbRT+uaUlo/HQIhSYDP726Kr7yxwhYbFRa3U1VGkLLYxsxGajoTcLmfrVX52Y
         3bBJ7zY8FtECiPaj7we3BCgR3j+kJI5zIspfeis4coMRel+hQ3j2s0dk4Y1COObGrivF
         zObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qkOzGCctQL30LKjh61z23+b/2EwmO+vcdgiQ7sj0+R4=;
        fh=S9Rhv2Z8/HeBYA/sEt2aO2iNbxSlRYNLK8rlODbz8R0=;
        b=JH0pjQuqO80lfqTqaCO85tieVZmyfeyhQAcgtLtVSMtQW8t26hbgtpzcvTQdXHQQ+K
         xYORp/7BZVS54bAX6J79/rOQ+8V2eTeeWT0av+yW4j3eHmb3GpIpGDu/dmerCtk0cf2p
         3jd1+7eTA8xkyqhwckjFrNjBbDfLKWM1FGvgP9UUXFBeIWfG4ZgD1tUyYG5OUVU5GB/V
         JYGCdIGHDOVJ3M7eo6/+7ogFFHOZF3P6BufYduV/m6AAHQ7CqNmSdumpNlHokWsPgpOK
         nmFUoGtzqDBJpIuq5rGf9P91fP8pwpeI9CaFh7D8dp74qY8p1NL3d8uW3KcBKqsDCLN7
         iA0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770219263; x=1770824063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkOzGCctQL30LKjh61z23+b/2EwmO+vcdgiQ7sj0+R4=;
        b=pBanTtoMvLNrPLrmbtThb+8EkALU8o+e1Rf1NK9EDF/mTIMxSG6WUsh5PHvLj0lVDd
         rLLYEJsTuk89Ikt4ESXLIRTjZjquPHEpd/OiH6cHB+9GsY94hRe+6ezqJBOKeSSlYnVY
         y9hAMGPC5gbROzcaBfGasf2Kp8QiBmAZt7+ctzhQt2hXOx49IEbV5aihVb69ER9ashR1
         sDu8zaF+L/YHX2sflPI1fJaVa9F/Ltz5wNRjpbe4qVoUkMkpaEFErL0xjKSKC18JmD4p
         VeimxaY3QXZfJhEoIpTasyUt3McSVTu+Vv4jB+uhNu+qzc1Mm6LKbye4ru/RuyZ+qOvu
         +Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219263; x=1770824063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkOzGCctQL30LKjh61z23+b/2EwmO+vcdgiQ7sj0+R4=;
        b=ArPrSnLEDg7uBIuXWBSQI7l7UEnzOj+jqyiKerW2p15PhKibzdFHtO5SfAAhUuHTCw
         OLlCtOtGfAe3wWJmj52hFk0OYAt4ZKQTvwBf2sEH7Jilcfkl+J05ymUiid6csR53+W07
         6IZxSbTygvYtpZuw2YHb1csJUAlGaHeTHCaGxdlVNh5QAxOhh8gQOK/iLod6LSMlvabR
         1+PUY3CR7wCrjZKV02BoMlqYzGOWiUFjmilx7bR29OdtOEgAkmAheQC7E+gC3WH4MyhA
         cxQmKHZQYYiXXgib/dsBHD4E6mqKqp5Zdozu89iUVz0eiFuw1Stn1ei0O4OItdFiDiLN
         gL5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6W9PhEZYohOdyMBmjUSX9e8LZkYzkWfnkKRwE1f3PCJdTO0f3OBDvgRFYuzJVLZ/xmPVFEwZC00OV@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3odc5UBRavUaOp1ekkKZQZO8Cq1s3tF8nTxSGpNZtoMpBp9/
	FTxHR8vBXZlgabWEWgvOG7kviQ6sSCRTEu9Im84sAGtdiymxXbu+msb/jL1jRPpsIRyLpfNYACF
	5rAxB0P9n0BnQmGo9LhIGXsWZXem8e4I+sNzzIp+P5w==
X-Gm-Gg: AZuq6aK1jEmDWzFA/PjfbP2oUynqGil0EvO1dhawIwoemA7qzYpzoH07rKFJEc7/QL/
	C9x16/KvaSYNlAOOia077QzGxMz/LY6ot5Q50+vIcfk7vD8Os5/FoFA/Ctast2Nsps/mxJ8pqOl
	YXfE+kIyW78v8pPi+DISevl8Ug5Q2b5C0ebamXqUgGJ1kU1j4d6zegPv+7hhof4eQVSqOUL8Ow3
	jijQvu8EM6OLW+0wS3eBsMS4yutuE0HtEPtakk73Z3G640krQ5BIxSo5SO0POJkkZUjxzXZ
X-Received: by 2002:a05:6512:b87:b0:59e:161:652a with SMTP id
 2adb3069b0e04-59e38c27b46mr1376642e87.31.1770219263338; Wed, 04 Feb 2026
 07:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 16:33:46 +0100
X-Gm-Features: AZwV_Qh7tniAwClRnk-rPGRk4VKw9IxuzE_pomII0cTXEalWLMydXWCz4mlcfmk
Message-ID: <CAPDyKFoeKCPbsaRh+0t7=naO0pFvFCD3NV9nA7a4UOjxj4aDwg@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 14:01, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v8:
> - Add defensive null checks for all non-optional calls to internal
>   mux_get function.
> - Document NULL return value on applicable functions.
> - Avoid IS_ERR_OR_NULL and ERR_PTR(0) to disarm smatch errors.
> - Link to v7: https://lore.kernel.org/r/20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com
>
> Changes in v7:
> - picked up reviewed-tags
> - fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
>   and enable it by default when COMPILE_TEST is set.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - fix another kernel build robot warning: undocumented C struct member
> - Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com
>
> Changes in v6:
> - replaced /* with /** for devm_mux_state_state function description.
> - collected review tags.
> - fixed checkpatch warnings (space-before-tab, void-return).
>   (Reported-by: Geert Uytterhoeven)
> - fixed use-after-free in mux core mux_get function.
>   (Reported-by: Geert Uytterhoeven)
> - fix mux helper error path uninitialised return code variable.
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com
>
> Changes in v5:
> - implemented automatic mux deselect for devm_*_selected.
>   (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
> - because of semantic changes I dropped reviewed and acks from omap-i2c
>   patch (Andreas Kemnade / Wolfram Sang).
> - fix invalid return value in void function for mux helper stubs
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com
>
> Changes in v4:
> - added MULTIPLEXER Kconfig help text.
> - removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
>   not required for all devices using this driver.
> - added stubs for all symbols exported by mux core.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - refactored mux core logic to silence ENOENT errors only on optional
>   code paths, keeping error printing unchanged otherwise.
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - picked up various reviewed- and acked-by tags
> - Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com
>
> Changes in v3:
> - updated omap-i2c and phy-can-transceiver to use new helpers.
> - created generic helper functions for getting managed optional mux-state.
>   (Reported-by: Rob Herring <robh@kernel.org>)
> - picked up binding ack by Rob Herring.
> - replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
>   commit descriptions.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com
>
> Changes in v2:
> - dropped mux-controller node from dt binding example
>   (Reported-by: Conor Dooley <conor@kernel.org>
>    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> - Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com
>
> ---
> Josua Mayer (7):
>       phy: can-transceiver: rename temporary helper function to avoid conflict
>       mux: Add helper functions for getting optional and selected mux-state
>       mux: add help text for MULTIPLEXER config option
>       phy: can-transceiver: drop temporary helper getting optional mux-state
>       i2c: omap: switch to new generic helper for getting selected mux-state
>       dt-bindings: mmc: renesas,sdhi: Add mux-states property
>       mmc: host: renesas_sdhi_core: support selecting an optional mux
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
>  drivers/i2c/busses/i2c-omap.c                      |  24 +--
>  drivers/mmc/host/renesas_sdhi_core.c               |   6 +
>  drivers/mux/Kconfig                                |   8 +-
>  drivers/mux/core.c                                 | 205 +++++++++++++++++----
>  drivers/phy/phy-can-transceiver.c                  |  10 -
>  include/linux/mux/consumer.h                       | 108 ++++++++++-
>  7 files changed, 302 insertions(+), 65 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251128-rz-sdio-mux-acc5137f1618
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>
>

The series applied for next, thanks!

Kind regards
Uffe
