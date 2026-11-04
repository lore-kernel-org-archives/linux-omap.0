Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805791;
	b=0Ja3nuF4mWfuI6T7zp9KQlqibDfdwS/46ZkzdB5t8lkTIV49fSJqn+LW/AeXrGTm8U+N
	 vIVh5uBpzxJ50wgRimP38B4LCkxy7FNgGPpIZyX0EY6hfTdwy/WJD8+0WBEHCGSwD/Vu4
	 ZI7SODzpCIKvLzdgF1EfVKB8BVmHqz4tUfAM9ISo0S+R5PXuB2vH6D8gU/I7kdrI28fPd
	 bqkgbWbOw8/1kN66M3kiJ1G7hmZhXusJXdKJ7RMLgmGt+ktQLSoejBI9GUHanWf6tXah4
	 nydHtdyROJ1eoZMhwEq5zt8El1EHOVrYhS92bK0x85p1qcDxSuD50mGoSdTW5cDle5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805791;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/C2hcYZOYvJEefWID095f9m7L8eAhaaSvDOhtc1OYaM=;
	b=2ImzNhzFQ0Hz/jy67KBwFHYcKVx7ZRyJUkL3wCLtWtj/zp5aFif0YzWQ6f8ik5SGxHle
	 W22TAZoFG+osLipYNobkp29v1aW2/cNj+vc+wXFFenZwzgWLn8CkB7HNd285sLSMhFb4f
	 4YmbtHtgdkmHKAApTatwAFteWV88dT74nM5n25c8zt6poB6Ji/vAwFLJCCemEywqepajV
	 lKmoIOKCZiLmBYxfEf/ZR+ZXtQpx5j0K/ONd9ywhn2ftr0Gv7tvmpJ62wxWwP2Ff+cnt+
	 k/Tesz9v7t9kr7HB1hE7LUqYLqD9MKt6lao6uh6W30a7f+L1tqghQkW7vjWR4E68VTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SxT4X7NL;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C062606A31B;
	Wed,  4 Nov 2026 15:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C062606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SxT4X7NL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7EC7B1A139E;
	Wed,  4 Nov 2026 15:23:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50E5760770;
	Wed,  4 Nov 2026 15:23:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CFE7103291D1;
	Wed,  4 Nov 2026 16:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/C2hcYZOYvJEefWID095f9m7L8eAhaaSvDOhtc1OYaM=;
	b=SxT4X7NLHKvj7CHPFTAlZII+WFJ3xmJWpcW3TxQICl2ID4y9/N7gCTHyc+jkTGXMA4X9V0
	KvSdd+fN4/pfAFW6QYqEfWTE0PUrr9vjeFVDmr7PibtiD3ulZyo/AD0mSZWUtDoZ03Lx8o
	gpO0ddPp4EPk9jPUr6cnzJxjAbnsur2+5dYfrvlzrBfy8RizxdOmZETd9S+RSD68o7WBb7
	jnB7D+DHkWFio75tfVb6hTyuqhH8mNWTYSuPenH7krpiHumHBt6C60e0M/QUxPwW1Y9cAH
	zLtnfXWrwN8sWAg9vkAnQB9sQijLj8Y9oy/TJeC7TcFxMmYXOUBJuOuM0mbtvA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 04 Nov 2026 16:23:01 +0100
Subject: [PATCH] ARM: dts: ti: var-som-om44: add local-mac-address property
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
Message-Id: <20261104-omap4-dtsi-v1-1-8d987f953fe7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3fzcxAIT3ZSS4kxdQ7MUE8NkE0vDZAtDJaCGgqLUtMwKsGHRsbW
 1ANko3QNcAAAA
X-Change-ID: 20261102-omap4-dtsi-16d41c491c81
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Richard <thomas.richard@bootlin.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Commit d8f1b27c9f12 ("ARM: dts: ti: var-som-om44: Add USB Ethernet
controller node") added the Ethernet node to allow the bootloader to
patch the device-tree to set the MAC address.

U-Boot has an already-existing helper that does that but it needs the
local-mac-address property to be already in the device-tree and an
'ethernet' alias for the Ethernet node.

Add the alias and the local-mac-address property to allow the use of
this already existing helper in U-Boot.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
On U-Boot side, the support for this has entered the main branch with
commit f5df14cb949 ("omap4-var-som: forward MAC address to Linux")
---
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
index 9e04aa70f982..6c615dd71491 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
@@ -10,6 +10,10 @@ / {
 	model = "Variscite VAR-SOM-OM44";
 	compatible = "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
@@ -334,6 +338,8 @@ usbhub: hub@1 {
 		ethernet: ethernet@3 {
 			compatible = "usb424,7500";
 			reg = <3>;
+
+			local-mac-address = [00 00 00 00 00 00];
 		};
 	};
 };

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-omap4-dtsi-16d41c491c81

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

