Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9D2F25F3
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759246; cv=none; b=X90O0f1/sjDs/O90PyWdDwX0ucrOYBGG4h9lK/wMh1RYsBX9xxsB8Yv2YIO3El3MG8QBySWnGnK4712UJwN/g76YmitQuKLAwGaH808IVKrh0MLOi1A8jEEHo3CIcffGKKW86UGoPHxMpIs+3hWkZfKNjshW0UbHZwAj/HOBpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759246; c=relaxed/simple;
	bh=EirEtk4w7F682q2IM7vbLDYw+PYMDpUGY6uN0GOHS5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTxSQo5bkIs74JRre5KCz797QHGnOw70WqJ9UCdGGZNA3jUTSRXJAQO2D9pfbPq/m2L40AecKPdBTGrGL5Zvf3D2VDszRXeuStXo/P5bpHh+RJ5m0XgBBI1CGaDZxYKJYbc5IfN+zkVd1H5Al6E7D/YrQi++qu2qYiRSgd3oXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PgPyyaQa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PgPyyaQa"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8297c035d28so765559b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772759243; x=1773364043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kRcXgVkSQhw0XQs+BeJwsxiCbRmgYGK7GY+i24Yku0=;
        b=PgPyyaQaexwc/WAwQMMccnzWgjuSPQNl6tb3g67+GM+Mm73OCpGm7HXuZllfMHaqEb
         TIuqM4rc3mNCXA3t/FqjH6C+GAG4b2x/AiGQcgNpsab3s1ukf9sjKpK0OQHh2cMR7PwH
         pAgLKTIpPlaGjquyii3zcEQaZZLJe+NTP2qMAm1N5lDSuNGrqYhLY6R1WMpziDzQitIL
         scR8TaGOmcibED8MJOgSZAMe5gblSPIIlDsOrYAbcERHSPzGk9sHn5nbmCCvWpLraphY
         YyresnUw166GduINLkA/NaiFu+TRAU0b/q6v/3NiNxNL4eEJ14emvYigmSmSt1LCWZkU
         V9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759243; x=1773364043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kRcXgVkSQhw0XQs+BeJwsxiCbRmgYGK7GY+i24Yku0=;
        b=TESD5Tx6DnW7oIusLld/XSeIr83V+wi+eOZy/JCHgiTHSLHUNvuTMv6dO+oDR/EZfi
         3MSONCmYoKRodrPbtbOHdqYv1PJRiYHG2lpDSzpKI5hONdK5sW1chK231ZpL1umJ5Ofg
         Ig7GSatUeY59R4anOkNi4lvJNRAeYpyAAgSsHOSkk8WRNt8j9B20WoZeugZSOqtIdVML
         mKu4lhnhdA9A9F+hlRYutN5GPJl1Tx+zCS/9bJM1nf5poCjeGdHXIw9dwPbEwZHooZ7M
         1J1IkOSJZ62YrEWPeA9O/oU+oZgTeCM60TkuJZvIjXYbEps+3NcRaJgbEIlDygOrC8oU
         z4cA==
X-Forwarded-Encrypted: i=1; AJvYcCV2VaVZryPE/UoVW9b9Jawt25QvbyS8iu0pjnQNxiHNhpyrX6KcYB5DeCqcmhBWv2u3gTAjNjQSi+1S@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9189lgVmjjfEmM0pbrFh3ZjLG9KnTvGo3Wrfafok08W0FO/UZ
	mgFruKLPUmrls4C0iO3Wp1vE0LLeg82zQri+YEoExGx2bEOdIz2YSOclQj4FCb3YC2E=
X-Gm-Gg: ATEYQzz131qKd7QVp0tFCWdkyq4JyhFKDNO5aMgYMbRXWW8ZgaHjzypGmdI2Lm5QKBl
	4RDnwb0CpXsnoEJJ4V0LhuhNgW/psvA0YeyVn6AdXFg7Pd1KuN107CrzfuuNrDH58Z2Voa5OGZ8
	+KIvHACn9bcQFYQk4V79n6JFHy4HmlQ6hshjLWBsvJXYs67mfJRSNrks2p5JGjdrHcFQCk3KU7x
	nciTUNghuDPTDiEJufxLCMD2TBxMVEan6rPxYw+FuUGJGDroMoqc2HJJKM8V7QtJBSgzmdnmM/i
	fghBRj+XZWqP37ulVPIbnKBnSFkq0dRAy76yxuf/fdju+gTPsdlG6POodDIgjVdYn5QRruZy5Ir
	mxn3k45o2ANgzVlS1v5pSeKhltd4QcOcQOKZL610zNKehaEeeBT076KOkpTsX49GuVbu/GJAWBy
	SvhvCmv6AJjGPLH4L4W0x4
X-Received: by 2002:a05:6a00:1a8c:b0:823:efa:a657 with SMTP id d2e1a72fcca58-829a2f6fbd1mr253851b3a.40.1772759243445;
        Thu, 05 Mar 2026 17:07:23 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a010996sm22242994b3a.44.2026.03.05.17.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:07:22 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, airlied@gmail.com, andreas@kemnade.info, 
 conor+dt@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
 krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
 jesszhan0024@gmail.com, rfoss@kernel.org, robh@kernel.org, 
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com, 
 tony@atomide.com, tzimmermann@suse.de, andrzej.hajda@intel.com, 
 Mithil Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260303203017.511-1-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
Subject: Re: [PATCH v9 0/8] Initial support for Samsung Galaxy Tab 2 series
Message-Id: <177275924237.1445909.16957765309928368128.b4-ty@baylibre.com>
Date: Thu, 05 Mar 2026 17:07:22 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Tue, 03 Mar 2026 15:30:09 -0500, Mithil Bavishi wrote:
> This series adds initial support for the Samsung Galaxy Tab 2
> (samsung-espresso7/10) series of devices. It adds support for 6 variants
> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
> based on 3G and WiFi, but since they use different panel, touch
> controllers, batteries, I decided to categorise them based on screen
> size as espresso7 and espresso10.
> 
> [...]

Applied, thanks!

[1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
      commit: 3b142fdcae780cb67ab4cab61cf71647e9566411
[2/8] dt-bindings: vendor-prefixes: Add Doestek
      commit: e17a1b049128274386ebcc9bc88e2fe4fb81a4db
[3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
      commit: 3e375496c6d0f8c506afebc7de6bbfc392a6de00
[4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
      commit: bd861514cafab553b7b4dcc3b436a8036c90150f
[5/8] ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series
      commit: f768d54723d13a10e7c7556aeb6087e8938f2951
[6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
      commit: 9b2ee6dd895625155ad90c2430e85e9a8885c2c6
[7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
      commit: f1bf8f53355411d5afbf0421b59c7218d68e081e
[8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
      commit: 16dcd2c7535ed09e97fc075cad97814f0e8968ed

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

