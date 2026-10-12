Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769A4078D5;
	Mon, 12 Oct 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807014; cv=none; b=QzIXDkDxRBE1UlbD+KeZQWhBX3u7g5idnD3hg57MsTWEck7VFh+aWGtILpxXnsNb88+cjo/hgzG5mAc2JL24XsDiw6fNJ8ir4RWjxbSYExI4MLdDO0uGcfHSN2gXP/Pz+8ktE31FrKBNclQZy7ZTVOwRRnYlavMA/xohXTbF+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807014; c=relaxed/simple;
	bh=Uwlqf7qlPT4N2Iy3JwU3MFX1mH5LGVxwdtWw3roIl2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opyVHYae3Tf0o7iFNGcTC5wd5HiC14qNE0YVNNVwpuK00412vq8Vu4vrZlhwmCXowwBOnNdaHAYdYoHQMCQHV4PwaDa6+ROra3EUhzxZAXJ6VBnWd/FoUxr0IR8DZIBuvXBDgg0TlxYU7uajMInfHMVg8m+fm0tA2D/ueuNCFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U28QwxE8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U28QwxE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EG
	jWHdD+0WJXirqwSDGo2+u4NUBE3eJztml/JqsySN0=; b=U28QwxE81Qk0EQjnOI
	T0yvJ4DU2sgIxBOlyZ2Ggo1Q9Z7nt6c7r6fj/CKuR0L1clWR0APzbg/uNnhnIhZV
	kGU8bWUDWbjbjZGlh9vHDCdcjkiX8rJntKzG0pZaK1FFxASQ03B+gJR6vFu31TLP
	ZmLuzOsAGsrjCguc/B7TSoF0g=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Nz_mzcxqHGNeDw--.1037S2;
	Mon, 12 Oct 2026 20:09:12 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH v6 0/3] dt-bindings: display: ti,tpd12s015: convert, and fix what the conversion exposed
Date: Mon, 12 Oct 2026 20:09:07 +0800
Message-ID: <20261012120910.506444-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Nz_mzcxqHGNeDw--.1037S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyrJF13JF13WFW5JFWxCrg_yoW5Gr15pa
	9xGF4kCw1kGF13KwsrXw1jk395CaykJF4vkF17trW5Jan0kr10qryfK3WavryUG3yfCayj
	vFnYg3srKwnFy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizuWJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAh78GrMzejbpwAA38

From: Chaosheng Qu <quchaosheng000406@163.com>

v6 of the tpd12s015 conversion.

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

Changes in v6:
 - Carry Conor's Acked-by on 1/3, which v5 dropped by accident.  The only
   change 1/3 saw between his ack and v5 is the ports $ref Rob asked for,
   and that does not change which device trees the binding accepts.
 - Send 2/3 and 3/3 to the OMAP device tree maintainers.  They touch
   arch/arm/boot/dts/ti/omap; v5 reached that tree through linux-omap only.
 - Patch content is otherwise unchanged from v5.

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

