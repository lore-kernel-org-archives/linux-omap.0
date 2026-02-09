Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5B126C03
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624939; cv=none; b=dlhqhsp69tRu3DEbhNSGG4pTT903OzYZRTZ7oOFx6GjhgeQU+LKbkEWmjWOvC48ChNMca1lWrwiAm4P6aL0OQt20Q6YkPbFdnZ1l2YStoHq6rYwUWMHPPH4hl3xnKN6NapsdPsIOe95tjp3gBUeNDSsYKTcbNJWi7rqzp0IBP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624939; c=relaxed/simple;
	bh=/zYgLPOAHXK4/exWmt8hOWg3cIDWG24Bmk4iX8O5iZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjKfwXOCYA3vOWi1/5KDCrf4Xv0tLltWCVqD1iPFxa/yBD+Qr9LUsYdhkGLyw1+PIMs6dbpNz02BwfW/umtsa3LNOHRtTk0BzNWC352WodnXQQ2V0dSGrxDwI3Ahb6pExdjeBoZq6/swkmLtXlZaUbPyjmmhjRROUWDeyW04Vac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fa26e497abso1848651137.3
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 00:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624938; x=1771229738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bAsoauLtymOFaOmBSRU1sXzH6MyMCHQePcHPtAadtM=;
        b=BEZ/Y4tBMERpxrqdu4WydZcgbzoF1KY7czg//AScLdts9CNeA/Etw04b4YNgBI0uuK
         fsHBCS8y/OW85VQLS4wZqlGl/jadA214UV/szDXe+Dl9X0MCJIImUUHsBAgVC7mxTgZX
         YNxU+f+PEMLvalYqVpPYyFIgKfjHqgjwYhKFhZkyWx/4Pnt3249VcXr1d8gVA1NMLyh1
         XxcR/YOz4pTCdkzGO8GaYDAYr9k3SQDOZDl/MWYiEnCGjZz68lPdPz8Av62nZUxn/SuJ
         vwnK+e/o5JBPhjvcNNXDcdq2M6pqEi2JYo2ejlIfECVYwyR7oUtHFIvWZvSVcMOXgEBF
         Rr1A==
X-Forwarded-Encrypted: i=1; AJvYcCVtOHYifZTROX6Eh9ReHHDlVgwEW5X0XUnKhAIBi/oLg3Fn1X7+Mk61V9K61mPK7Lju51aN/dvG0X6p@vger.kernel.org
X-Gm-Message-State: AOJu0YzQapk2mjdIf9yBjFT7Gp26YyNIqbXm9IE6iag6z5SHmM/E7Ycw
	Lj7eGh9zS3nKn/PCVraTbLcAuWJ7G9+OxAl3SqeYOdpr3kZTVYFrOxBMhnCkJbrM
X-Gm-Gg: AZuq6aJBDBeH3np4wJolSWQst4Mp1F9KREqLeU7x6YF/t0utjTCJtkul2b0ciMU2Q/A
	6lbGiHRVj6+NyBp0Hd0cUtc8elIJTpHaor+2spB3DfrZqZ/s+7Q1CG4D9mnE0PzfGgx6opeZG8X
	s1FyX49G6Pl2QY9tb6yLGOo37fYSMfigIhRb2js57qtkB7dHNgWeRXnDp9QoipoUc5TxMRaoOw/
	y+7lkRa6l7pVBaWVYb07U1YHIh3zX3yiO3MhjkrlmqGC9kVW4Q58m7aMZrtpd1QrHVS58EXeG9V
	3ev8XKKp2k+/LnFsW0GDn+22Voz/cgKILLV/74VxJp71OFixTi8jsov5ybkRHd6H/+Qq9Bf1Lju
	1b10OAmj9xmwP5fq+/K0Xg1RKf3JcAkQDIU3T0ZX4CRPo3IPFaQT9liS0q60BA2ltPI8W4NV45S
	L0ahO/GB5c2W8hvM3FpSLfZk5JhW/ylSCgOFEOatPk+P5+kAmQ
X-Received: by 2002:a05:6102:3a0c:b0:5ef:49d0:5862 with SMTP id ada2fe7eead31-5fae8c44410mr3011874137.34.1770624938526;
        Mon, 09 Feb 2026 00:15:38 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-949014a724csm3023397241.2.2026.02.09.00.15.37
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:15:37 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso1163085241.3
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 00:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBNOsSh3kNKEGO9YGV1YlSHikOd4q1rICBTMoiU0Dr56zcjkogjeX5bE3e72z5YYTGNZ8kplvH3Rii@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5fae8a3ad9cmr3362584137.1.1770624619183; Mon, 09 Feb 2026
 00:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com> <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:10:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
X-Gm-Features: AZwV_QhXlEX6D1abbrehjsrn3uf8WxyCcirF_ZvMoX3URB-GFlRdZjQEEn6kewA
Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
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

Hi Josua,

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> option thorugh the kernel configuration without explicit "select" driver
> dependencies.
>
> Select it by default when COMPILE_TEST is set for better coverage.

Merely enabling COMPILE_TEST must not enable additional functionality.

> Signed-off-by: Josua Mayer <josua@solid-run.com>

Nacked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
