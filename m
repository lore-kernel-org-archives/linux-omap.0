Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4B4C4F7A;
	Fri,  9 Oct 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543267; cv=none; b=TgQrNFBIJInxIQ2lbLc3NgQu8JwalurP7D+Fq2QfC/46bl+b+3GP0gt1g9lEgA1UQW4U5Xqv6YuXC/i/B1gCVqA4tcKup1wXEcu3OoJQ2VeBW75jW5torFJMhu5I599/CdkHNM7qRHCUnthjS8qxiENazE+OnmbbTInowN8WDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543267; c=relaxed/simple;
	bh=2hPqeInkmw8dt5AYJTT6rr65iGpV6pnYu621nd+a2Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaY1gbj2mDijUO1Bbi7I57JMXeb5vT0FXv+SQMt9IF2rhpwyZflti/t4waSjwJGuHxV1TXCfM80h2rZixViRT61YcUPL0BzF403sh/tOYPTgHdZ5LSAz9bW6/WXscJAxV+rMj0oeeVNXvwri1ggznG04EdFFjToVUUlr+u1viME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JTZYIN2s; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JTZYIN2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SU
	2hOrP3XkxbQgBianI5yCRcm1GVQm++rhoG9WeYkXY=; b=JTZYIN2sj0vAuoqrps
	vi/0vx2GE7Bj55qSbh6B4dn0hJWYx44xkMXh/wgbu39J8SrWHRdDffBhmMMv3hwd
	mCudI2CZ/DWTtT+kcSecklEJHwihtSfohKRi5rueDYJUJqz1PC7ITSmxmoFxXA0j
	pPnislj0xrvIUd0HXBLUwvMJ0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3fLnAx8hqSa9RDQ--.50503S5;
	Fri, 09 Oct 2026 18:53:55 +0800 (CST)
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
Subject: [PATCH 3/3] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Fri,  9 Oct 2026 18:53:52 +0800
Message-ID: <20261009105352.300149-4-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105352.300149-1-quchaosheng000406@163.com>
References: <20261009105352.300149-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3fLnAx8hqSa9RDQ--.50503S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1rXry7try7XrWDtw43ZFb_yoW8CF4kp3
	s29Fs7tws7GF10kF4DZw1qgFyDKFWDuF1akF4UWryUCa13Xw1rJr1xt3sakr1UCayfZw4j
	9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_b18PUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wPuZGrIx8PVFgAA3P

From: Chaosheng Qu <quchaosheng000406@163.com>

The endpoint nodes of the tpd12s015 encoder on the am5729-beagleboneai
and the am57xx-idk carry a unit-address without a matching reg property,
which the device tree specification does not allow.

Drop the unit-address so the nodes are named "endpoint".

No functional change.

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

