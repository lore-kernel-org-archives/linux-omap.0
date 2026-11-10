Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340399;
	b=OoggfI9+QL0c+j0mdFaYjtuvFZ1pguJ0mGTr0EfHwARzv7bEHphkJDPOsYbdXVZXMZyA
	 FFQLkXYfaH2yz9DH/mlLtfl1KDL84pPfS1dBE/Fips0ZXIz8vmXg1VlwCe4P2eflhHrUt
	 8SGyQvsDaxO7wMgxSf0rs5oSE0KYUPUeLD6Ojyekwz+vNSEVla5Qol1N7Brm1WURs+Cve
	 tyh4Piqjx27u0GNFR/tALhtDHykF4LahnKoefnnMeWPdtZtQD0a/1NJI4slUwYwSUvM5z
	 Pkh2+WX1cw3WrZskn8IqzZ5Q/GeGa7jQIZoLCKl62zzJa0RCTqWSksB6pzx4yXhJgFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bMjomd0jtFOusb4r+jQiPm04tLdqb5W0DB/94s0Gjp8=;
	b=eC0zB2TPeP5Ky6pGwwpId5O9BjzxZQDlmpO0eAsx4OklJYa6YyHDsB2fosbJskTaBLgC
	 cXfZ2NsaXO5AJG5rr+K1AklqjDNDlRGHJXZvR3p282uChHSGnPHkktaUxMrHw9RyVCZt0
	 6s3a2K3vj7d9BS+EZVzdvKsAW49L8lxJ6LURJ1ZZP0RM0Kp9sg0sTJmNPUbaDeAXW0JDH
	 fqRiD+kKvlzDeAYQh0h2AdoUM3tSam3fphm9I5fppw779pYnc8hUriQ3Hb4nng/IGkXA7
	 3A2bQzMsTVLTlZR/IcK/knLGzEH1SwyGi6d8RIBE0cEZv+rgnWJecXsyuBtlB+fc6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNmq6Glf;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1176606A33B
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1176606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNmq6Glf
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-376a4059061so731eec.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340398; x=1794945198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMjomd0jtFOusb4r+jQiPm04tLdqb5W0DB/94s0Gjp8=;
        b=KNmq6GlfCII17HZE+AJjaHUons5D0oj6okIngpx/wla3vWVEXU5J9gr6TLWbCSCkNv
         0Vw+wgVtfmfckoLXVNaLvezuUTj87YqcDM/+tcgED8kk7TZAEa05Ga30rj0riDh+obd8
         vNqvmLLkqQQZCEgfwMcOk42iCUM5WeZXR6CPToOmSQ2qW2q8AWk0y+hxGHvM4thiJPHv
         DBpr8+lGdsG3sHWTvY2pilxDdGXQhJ6jGmqOmqaBolLw9Sm72No8hoDcbQK+kXa1KfU5
         6vk9zBIDasMCloANO3SG915OAxGrnGZwRK1TY/L7976gwnutBSXU2Os5f6x0KohUx95F
         BLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340398; x=1794945198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMjomd0jtFOusb4r+jQiPm04tLdqb5W0DB/94s0Gjp8=;
        b=kg6vhWsDkRCYz3sGK9NRHFymJH1Z0ohLtRYoAJxaXsgQv0ViqeVMAfeUJdt+dwq3Td
         JYnZt7iuQsni9hRwQpTh1nabeQ5bYhi/M0qadhXLurPH+tvA0LW4nOnZwpZ75qqWZIVe
         ZSQNGdOJKyN9gYpHki/qJph0E7ft2viPx8S4pTsOSSr8OI7tmp2LWn+q56LNDJSIif1t
         NXnxyePnNwgTLDAZRnOWNA90++typZhBTYPl4+uwsNxNGmbV2OypAySTNn3usZAaQ3ve
         UZMAeMqOue/YY0RtWKa/KaXyfK7wBOKpsBDWjCRXX4EWQWjbFM8DYL+GkOOwf0P1smRI
         kVXA==
X-Forwarded-Encrypted: i=1; AL+hErE1VdVre+3lOppcDV/9lqrnVntkF48D7rbD5DYu1tlMtecCbD52eL5QyvZdkiedtoyY4iU+rpa0+RxP@vger.kernel.org
X-Gm-Message-State: APuU4Z8nZYe+9G6zI2s9TAJz1ol01QhKE3gpTA/POo9WGsCBe2PvbdcW
	mVjr4kV/vLNUyXd/xmoxaJ+ZUY/5XrK/kLhXkRKgpxynlSrOP0xTHiIr
