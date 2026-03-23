Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846436681E;
	Mon, 23 Mar 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278180; cv=none; b=LZWJDIKBNXdRQ/pi1H5nosI6IOt/aOUEjq0VPh//x6q0PM7f1HZn+fnCHUHOcd/pj19nQQajbZOaxG3HduD6JfIqQCdSDpk6gNMW00TM/UCpn1u/FlYYCqLwqk3sHoR8I/ttphMIAKNFzrgU49jYQHPRStW09ojO5SxNf6KsXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278180; c=relaxed/simple;
	bh=0O4TBdZ9JeIZhQVsh4ZaCpriAX2OdR1rhbqhuVxZ1ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6QE4NLQ/M/ayJlNwHtDL7IiCJPEbE78sDsMvc43LJnQxZ684sYLsJndZJGnvFxaz9HvB+5I2Wqw5kBweWjjQ6wsppEsKCybPhOncF6v0Z1UWRGRhVuwkMeYPuziMmNLJhNZmimyCObMh67U6kZL+zfuu7a1br/El7jgwzqjiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O1SegjN1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O1SegjN1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 389A9C58083;
	Mon, 23 Mar 2026 15:03:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 554405FEF6;
	Mon, 23 Mar 2026 15:02:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04E6B10450FE4;
	Mon, 23 Mar 2026 16:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s7ieGxUorH5vEoclzdFlJzFlL8c4gOCHik9ITpDwHlE=;
	b=O1SegjN1pZ3JtKr06ywQW66Y8aNGXNiUT1vFYKH34ry43kFmpcAGKqP2Rq1KFeWqQ25lQA
	wdhZEYQByuyCkukSs6pNZ0m9um/e0hihsJ/TreZuQWCj+16FeaaorDdswwT0ldQAsWNHUi
	fTbLdGVjrNKCMo1tEvishTWJcb1OykpUiWNpTV0Zwf/ghWexSsNbci/pTU1jhbxtsfi+pm
	FCaYvojKkPljbqGHP5AnorY4d3EFYWDtBTvI0zhx9LZ3vUgAxZDu0RKJk+v8gnxnyH2t7U
	blf/uFgbDtQ2dO9Tx5AFPAvISe6COt50SN5XWOTedXZpXwxgzwADfyzSgSs/8g==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:43 +0100
Subject: [PATCH 2/8] ARM: dts: ti: omap4: Add pbias SIM regulator
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-2-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Add the pbias SIM regulator node for OMAP4.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 4881dd6743930dee65eaeab802d1e3766f480ce0..6904a84a1700527443cee19f62870904082eb48a 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -697,6 +697,12 @@ pbias_mmc_reg: pbias_mmc_omap4 {
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <3000000>;
 					};
+
+					pbias_sim_reg: pbias_sim_omap4 {
+						regulator-name = "pbias_sim_omap4";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3000000>;
+					};
 				};
 			};
 		};

-- 
2.53.0

