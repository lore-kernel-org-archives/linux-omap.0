Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D197434991
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896416; cv=none; b=ED9v7wXKE9tcb6xqTdIQV3nrjdyaiI9nh1u8r/LcIO1yB1+fN+C9GqnfSxbEQ4UPCVwulQsjTnOi0KT+iaGlfetfGtXZMTwusAFmzXU3gwZzkui9hR+qMlLVWy0bq1t7wcqToHdz1MMAfu/nu3LDGuAxVpjRocqJTw8wfBaJmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896416; c=relaxed/simple;
	bh=EsrGjrnP7IgSiDLJcakyY4ms71wqAvVcdyupbrs+ipo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVu/PJzsMQPieE8tdhJelccEaRZq0iSojp1+5aSgGutDHqPNk1s8i21DQBzAEOvfeiwHSoAA+HDx7dfGiFftzsKzJqiuqd+fDdwN/1n6+K2ouqG3qo0S7lj2ePMBda+z7U/kosUnVLCUfPFSBv3oR6qg3D1nnCT5xSdx3M+PovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEDHWMJM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEDHWMJM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-485850cf499so3342373f8f.3
        for <linux-omap@vger.kernel.org>; Tue, 08 Sep 2026 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788896412; x=1789501212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzP/HtSzvmP6ZP70XBuHWUc2m2AKpgco5yULa/5Kmis=;
        b=TEDHWMJM9duaytD8JkqocezS6iP42AtBh5KBUdL6VJfMAo8G72zIpPgMijD++58Po0
         YwHwizi3QVSNbvl4pEaWbB6M+s9YZwMWDOxMFtEILOG/FKg4VCuHJvoiejsBGj/B8ELd
         M6MBENKrWZ/n8I8xUJVhLId7XCco84KBIIBd6Q3NUTtCaMHVeFeMf1doV9F52xOheVWd
         ZafumnTzVsVcJ//LRyR7yjnBPr1uq+kT7RtXKWt7YOL3NTbu2nSpJmOBbctZl8f7VUDn
         MHay7jF4KqXdYWKswO4Url/5cuki37cFsHDoyppV6YdOQGmyHB73PIIkwYzxyZ1J62Ib
         xNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788896412; x=1789501212;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzP/HtSzvmP6ZP70XBuHWUc2m2AKpgco5yULa/5Kmis=;
        b=BqGIqNuM8YR/A6zYI/tZD47AT8FijkNZ4g5saK9QrYK57sRKCRVwQbT0qMAD8PjR9S
         TV68JYWDZX9RvXPaUZVIEoPbX2Zw1dS3eYT7pvDAOk0wFmfZKJ9vWUSuLirFzsO/48kX
         fDhW3LuGDjHNgAzFbRhMUnTCQC3B+Z6mN5EJmCVCqbePe2X+GghLjJygXirRTDXQYvh5
         gh74wkSDkhIK39uhGwlCLplspFcXN5MvvXo6TJOg03SYOTMo0ko3idRFrI5y5BICZI+j
         /zc4SEMYQbGthZVdkMqZPMZI/SjNt8NIG4+B6MnaXQeVBY2/wPxy34Nog3TDbcXLRy06
         E2RA==
X-Forwarded-Encrypted: i=1; AKwUvBxAlwdDp5CMMMNdQExmitmrqp0OjZL6ZixJ/AdY5LO6BdNlQvjlgqXsawh5CnJWF/smyjA1lb79tQrd@vger.kernel.org
X-Gm-Message-State: AFuF++nhRa/5OBzuxv1L05PmaDuK43Zv+RgxJ1ui4rVHEds4k5KfqtSl
	MDaN0gOOo4NNC1S+GNnQrl5AX5mH4zlBdeQY3r7/WqRuK8y9/5UMk70K
