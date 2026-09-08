Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0B3B5303
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895366; cv=none; b=pnW+DWOtvfRqo/ZNFQSbz5g61sDGFI+QLTFbNjohmWfT8o7dp9Y0rnhrQdt1aC98c0dYT+IjGnZ8C/ZBuXrwUSUlzXbmZSv093fCA6GqqZpOTHQW9A/drWirF9M6PZlZWKzlSL7VflVyeRNAtizsSsXGxH07pSgtPKE+k8pyRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895366; c=relaxed/simple;
	bh=BL1RUYoOl+2DCnnljwHrTpWKc1vt3ozShPXUSpVHg8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0z5e6P+ZXc9tKsg6ZhI0OZviEbiiWQGjt2yAgxjFfZ71TEfIThT3GrpgtHHSZ3FLKZnG5v9AZeEoYiX9gyuGP8HvhYpV3sD2YCiaGKwZSgpIpaFOlLKg3gtUXQ4j+sZ3B4vCTSj8oriQtrwm6pj2wPlIheOWwASKR4Lg89MI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IldMupf/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IldMupf/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so40582495e9.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895358; x=1789500158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
        b=IldMupf/CXO1fJhcChwVffZ26pAdYEuJJo7n3NchFgpe6wbStMGfI4utvCihSq3+Mx
         QfakSVaL/MJcsyxLgiVpLhVZFiyd8ScB3t8IUALrvbnZWyWN17avGp9xQ9S7P4++LXdU
         LUlfBZMoh7BO7j3i9dt1eIczOoUyh6xGljMyldbvy7aZbl9McjsggHDOzBBQdaTDXM7h
         T05dJ6nI49n7G0r3JT59zHl54FDUVXNFF31hTE4azXp5dODZo1yxFt83JcwMmjJUyP59
         wMfR0iaSQSzgKmfqD4f+FZODJ2rym9Fks8lUDFHOufvKk5rwLwpiVRfU7SdRzD88aQWa
         rObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895358; x=1789500158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
        b=BFfWPfjIG1RevEYp1q0fe8lwPq0f7n04g2Q8ktAVKd/bERp+4V9c5BYCchDiQbJCcw
         AUuLnEoFOaAklUSsEsgfxIom0cp+5CnheUzY0F5NfvOSiPCCw+aUzuklIsOdDO5LtDsO
         Yfqet9PuGciAYA08nLNNKEgXhIEPhprpxr4Qc1vT0fO20fTEMgOUOuJGXBmJxJTHLKZG
         Ii44T6vFyrTW5fSDERj/0/3i6aNkJ5RwXMWFVojmgXI8ag7hDGhz5wOzX23VDOL84r1q
         fwdH+Q3pjF9VdlgmTb7rg3U9wQZX2N8dheV92zfTuWS1ipvCsrO9vDTynBDmnvBvmkkL
         OKhg==
X-Forwarded-Encrypted: i=1; AKwUvBwQduyzMn36JfQwb38RnxZMDAgYm5vc0QI72EYZuG+gNwz4i1vtt7hjERr0V9CGWnQZiSPtj7gh0AiG@vger.kernel.org
X-Gm-Message-State: AFuF++lDR5Atw5a2RnYJ7FG2I2kXp2yuvQBPsGrWMxjdCtbSp+ywPag0
	G/jQ8RQYajckiKViL54X+2eJYsJMJpZn9kEJlMqnvxELMv1zGmOZYVjp
X-Gm-Gg: AYBFou2bwWxW5AfiKBEXoSngW9xI8rUWT4PQrDRz5HgAeNQrbKrtdeIWCcCKoO6OnA5
	Q701dijJC1+MY9lch1R2wlDO8h1BVbJaaDKt43pF3Rr7QHyFBorN+7JyaCKJzOUwkfQ8tGgKIwQ
	0QPNrDTJAYXg+gGgnREAMnv5ljAiXz0K/teFYn30PVPks0ELasFW4NGbd1YhwNewCArX7xRgh27
	1hHNZjevgI6xSrIsiQJLlJh/dHo5FOOxxNnfg/+VbkZtRq7U9Ss1lk9Hl/k7sPSmScdJV83jS95
	u3Pb/NUhxRA73BSn91lVb72rfNCJ2TNtXOOmcFFpZgOa89dAkLaFfmiGVl5XYiqm2DPkC/FcNDJ
	EWhpXcGfwMbLgqhR6O7skySiV9ur1OYgMU+/rr94WiUl+TYUwLQ9JhfNuyw92I7g3537JMSPHRC
	tXywACaVucHJIhstyRBKbdCl/3HsxEciHw5GHUgIKuIvybMEX0rAMKjMSUSS4/GFAkTTQJP5glX
	fefUc+kK0ePyDExWwpFjYSJKirDUn3GjTrG0s4ZyXLj6TQ+zu7Endo0yVZC6CgpiXBozHWMN69/
	YHSSqgXu3MCj+R2rspXOclWcVxbcPA==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr157041045e9.26.1788895358151;
        Tue, 08 Sep 2026 12:22:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm38080321f8f.1.2026.09.08.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:22:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:21:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Shawn Guo <shawnguo@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Helge Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
Message-ID: <aqBXOemS4boakDGt@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>

On Tue, Sep 08, 2026 at 05:27:56PM +0100, Arnd Bergmann wrote:
>  86 files changed, 60 insertions(+), 10696 deletions(-)

Note that Sashiko skipped reviewing this patch, because it exceeded
its current 10000 line limit.

> -CONFIG_ARCH_MULTI_V6=y
>  CONFIG_OMAP_RESET_CLOCKS=y
> -CONFIG_ARCH_OMAP2=y

With CONFIG_ARCH_MULTI_V6 gone, CONFIG_ARM_ERRATA_411920=y a few lines
down can be deleted (savedefconfig drops it)

> diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
> deleted file mode 100644

perl scripts/get_maintainer.pl --self-test=patterns now warns:
  ./MAINTAINERS:19896: warning: no file matches	F:	arch/arm/mach-omap2/*gpmc*

> @@ -560,13 +533,11 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
>  	 * We still need this for omap2420 and omap3 PM to work, others are

Stale comment about omap2420

> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> deleted file mode 100644
> [...]
> -void __init omap2xxx_voltagedomains_init(void)

The declaration for this is still in voltage.h.

Thanks,
Karl
