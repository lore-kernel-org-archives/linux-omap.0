Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EE4CDDFF;
	Fri,  9 Oct 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543279; cv=none; b=XOqp5kQLPhS/mXyNJqySaWUVOTwYW0sDUhOnWRvUSTAux8f7gGttN3voicxnv15Mov8u4eD6FHOMy0fJS3tXXJv/3d8xv0Zk4ALy8UTBYOOleIUDAoaxyjNf+TTPRJsg4el2aKhKbjPAB4kOPLYDFOiE4jeYmin6raVhKMZmhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543279; c=relaxed/simple;
	bh=g3CZoYHJna7Pc063eIRpS7CHxPnMYVH37s2UtbhIpMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHvkb2pz4oqOZfBb+cT7I6whdC7T5Tp3Z69u+fg2DCpfEb1g/NPluZ6Tju6ZypmYpx+KMUlxAUO0gx/Wtk5uMoM59REXAPOioj+NJysE+kpUbUFIdw8nEIXuLdRjZpe4WXhOhYcUcl2S0NcWrWAiMYTqgHd49B5KUe0UIaIi7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mF9LnetM; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mF9LnetM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=q6
	KiQ0JnIYlZjIauCBrkVstsxm3xXiTQEIf87XsyrHw=; b=mF9LnetMlO8n37nrj8
	oQd/EPbLkrfWWt0sLSs7ENU9dUvG+ivtAL1wue7nhwS34sD9nZo3X4XxF2xKY04X
	0+0PBAZguMw1h7iySjluxiV5CowJh9NMHukGyIuEHt7tMLb86pzu7xRFMx/h+PwM
	1HSdWXFAmKI1+yD9kvlszSHoM=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3vmvUx8hqvTiFDg--.2548S4;
	Fri, 09 Oct 2026 18:54:14 +0800 (CST)
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
Date: Fri,  9 Oct 2026 18:54:11 +0800
Message-ID: <20261009105412.300338-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105412.300338-1-quchaosheng000406@163.com>
References: <20261009105412.300338-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3vmvUx8hqvTiFDg--.2548S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw15Ar4xtw1UJry7Jw4fXwb_yoW8XF18p3
	9Ikr4DAr929F1ayws7Z3sFvF45CanrXFyq9r15Kw4rAw1aqFyxKrWSkr1avr4DJFWSyw4F
	9r45X3srt3Z8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE5rc3UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xbzaWrIx9bWHAAA3W

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