X-Gm-Gg: AYBFou1tukLPfGzJVWXupQ4asCkKQmIiCK4kp97W63erk7kNTEPdqi1SC81ZSdzDmy/
	FNxuNkc/vk3deTqtq4oESrkYplSLJt4Z/D4QyIPF9TjAljXFdoLfHa0cAKtH7ZBT+rmYRPC+jQv
	JWZfxspWueosRoJARGZxYi6HE7sdDoP5SWVSvNrSq2tkvNo3gchm96lw4ndyGhFBHquL3o+CSs9
	IAvPYZOu/NxQQGRfFK1/Dy1KuOGvfUZTlzN07JrhHSKBEEKKOxZvwp9wN65qtQUIfPdP5mjtN1U
	aOA+cU42tpc3b8JU3NjY4rZE+am2lvxYbt4hcIzKbVFF52VtGfBpe87joS6XFmxzsI6mh4usuI5
	Zpx9gKlUIjupnBELDl5/Fdt4cX3i1oC/StofImNJ7QvxWL0FSVhlr2cPU3C8K76l4/ip192bTq5
	piVYj5moFLM5i9cqxe6rsjNFKx89O2N2ax4WcfUIZFmeGkilJmt+rUH0RfbhtBcM4cZsOj8SygL
	CpaySMobTzDkmpX3AFsLWxnvUQnpzqftodoW1jbZeJPOLixDPdzY3J4ViuIbHODutHcxeR4nzku
	AJ025AXVjjnb4eIQ+vqq72wy
X-Received: by 2002:a05:600c:a087:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49cf825a75dmr321721005e9.15.1788896412155;
        Tue, 08 Sep 2026 12:40:12 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc1be3sm991795e9.4.2026.09.08.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:40:10 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:39:36 +0200
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
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 01/13] ARM: remove sa1100 platform
Message-ID: <aqBhF5oS1A2W6dAa@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-2-arnd@kernel.org>

On Tue, Sep 08, 2026 at 05:27:51PM +0100, Arnd Bergmann wrote:
>  62 files changed, 19 insertions(+), 10501 deletions(-)

Note that Sashiko skipped reviewing this patch, because it exceeded
its current 10000 line limit.

> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> @@ -275,18 +275,10 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
> -	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
> -	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
> -		info->rcnr = base + 0x04;
> -		info->rtsr = base + 0x10;
> -		info->rtar = base + 0x00;
> -		info->rttr = base + 0x08;
> -	} else {
> -		info->rcnr = base + 0x0;
> -		info->rtsr = base + 0x8;
> -		info->rtar = base + 0x4;
> -		info->rttr = base + 0xc;
> -	}
> +	info->rcnr = base + 0x0;
> +	info->rtsr = base + 0x8;
> +	info->rtar = base + 0x4;
> +	info->rttr = base + 0xc;

This drops the layout switch but keeps "mrvl,sa1100-rtc" in
sa1100_rtc_dt_ids[] and in bindings/rtc/sa1100-rtc.yaml, so a DT with
that compatible would now silently get the MMP register offsets instead
of the SA1100 ones.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> @@ -614,16 +614,16 @@ config S3C2410_WATCHDOG
>  	  be called s3c2410_wdt.
>  
>  config SA1100_WATCHDOG
> -	tristate "SA1100/PXA2xx watchdog"
> -	depends on ARCH_SA1100 || ARCH_PXA || COMPILE_TEST
> +	tristate "PXA2xx watchdog"
> +	depends on ARCH_PXA || COMPILE_TEST
>  	help
> -	  Watchdog timer embedded into SA11x0 and PXA2xx chips. This will
> -	  reboot your system when timeout is reached.
> +	  Watchdog timer embedded PXA2xx chips. This will reboot your
> +	  system when timeout is reached.
>  

"embedded into PXA2xx chips" is better.

The RTC_DRV_SA1100 help text a bit earlier in the patch also still says
"built into your SA11x0 or PXA2xx CPU".

Thanks,
Karl
