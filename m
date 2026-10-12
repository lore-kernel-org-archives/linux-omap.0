Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598D4766A8;
	Mon, 12 Oct 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807020; cv=none; b=GzOBVBa1p9K8HLsOKtbfhWpJV1Z3Lhd9QaGR3E/DNkUqIfJhsGX9Cl7e8NdwKLqAjet43anoY7nlSWjjdqqsw+VrWiy9wSbHMFvr4IFoKckg72IF3YEw1baairoOC5CBeEz3+oE/dvjnxzRBVipup0oNZ/v6fUTKLsMh103XskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807020; c=relaxed/simple;
	bh=lNRcAUgKgQ3+06qfzDmCw6ec5pwHZ+dJbRpu1Awqnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv54Py87LXeJZuedlFyyoym0HkCviqF5EdgunZ7tM98P3M29ksGtr+7QoKpX17Oy82itqZCBVNTYvQDmsEiUIAtvcLFeKTi5ncLnMgaQ2PauZGHe2y0ZN3zfMjh8ivdq7jpSF70bKbTtfoorea9B7F/EndlVP5hi3eZe6U+wZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FU5lx9T9; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FU5lx9T9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Po
	nCbc/xJHNlxMrmJfxsNmEN6pluLhutUWocJ/bKsbM=; b=FU5lx9T94oquECpIhi
	5qModf2TfFNxOKBY2D+3nStgsgJaZcnl5s/NvFSYBt5rE0lHy3p8kppwsw2DrELQ
	nDvSQ4HrmYdl9T3dCH/dt4M9AMs2X2sRztkBIRjyXwgZotcxF8goFZaT2aNvkZSP
	09NvWCNjWVE6w2EiWcuMJji4I=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Nz_mzcxqHGNeDw--.1037S5;
	Mon, 12 Oct 2026 20:09:15 +0800 (CST)
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
Subject: [PATCH v6 3/3] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Mon, 12 Oct 2026 20:09:10 +0800
Message-ID: <20261012120910.506444-4-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012120910.506444-1-quchaosheng000406@163.com>
References: <20261012120910.506444-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Nz_mzcxqHGNeDw--.1037S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18GryrtryfCF4fZFyUGFg_yoW8CFyrp3
	sa9rs2yws7Kr1jkan8Zw1q9F1DKFWDuF1ayF4UWryUC3W3Xw1rJr17twn2kr1UCayfZw4j
	9rn5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEeOpZUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAt78GrMzevb4wAA34

From: Chaosheng Qu <quchaosheng000406@163.com>

The endpoints under the tpd12s015 ports on am5729-beagleboneai and
am57xx-idk carry a unit-address without a matching reg property, which
dtc warns about:

  Warning (unit_address_vs_reg): .../endpoint@0: node has a unit name,
  but no reg or ranges property

Drop the unit-address.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 4 ++--
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb364777e..f40017a0e414 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -168,7 +168,7 @@ ports {
 			port@0 {
 				reg = <0x0>;
 
-				hdmi_encoder_in: endpoint@0 {
+				hdmi_encoder_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -176,7 +176,7 @@ hdmi_encoder_in: endpoint@0 {
 			port@1 {
 				reg = <0x1>;
 
-				hdmi_encoder_out: endpoint@0 {
+				hdmi_encoder_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 5eccff3bb4b6..4e8a5820b05c 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -135,7 +135,7 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -143,7 +143,7 @@ tpd12s015_in: endpoint@0 {
 			port@1 {
 				reg = <1>;
 
-				tpd12s015_out: endpoint@0 {
+				tpd12s015_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
-- 
2.43.0

