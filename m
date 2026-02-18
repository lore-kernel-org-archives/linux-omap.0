Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B7318BA6
	for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447182; cv=none; b=kQEgLpfJ1dVgy6ZnZhzyA99KbmDhZH9w4qDDZq5nEfOSKIGbg252CQah/bBHVB3dAAYrXCDe1bL9RGZkNOVO1t2R+N3ScvE/RqeuHFBUHfDO2Y6LaG3DG8IQIoHq+wSe5AfrtZo4JEGrDv+r873YtRxmSd3OLATsnWaUKrSHpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447182; c=relaxed/simple;
	bh=IZOe9Agq5alFuZFtw7BiAeMypRr0qgvFrTQVAA2QJGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJhtLimDtgwg1ragUyQ4Uy3zqWEWCXGxy6Hcud0Hq/X/7yw8Ym7NdAwl51/GDpAOgxs3LVJiyvgkOQ0U0+0GB93hRlC6MLbrhlDwSeNF2ixMbdC9cfx7ttOCWDWb/BTzyIGiIwrbUUXZj8FnU+Bkd4et4pEr4T1ngO+qZaxy26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=N4az98+k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="N4az98+k"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f10628so1748935e9.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2026 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771447179; x=1772051979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLWHawfUnZuiQ3TDhSdC1bL32uOxcaH5z4XCL/rXWbU=;
        b=N4az98+kxrdCsihwFNEkhNcyK9Y2wCxB9Egd5mGJxyF5jkeLVx4ih4+WCjHGCQdtq7
         ElKWEZUJvbpTujjhESL3kmKryiWsFUGLv/4WUvWyF/gQlTfPsbanaJMttOMfXGNQIXTa
         85t4Z5uov6C3XeiLhkWADcMOwUdrFKkDXmAIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447179; x=1772051979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLWHawfUnZuiQ3TDhSdC1bL32uOxcaH5z4XCL/rXWbU=;
        b=MMo5cIWWLucT7xwzbn+F663W6Q9tNlUOQ+r0KZWEIHGc1m+pKYALHPz+TUZOK6hD5N
         P+QQ1TVI2Cb/zPiv96eQfkQyAC549bJl9QAYUmzlTsv7Jnb7VKvyMN7tIb2uqt2V/Taj
         D9Zg7cCTJ8VFAlY1pOhPO+yzMVGgTOm0UPRgr/sI7wwIl6yXRXdl69HbFTWw/2WOqx7n
         6aTyHif+WYNbXh3QEV0bOz1jn9hfcXuyZXBuSBCFl5afgMcj6k+cXlEsGCLVG9LUcM9/
         BZAgumC8Lk0Zt8U63U/kWnZDCpmUy0rSFRPZxvhwpH2loxBvLnUVHOOgI/MdaVNQhuy2
         6hcA==
X-Forwarded-Encrypted: i=1; AJvYcCXvLQ5as4hYp+i5qkZOh+Jjd7s9vMXtOkuRxXs7jtSsa1B04v4ixNEX9TqHestugeqpuiH3N1vEE7fm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dOO7V0t7lK96wFCSrHxi+IJpYIynIZCIXJJBv1TQBkym0G5M
	FRex5l1VkYnArChnZHOcGkZtYBWcY+0KxjrFZ5bcrrWdviT17qSgOXz0a2SuN+SIOQw=
X-Gm-Gg: AZuq6aKADARZTPfgAX8muAxFXAw1Gvqh0v4kSlQlATm8YnoyTg5NGki5revwAY2kezG
	q7awGNaGA+WjmOQx71zRfHqcbMEp82d6H3eDLPc1AJPEgwCTLK/n1HmIY97wHZwicEKqbgxpFoj
	UVEt2ZRjBP+mxjPKEc1RYMmtJ+wFNLvH3F94VN+UcgJne/AWNkbI31Pk5A7QSatPh6gOFyrF/cy
	J+xJVCiK/OgFIL8H6oLSwSEs3IInpPr6RLytGtt+1Y/SJljUFb32i9AwBhvB+mh0Mi3t0KRWQHT
	75p0Bua56XmODwo7MXp39ddhna1UZSu8VqAJUPLO4IhiUP3bDMfEOLja1c4+LsGiHLpKhUFlnn2
	SDRNTAwJ2FCojzDEVi5umC3pJfaXgQLYbn1HTr5PC4HRJ4JCaUecFJ0enj1eiexxb/hcJ3uh2Eh
	ilx6Bbop55BD1XNziKAyLs+gevqgvW27VYa9P/lUNaXzRAKtGmt27Da3oD0esSRbPZv1cOzTtjL
	gsFuG38rbVcpO87s8bvG29fFHJJRiLvPaXu
X-Received: by 2002:a05:600c:6091:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4839e661d1bmr6597615e9.18.1771447179348;
        Wed, 18 Feb 2026 12:39:39 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e327sm620432895e9.14.2026.02.18.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:39:38 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kristo@kernel.org,
	vigneshr@ti.com,
	nm@ti.com,
	Romain Naour <romain.naour@smile.fr>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values for MMC1/2 subsystems
Date: Wed, 18 Feb 2026 21:38:23 +0100
Message-ID: <20260218203823.1825554-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
value to 0 for MMC1 and MMC2 interfaces. These values were updated in
kernel 6.5. As a result we have some occasional regression with ultra
high speed DDR50 SDXC cards while mounting the rootfs:

  mmc1: error -110 whilst initialising SD card

A similar issue may occur with u-boot after a reboot while
initialising the SD card:

  mmc_init: -110, time 67

Update the delay values for legacy and high speed modes, based on
the latest revised datasheet SPRSP36K released in April 2024 [1].

  (MMC1/2 - SD/SDIO Interface): Updated/Changed the
  "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
  Default Speed and High Speed modes from "0x0" to "0x1"

[1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
(SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)

Cc: stable@vger.kernel.org # 6.5+
Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems")
Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d5fd30a01032..418e6010ef1f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
 		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
 		assigned-clocks = <&k3_clks 92 0>;
 		assigned-clock-parents = <&k3_clks 92 1>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-sd-hs = <0x1>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
@@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
 		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
 		assigned-clocks = <&k3_clks 93 0>;
 		assigned-clock-parents = <&k3_clks 93 1>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-sd-hs = <0x1>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
-- 
2.52.0

