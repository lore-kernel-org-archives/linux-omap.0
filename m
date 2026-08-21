Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323A46EF9F
	for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307748; cv=none; b=PbWCfjTz61tzEOJ/StSNBmLsIevtx3BewBCcjZjlT2qUER2TTnWIEyyQQ2u/MgEpsV/KpWnzoCGHYWi1utugBabqMMOpNk/R/9VTR2luvXvmArk48E8CAe8U+yjg5JMINI2yDIEzQ3vGmFYjnwfbecMPLg9eFI+lPr2CHYvcbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307748; c=relaxed/simple;
	bh=TajKrkP7iAilCm/Wf9qOw7yL7OS5AMPI8Bf5cDTLAK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=OGg5RsE3DPft09kJldm+1ofctBABTR8UKubuhG+XMHMF56ln/axY2kVtA3Zfxsc1fWmvqATzrSV11Ca7vb+aBxZq1/KDLx9I6VLsIZ0Ob6s9b2m1/idUDm39CpRyv1KKc0CLvf7V+Qu76erjYhQlbZ85l/G5/5b3nvpMZejRWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfb3347dc4so728957e0c.0
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2026 03:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307741; x=1787912541;
        h=content-type:cc:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZ9qFWwtyy0CyLFBazZArycje1mFKlJigB1GC39CAP0=;
        b=Vd8j580reLwAgpcmMmg7TiVHjs9585nbNKQp3krf/hZyZASvBVhf3quMDhdp0ePG5O
         /OQA/hsgpp6lBwE0bTi6adE6QKPy/+xm7ZQn0sBldBqgXZoHAifJV8+fU5uTwLdMDxhP
         f46dnSZIDprMvDaoEBAZfElUSZ4R55C1zYeyvgc+PjaQXAKEeZVK1x6Cu3uQqSKrCelL
         9nJBFZ6X/1kl/1NmANolWpIXhKeK0g2I9EPe5XVcuvXzh9tM9EfEZds9OZmP+QacosjD
         lytwcPEiyiSKAsRBn5td83vN9c7Mx0VRJDstckiCCA/Ci/kb1B6frxvajsQ/FAihh+Z4
         lbEg==
X-Forwarded-Encrypted: i=1; AHgh+RriGHGKGJD55/plKdUpkZhlCJabaF6ti4yQlHo7watoyJXxL6GD4Ewuyg0MIxrT9BJH36Uqm9AGRMgA@vger.kernel.org
X-Gm-Message-State: AFuF++njboc+bu8ZAqPUKAWUzbYp81icUJU4AY+FicFXHwbp9MCSxLDh
	Nt4pUZfAL6/mmb0hPWkjjxHUGRcOEYBOyeIYK7lIhYU4TIpwQwTVIvxvvtyE+2NF
X-Gm-Gg: AR+sD13Pgw59E4i9V2nL55Ughu7zHKlme0g8pDTxgPbFH76QgoQNjmxbdXwmuyq5ZGv
	tB5mvp5EJ9JEd2uOmhhyN+WiZUZMj1+iflrD9HZ7ONcHGPlDwtMUczqar1ug+V2Mvnzxj1ALtF/
	gcCXPAF+N3Fv+rK+LZ3prUZ9u2dxfGlApnNXya+6L5J1l7tFlgO8b6mCSonXffbxU0YP0iULGlE
	6Fmw/AkaYBQseVMGPvhE5EdtrpUnPKCiFVgPhWcgCc4VexqKh9KB3QxWe57ZA3dNl6D/S2N5IKP
	VlpB/7HdYEJJRRggRZuwc1zfdBbqgejiX2C43IV3r/Z/nccZNgQgzxDZWD5/4wnN53yyFMM3AH3
	f24PW3r1OJBu6B50MUlSZ/joOcwe3sw14k31faato0d+HlnIXGG1ihBE4FdzRFGtFNwxPhrIkOl
	bOJIjIah1wGML/8H3iatVZA3ZoLvEiZP614DT/WJRNbSPHbAcK57GPkH+iMTMytg8uayfNR+j4u
	E3OO1XvvVWQd8kyZcQYTbk+Qb2J7azKWVOQ
