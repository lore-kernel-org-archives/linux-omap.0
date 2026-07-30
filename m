Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FB402422
	for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403394; cv=none; b=U4DHabdESLvVT5BRAdY/PRM4dPV+t5D2WRoQXRBrcNzxOBELi/71+fSjCthR6v8OtiiX1FK7JoxP2v6rMjuLAuXQjnFnA+m/XPdZrj/4TzblJgc52zhEJUmlDR5zCFwdiq8nb6XubQy5RICNoGjBlC0xDwwY6IAoZhtKfZXngGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403394; c=relaxed/simple;
	bh=4rDf13OrEejhabHPDOf8r8is5XO9Y71faY+r2M0nbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9UZc3b3q9DTxuSswzKYqqV7VvrQx564uwOZ31iyWHsSxIoC6AQkAY+zR6gQ+hVyngtPKwa5nhsDManOERt3dv3EIKkIy2XnvBcOPdvn6K3i7610aTgfbPhfM+s0jpJ1YvoQFXb3CvIYAmnWzwYlEIqqAVg0Pb7RIPGdPt+VAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StIMeeA3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StIMeeA3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1661227f8f.0
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2026 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403391; x=1786008191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=19dWbdtDz3PuL5QLyRHvpa2qFjaBjIFM+A1PtZ3dpCg=;
        b=StIMeeA3Dhz+znVjUooqTw49hfnyCNc4N0O8jiWthV7W0/Xbbz08up/PQFvtIAoGpr
         me6HEWAfBlngXzIpbZx4s9dv7cI3aXISXTw35/ub5BJCNfQYwzX6WS/wCQamQxqa6uyT
         sIMR5MnEWqBeaM5cCNfnErdvXt61K7S+/pu3+/E6eZudyUcLGODnfHWzn9wOoWTIpMZW
         n2XbgeId4SqEbi9HP6w6Zdd4AEMkisfbo6Sra0P1ZlKBBSXvwGLTYqp5gyMu+xrWN0j0
         jCASVIyEocPnRDuzAL6Kd1ebTJ80YO2bendH1DpmoPUZLSavb7aXGi3ETtfbuX5Md35s
         wA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403391; x=1786008191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=19dWbdtDz3PuL5QLyRHvpa2qFjaBjIFM+A1PtZ3dpCg=;
        b=kuMso8nlVzNtVa6YLLDYv40a/JsfERGlPQNyAHjmfvTrIv3uSM/5jdpedojWe/0ein
         b1yURoIDpMB8ErgOSNhFNomOqWYMsCiYBsRefB2zjUBwI1iNcpJllI3SoiTy3o+rYA/X
         +YsWPtlsm9/2DQPu7oZauCOYbqHXf3C2HqTCNwoU24JGarj3gkZgpjv1csbwjRXJWK1U
         WoS4Sz2STSbUa1LjJPCwnEQrZmEL7ZaNE7ZMhU6RGvZdqoNoR6CekKh9GbQ6mL0vRfV+
         X3ZMfzUS70ZpRT8nSgFLgHVZF/q+qoPXoMFnY0PaBxkw8m4dZHOvBcoR+FmAQy9N2i/Y
         4J3Q==
X-Forwarded-Encrypted: i=1; AHgh+RojSK3rdYDsRjv8kaDhesDrpkJYreOj04rC2zof4aIM5EEIwFhas96UmrZRYbsuYCfbgafgLyKpiFwY@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ2nPVEpsP48WALrlxqfati4miuzwjRsCg/p495n8nArLg84HO
	2Qsgcd74lXM1WFLckt3+IbSetCj8tDuj8LBpvHFi1GtOx61ZbQE4bKKv
X-Gm-Gg: AR+sD10JFReBQR9BHEFlgzeP35bL8Tf6xUvq+X1cCEzy5WWTy98PxJvZ41IyyAngQpr
	JQk4fTIOsU7PFuV7m3mLyNGvk9/OC3txBwBFg+Dv881DktrR5DTkTy76ki8j7HCpzOrsvgZ7G8J
	Irs8VB+rmHjt7YZIV2PQj/kDtYXKtQ8fBLqbbB8kpsPwrKIGO2SbT0ElbfQM27KJBIqtV6VV9KG
	CUpUkxBg/IupdnJkxQTfuAir+O5olLdIaHG+SZqqb7S5nYjFtIDb5Uvplsiv4wbMayIOlPMp9ZQ
	pJOl8lFYJdQfd1XKhrS4OIo3XMb+Lf2vd6MbGQsDPWgDaO3ClxSfGm0OHqQFm5GqyPo4knz2+TO
	8G02wLWUZ7Gi2Lx7B8EBTs8CzWLlSEDVZ0XCkIH+k4vgrq6Ji1RN9QDbMe6jyJzvnUYstrKtoz7
	CM+mKntO5qhxnRQlRsfR1xwLUDgTCTFPFMFSHBEZ8im9t9Ph1UKCdxUl9aRIWxObAm15I/8mCX+
	k77TWZXCFqiouWjByVMEcH9joDNvTK9lA==
X-Received: by 2002:a05:6000:1a89:b0:47b:5f25:7c59 with SMTP id ffacd0b85a97d-47fc822dcf5mr2420000f8f.38.1785403390868;
        Thu, 30 Jul 2026 02:23:10 -0700 (PDT)
Received: from fedora.tail6d6c39.ts.net ([82.77.79.56])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47fc88e64d5sm4308425f8f.15.2026.07.30.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:23:10 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 2/2] ARM: dts: ti: omap: Fix TPD12S015 node and endpoint names
Date: Thu, 30 Jul 2026 12:22:45 +0300
Message-ID: <20260730092245.52034-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730092245.52034-1-egbostina@gmail.com>
References: <20260730092245.52034-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPD12S015 node and its internal endpoint nodes are currently named
with unit addresses ('encoder@0', 'endpoint@0') but lack corresponding
'reg' properties.

Remove the unit addresses from these nodes to resolve the warnings and
align with the core schemas.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 6 +++---
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 46270ed87..1ac9c13dc 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -152,7 +152,7 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
-	hdmi_enc: encoder@0 {
+	hdmi_enc: encoder {
 		/* "ti,tpd12s016" software compatible with "ti,tpd12s015"
 		 *  no need for individual driver
 		 */
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
index a2a654ef4..ed8d3eebf 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -121,7 +121,7 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
-	tpd12s015: encoder@0 {
+	tpd12s015: encoder {
 		compatible = "ti,tpd12s016", "ti,tpd12s015";
 
 		gpios = <0>, /* optional CT_CP_HPD */
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
2.54.0

