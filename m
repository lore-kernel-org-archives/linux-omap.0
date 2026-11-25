Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619317;
	b=xdTHY5MkRynq5mkbFgM3UMlNgOCpmf7NT4SSECwa0LVxEYZZWXao4cma14SPSvFWMLGi
	 U6slrH9h9bwy8xQfhEwv9Q+83kAdLJOh7uEBFtsOkj9p3QC9TULIAeThsbEZKNfjO/rIu
	 QpV93lVn/CHcfzVhGwb/kL3xDiOICg1cggiTifwL0EYbeM1IdJkQrZnLn1HprRDbVSL8K
	 fBTV/Pk8dAMbjTO2vcoueo6xWZEB50kgI3nfl9g95R5mVTo80/rljRn01hNSx2mIfNkqX
	 A8qf3iykEseh6+3Tgh6YWx5EoY57gwrDVnyNlLgBdxkyR4dvhvvvkDwcjVVcXbleJ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619317;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=jKiINtiFZLvv3fP26wCKrvWeqdgvC4rYIw8HH1SOXJs=;
	b=PCjzxNrPj41ypIkDBHAhG4tT8F9W+ZCk4UkFPe8flBkm/5lFl/gn3hYOA8k3C66haj1z
	 4mWuh23sX56E6LFQxppSdinl1cFpW1Qg4GaIQCPVG4UDKHivg1fFpK4STIlqP0VUgdTR5
	 Wt+MDt5hOXKFQhc3ISQ+c1QjHF9DRtGIvM3nAV1wed0PgBzcu7yt6Srlxj6I41PhyXh5j
	 uR2YaVrvCrkZwqVcfEuRIMray50a5H0jdn6b0jw5JEyE9Iq5eOxWNsrAmQJyHmLik7yqx
	 rtsuIBuZpFM4QC60PayptWA8JNLs3EKXDdXFObaMhjfJ2gOSLJdNA1E7snmgK0z4/nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="i72/3uma";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FE606A31E
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 15:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A85FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=i72/3uma
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 41D1B1A17EE;
	Wed, 25 Nov 2026 15:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 102FB60480;
	Wed, 25 Nov 2026 15:08:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC24411E69A68;
	Wed, 25 Nov 2026 16:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795619308; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=jKiINtiFZLvv3fP26wCKrvWeqdgvC4rYIw8HH1SOXJs=;
	b=i72/3umaoSfOZyGoBI9EBMgLsCGTRbrnPv2op4VuhVibYtgCUsQviBtVqjEgmk4FtVWM3f
	dR4djV7VLJdt2WRxo378z7GJhsvIQpm3CaTXzZOJqvft3eszbi3c+6GaUnXU7ql5ASlqzW
	pfXqP+4AjotsSwi2Rt5MIeecd80u7UTx70z8sK01KHMpOYwzxcNXZDrjkU8ohidClhmhoi
	QrNUyDqAsh1B+heixhIWVU4basxb+E4rJguwjqClHOt5c00DQWF+xjomkrZs6XfF7L2wdN
	k94zz0r8yG7n3lojpRma/Wjo6IHQvI+bINUr1Qq9C23nKuKD675btL8EiyWdnQ==
From: "Paul Louvel (Schneider Electric)" <paul.louvel@bootlin.com>
Date: Wed, 25 Nov 2026 16:08:09 +0100
Subject: [PATCH net-next] net: ethernet: ti: davinci_mdio: enable MDIO
 manual mode for AM62PX
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
Message-Id: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMBAEf0X2uQfJFQX7K6UPiZ56glGStAjiv
 zetj8PuzIEkUSXhUR2I8tGkayhgbxW6yYVRSPvCYMONtVyTWxreaOl1Ja/ZlwtZ03J9NzK0zqC
 IW5RB93/0iSCZguwZr2tJbz9Ll39NnOcXOSVe74AAAAA=
X-Change-ID: 20261125-am62p-mdio-bitbang-1092530ef9a0
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Bo Mellberg <bo.mellberg@se.com>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org, 
 netdev@vger.kernel.org, 
 "Paul Louvel (Schneider Electric)" <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795619303; l=1401;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=1il9qHivqMNwPiZVw9sPvLECBKMOEr/o3mytWEfbYUA=;
 b=iQ3j0Oto7RbAX29hgjj6WViAgS43OBahk78MZ2aXn4Dk57GMFmV0bt2K8Q1JaA51YJI9pOCgd
 lm5WbTWjP8iDzeGOm7H84cuuQwPfGjc0foUswkBtDepSnPJLuy00vyt
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The problem described in Errata i2329 also affect the TI AM62PX SoC,
despite not being listed in the following document:

https://www.ti.com/lit/er/sprz574b/sprz574b.pdf

Add it to the structure that enables MDIO manual mode.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1647576/am62p-external-switch-connectivity-problems
Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index c413887657e9..9b58ba7acc4f 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -505,6 +505,7 @@ static const struct k3_mdio_soc_data am65_mdio_soc_data = {
 
 static const struct soc_device_attribute k3_mdio_socinfo[] = {
 	{ .family = "AM62X", .data = &am65_mdio_soc_data },
+	{ .family = "AM62PX", .data = &am65_mdio_soc_data },
 	{ .family = "AM64X", .data = &am65_mdio_soc_data },
 	{ .family = "AM65X", .data = &am65_mdio_soc_data },
 	{ .family = "J7200", .data = &am65_mdio_soc_data },

---
base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
change-id: 20261125-am62p-mdio-bitbang-1092530ef9a0

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

