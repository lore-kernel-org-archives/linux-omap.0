Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE04471269;
	Mon, 12 Oct 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795191; cv=none; b=oaxBtFFsharTkHubSbfKFsnE5r4J1U8hrQpbmg5hGeAoYT81yX1d3u7wvDQmINEMLbV1Ov/UNHmexknDm658HdQOsIP2t1lGLBlcB44/UkjpSOGkD1YYpT4yKRblOIls60YGh42X2skJ6OILIhc745/x6fC5+GdXXFfiHa6j7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795191; c=relaxed/simple;
	bh=tBw8AnSAuUdFX0dHuetjUscoCgMSHOjX9xOFoZ1RXY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBO/uNhNyFg/MOa9kY19TK+jhosm3aJPxRNFSYF2qGYR5hyOM60jys8gtgFvqIXKPdhAyegg/ELzFpfbCh0liVAz6rA/Slt6NcfJ9Bs903So6eaTtE+ALMxSu1nWFwRr4FCeUAOS8TIu2DB8XLOJVAIX0K68mFen/u7ychww6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HzMpL1y9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HzMpL1y9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RE
	/zNUeGEkWnIm8O95nzlupYlUidLYEUOb0tJRK/LBQ=; b=HzMpL1y9zcisNegExp
	cZOY6biq7SrDKrz3aCTWW7scfEAsbzqyDwVW3vKkrEAHWadoXWARWaw0vMpD2XX9
	Q4n6QFYSMSY/zUUZEF1+RlWgeb+vJstd6O3xQlge7CjtGzA0Yk4wv0raea3XH5pK
	++4VQGH/ZKm3LpEdswwB2bDwE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXn6rVn8xqjDtnEA--.23112S2;
	Mon, 12 Oct 2026 16:52:38 +0800 (CST)
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
Subject: [PATCH v5 0/3] dt-bindings: display: ti,tpd12s015: convert, and fix what the conversion exposed
Date: Mon, 12 Oct 2026 16:52:34 +0800
Message-ID: <20261012085237.377612-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn6rVn8xqjDtnEA--.23112S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18tF4fWryUGr48Jry5Jwb_yoW8uFy5pa
	9xGF4kCw1vkFy7trZ7Xw1v9a93Ca97JF4kKF17JrW5Jan0k3W0vryfKw1YvryUGayfCayj
	vrn8K3sFgwnFy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizBTrUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xbqYGrMn9aZrwAA3m

From: Chaosheng Qu <quchaosheng000406@163.com>

v5 of the tpd12s015 conversion.

  [1/3] converts ti,tpd12s015.txt to DT schema.

  [2/3] drops two gpio entries from omap5-igep0050.dts that nothing reads:
        the binding and both drivers describe three gpios, and the extra
        two have no pinctrl group and no other consumer in the tree.

  [3/3] drops the unit-address from the tpd12s015 endpoints on
        am5729-beagleboneai and am57xx-idk, which carry one without a
        matching reg property.

Patches 2 and 3 remove warnings that the bare conversion leaves behind:

  am5729-beagleboneai:  241 -> 237 dtbs_check warnings
  omap5-igep0050:       188 -> 186 dtbs_check warnings

with no new warnings in either file.

Changes in v5:
 - ports: use "$ref: /schemas/graph.yaml#/properties/port" and drop the
   unevaluatedProperties lines.  Neither port carries anything beyond the
   graph properties.  Reported by Rob.
 - description: drop the "|" block scalar.
 - no other change from v4.

The sashiko finding that gpios lacks "minItems: 3" is not valid.  Rob
explained that dt-schema makes the two bounds equal when only one of them
is given, so "maxItems: 3" already means exactly three.

Eduard Bostina posted the same conversion on 2026-07-30,
<20260730092245.52034-1-egbostina@gmail.com>.  If his series is the one to
carry this, say so and I will drop mine.

Chaosheng Qu (3):
  dt-bindings: display: ti,tpd12s015: Convert to DT schema
  ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi
    encoder
  ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 88 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  4 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  4 +-
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts  |  4 +-
 5 files changed, 93 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

-- 
2.43.0

