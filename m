Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFB389469;
	Tue,  7 Apr 2026 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606187; cv=none; b=l5rBuFTNGCI5zMWgXE6mU8NarIfkLVWSggb/VH8aJm7PS2tZJegvHLtFII0P3WrvxMN9L1BxsH/GRfM3WWMoBb3hDEvS1UUJpQHfuXHrii3QhPgbFK9X7cRcOz1czvWeOcutYleBfTWRzRpltKqgT1+8cBi28+rWbAfNcXVLrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606187; c=relaxed/simple;
	bh=FxZb5iB7wem8tBCkfh2yjwja+J217c+kc8Kc6lBt+94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHabbkeue8tIDQORAMrdV0Y9tDe1yGJ7nTHmf+p59f5pTk68KA/T8OLo2Im5dscFZsT8cnrv8mfPXJOYU2MSqvqKfMZJxMqn+tJHvWt+oSKX6XCFfLHbtHqdceIWsN4lJTyTTDsqrqD255T5c5E5OR4V9cZ2GWYBFhdn5bcyxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DKYL0dGs; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DKYL0dGs"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4BFC8C026444;
	Tue,  7 Apr 2026 16:56:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4BFC8C026444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775606180;
	bh=FxZb5iB7wem8tBCkfh2yjwja+J217c+kc8Kc6lBt+94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKYL0dGs1fToe1L0p3LU9iuewyQV8WtA8RUYyIGCjVtxkjBuOlOtWH9na+8Lu+ZP9
	 28q62mfgwX2JHaycS00pJy5RODqOdJegi/flPe/t4w3W6ia0SBv9PPtfuEdokjLsTn
	 HssldKzt+zpFy2ADS0K6vySuAdI18tLbqJKERzoY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 3EE98AE81;
	Tue,  7 Apr 2026 19:56:19 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:PIN CONTROLLER - SINGLE),
	linux-omap@vger.kernel.org (open list:PIN CONTROLLER - SINGLE)
Subject: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: Add brcm,bcm7038-padconf
Date: Tue,  7 Apr 2026 16:56:10 -0700
Message-Id: <20260407235611.550515-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407235611.550515-1-florian.fainelli@broadcom.com>
References: <20260407235611.550515-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "brcm,bcm7038-padconf" compatible to the pinctrl-single binding.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index 9135788cf62e..afe7329a1df2 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -38,6 +38,10 @@ properties:
           - enum:
               - marvell,pxa1908-padconf
           - const: pinconf-single
+      - items:
+          - enum:
+              - brcm,bcm7038-padconf
+          - const: pinctrl-single
 
   reg:
     maxItems: 1
-- 
2.34.1

