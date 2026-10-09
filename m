Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAA4BD78F;
	Fri,  9 Oct 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543265; cv=none; b=kO2U1L64ajGfJGyQEkVxqG96sQMACCKJaEvYKLvEeCv7gpGrmmDwNDslvHOHb4N1ieIXAU5p+hXQfDXHdK6fk8WLUJ4zihZpPzJVK5VJ6iKEup1Sd/X2avvGomhrzNjVzYVXuzijxDSeVC3FjHrBzNDxT/7PvzDwipJmoChCLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543265; c=relaxed/simple;
	bh=g3CZoYHJna7Pc063eIRpS7CHxPnMYVH37s2UtbhIpMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGBzKpleAYIklcED7spnfm/E29Lek8s7JGbw6vLCAJw4JO18cjaLTRF8YoJytAE9TFqSX6WBaW69ehkayqYzHfDDrqNyCwA86I5emiN7f+/p2VslqbmyprOPJLFo5NgM+olRGODMjCM0qZ9nnKHaG7fYN9ktzUcuzrPsQdBwLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fcpDfl7B; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fcpDfl7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=q6
	KiQ0JnIYlZjIauCBrkVstsxm3xXiTQEIf87XsyrHw=; b=fcpDfl7BxKIuQUqkKh
	B64qwim91T1aBqLpcRWiPJei9ycQ2N10k2InQoQxAV4YVkDQ/xd0YHorrUqTkcl9
	KSNvIZzNXTNJImHRv53TzsBD+F4t/EnXNy/PWl4nP8X0hoUykcvaxzOa3qd1ks4k
	Bja8hNjawZFG/nOyc7NCHfVAI=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAX19XEx8hqHXqzDg--.691S4;
	Fri, 09 Oct 2026 18:53:58 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH 2/3] ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi encoder
Date: Fri,  9 Oct 2026 18:53:55 +0800
Message-ID: <20261009105356.300188-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105356.300188-1-quchaosheng000406@163.com>
References: <20261009105356.300188-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAX19XEx8hqHXqzDg--.691S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw15Ar4xtw1UJry7Jw4fXwb_yoW8XF18p3
	9Ikr4DAr929F1ayws7Z3sFvF45CanrXFyq9r15Kw4rAw1aqFyxKrWSkr1avr4DJFWSyw4F
	9r45X3srt3Z8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pZjg0DUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AbvZWrIx8ZMPgAA35

From: Chaosheng Qu <quchaosheng000406@163.com>

omap5-igep0050.dts lists five GPIOs for the tpd12s015 encoder: the three
the driver asks for, plus two more that the comment names "SCL" and
"SDA".

Neither driver reads them. ti-tpd12s015.c and encoder-tpd12s015.c both
obtain exactly three GPIOs through devm_gpiod_get_index(), indices 0 to
2, and neither file mentions scl, sda or ddc anywhere. The text binding
that the schema replaces said the same thing: "gpios: CT CP HPD, LS OE
and HPD gpios". There is no pinctrl group for the two extra lines and
nothing else in the tree consumes them.

Drop them so the node describes the three signals the hardware is wired
to through this binding.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
index 0368e32f67e7..8e8325936cda 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
@@ -102,9 +102,7 @@ OMAP5_IOPAD(0x086, PIN_INPUT | MUX_MODE6)	/* gpio4_118 */
 &tpd12s015 {
 	gpios = <&tca6416 11 0>,	/* TCA6416 P01, CT_CP_HDP */
 		<&tca6416 12 0>,	/* TCA6416 P00, LS_OE*/
-		<&gpio7 1 0>,		/* 193, HPD */
-		<&gpio7 2 0>,		/* 194, SCL */
-		<&gpio7 3 0>;		/* 195, SDA */
+		<&gpio7 1 0>;		/* 193, HPD */
 };
 
 &twl6040 {
-- 
2.43.0

