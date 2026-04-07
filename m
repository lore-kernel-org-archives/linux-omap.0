Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9B38D018;
	Tue,  7 Apr 2026 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606181; cv=none; b=ZhD4xVgOuap8CENQlwj7aqi8B3rd/aIpdued4Wl5TebUkLQXgfQZrQi/3DREYXtcwMpzW7bXZvelkcb7J47NnAFKA1UPQ3NeTOwaE8enralO0p1FLscXEn7kkvuTQmA05R2vEf9ZWGai9QPEqpmw/Gn+r07AvUI51JBvV05TUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606181; c=relaxed/simple;
	bh=NkCIIF2z9mS3Ez9+Jxm0z7amc66BFTGeo8CZqQ83kuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2IlvxxokxsUMB2R6ff9xtCYBf5qjGmf5UyvJ4N0RbV7jEfOBx583pVdop8hTXmgIBYJJmeQewpJhuHagr1rBslVivb0aAg5GuuBsUW3CEDuBeD+ECwLBpRdFuVms6hQkfVX5gIyMLkY+spta50SM8z4OlIF82ZCrVSJqeBFibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XZzrEO4w; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XZzrEO4w"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 28278C030951;
	Tue,  7 Apr 2026 16:56:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 28278C030951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775606179;
	bh=NkCIIF2z9mS3Ez9+Jxm0z7amc66BFTGeo8CZqQ83kuU=;
	h=From:To:Cc:Subject:Date:From;
	b=XZzrEO4wWcbKmprJHvaeh0mtpymK8En4IwSJHqRqRN0sJsAjBw2idbX1GeEd99/5S
	 ihX+qHxe1vPoKoU/NmsJKGSWtv/BAnLZBtJebsD7FY4xKMYKpISPiQlbWmaPJpV82m
	 YHTSxn1jvkmfaTVSJwQRqTkad/ZPBHCJsz/I7Tl0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 3930AAE80;
	Tue,  7 Apr 2026 19:56:18 -0400 (EDT)
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
Subject: [PATCH 0/2] Utilize pinctrl-single for bcm7038-style chips
Date: Tue,  7 Apr 2026 16:56:09 -0700
Message-Id: <20260407235611.550515-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set allows Broadcom STB chips with the BCM7038-style
pinmux/configuration blocks to use pinctrl-single. This does not
preclude us from making use of a more sophisticated driver in the
future, should we need to.

Florian Fainelli (2):
  dt-bindings: pinctrl: pinctrl-single: Add brcm,bcm7038-padconf
  pinctrl: single: Add bcm7038-padconf compatible matching

 .../devicetree/bindings/pinctrl/pinctrl-single.yaml          | 4 ++++
 drivers/pinctrl/pinctrl-single.c                             | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

