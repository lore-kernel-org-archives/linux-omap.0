Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4B7260D
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372648; cv=none; b=BO66USE03bagmxM/4T0JR1azEiUZYaasJOIKBV6PgX2Z9ByeSBqngZvUNZxi7aTS26ZNRiwNcGBgFtzQcsFAIDXS2x2g8dvlE32v2uV9V/RBoDhz2ldxr4EBdeONw2YmZ3+mAcB/koyhDqS7NwdeGC3QjexTXj++K4XPNR3ce70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372648; c=relaxed/simple;
	bh=y0zfqFWokNsrIDe9PtcC0FGpPsu//Tml8hGBhCs4wsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cL8s/mSAqAVyjVRhW6aCaZmx0ZVfCZPVqyNN8AKxejSeljTco2vF6BQG8IlmTqFnghVPUcLUdbMyh7hs/UPf7vEaqGYFuBVk8YcPld84RT0hwZCCMGZ7GesEyLDccrsouwfHLjv9NmU2Ky+Ig2YUNalw/qK1PiqIrsnkbcpuSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=iJdp7McP; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iJdp7McP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1782372637; x=1782631837;
	bh=y2EyM1Slz2fBwVQO9+V9ep49e9+zU+R6lVHhXnzaIGA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iJdp7McPE/EvMZZW61mm8S+1u3VqMtFig21yBh9q2YmYZBFUT1TwaBMqqgweR4Ld+
	 1CK7LejYxkfudnsUz5cXavTfejEooMeK8kR6UNEG+EAnmMk3VWWjGg+DuwiIPrsMml
	 WZEeRQ9z/r1+o5JAqgZ6ErvkYRWjIu7vp9PZVqkUKEiAV7X395Xo41URHfJ96Q/W/h
	 hTZkO74Imvoq5XzaGrQG64km4Kx0u8BukoiGK3Gyx3h2ROYJP9moPqVo0lyc8WqGL1
	 +Lj7e26WmHtTFW2dXQDAUnPiLEti1/pkeZK9XWSNNT/CGKhZvQaW+o26HRll/onx30
	 8Nnj59Lj5ddpA==
X-Pm-Submission-Id: 4gm9Sq5cJVz1DFTD
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tony Lindgren <tony@atomide.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] ARM: dts: omap3: fix #ssize-cells typo in omap34xx-omap36xx-clocks.dtsi
Date: Thu, 25 Jun 2026 09:30:26 +0200
Message-ID: <20260625073026.110253-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the '#size-cells = <0>' lines added in commit
808e65304d18 ("ARM: dts: omap3: Update clksel clocks to use reg
instead of ti,bit-shift") had a trivial typo.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/boot/dts/ti/omap/omap34xx-omap36xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap34xx-omap36xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap/omap34xx-omap36xx-clocks.dtsi
index ca6372711baf..a5ec71b00e57 100644
--- a/arch/arm/boot/dts/ti/omap/omap34xx-omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap34xx-omap36xx-clocks.dtsi
@@ -258,7 +258,7 @@ clock@a18 {
 		reg = <0xa18>;
 		#clock-cells = <2>;
 		#address-cells = <1>;
-		#ssize-cells = <0>;
+		#size-cells = <0>;
 
 		mad2d_ick: clock-mad2d-ick@3 {
 			reg = <3>;
-- 
2.54.0

