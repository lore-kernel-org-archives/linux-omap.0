Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AF2E2DDD
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182769; cv=none; b=ANlQdM3LrdLpBH+pWM4BIhMpGjC31uHiusTjbUEWffaDDa9GQ8Hbj6ycp7xYvtpxjUz7JlN5ZfhC/1s+zaXPIzxme4QYxSWcpBQpXNS7iGNagvIxN2O0ZqCGYQvVaHV9fUvyQAWLt2T81Cg9yH1wgR9DVsV+SjRryQ6Oxa8CQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182769; c=relaxed/simple;
	bh=0crRmPwSiMEOVOi28jVt9hbp1foFHnuqbD2Zs4kEBXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2iJ50xOHcMLqSQs66dKJUbfEaW0fv4PE4os64G/GuZA74LXTExi7XsKUHQWH4kVb+nxdaN+9p7YLhV8SE0hdaWdasNl8Tx8jHfIqJmeftUsR6/fAboL6gVHulZ10XS25eV0WIbGy+NrYznRHJj8hoSmGn7aJbGdUP/IaVe0JtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg6AZE9z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg6AZE9z"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7d98c1879so11644655ad.3
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 07:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769182767; x=1769787567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcWylPv8TJyXsVhSrUUC23A8HhbSPg4cc6ltX4FBb+c=;
        b=Pg6AZE9zbGSwAZ+IGZK4NGhIfmg8tlcppHq8so6JHCIwJ1YIEb/K1jLxkvgUbKnfQn
         tcGUKq5ZVhz4oV6viK4+j8+iii74augn6dhWgY78/AGoThzManG+Sc4bi8W3nLBj9FOm
         +Od1IOPhN469Qp2sEIfA5fjZSt7io2bFP6Zc2i1TRkWYyu/r6hyFn8FvYETqZ0vVZz61
         46rKC1qt+HfuvG/8gitdSqbKQEtDKdMqrsgXxbEXmVZZVIp9vqFnMR+Z7YJ4hjTs1+Tm
         mlFzZC3ofb9slYMx5VKto8ytVCsrDAdIaOJvSeIL5bWBAZNgL6xM+zfRujzaNHxQQwG7
         Bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769182767; x=1769787567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcWylPv8TJyXsVhSrUUC23A8HhbSPg4cc6ltX4FBb+c=;
        b=PBKijTO8YDW87QSLBXWcmlwsooJJn9K4al+Hmw3aY8RbO3hCFhqpiq2k7GKf/KPl/A
         QhZQRqg/GJ+5WnMZ5MtFjr4Cu+qM8P99b9la1/ZCIFT441hOUrIsJaGPH32OnYPe+DWB
         LCtdUwNhYKbPfG0hfR0SL9aux6yF8xWAG3I20Gt4HZncVacTtxNwX8Ec5ASoxCt97SRt
         MJ1He0fRXiEyXOcdTfh/dZcytC2gu3nnwjeAGi+YtVJeOmXQvwyg9wd7KvO9SJbgd+dy
         PpUM7EYaB8cwkXbB2bQP7ftZbUFqdzaPHCFKLT2sw0VGJwOvHM2Gry6GW2giyCSnKXbe
         tU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNL/ozDMTIdFzRHTLaDPVLMcBTrrl+kHrbN2FlNa3yp3BqOR3tG+RYh7CasYudHpowpMDvmfsR2Qge@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1j5u/+i/4nIpJj0P/IesyqWdozeFOrgYwniuMSsMkQQIpR9EF
	1v7SVxvFAyB9EST6Nn0BWB+Ts80N48lYhXItBtKmk9VhAS+Sq+aQTE+O
X-Gm-Gg: AZuq6aJGhZxWAfYy6gWZCpLbgcygx1mG+29VdcBFWfaMcTq5KCDGJzhOjZXtfoDJsQF
	DybkeL71Q+KGvhSzvO+We+z6veqad2uV3gVfvCKbnYgI5gqaGZxucLDeVdJbPGMqXgfFfdLe37b
	2u/zsAUThqzzd7gfkyDhfMJr0pD0Q+wny0AvxnlEK4b2wJIZQNY7+IGzWgWd+q3Ch6hQcRZBcCU
	nrlk1Y9mUFbNPg3d3TOGmG34Z1rD88BM9HcHVr7AoK+yUb7DQMe5JAkUArXVz1eFKWsP4Q4xTkW
	e4FSiaZ8LG7aK5z15TUgi4CThohmm54eMSH80CA3n2Wu/iVQ7/eKmvmeOCOaoDgpwkh8mZmuXzu
	ew+cq/8CFzRuMmtnXltlyIfQRbnQ3BYnCMG2cIu6cfBkB+QFhjZ1+z05Wk9iudEIpY/7fuX+uSR
	uPn2B5/y4P7hp90g6p/8VjKdOhlZw9eAMjIA==
X-Received: by 2002:a17:903:247:b0:2a7:9da7:d21d with SMTP id d9443c01a7336-2a7fe77411amr31093455ad.56.1769182767504;
        Fri, 23 Jan 2026 07:39:27 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a802f9769esm23732205ad.60.2026.01.23.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:39:27 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 23 Jan 2026 15:39:02 +0000
Subject: [PATCH v4 1/3] arm: dts: ti: omap: align node patterns with
 established convention
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-ti-phy-v4-1-b557e2c46e6f@gmail.com>
References: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
In-Reply-To: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Roger Quadros <rogerq@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Update OMAP DTS node patterns to match established conventions.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi  | 4 ++--
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 4 ++--
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index c9282f57ffa5..ed206eb84d02 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -328,7 +328,7 @@ ocp2scp@0 {
 				ranges = <0 0 0x8000>;
 				reg = <0x0 0x20>;
 
-				pcie1_phy: pciephy@4000 {
+				pcie1_phy: pcie-phy@4000 {
 					compatible = "ti,phy-pipe3-pcie";
 					reg = <0x4000 0x80>, /* phy_rx */
 					      <0x4400 0x64>; /* phy_tx */
@@ -348,7 +348,7 @@ pcie1_phy: pciephy@4000 {
 					#phy-cells = <0>;
 				};
 
-				pcie2_phy: pciephy@5000 {
+				pcie2_phy: pcie-phy@5000 {
 					compatible = "ti,phy-pipe3-pcie";
 					reg = <0x5000 0x80>, /* phy_rx */
 					      <0x5400 0x64>; /* phy_tx */
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 4ee53dfb71b4..d8b16cbe6c35 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -72,13 +72,13 @@ scm_conf: scm_conf@0 {
 					#size-cells = <1>;
 				};
 
-				omap_control_usb2phy: control-phy@300 {
+				omap_control_usb2phy: phy@300 {
 					compatible = "ti,control-phy-usb2";
 					reg = <0x300 0x4>;
 					reg-names = "power";
 				};
 
-				omap_control_usbotg: control-phy@33c {
+				omap_control_usbotg: phy@33c {
 					compatible = "ti,control-phy-otghs";
 					reg = <0x33c 0x4>;
 					reg-names = "otghs_control";
diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
index 9f6100c7c34d..5c94db589dd1 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
@@ -472,7 +472,7 @@ usb2_phy: usb2phy@4000 {
 				#phy-cells = <0>;
 			};
 
-			usb3_phy: usb3phy@4400 {
+			usb3_phy: usb3-phy@4400 {
 				compatible = "ti,omap-usb3";
 				reg = <0x4400 0x80>,
 				<0x4800 0x64>,

-- 
2.52.0

