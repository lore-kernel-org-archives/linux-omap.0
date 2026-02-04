Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA2306487
	for <linux-omap@vger.kernel.org>; Wed,  4 Feb 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191314; cv=none; b=kZcPwrxohkqm+vNm3L+oEjk1uce0z/nETJVPgdTW4th67aINs9GLn2HypFBXchgp43MVy9fD7NGgvLAXgEaIqFs9NWhhCPkDRdmrVFbBddVK2PBIPyLd2DZT/STEfXzuh0/qOLM0NHNh2iC8UCwt3ApA6foczG7KiB5ozNIWM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191314; c=relaxed/simple;
	bh=wD5KQf4PNdjpQpaRREtiHsDRqlXZZrXVKaVHX2VHgdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw5I36fkU1+dlYfxIdRKFaJelQ7HxFDO8yE9W0AEYEF0SXATEN+LjVHTV5pC1qsU+XddAyd7esuqlczY/nG3485JEExeZZlR7e8vQsGU5MwmOLA21DKI8J2v18Xof+9oKatJCsbzOn3mq1i+JhSvphA5SCyaFJMx0OE+/2mhSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shkmpq2L; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shkmpq2L"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6a50c17fdso690028585a.2
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2026 23:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770191313; x=1770796113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFAyxlb4iCSkPw1pLsAtumnvdjzuriOCYM9dwXAoQ/M=;
        b=Shkmpq2LuKv8IL8xqTHIK5egDegoF4FBsBROO5JGUq7OKaOWNXAmb38RmX3EGk28cO
         basY3JEi34lrf4LFB+aAhiuzaAV4ns/U1pZfa6dDN8+pHNBRxOqt3fPirrDTkGIrIDv3
         sMAWKnZZdnDhwcbBGCqPgrWdZFYzAn0ET2Q4KXI/YsCLPc71tQCtg5mgOz+QG4Uo33YP
         9OojW3PVTmi+ZtHqjKYcRNvAwfBcUyZROxw8wqpheBML9DwSM6fMbpXDc8qhj3YOk82l
         l82cDjvlPXgN6zbGQtNnKqgbiayGPw2j+4dH244aHnR8RRh6cBWycMhJ6v3OfFamfvRJ
         8SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191313; x=1770796113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vFAyxlb4iCSkPw1pLsAtumnvdjzuriOCYM9dwXAoQ/M=;
        b=haNuQiMnqpwS5OI7DRjHA2Yddvqtr6Tg7i3pD6nbHH7fD1OndW09UdO3N6Y9DcG7t1
         FgvqsCGG7yJdTL2txs87gSNIZMk22pizDFxG4nN8U+sn+hEnfryAkVSd1yOTqCckwGuR
         tysxHRWGRJeuoTPSxqk9JeYMwZP/+w4QkA3h/xr/SGSzPFT59MaiiTA+1O/3qvslZls+
         KwWAAM3i/eCualDld8GDJ5mcpzW5x64UXAIZwTn2gt8v7ERCzpZ6PhT3tO5I/LwYtbJs
         y2Nrqz+uloFJmpZHQwsWK7YsoTIGeFpUuS+Ln/TH1eqpRmXk7fNTE4/XwvyyZeJdWctY
         tYLg==
X-Forwarded-Encrypted: i=1; AJvYcCX0hIk/yESfMERe60whNvWzLEb1b1BfFzKY6xIhb6zjzC5EOa/9+qiewtbZPVpNyYdkS0H0+5TYQLtl@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsSTZQRsWlovtL1TcNj/ChVBF3EPHVrBWFIrMAHRsDaQ+j12C
	SX6RjldJlApyRkx+fQaSWU6Yw3QNd/VvM/YB+BVLSRmwg9ek7dXP8udf
X-Gm-Gg: AZuq6aL2DXFbKXjCOoq0Hi2mM41CO3VPQdzc3PL+ZwFE72baJuWDVeQLL458Pui3uvk
	9bp9fWitgjCE7DEVtjZQ5/BujrooibGMrKsoZuSFRb80qnY0I09bSQCh3yahGze7W9XiJSYqPvL
	5+xvajWEX/6iD0aQgkXDrVcEtA3/nSVGuU4eUJ1E2MgSG9tQHeAoZcI7/3PPltgX5M2twRchjoF
	0PizUnyAipEG2+yY75waCpYobSkFKqR6/o9CLQm1RkKAP7CjIsJ5bjoRPXfismDDeDcFoHU9Hwp
	sUB3XfZ1NdAoyFUAp7yhxCj+sMPqd5nCOGEfOU8pUlH16tth0oIkKltBKiMdOsZJyXlyjcSSKVr
	Ef8IE4ZXRtAZju4QJ6/qQEuKr9zyETywRaBLtUsoMtHFMAxUoJPx0Wgn/kzwHjifpldFZCMrCJ1
	9aAxg/uLr5K+U86yL8HK6bXeaskCa/o1nX8fTAeDRb/mZmnEVUpq+XCFWqJvl5vXDCWghkUzI=
X-Received: by 2002:a05:620a:f15:b0:8c6:a539:55d7 with SMTP id af79cd13be357-8ca2f9cea3dmr248741785a.55.1770191313409;
        Tue, 03 Feb 2026 23:48:33 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521c19923sm14215576d6.23.2026.02.03.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:48:33 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: andreas@kemnade.info
Cc: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	bavishimithil@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de
Subject: Re: [PATCH v5 5/8] ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series
Date: Wed,  4 Feb 2026 02:48:31 -0500
Message-ID: <20260204074831.300311-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202090408.4c3757cb@kemnade.info>
References: <20260202090408.4c3757cb@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We had the discussion. This should be done via pinctrl irq if possible instead of
> specifying WAKEUP_EN here, You had some trouble to understand how it can be done,
> and we agreed to add the wakeup functionality as a follow-up concentrating just
> on that detail and for now just remove WAKEUP_EN.

I think I may have understood what is to be done.
For example we have 
pinctrl-single,pins = <
	OMAP4_IOPAD(0x0bc, WAKEUP_EN | PIN_INPUT | MUX_MODE3)
>;

for wlan_host_wake, so the change needed to be done is from
interrupt-parent = <&gpio3>;
interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "host-wake";
pinctrl-names = "default";
pinctrl-0 = <&wlan_host_wake>;

to

interrupts-extended = <&gpio3 17 IRQ_TYPE_LEVEL_HIGH>, 
			<&omap4_pmx_core 0x0bc>;
interrupt-names = "host-wake", "wakeup";

and remove the pinctrl?
Similarly for all in the omap4_pmx_core domain (wifi, bt, i2c as the
drivers support it)
No chnages for &omap4_pmx_wkup domain
