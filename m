Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9C2F39B5
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003279; cv=none; b=ZQhz8qM8oy1JvDAUsqPFZmFpUkPQxhu9O2KsLiRIscIUfiS5qjfu2YQ5H9ynGk3QE2sCBRSWSfqMo5nGhTlp9wSrgy0ddJ4MrPt5vdhdHSdF9jEVvnAO/eqEi/VlJwPORnlg/NrgP8YfNii/B5jOn7/+it6DhQ3DN048lqJvA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003279; c=relaxed/simple;
	bh=2zGPgT53nMyKtGN4bplmgmbVd+Cg1WvfyXIJuEqowq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrxXmXJByR4aKapkUhatrvba3oDPQFGX0PoFBtVamKl5L05j8KmVbAzhJRn536XYmHkuM+1n+Z5g++UK586PynRxPu9VxNtWy1akSAKWC2o8BDr8Uqkvs2en9fkxx4VkihIIBiLDuIwi+1wQoNCCyGg6ZsQF/6h7ResGeAUQOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmChcg7P; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmChcg7P"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso344701a91.2
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003277; x=1787608077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Shib2rntu2e/Z5UR8HQqW2K03GJsazba3W0OpgQm6G4=;
        b=WmChcg7PcM+dluZU5BEOWq8wlz7BtCkxQcbpJRN1xCc3BcU5ZiCr3z92RhUZD/oKiR
         VaghgZk8iCoIkdXlOzUa77RfxlOEhSZoSTms2fmXfxSxgdgm4CcZVAV8tyfPHY5sE0y0
         VCi4MkunjEE6dgDKo1A4pHWWFoceixahPgfCnLzEGS60UcSybaxBzixwfJ3AORGE/Wv6
         C3VCMnxk5nGEzN2XCnlPsD9z+EMuCkFO7JP3sa7tXerdWHfPShBhHc6DmRwq0IEOLeNz
         NGlibCVWv87fDPzNFK5jqYMXRrdfN27dqzlB+RK29CUyIg1CSP6nUzLZL83ajtTttVIa
         G7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003277; x=1787608077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Shib2rntu2e/Z5UR8HQqW2K03GJsazba3W0OpgQm6G4=;
        b=jLEU7PYM9BoZry1WPNeXJioeeBK/lx1BqpRpgsojS/5hHAtJVaLizGv89Oyv7HE/AQ
         foCXGrteas9BW0lUyj1FT/qLzxZXd2/QomuGlc+bV9hIuKRRInCdK+Bjrf781ZDBj2t6
         qnqLLqic6lPR/Q6fkQzczy6e2nJPfuy0Vt3Jjwnk+W3GaFwd9w0wKedk27HsUUfZN6no
         moEisFQUlHXOJE4DSm22K+3ak/E7vggot3LBxl0QK7EjlhCGBnfmcVwmU4lHq/uLA98H
         fU1rZAnCR3RfHU9Lfyzj5qKo1S//3tKq0pRRMjpBABt3XAiHkaV/lE2qr2+3J05OQH0z
         OAyg==
X-Forwarded-Encrypted: i=1; AHgh+RoRIJxqSWrn7FAg2A+LU5Apbpj8dk0NGQwDQVg8zyYazOOcAQgCE55pmQOLWg1VvOnJHD0raSOsKdUl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4A3RTzDDK3lEZqMkPWJ5oNo+yq4yXQtJl4iE8meHqaoLlCJZ
	2/MSdL444l5bBgDE/XYrV88GjoYMUCXlVqXGIfC9NgarS71cVbFxg+bb
