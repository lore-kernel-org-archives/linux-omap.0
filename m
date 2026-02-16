Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857C1F03DE
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236105; cv=none; b=iJ6+QK+iFSBW7nRFufQVkGz+kcE7bWU58uv0r3hZFT+NwdoB7RkNp2v521Fqv9tJmPAQNk5Mm37wHVy+NmF0mYtfXA3v6NOX3mZSwF+GCjxAOaUlBq6GcmCaVgXHxhraQvW65O4dagsJJpkp5/45BTf3YlcVf0piWGa3LsNAqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236105; c=relaxed/simple;
	bh=qIHY7cCiEnGtwkY7aFFwE/mZ8uiiY18ecDxBJTYhSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkkIE0JfUh11qQafdpDaCz8/VbywMBkXU5YVk7KxMHkQm194crV/BaGvuNQRhu5JhR72slrl8T0fUK+jNzBb8naDzijemp5tLc6vzFZyi2qZo3guGl/Uh/hO20TQPaC+28mY3z+T232b1WRxvUfwz1pS7Lxtt+m4Lhck0Mxlklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5665171836cso3799609e0c.2
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 02:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771236103; x=1771840903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwpdPffhWm62Ds9NyNo/SaQsJWiUgFomKDnAW7WiSg=;
        b=h1/xbFssjJ7zIW0VFGMDuRCmA9HMFOKGUExmb3mJ7+JTsxQ0gUfzwol+zvWyhBbB9v
         grs4SQGCPBz4j2ThgANaAWnQcl102eROrfNqtbuQqnyc2dhujhv5VU+6/c24KWgSqve8
         ijOVA6FN+pn6kYo+JUh++XTWqZRO4n40VDN6fbxaxXg7kAdhZYPVGORrhVD0DDuwAUJG
         JG094m6IYdYq55O33SduwahgxlzZ/JpPcFSE4avAIRzyOmHZ6Whjb849RBiXMJGYWHhx
         P/b3wJSHQizxfMSKaaYdRg5BCbqV7yJGj5Eh1XqhDwqnhSssuTQCPAGA1TYQyNpqUcxb
         lJjw==
X-Forwarded-Encrypted: i=1; AJvYcCVz39HGMv8ssulFMHzTHFlRVFDSS5I5jKZnsmLMRV0ggbr0CkPTOQxN58TnTtco8s4BPVnbjhWlGlRG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZFketx+ob+TuglCu3r2pJ4WclhJfQci1xbTJFOghygFyjTIj
	RxMXKIE8Leo2l4z3DdCis8v05e/rp1eNe8gsJLa4dAh0ZWv9fRcyA5vaZm0wrxWK
X-Gm-Gg: AZuq6aKp6IRbSuIH4nYVxmyKbEzMCxNheyayrnJR2HhgZMb7LqgEYNuV9ICzARhl+Xc
	h25/5LVdJ9rlXe38R+E4X7D4DQXYf3wk6zBG4ts0qS2wBeTcwzturiQpNsV7ftJaEGv7K6cgIiw
	LylA/PSxVwpYK7Oz7xdtL0Wv7Y3PDbXa8K1YUe5cHREf5gKSm0y1l44JnxcVqPk99JHa22H6OQ4
	RaKFiOVfB8LPCM4+WG8SGXOLDXj0xH7C5H+l5PTfLDeHQZOuYqb3Ddf2loN1SYxCROD3Lwr/Ihs
	PDZeo6lozkDAgeYs9ywCA7Cfkx91gnGPgmcqe4h6vl019lGDMmTmqcmUq+H9ypldkArHsJtwsq8
	n2HsQ+x8syVMIYjhpXLbmioH2ULkWivRu9hT1N4mpN49OJ+N6lyTW0+CDP1oBoQJ8Ow5CuJfmiT
	hOMTyvz+XU/36BEkNyT8V65kkriDOnpziBHtqdey11dpe5gC4jZGmmsTHRx0Uh
X-Received: by 2002:a05:6122:4d84:b0:567:44f0:b076 with SMTP id 71dfb90a1353d-5676aa23c8cmr3087917e0c.11.1771236103188;
        Mon, 16 Feb 2026 02:01:43 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bff0922sm7259318e0c.6.2026.02.16.02.01.40
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:01:41 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-948c3ce4d35so1758701241.2
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 02:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9z3s/InGJzUlnpyEtbCaUoFqkkz3BoSZMxJFwEfU0vCJ5p3Mm2N5mdjGpBU+6RYAb2QeqvDu6SM/5@vger.kernel.org
X-Received: by 2002:a05:6102:cd1:b0:5fd:f145:b88a with SMTP id
 ada2fe7eead31-5fe1afcd3b7mr3584435137.40.1771236100546; Mon, 16 Feb 2026
 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
In-Reply-To: <20260216092914.kmvl7aep7dantcsd@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 11:01:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
X-Gm-Features: AaiRm50a7dRj7dLKtMGILEQb14-VkaVzM5nFFHi-S8Lj08OYuJXTfF9bVPV6HRk
Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
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
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Mon, 16 Feb 2026 at 10:29, Vladimir Oltean <olteanv@gmail.com> wrote:
> Then there is the fact that local definitions of devm_mux_state_get_optional()
> keep popping up, possibly in unrelated trees (not the case here). This seems
> to be a bad practice which should be discouraged during review if caught.

This was done on purpose, to (1) avoid having to make too many changes
to the file when a common helper would be introduced later, and (2) make
it easy to find all locations where a future common helper could be used.

The alternative is to use a completely different name (which is thus harder
to find), and having to fix up all the users of that name too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
