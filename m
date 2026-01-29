Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2E33D6DF
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703348; cv=pass; b=FLvoGJUeYdGVpv/C5BD7i7NOa6Sj2PxJiwtO1Ln5lY9wds4DwomR2VDQpxygvPQ310jQU9QPMLyhvUtI2FAx7jJUXAeHhmxKHU9E3YNqlhdk5114j4K+OpmAg5FM779DwOgWyoX//HwyzdYBKRyVFy82BpRMcIgGp7K9mVR2a2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703348; c=relaxed/simple;
	bh=1a2qdSYst23Ql9WM1gLQFpUCuswuU/Q+CP4seG8rf9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkwpTB2ZB+eCswFQyOcqxYZ7in6qqNx6nmWCCNWT01K1r2AQwVzFORrk0t4eQcKEYJbfu0CgaUfir5iyNC9+mLYLIidG93Wu/BpujC+Q+J26xaOi9HNCyCQ26l2VJflPhe0t73OKURBMbA/n8VEe26itH0m468nJ7+byi1JgA20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R2rtEw6s; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2rtEw6s"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso1476562e87.3
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 08:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769703344; cv=none;
        d=google.com; s=arc-20240605;
        b=VQGHBCuySL3PqbU+uu6s8QagZHG7AKxxsGnYEaVTl2lBSS6h9qM2P2WUHvrrNjAuUD
         Nm6EK1jRZOLRptOxWzJ3m5aYY8Mp1PsjjaXnaoXFrlr5H6kX6NLmDdjj7O5WbSwVe2R0
         q32E9jlfIfJabP5512WgsB8juvrJfh36yDm8oBTgO4j/0EuXB+5/wdXo3X+wiiAFkWTl
         iBCWtE5vYX2z6w7uYjk6PEuTyv0zRk8UyT7bBHMx5I8Hu/4ou048BjW6zdTKIjKQTnOF
         OdQ8Xe9d49HfhONMamXA67bSrW8jDoBfgLNBvyKaZQ8Xr95Qbi66cT4F8USu4SBvE959
         uGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        fh=vsDx77dL+/FHd70NejLaPa4RJ4W3V7362zP8h3l6sh8=;
        b=PMRJkhsK1r001aoXkerekeXSr5F5QAwv/Z7ER3X8i01rBAQpeB1NHeDNH3ZlMwJaOM
         6sWkmxUN7L7hvIz7H9ggvsSJ7hyORjcclyAmCdkKlykvwyfz4RO03Fu9I5l7yBJJAw6O
         65dzWdcjSPIGxMHag1YfV5mNE461AM9l5hYYYJE6fVYd0naLGAxVwWWS6SWZ6I/QL5xN
         zqJH8Pi9T10Ru65PdoYwrk0iSMlu3xPLri/fAwSjB9YGvPcy2BWJhKEaSOU6XhTciurQ
         OFAKRFsyVO0U4i2J5HWz0DQsb3BGz7kZUn3zW4HVAzR1TpcSUXYwzOFlfbIt4vMzufhe
         H0Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769703344; x=1770308144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        b=R2rtEw6s8YTcWjZY2e2AML4K7tM5lKYxugbTWebu3siLyB5CSjCoSrvOgNWrgvTYGV
         oc4mjod6t8J60MqV5zuFdulMWx9ldKucS7iPUoULRVGFN5b0p+kHB8+l5dif+C2NPybG
         ZHQIoumYPQrrdr99VBv4PfQR7aYg61of8NYSXgn1V8+61CwpsOqdT35xom/A2UjQKos4
         C9YiCt0sJbhMTYdIysqY2Inpqug0vXlovsx5TPVB812+3TSpX5QasTly5Y1lY8y+NFIq
         gj3SlGvUMthAyhh8UJZ15bAi/zQ49ohRS6DIVQqZHSV8uo6U8gsrAAnMKRuWu3tZbhZn
         yIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769703344; x=1770308144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZyL8rlWiol7qHJKX4MkvpKMN+RPE+vXis8g5P5uMA=;
        b=KGhW6eKRaoj69nUpgHQ6PNtu6HVgvyHODJhzHuFJhGxrHjW0lFvUyxeOelP6lO2rJ4
         CzZ3Px3r+1qKWT8bm/QxqySEZmp+angaUOwvPJ6QlT+55WVo8lZPykQzVoRmBAUkgQz3
         d3btwBi9a51Kqn9UW2wwfbcpM8NOchm+KAsVcMFwO1YDh9eQvBAPli5g+Znf/fCtMTJm
         PhwS9JkrWVbGp7r+1f814KZcYJwr7xgrhYKBq/n1iOxi73sDw/s0EHCnrEQigjp0/Y3j
         915AvIpeUTFnFI3oXWd9jNdqsA5XPpMJURc9nr9TAMepp5jflA0/Wpziiym5J7SyQt78
         Ynlg==
X-Forwarded-Encrypted: i=1; AJvYcCVng/FfU5I3aFxXWbkM9dWmqHsBSRcBKr0G02lZv4shPBVueHJHOi/twPOhPbE7uyNCB+gi8EI4q7+8@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZ/WfHg1saNYVeSQ9P/TDk6csmbHjFFcqGjKgsPBDLG2Pc4nR
	dL0dGcDZKbnMOsyTgi9Ro8dUMunD3E7kocHTBxQIlYUDYn4iyvw+YyniHukvVy4RrlPXyrbbKtS
	AkniWQTCg3yPJtv/7+lPYXdaJ+0MRSrCXg+Q9O1cxIw==
X-Gm-Gg: AZuq6aLKPiu+wX5XbECz992PN325wE3ElL9jmX0jrfTaR8Z9xZVjWrXW5AaN2xhg1z6
	OH6iNhatt2Kh286Queuz1GfLZAs76j4GLiQTTZ8PlrJA04vNGTn2MU0sz2roGnE+/rzosUO86+t
	vrAPQH/jPuQyRjM93R3cTtvGAU2FkYRNvKudLWpdXmN0NWfEzEA3OuK0M6uhcJWEFx2AmVAJW7N
	oPZN3IbsFTrZkhLySU/X/+Lck7vL2ARTP46juif/6KyisHhbGFUHEHdKbyPx0OFKRfWbgtV
X-Received: by 2002:a05:6512:1394:b0:59e:15a:d704 with SMTP id
 2adb3069b0e04-59e04015669mr4368983e87.13.1769703343301; Thu, 29 Jan 2026
 08:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 17:15:06 +0100
X-Gm-Features: AZwV_Qg3mhJxcxsaaNM16DuqcQOXYrDFWwz2xcBsELVK6E8j4cCnjP0a7TG6aus
Message-ID: <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mmc: host: renesas_sdhi_core: support configuring
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

On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
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

This series needs to go together in some way. If you like, I can
funnel it via my mmc tree, unless someone (Wolfram for the i2c part?)
has objections to this of course.

Kind regards
Uffe

> ---
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
>  drivers/mux/core.c                                 | 178 +++++++++++++++++----
>  drivers/phy/phy-can-transceiver.c                  |  10 --
>  include/linux/mux/consumer.h                       | 108 ++++++++++++-
>  7 files changed, 277 insertions(+), 63 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251128-rz-sdio-mux-acc5137f1618
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>
>