X-Received: by 2002:a05:6102:41a5:b0:737:bfe6:3b03 with SMTP id ada2fe7eead31-77a637411b1mr1946894137.7.1787307741054;
        Fri, 21 Aug 2026 03:22:21 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777dd4a7211sm8428429137.7.2026.08.21.03.22.20
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:22:20 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-73b909fbb6bso511716137.2
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2026 03:22:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqiK5ISnxJVujYaFRS8ElnlHVkdqQ3hC9IEsyhuRKW/YaTAIDaHHYicDZg2hojUXgYcEcmPPOUJyHpa@vger.kernel.org
X-Received: by 2002:a05:6102:a54:b0:74f:4162:3f58 with SMTP id
 ada2fe7eead31-77a634443c4mt4161026137.6.1787307416387; Fri, 21 Aug 2026
 03:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787165329.git.geert+renesas@glider.be>
In-Reply-To: <cover.1787165329.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 12:16:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
X-Gm-Features: AcwNN1XMP476J77X05DStUZ6YHTKoquM1cTbXZSuVIS6ygsja8ReRo486qzyWdY
Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
Subject: Re: [PATCH treewide 0/5] clk: Make sure clk_init_data is fully
 initialized (part 1)
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa <nuno.sa@analog.com>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Sunny Luo <sunny.luo@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 21:05, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The clk_init_data structure contains three mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  When commit
> fc0c209c147f35ed ("clk: Allow parents to be specified without string
> names") added the last two methods, this was done in a
> backwards-compatible way, using a priority-based scheme:
>   - .name, .ops, .num_parents, and .flags must always be initialized,
>   - if .num_parents is non-zero, .parent_names must be initialized,
>       - if .parent_names is NULL, .parent_data must be initialized,
>           - if .parent_data is NULL, .parent_hws must be initialized
>             and valid.
>
> However, not initializing all members may cause subtle issues, which are
> only exposed when CONFIG_INIT_STACK_ALL_PATTERN or
> CONFIG_INIT_STACK_NONE is enabled.
>
> Hence this series makes sure all members are fully initialized, to fix
> such bugs, and to avoid future breakage when converting drivers to a
> different method for specifying the parents.
>
> This (small) series is part 1, and fixes all cases that I identified to
> be real bugs:
>   - The first patch fixes a crash I saw on BeagleBone Black,
>   - The other patches are only compile-tested.
> All patches in this series can be applied independently.
>
> Part 2 will be much larger (touching 185 files), and will fix the
> remaining cases that are currently harmless.

FTR, I split part two in 13 subparts, per subsystem:
  - "[PATCH 0/2] ARM/soc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239869.git.geert+renesas@glider.be>
  - "[PATCH 0/3] ASoC: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239902.git.geert+renesas@glider.be>
  - "[PATCH 00/45] clk: Make sure clk_init_data is fully initialized (part two)"
    https://lore.kernel.org/cover.1787239813.git.geert+renesas@glider.be>
  - "[PATCH 0/2] drm: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239944.git.geert+renesas@glider.be>
  - "[PATCH] i2c: bcm2835: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
  - "[PATCH 0/2] iio: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240005.git.geert+renesas@glider.be>
  - "[PATCH 0/3] media: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240035.git.geert+renesas@glider.be>
  - "[PATCH] MIPS: Alchemy: clock: Make sure clk_init_data is fully"
    https://lore.kernel.org/3610b51df642abb1fbb39f5bd93fddea43f8f164.1787240060.git.geert+renesas@glider.be>
  - "[PATCH 0/2] mmc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240090.git.geert+renesas@glider.be>
  - "[PATCH net-next 0/3] net: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240118.git.geert+renesas@glider.be>
  - "[PATCH] peci: controller: aspeed: Make sure clk_init_data is fully"
    https://lore.kernel.org/48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
  - "[PATCH 0/2] phy: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240165.git.geert+renesas@glider.be>
  - "[PATCH 0/5] rtc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787241693.git.geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
