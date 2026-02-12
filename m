Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F635E557
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915520; cv=none; b=sEEv5eS98ATaDl9hfQW7Km2z11ncSB6CblLhVdbz+65m0dO7VU28VAVEdkYIneUBdPrSdkB22qcBH81sIOTHJCak/pp4UM6jyLBWHoKIsSkK65BaUXLjeIVggb0Q8ZBDQVhpadoGatgP60Vn3owqNhjugqr/A7dcfOvZKvmY9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915520; c=relaxed/simple;
	bh=FavnLYuCSZbZEB88+6M4JKOu7/zHNtiz8QGLBab5uI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agPPgQ0jWr4ONkWXQMKL81PKF472oEq8ztVl2UcVb+gTlgrB7erBshAmO9O6J5N9KLTJQNHiLjbGqo02NP9nxFty45ydYDrjm/fWFwm5Z4oCeebz3PH9NLBxd1JNDnwaJOi8gyQTufuF50WwMhJtsHlESUl8E7EYq9wzcTBb+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-567417610ddso48579e0c.2
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 08:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770915518; x=1771520318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om3cuNbQzAgOvOQckRciuNr9O8eg7IAaHrWKXJVxB8U=;
        b=baGZv6zoxQebs9U1OaJmHVYmiKIh6DfX8iRoQiRfNncKqU8Ym0iIA1yY4oBmQMvjsR
         vc/7LzBNMiSLYzKLnNfmov1mm8ahqs45ck4Ptt2dSoFt+NARoEkp+dc2kV5T0FeEcd1i
         nhb/gNzCdgKKeEECDWXeYpUwh3leK/oGhVa17ezvfO64tkqTW/+AxqfnSPD0/i9im63N
         MtriIKqRaAf9aQcq7P5S+6VfQF0E+vQ9/3dgPMGtvtmivvt9unEQETagPbo6Ybg6uVUW
         Rgws2vYXfiL7c4Lu+y7DCeT6ZGSCkQjUa0O8sCeJgRJFUNth9xAdyIQLWZzWkLPryszj
         o96A==
X-Forwarded-Encrypted: i=1; AJvYcCXuHSki96HO6fv7ktuVIcFBJprdIdcAZwnfd9Z8l26nqYMYl0af3WHeOZ8pVuk2VjU0Z/dhMQVskgWO@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfW5tGDcIIFPkDy8z1eIR+zSu/Xkrb/MMALfMrjbECL6yG8Bo
	jawBS9v6ny5zZDRFc6TNXtdPIpbd7CN2AsaVuPnbqPO89jJLLUiTq7eRQUd3nSfN
X-Gm-Gg: AZuq6aKUjrTg3AGhQIGEL6LwMfdbHGy/NhOm/9Gre4EkRq+9u43J3BmJoc/fE2UZ4SM
	JMZj2+Pmjbo4c874ZVvFfVTazV/sn/qQgAJgG33Bi3C0tT9beeAACXoWKJGc7TjqYEoRqH3o07H
	07ALrvhP59RhJKvLS3057DjHO3VfKdsapwnQKgRwlAHkr3/QtSVYauekgTvqWIeVdD3FcfFZhvj
	bzoZIGIMHej1abfJl581skIg32E1W0KkoQUzdT1fwBX+8LPXZBB5CSzkIZpDnjCRw8WzOX9lD0n
	tr38sPoldinCygwfu3wFop3j6DA+PRTYDMiCi29T+OyetnFxhkI7c2iC4nMseWFYxl10vcdWjkL
	9uFjwmfc+cf/am5GFCz6gZT8m605mqeeqWBFYfH1fA7P+fQ9zOpPK2zsXd+ej/hxr1LOvxkw+Ha
	eGf1XqjX7N6YDXGct88ew4Xh4GRhg/c9CJcGiBmebKYDXkOZrg2Y5DyR7Lorwa
X-Received: by 2002:a05:6122:414e:b0:566:38f4:4753 with SMTP id 71dfb90a1353d-5675b7e3180mr863415e0c.18.1770915517858;
        Thu, 12 Feb 2026 08:58:37 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c2429c9sm1908026e0c.16.2026.02.12.08.58.37
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:58:37 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fe086fb0baso30064137.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 08:58:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzt09t4gNp6zWJpPI0D8UoUcDoLzNOvzdqobWTXQGnkNzgsO2PiXEpRYTLJ2GQNoD4PPUd0ENNsNTo@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:5fd:f8d6:e5d7 with SMTP id
 ada2fe7eead31-5fe003fb1fcmr1021759137.11.1770915199593; Thu, 12 Feb 2026
 08:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
In-Reply-To: <20260212164823.mbeycqwzsy2dfq6e@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2026 17:53:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
X-Gm-Features: AZwV_Qjd18dp3H6_yOLJUoqzfa3vu8ojTLTUkfH0N1bdOdZMnHdC-jkEvP2Togs
Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, 12 Feb 2026 at 17:48, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Sun, Feb 08, 2026 at 05:38:56PM +0200, Josua Mayer wrote:
> > Rename the temporary devm_mux_state_get_optional function to avoid
> > conflict with upcoming implementation in multiplexer subsystem.
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
>
> In the future, when you have a series with cross-tree dependencies,
> please try to think of it as individual mini-series for each tree's
> 'next' branch, and specify clearly that you need stable tags (to be
> pulled into other trees). Telling maintainers what is your expected
> merge strategy helps avoid making mistakes.
>
> For example, if you did that in this set, you wouldn't have missed the
> fact that in linux-phy/next, phy-can-transceiver is _not_ the only
> occurrence of devm_mux_state_get_optional(). There's another one in
> drivers/phy/renesas/phy-rcar-gen3-usb2.c, and that should be also
> handled in order for trees to not enter inconsistent states.

To his defense, the one in drivers/phy/renesas/phy-rcar-gen3-usb2.c
is a recent addition.

So this is yet another case of "convert all current users" (i.e. those
present in the typical subsystem base, typically *-rc1), with new
users popping up in -next in parallel, which happens all the time...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
