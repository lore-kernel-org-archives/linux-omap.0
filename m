Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3735A385;
	Fri,  3 Apr 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242970; cv=none; b=YSNTzaveI4MT2UkzlIMAEWg3UYnZHhTiDMW1dsMpi7NevLaA0esArpRsih/RZdJcxCMlSBfL5x9AwEXV7W/vcRuuwFffKjef2qGF9c1tlpJEPLzG4HlXgQzmt0qg99Ncm/aGAcbZ20qthfEtbsDTVUnbju9aOL2eDPYV33EhIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242970; c=relaxed/simple;
	bh=xMJ0Nvap2CsnK2uUrSWpt8DVV7KnOOtBSBQOOGMrk+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OYCdocFJ2PwYP8yJsdr1odsKk5tevfJ6bRDafBS0rPjYdbvEK66No+gvQFC5iAMnEILlDtgOGh4Pxww8uNEEy7+wbig6oBpHwdK5Qi/tNtNsR78BoWaX2ZIDgVH2ED7TU7E2Ewansi8b14hYYsBxhHf5RSnw+gL3LJyP+6cnbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqEjNb1K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqEjNb1K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76DF84E428D8;
	Fri,  3 Apr 2026 19:02:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 326EA603C1;
	Fri,  3 Apr 2026 19:02:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A61A104500FC;
	Fri,  3 Apr 2026 21:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AKUAxsGIowO/qrP3Ue03zFJGU3E4OczJZllSpoli1EQ=;
	b=DqEjNb1KN6GZpdZrVsSvAigRbFH5SDwLZj0XZNTWzbBIZqKgs1sgvnhgqs1/mQz7Kw/+bI
	/cnQy9RLEsaPDePl5EPR9UPEFgRterBtZeYMzDAArv6kjwFCcUdvNObJN1V8XtIHCR/pJN
	bd8K+JY9Q0EgoPLcjBudqHF2bpgvM3x4gLxTt+WDM5/Vp0ar1ybAR/ITt/gku1VzJLVUk+
	nyEp1MS1FWnW9kHkLliIWzsluKJ1f6J2Oni1dpNJFrEYfyOBWAXuSGuXTP3wTXKELplf08
	AQt/0HQsTBFCrpAuHHUlO41TNES2l6fyRXFWqQqHVttluss9882qEjyT9iylpQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Date: Fri, 03 Apr 2026 21:02:22 +0200
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4O0GkC/x3MQQqAIBBA0avErBuY0oq6SrSwnGqgNBQkiO6et
 HyL/x+IHIQjDMUDgZNE8S6jKgtYduM2RrHZUFPdklKEs8ZkAkZ/oj+1xsO4riFC6u1ql65SVvW
 Q6yvwKvd/Hqf3/QDdrtSYaQAAAA==
X-Change-ID: 20260330-b4-var-som-om44-lan7500-09dfdc713d39
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The goal of this series is to add the USB Ethernet controller node in the
VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
devicetree and pass a MAC address to the smsc75xx driver. This was also a
good opportunity to create the schema file for LAN75XX devices.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      dt-bindings: net: Add schema for LAN75XX compatible USB Ethernet controllers
      ARM: dts: ti: var-som-om44: Add USB Ethernet controller node

 .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi  | 14 ++++++
 2 files changed, 66 insertions(+)
---
base-commit: 6fa0f2cbadc046c57fdd2aa1dad81553cca08963
change-id: 20260330-b4-var-som-om44-lan7500-09dfdc713d39

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