X-Gm-Gg: AYBFou1HBfzDLe9E9SGO0g5MwchwUMIPI+SOAUlRB5MZ7p89jVSXGbvrlwCAsYZ9Wv5
	5oKZNJOEl3QHHRmWbBag+KgPZILorGuWTiPYCczCm76T+bkFHXQa9cjGXxWruYF8G4CsFRq5zEj
	I8jDtxchEAAyCJCTU/oDAnsm19wL09WOtSzs+4h2vW3hosxnVINGvN8nvTaOI6PqAzJ1/0Lzo+P
	WPd0Q7WKGfp7zRhqSe8FSk9jvzglHb7/hsbKCxBhYa8mTBm1WHIAh0u1R8dSVpr6pw/mIgSFR4a
	sOBnstFwE4iUmAcZZjqxgjaKOXIc0mdbPgp/KIfUsb7mbkE4YNgtI9LQe6gALfWCyH3ewFWe50S
	r/wT4rXlNsQG/6GEjcqjpOMHVDbFPJiBxs8eUuLq5jnRYK94lWpa5zrwfBLvi7k6dpKwQ6K2Nyg
	r7vE2ExGWsBIw44rv8pLdXIsqIjhZFgOnhSQQlm8/PQxuT1Cyv6HahoP+nliA1eGbJrKBqD+3ck
	I1Sry9yFmsLH3nnnxfzt9Ho+PUA24wMTYpVGVKK4YahK1jhfGm993zljytf7KfofJNURZ6AhZmR
	Cs3vXrQg/w0JqMmFncasrRAbJiFrwuvF9E480CFrU+DCry91x7bnBzwYp1y5
X-Received: by 2002:a05:7300:f797:b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-376850ceb37mr593617eec.2.1794340397850;
        Tue, 10 Nov 2026 11:53:17 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:53:17 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:37 +0530
Subject: [PATCH 7/7] ARM: dts: ti: omap: omap3: drop redundant ti,omap34xx
 compatible
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ti-omap-dts-fix-v1-7-19022d1ff4b4@gmail.com>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
In-Reply-To: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Jackson <mpfj@newflow.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Bhargav Joshi <j.bhargav.u@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=3535;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BYon5LDCHp9dtQh60TtA5CEBqyx60kTVIJ4v97FVd/E=;
 b=S58DoGXGcWdkV+aVPGpG3paMqKurohdzVxoPc8uuX39+HJMn/z/MkBGIFLsYmSuooUlFisMVt
 MdTLz9HD+qOA9S8hyk/CD65Ncqg2ZT49bJWNAAQYTTaS1CPtP1VxCqF
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Commit 6ddf6c91e6f8 ("ARM: dts: omap3: bulk convert compatible to be
explicitly ti,omap3430 or ti,omap3630 or ti,am3517") added "ti,omap3430"
to but left "ti,omap34xx" behind. Drop the redundant "ti,omap34xx".

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/omap3-cm-t3530.dts  | 2 +-
 arch/arm/boot/dts/ti/omap/omap3-ha-lcd.dts    | 3 ++-
 arch/arm/boot/dts/ti/omap/omap3-ha.dts        | 3 ++-
 arch/arm/boot/dts/ti/omap/omap3-sbc-t3530.dts | 3 ++-
 arch/arm/boot/dts/ti/omap/omap3-thunder.dts   | 3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-cm-t3530.dts b/arch/arm/boot/dts/ti/omap/omap3-cm-t3530.dts
index 0c6f14963e5ea..0a32ccc84e932 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-cm-t3530.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-cm-t3530.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "CompuLab CM-T3530";
-	compatible = "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap3";
 
 	/* Regulator to trigger the reset signal of the Wifi module */
 	mmc2_sdio_reset: regulator-mmc2-sdio-reset {
diff --git a/arch/arm/boot/dts/ti/omap/omap3-ha-lcd.dts b/arch/arm/boot/dts/ti/omap/omap3-ha-lcd.dts
index 94f6b7931e333..e231209be3a15 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-ha-lcd.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-ha-lcd.dts
@@ -8,7 +8,8 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics LCD-baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha-lcd", "technexion,omap3-tao3530",
+		     "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/ti/omap/omap3-ha.dts b/arch/arm/boot/dts/ti/omap/omap3-ha.dts
index 19e471eb3b4e1..d4d883f588eca 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-ha.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-ha.dts
@@ -8,7 +8,8 @@
 
 / {
 	model = "TI OMAP3 HEAD acoustics baseboard with TAO3530 SOM";
-	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
+	compatible = "headacoustics,omap3-ha", "technexion,omap3-tao3530",
+		     "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/ti/omap/omap3-sbc-t3530.dts b/arch/arm/boot/dts/ti/omap/omap3-sbc-t3530.dts
index 1beefc3194224..c2b4c707cd9e0 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-sbc-t3530.dts
@@ -8,7 +8,8 @@
 
 / {
 	model = "CompuLab SBC-T3530 with CM-T3530";
-	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
+	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530",
+		     "ti,omap3430", "ti,omap3";
 
 	aliases {
 		display0 = &dvi0;
diff --git a/arch/arm/boot/dts/ti/omap/omap3-thunder.dts b/arch/arm/boot/dts/ti/omap/omap3-thunder.dts
index c87956c59b083..a0cd06d4e39ac 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-thunder.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-thunder.dts
@@ -8,7 +8,8 @@
 
 / {
 	model = "TI OMAP3 Thunder baseboard with TAO3530 SOM";
-	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
+	compatible = "technexion,omap3-thunder", "technexion,omap3-tao3530",
+		     "ti,omap3430", "ti,omap3";
 };
 
 &omap3_pmx_core {

-- 
2.56.0