X-Gm-Gg: AR+sD131EuDv5alN5VQL+s94CiHqkwzT1AJVs5WJe8YStvDCBwwhTTUnWBrrWtCK/UZ
	5w7Cr73yaHLHJAXiBqUAO8SQMI4PBgfvsy8arVr9UAm84fAoJ5MBAp9AwNdWKoP9wpqqg/i4xJv
	+FhQIex/t0EAs3Kry+Y2Td9eZDy8I7fgqyMSfIkwgUyk6S1fqHHB4u57ChgACzoV+Z0eITmcrP1
	7iIwqhkhFv1zF7tkgIwl9xeXg/YYfqDN+2ZJJuykwTKv9qP9bY6hDCQJxtjb3r/oYUm4dXnqzrV
	c9pTY+n93uXGakNnm5Ikg9wBNWrfHlQdeG+4JKbBtdr2IMezh0e6OncTz1DQI3FOgheT1ylsPz2
	2XUx2AQGw2SIj1zE057JLHM+DQrI4BjmA52vY5TI5/cYezlNoEuDnO/FWzR7+rNCUkD524oxxHi
	svHc+xCX2qPvMldThx8rsp5b6xGQY8MbPfIt+h4R44IGAf+Gi2yKqBboziZglekjvn9gq7z5b4Z
	ks=
X-Received: by 2002:a17:90b:3b42:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-3933baae9c6mr19716659a91.3.1787003277081;
        Mon, 17 Aug 2026 14:47:57 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:5053:3384:1c8f:aa2d:e07e:6d3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e3csm10153024eec.21.2026.08.17.14.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:47:56 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 03:16:33 +0530
Subject: [PATCH 3/7] ARM: dts: ti: am335x: Fix redundant interrupts
 property in USB nodes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ti-am33-usb-v1-3-69ac5f92df45@gmail.com>
References: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
In-Reply-To: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Siewior <bigeasy@linutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>, 
 Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787003201; l=2514;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=2zGPgT53nMyKtGN4bplmgmbVd+Cg1WvfyXIJuEqowq8=;
 b=J2aDNs1JbD5WHy4QICMYeixKDDwKXUIq702t65HPDqSG37dUVXssumHiJUZjcOf+0PeHyYsGR
 5w/krRlhbnHA8APgYbNaYQk/sTkjsf2Rt5UBG/QDaHSLSoX8bWnhSSs
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The am33xx.dtsi defines a single interrupts property for the MUSB nodes.
Several board-level files override the usb0 node to use
interrupts-extended instead to include vbus interrupt.

Since both interrupts and interrupts-extended cannot be used
simultaneously, Add /delete-property/ interrupts to the overriding
nodes to resolve the schema warnings.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi   | 1 +
 arch/arm/boot/dts/ti/omap/am335x-boneblue.dts       | 1 +
 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts  | 1 +
 arch/arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 1d83fc116b66..c436edd98e10 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -197,6 +197,7 @@ &uart0 {
 
 &usb0 {
 	dr_mode = "peripheral";
+	/delete-property/ interrupts;
 	interrupts-extended = <&intc 18 &tps 0>;
 	interrupt-names = "mc", "vbus";
 };
diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblue.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblue.dts
index d430f0bef165..7da2fb782ab2 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblue.dts
@@ -304,6 +304,7 @@ &uart5 {
 
 &usb0 {
 	dr_mode = "peripheral";
+	/delete-property/ interrupts;
 	interrupts-extended = <&intc 18 &tps 0>;
 	interrupt-names = "mc", "vbus";
 };
diff --git a/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts b/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
index d21118cdb6c2..6bf388c4abbf 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts
@@ -35,6 +35,7 @@ v3v3: regulator-v3v3 {
 };
 
 &usb0 {
+	/delete-property/ interrupts;
 	interrupts-extended = <&intc 18>;
 	interrupt-names = "mc";
 };
diff --git a/arch/arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts
index 23caaaabf351..068ea23bbc0c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-osd3358-sm-red.dts
@@ -376,6 +376,7 @@ &uart0 {
 
 &usb0 {
 	dr_mode = "peripheral";
+	/delete-property/ interrupts;
 	interrupts-extended = <&intc 18 &tps 0>;
 	interrupt-names = "mc", "vbus";
 };

-- 
2.55.0

