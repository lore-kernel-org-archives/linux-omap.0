Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510E308F39
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802575; cv=none; b=P3z3dMQA51biG0HldTTArYGSwrEsuLOBiX6Keloy4UGn4dC0TvBpSod2SnB+2dkjGFsN3H0LBX9Rvb5Z4W2MzTPqlD1Kc5uxa/TM4G7xhFRrHDbinUMfn1P8jshP25FYxBrChXEPEihyG/Kb3LtPZRKmUxxJ1+Bq9xjuhVDS618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802575; c=relaxed/simple;
	bh=yVMP8UAtXlu981/AZfXfuu6ntdCZq3l09RETxP3vnIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nftS9i9zgV6tWRRoU+AiUAhq2LF+yOZira2nx1mAZi40WAuH4HZjEdjSDEnblkn2DgtnUmF3ithbLjVm+APi/qKOHO5Nt559lB/k+K3r/TgNewx4qasUH3wvkwBUznGLGfa3ugd9bWxwxQ/7HvJg4LTYSDbd1zC7iuuU5XpN3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqgxc/IL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqgxc/IL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b1710405so9299625e9.2
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802571; x=1784407371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDpn6H9slILEKuaZA30ay5+GU6mS2ER9t41k8f7Sm/c=;
        b=Oqgxc/ILhJbdZLdffAL/Gx5QOoL6JDhumNO3glwYxoqTfqXH1XFbpVBxn9KEUuCOP2
         Ca2juNqV6dbJZb+fDeGFzBS7jKceYOeJbtg+NstjzdaQ1mkA3T81KnHDEu6qcPG4bsvU
         G20yAO2J/mMz8enqH8rsS/LTRjXej5DN6dhKptOxXsqaZagV6FeISGFjpsdXxwppvmNv
         M4Rj/SDdtnPtz3/Bchld4+bt9yyOs/WKHfn4v7yPVve3WuKo9hyBB976i0ksOTLLhPhN
         AXwYPAYt05YGrNHILHz0I4wRUBsCaZ8EdjfGgfMJLa0CJBDOwkebBLSUOHT9B/r8Ohcc
         p3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802571; x=1784407371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VDpn6H9slILEKuaZA30ay5+GU6mS2ER9t41k8f7Sm/c=;
        b=BXsAh/I0L4PgquTY3gPCiruQ6/XuEquy45zFCBO/YRL5APiaP2tWbF+m0zIAQhVGzy
         BwWlA8OM6SN3DuBEzuH56uwb+A6+PAHk2GsUjd3pvTC0yTyQd/z5nOXRks2m606lf/hO
         UQU4QVEbkrMjeACYDgzGT7R/rSl5QvfOg5e2hteh6a/KW7KOZ6EB3UK4RQhHL0jVil8C
         gxIk6yZucHEP/MyxbJipWQSJVZcOul9tGlq7hPEWWNcQboMrX7qpdoXiepExng0jqMV4
         XCb24w8CW2e47zvJp91rEYMSCOfsvq+w/zVuOsJTI9c8IVGm0b0CjADgS/oZLW6sgItz
         /91w==
X-Forwarded-Encrypted: i=1; AHgh+RqKzwic8YchDt2hM4xZLj8n4QJ6ixhIZ1mWyaBZlWRuew/QwzHG83ms6HW46KxFBN/hppdyB/8m/Bk8@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyT1+O9+rQxcNIl4fHxM2b6FMXajr6dAgYBEC5VJu7A6iAjf+
	HbQQnFaYH6bf5D9qVmalxNoXqaqqgEjP5UaWX3IkiyRzHr22LccrqFZZ
X-Gm-Gg: AfdE7cnBRXllqwHf8OcLKoA0f+12P5a2aQNc/QaH6f6LJoQEH36jmhd7oz9JY/uklJW
	8kBbLZpi9ge8BaP9l6cjSnf0PmaVeDzdHcHtPB1yugMiQ21Nvgf6M57WmI+Lz4BKxcuUX4oZCZe
	gXgH+Y9VMvq03zvH7mAo36ERZZ3k9j3yroqCCo7gbrUCdbwTsgjI1rfg5nLJ1ZU20SGJbna9Bo1
	5Y5Vk5UiG9KrfrtRhJBf+YUo1W9HbfxzM/e6usfGJBESr5tpdowJrVJdRAVNO6YCbhMCoqIMUQg
	5kRHtFX30+GnHIpqzZjH22saSC/dpQnYQc8b2ofswOKdBOQHq7WJFPYytMP+TgYjWlt+vIfxYSy
	sVGU8H1blr1RqzlfBNkJjxV4r+B9tGJaIVoaakpEK7umcfl496NwyHALOI/KE7bV9234f7T3PbY
	Y5txe1LnRPk0ao5GbCiOlWryREINbYFGOacQ==
X-Received: by 2002:a05:600c:a31c:b0:493:fd5b:2d5c with SMTP id 5b1f17b1804b1-493fd5b3043mr9045005e9.22.1783802571359;
        Sat, 11 Jul 2026 13:42:51 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:50 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v5 7/7] ARM: dts: ti: cpcap-mapphone: add USB safe pinctrl state
Date: Sat, 11 Jul 2026 23:42:10 +0300
Message-Id: <20260711204210.197144-8-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pinctrl state that configures the USB interface pins into a safe
GPIO configuration. This allows the CPCAP USB PHY driver to place the
pins into a defined state whenever the USB interface is not active.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |  3 ++-
 .../dts/ti/omap/motorola-mapphone-common.dtsi | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
index 51a858021541..368cb539997f 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
@@ -120,7 +120,8 @@ cpcap_usb2_phy: phy {
 			pinctrl-1 = <&usb_ulpi_pins>;
 			pinctrl-2 = <&usb_utmi_pins>;
 			pinctrl-3 = <&uart3_pins>;
-			pinctrl-names = "default", "ulpi", "utmi", "uart";
+			pinctrl-4 = <&usb_safe_pins>;
+			pinctrl-names = "default", "ulpi", "utmi", "uart", "safe";
 			#phy-cells = <0>;
 			interrupts-extended =
 				<&cpcap 15 0>, <&cpcap 14 0>, <&cpcap 28 0>,
diff --git a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
index acac3c243c7a..475ffe678e76 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
@@ -352,6 +352,25 @@ OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
 		>;
 	};
 
+	usb_safe_pins: usb-safe-pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x196, MUX_MODE7)
+		OMAP4_IOPAD(0x198, MUX_MODE7)
+		OMAP4_IOPAD(0x1b2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b8, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1ba, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1bc, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1be, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c0, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+
 	/*
 	 * Note that the v3.0.8 stock userspace dynamically remuxes uart1
 	 * rts pin probably for PM purposes to PIN_INPUT_PULLUP | MUX_MODE7
-- 
2.39.5

