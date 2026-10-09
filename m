Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117394CA790;
	Fri,  9 Oct 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543275; cv=none; b=Eqcygd/tkd5ysCw4dYb1HaovuAKYWX/YE2+02/yWMxTwggGFL4ChwA2tFzpYmWvbIWxuZ6vcdQlqpycHZ3Ums5i1dwXXavA3NhtI3QTimlrk1ZY8ODXk0d9fOkOJrcchfkcHPPeC85fvMQt0t4IaZ7x0dBlckuwGyVCf1vo5tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543275; c=relaxed/simple;
	bh=QWfDTsPEtpXZqWKKz/v/V/oMDxP2+xMMOxR62xlFr5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf5SAob/a4aPam8kW4wn5W1K8WVzAOPuRP7LLCWXLEn/A4UPthIfWbaujNt/jjD9UZcIpzqt5pF2waOuvyPVu9HST0OZZTBdovHnko0BS46uB+uVBE5gTcp74Ng5n9e6KpnORXsYbPWNX9g64lUFwepTworw1R1QLSZHpnayFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DdH83U+D; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DdH83U+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rp
	O4WDzaFdn7OJ5Ok0/pHV3CuqSEzHovW6aTlMkvFzA=; b=DdH83U+DAQ12NRQFKw
	ErSkIVeGtycniOQHRccTjzLE5zXh18OAudboVpbFvW37UliooMQqluJlTNaS1TVn
	9nylPEM4q+ky3o8uQHtDJqlSSFgYrnbe/A1d8S6zxIEySD7HdP5AK49dK0tSDcN6
	/Uipzxct0QjZJjVWyChQBzgZ0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAX19XEx8hqHXqzDg--.691S2;
	Fri, 09 Oct 2026 18:53:56 +0800 (CST)
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
Subject: [PATCH 0/3] dt-bindings: display: ti,tpd12s015: convert, and fix what the conversion exposed
Date: Fri,  9 Oct 2026 18:53:53 +0800
Message-ID: <20261009105356.300188-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAX19XEx8hqHXqzDg--.691S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1rAw4UJF48tr4fCryrXrb_yoW8uF18pa
	9xWF4DCrn2kF15CrsrXw1qyFZ3Ca93WF4vgF17G3y5Aan8Cw4Fqry3Cr42vrWUG395Cw40
	vF1Yg3sFgwnYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pikhLnUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AXvZWrIx8VMLQAA3q

From: Chaosheng Qu <quchaosheng000406@163.com>

v4.  The three things Laurent pointed out on the v3 thread are addressed,
and the conversion is separated from the two devicetree fixes it turned
up.

  [1/3] converts ti,tpd12s015.txt to DT schema.  gpios is back to three
        entries: the two drivers obtain exactly three through
        devm_gpiod_get_index(), indices 0 to 2, and neither file mentions
        scl, sda or ddc.  v3 had raised maxItems to five only to keep
        dtbs_check quiet for omap5-igep0050.dts, which wrote a defect of
        the DT source into the binding.  That was backwards.

  [2/3] drops the two extra entries from omap5-igep0050.dts, which is
        where the defect belongs.  Nothing reads them: there is no
        pinctrl group for those lines and no other consumer in the tree.

  [3/3] drops the unit-address from the tpd12s015 endpoints on
        am5729-beagleboneai and am57xx-idk.  Those nodes carry a
        unit-address without a matching reg property.

Each of the two devicetree patches removes a warning that the bare
conversion leaves behind, so the three belong together:

  am5729-beagleboneai:  241 -> 237 dtbs_check warnings
  omap5-igep0050:       188 -> 186 dtbs_check warnings

with no new warnings in either file.

Assisted-by: LLM is on all three, which the v1 posting and v3 were
missing.

One thing I raised on the thread and should repeat here: Eduard Bostina
posted the same conversion on 2026-07-30,
<20260730092245.52034-1-egbostina@gmail.com>.  If his series is the one to
carry this, say so and I will drop mine.

Chaosheng Qu (3):
  dt-bindings: display: ti,tpd12s015: Convert to DT schema
  ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi
    encoder
  ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

 .../bindings/display/ti/ti,tpd12s015.txt           |  44 ------
 .../bindings/display/ti/ti,tpd12s015.yaml          |  90 ++++++++++++
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |   4 +-
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   4 +-
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts       |   4 +-
 5 files changed, 94 insertions(+), 52 deletions(-)
-- 
2.43.0

