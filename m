Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3B453A45;
	Mon, 12 Oct 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795186; cv=none; b=Plrsx7amThdSDTubO8zxuLJRmNPLBxK2n0qRys0YttIVyNGan7HXFOOSHVb2DmPQgzRV0JiXcGKAAapjSb52vDa9lIfeQSS4Oa8iArkNk84vO5c+NZi9BRrWkhNllC8fNxQChuQzIZLkv+0BZAoUicvmGiM6CvusVdM+ZBdErrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795186; c=relaxed/simple;
	bh=lNRcAUgKgQ3+06qfzDmCw6ec5pwHZ+dJbRpu1Awqnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwdnoFzPEcN5gEBvmj3u+TtshsHZftFHrME+n9R7mbHjtQelTCOmbIlS4SJybTfnxzOs0K5obSra0E1SsV7NZUMqtXmCL0GltA+t+NiuWpaH9kNVK+R7HC8r1DRUELI4EguO2uncWwquRFN8anka/n0XSx+ubFBeKT/lV6p41YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lHv95Xja; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lHv95Xja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Po
	nCbc/xJHNlxMrmJfxsNmEN6pluLhutUWocJ/bKsbM=; b=lHv95XjaN1BtJIKUaK
	cbm6xWUUle/D68GLnpxHV6NFhr5BwI8q+yEb9IMl/NBIk8wmuOqDxYsrAI04Btyc
	kXMPrzhcUOjyxihPCSpeYyYgpbzoR/A8h4z7Jw5rlGSsS3AnCzdERqkH/U/ioFDP
	4fx9W64SC/FPw0rDZQnTum0rU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXn6rVn8xqjDtnEA--.23112S5;
	Mon, 12 Oct 2026 16:52:41 +0800 (CST)
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
Subject: [PATCH v5 3/3] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Mon, 12 Oct 2026 16:52:37 +0800
Message-ID: <20261012085237.377612-4-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012085237.377612-1-quchaosheng000406@163.com>
References: <20261012085237.377612-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn6rVn8xqjDtnEA--.23112S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18GryrtryfCF4fZFyUGFg_yoW8CFyrp3
	sa9rs2yws7Kr1jkan8Zw1q9F1DKFWDuF1ayF4UWryUC3W3Xw1rJr17twn2kr1UCayfZw4j
	9rn5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEeHqUUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BnrYWrMn9nPLwAA33

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

