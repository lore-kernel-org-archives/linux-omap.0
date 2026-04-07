Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A138D018;
	Tue,  7 Apr 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606192; cv=none; b=FojUZhsN30Ewj8h1QU+Z7M5BozTCQFdcFJqdJCSh+7dnZORVmI7cChtED6dhL83+5Z1H+zx/z7imTdqjVZWmHGccybtdIAcfaAoVeF8fJZIleDWeZqPJac3/TiNoQI1XqBlhpH50WrCFmDMHt208kJe/pKrqB+8tD9O6zV0AAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606192; c=relaxed/simple;
	bh=lDHPIP0z91YIoy/9et8RAk6xDXDfMvOvLikEmjLe23E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHNxscB3PmbfGAAnvCyKigqvNqVicS0b2c9VrNon1ODMlpZiUzHg4prSuIdTTQdaVYS8l2FW7K/VVUoe6hf7SnczEcTF959W+4BrqmQEC7Q4BWouoijWf8Poldo7zHrtH1S4GvQFYNmqHSg9Ew6LU1fpSnMK1ad47XfAyvqck+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=etZKesGq; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="etZKesGq"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 47A12C011866;
	Tue,  7 Apr 2026 16:56:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 47A12C011866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775606181;
	bh=lDHPIP0z91YIoy/9et8RAk6xDXDfMvOvLikEmjLe23E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etZKesGqg8Yyrjb9O/jaDjI/86KXY6pYOmhT97KKTouVQbpQSlEg2zk7wuGKb389z
	 VU41KCeCikcbyThzNvL8gvnUOBrfGa6CRrQk+a6MO8JwjHXJ1A5YU3aaHk6Zz0zVcy
	 Tay/hxbKuORbJU3qIbbYwu8thbi3eP2vnyg2XtUk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 399BDAE80;
	Tue,  7 Apr 2026 19:56:20 -0400 (EDT)
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
Subject: [PATCH 2/2] pinctrl: single: Add bcm7038-padconf compatible matching
Date: Tue,  7 Apr 2026 16:56:11 -0700
Message-Id: <20260407235611.550515-3-florian.fainelli@broadcom.com>
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

Just like the TI J7200 padconf, we lose the context and therefore need
to save it and restore it across suspend/resume states.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pinctrl/pinctrl-single.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index d85e6c1f6321..657b42caf811 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1960,7 +1960,7 @@ static const struct pcs_soc_data pinctrl_single_am654 = {
 	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
 };
 
-static const struct pcs_soc_data pinctrl_single_j7200 = {
+static const struct pcs_soc_data pinctrl_single_loss_off = {
 	.flags = PCS_CONTEXT_LOSS_OFF,
 };
 
@@ -1972,6 +1972,7 @@ static const struct pcs_soc_data pinconf_single = {
 };
 
 static const struct of_device_id pcs_of_match[] = {
+	{ .compatible = "brcm,bcm7038-padconf", .data = &pinctrl_single_loss_off },
 	{ .compatible = "marvell,pxa1908-padconf", .data = &pinconf_single },
 	{ .compatible = "ti,am437-padconf", .data = &pinctrl_single_am437x },
 	{ .compatible = "ti,am654-padconf", .data = &pinctrl_single_am654 },
@@ -1979,7 +1980,7 @@ static const struct of_device_id pcs_of_match[] = {
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
-	{ .compatible = "ti,j7200-padconf", .data = &pinctrl_single_j7200 },
+	{ .compatible = "ti,j7200-padconf", .data = &pinctrl_single_loss_off },
 	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
 	{ .compatible = "pinconf-single", .data = &pinconf_single },
 	{ },
-- 
2.34.1

