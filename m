Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029B26F2BE
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737964; cv=none; b=kq0TTpH00d4Ob6NpqYSEhs7Y7e4yqpd6g8euUG/AHzedZSN67CSdqeHo7CqeI4NARVPvDs0iVghLKUb3wyOGiLpdZcWOb4OeJiZwtnfqGkgE6X2ZKTCPTq8KDea8BNXs+4UBAvIRoPl1ln+Li1Gc/FSPE1Dhmz+6LxSGb9wwdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737964; c=relaxed/simple;
	bh=KJ34XveyoFveUmNZXdv/TomCqWADn2408hBhMRZcLws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0EO9lvL+O1ZoNwIZ6wmaCHgX+x7R1gNHkrvH/eNPuTVj4ePMhV4rJLwoZhRk0LheuREo6Mq9NnCkBS7TwgALOljHTMSNGAVzihK6wEAjnr7htDV80s8+SpVAEyEDvBiG8j/7aXvKzAE3iX9K/tzRQ2fr/WBIViRCj0ud0nNiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxP5i/Ft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMXAYPEu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxP5i/Ft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMXAYPEu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LWva03301641
	for <linux-omap@vger.kernel.org>; Mon, 3 Aug 2026 06:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7ThpIqXt70NKGj1QqvTU1nb/Wuyf2kshXu9
	wY3Wj5zI=; b=SxP5i/FtxSpu3O581zT2BBUCC3f0kU2Mdxu9DAHKc30WDkjQxzy
	L6AOgtedeGvpWQumGzjLTqMxLUh5GbF8npGhUrbCf+xiTUU4Uuk6BJ1V3kjRScTc
	5NAa0Jk/tUtaI/6S8t6eSAzdTxA3GUhDni1dRIykggHJCQqvCasdbABuT2LxegrF
	mjAaR931ootwJ0XGdaRjC/3d3uUmOeKyLnnkUwQbetzY+qOmzJKTASVOvKIF1HIG
	/vChA+vhBS0NGfpegNg++4KxPo7acpI4CyZEDU2MdnyK+ZSqDp10Qm75Lgqdg8Bz
	DN027KJaW6zmDqEQIQY/1lK8rWaOlbTmhOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8qpvs7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 06:19:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283fa0656dso46090241cf.1
        for <linux-omap@vger.kernel.org>; Sun, 02 Aug 2026 23:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785737960; x=1786342760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ThpIqXt70NKGj1QqvTU1nb/Wuyf2kshXu9wY3Wj5zI=;
        b=TMXAYPEuXzkbFGvp+t9GxEw6h9h3TxVukHOxBonvRHFuYK/BpexrJ03Yr8l5/6XhXD
         0q2AMe2c1Sh7ORP+KW0jpW++mEHZ19f+d95poxEhVHQGVFJ6pqLygrlJyLCluEJzMmBL
         apsdov9l04QOqwjkS3cnkL+2l5FOjBwHSaBUchBwM5L3YHyHB16IAL3Bb+q7JNCWdbma
         r7JJOB8ilM8WybnOqYy4fHskQRbJYPGJEyMNejvajQzWlnLXrdyygSLE8DoXaboJl4FL
         hJX83UnUF4TfcIkxBvW9i6sqYN79MF6KOZbLR45cKfNR4l0aAvZdPhvrliqTNeBcrm/n
         4mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737960; x=1786342760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ThpIqXt70NKGj1QqvTU1nb/Wuyf2kshXu9wY3Wj5zI=;
        b=fKBEN8vKIZ/pa7drOP5A6WC2jNv9//D8X7MtnZWn1X9mJJYzlgHUZC8TbNP5IRB91m
         b4ovtfa1Xpa+pkCHBIdRglki2G4Zefc3XZoVx2klvaERj8rj1jot/KiGfOyWN0iCjUG2
         0t/7UUOrOSOc5vT+va2M9niR8/mhPPyvrszKZKCWy4w0NBGI7MRQADtHy6/Ad3/OJe9+
         ftClahWEJnDHqww//nNRJ0rKQa+deHpvhkin2KYxCJTHjB1FDhnRAb8nuB7pENe9aj4+
         KtiSysBhVIvTKmxoKu3D/vayQ+9anuT37PweDTew6L4jgpN6AK5uoPM71GgNPw1h/KQK
         SMqw==
X-Forwarded-Encrypted: i=1; AHgh+Rrp8Oa95BzWmxJ3SdtouPausWI8APzJcIeIkyTz+cjV8Crp3Rniq/8MI0eaGVdgEf+nQcJwRDK+WEWy@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaLz3Kw1a+yg+jWug74tGKryWDQ8AS0MSnI1uyY/6n6QlMSHo
	QwRejt9u2Dc3NCsMFBSazMiOdd6d1s6WeeMV+05ZpoPyS5vznQ8VNtFVipXJO+k5apCYYoqScKO
	OByBlGkGVo32E+kfTmIVlo+VYmHXf5Kqbgh9zd/7v0ouD9A33yU88NZR3fFuWmGA7
X-Gm-Gg: AR+sD13K7ZrwAW7n9nWnx2XcKdZfVipcChyvqi1SOreZQhBs2kvv9fAsTQIPrz+Eh1h
	fNZfdE9HXItyvUhNJ5hoTMUIbPqlr7J9julG0RCiSXdSrFACsoL9Yjs6AAE7u0wzyCLoKlU7q0U
	uNJGYMMKWF9V9ZL7jARdio6IOTpfvPAATe8cz5ncQCdMIEFHuX/TsuMAKk36lT8BO85yf0iMJhL
	Aly1yBw/70Uj8ZY7D43XThrjo7iMHvaspiQr0Hu/XiGB6DzLNPAOJKrA7xWEttH2KIL3VuFfExd
	gVTl2WNKZzRLvC1bWkOhVz+oIZK+jQP+GDSVkmW2f82g7/kJwgDYMv5Do0/hiq81Wot4IE66TQT
	J8yKF6QWP6783SsEh
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr158017771cf.17.1785737960241;
        Sun, 02 Aug 2026 23:19:20 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr158017591cf.17.1785737959807;
        Sun, 02 Aug 2026 23:19:19 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm318457575e9.11.2026.08.02.23.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:19:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] ARM: dts: ti: Correct white-space style
Date: Mon,  3 Aug 2026 08:19:11 +0200
Message-ID: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5031; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=KJ34XveyoFveUmNZXdv/TomCqWADn2408hBhMRZcLws=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcDLea7N19wFo345AadZ40uBD3Hmf+6yXi2rrM
 2tHizHkFYyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanAy3gAKCRDBN2bmhouD
 18yGD/9qwDViIqJPqzR7UKW9w4lk1xVT/qtuFdpnrSXa/ynocX1pKovJ1mJOd3Q0p785W7dJ1SH
 AlBy+sPqsohOYnFGuvmKhIMg96wAy6a1t2+4zuFjCUCHDUovc0pzBmYuec+TctGq/K1rr2MuZqa
 T5YwcAVr7NQmUbVYhbTNDmV0ebmcTY0vcRdUqDB6TQ7i1OvKsL/6jy7UzADyR6wBuhPB0fU22ig
 nSvtl/cxdeRP16ihOWxugopQg6QFcPSKYJaefWhc5Dbb+wlagJdJrmSNF8yz0fepqNHD0A6HYDz
 VfnzEi4ssZoehg/obTCbLVV6UlaUxsuwnwiR+rPuME+EMkRL2R0Nrz3y0UDrv06U4pf6fEyQx0e
 XNKXxdXvkjJZj700zU0joZUF42wrmnm9MfauSxjumkoch8uKv+bSYmcRvTzPRsVuHtodn0DkxRf
 DiYM39C6oQ4zLJHSk+1qxFEzSCDmt4pipEeExpJqShG6ddXdwc0O75YPSIrvBsMhsnR/UhLviHf
 O42TZXV8SO3hS0DNd4d86ScMb98IDUVwAd4xBYchvq+gOOHbkeSieXghM8iNn+5d+6ZzF4kqYJ8
 rogft2/lWUJostfOAd7gcxLie/gRTgJQoO4W7iNOnGyqs9rkNJAIf3fNJXH3ysNgOU9F8Wxx7lI dNhtF83x+RdzEyw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfX5D7iKdlVQQDm
 R0Z9fuUtGZALRLCr/reKYbDrI3XIetdn8S7QvrVTEiND+4o7utvuSsw9wbLDi3/OXKkYkN0BK16
 P7LKpLQR2xStvOeP2Mo7d4WQeisqpiDR6XNUYHTYApskUFO6ngpab1918BOKtix6btsIeCP3s/7
 7pUUZw7c3UDHz7RPYOEXF61RI6BszegjW/Ce8E2Jl3fWMQUbJWYX099XQYUWzFEpbUM9b66OU7P
 J5/ck9SpOjxURVwPY3ivtiRBJpYj+UU2Vg1plqGB6rMfKEzBiRE1qDc/UzP8GiIax2w1RXHE2OI
 8TS98QC4O4AP2l+/UtZyMY78JrDt5c/pInKsRKzmj3QxYBmyVwgIsqIt9AducX3RkMJAFO2H6AH
 bjp+xJh9iu7u4V13shQzosmfSrXke4lTXQH4Dtj18v4NE5N5betfjF95LO9xzdjDElT1UqQF4zb
 AEIui1Ov9jPe1MJNEtw==
X-Proofpoint-GUID: rCIKhpaldsS2XJbqtaGlJoVRPmvODU2l
X-Authority-Analysis: v=2.4 cv=MpViLWae c=1 sm=1 tr=0 ts=6a7032e9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ZZM3ETj0FquT2mearPAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: rCIKhpaldsS2XJbqtaGlJoVRPmvODU2l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfX6b8V9qvFR1K9
 cGXH+15jdH+NU8HsGduvkJkzKs15pCigGWtb+5wvnu0vF4sEDSwGXqAfGGfofLzmIt0ie4uOnua
 kRZIHfh8J40b86C+LbceN+knkAYFmLU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030054

Correct a few white-space issues, like missing space before bracket '{'
character or spurious space, which will be flagged by dt-check-style
("redundant-whitespace" warning).  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Missing space for serial@2531000 in keystone.dtsi
---
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi             | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone.dtsi                 | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi        | 2 +-
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                    | 2 +-
 .../arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 6 +++---
 arch/arm/boot/dts/ti/omap/omap4.dtsi                        | 2 +-
 arch/arm/boot/dts/ti/omap/omap5.dtsi                        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
index 330b437b667f..d91a23bbf6bf 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
@@ -51,7 +51,7 @@ uart2: serial@2348400 {
 			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		uart3:	serial@2348800 {
+		uart3: serial@2348800 {
 			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
diff --git a/arch/arm/boot/dts/ti/keystone/keystone.dtsi b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
index ff16428860a9..cff549c447ce 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
@@ -123,7 +123,7 @@ uart0: serial@2530c00 {
 			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		uart1:	serial@2531000 {
+		uart1: serial@2531000 {
 			compatible = "ti,da830-uart", "ns16550a";
 			current-speed = <115200>;
 			reg-shift = <2>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi b/arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi
index 109f08fd174d..c52bc3324dea 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi
@@ -99,7 +99,7 @@ hdmi_0: endpoint {
 	};
 };
 
-&mcasp0	{
+&mcasp0 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcasp0_pins>;
diff --git a/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi b/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
index 30fcce33f4b7..9745e0d420ff 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
@@ -902,7 +902,7 @@ timer2_target: target-module@40000 {	/* 0x48040000, ap 18 1e.0 */
 			#size-cells = <1>;
 			ranges = <0x0 0x40000 0x1000>;
 
-			timer2: timer@0  {
+			timer2: timer@0 {
 				compatible = "ti,am4372-timer","ti,am335x-timer";
 				reg = <0x0 0x400>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
index 06651072f000..07c76a80cfff 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
@@ -16,7 +16,7 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		continuous_splash: framebuffer@bef00000{
+		continuous_splash: framebuffer@bef00000 {
 			reg = <0xbef00000 (1024 * 600 * 4)>;
 			no-map;
 		};
@@ -117,7 +117,7 @@ reg_espresso_external: regulator-espresso-external {
 		enable-active-high;
 	};
 
-	reg_touch_ldo_en: regulator-touch-ldo-en  {
+	reg_touch_ldo_en: regulator-touch-ldo-en {
 		compatible = "regulator-fixed";
 		regulator-name = "touch_ldo_en";
 		regulator-max-microvolt = <2800000>;
@@ -153,7 +153,7 @@ button-voldown {
 		};
 	};
 
-	reg_lcd: regulator-lcd	{
+	reg_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd_en";
 		gpios = <&gpio5 7 GPIO_ACTIVE_HIGH>; /* GPIO_135 */
diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi b/arch/arm/boot/dts/ti/omap/omap4.dtsi
index 559b2bfe4ca7..c8eedd33b5d6 100644
--- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
@@ -590,7 +590,7 @@ target-module@2000 {
 					#size-cells = <1>;
 					ranges = <0 0x2000 0x1000>;
 
-					rfbi: encoder@0  {
+					rfbi: encoder@0 {
 						reg = <0 0x1000>;
 						status = "disabled";
 						clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>, <&l3_div_ck>;
diff --git a/arch/arm/boot/dts/ti/omap/omap5.dtsi b/arch/arm/boot/dts/ti/omap/omap5.dtsi
index 6a66214ad0e2..07159b97f504 100644
--- a/arch/arm/boot/dts/ti/omap/omap5.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5.dtsi
@@ -536,7 +536,7 @@ target-module@2000 {
 					#size-cells = <1>;
 					ranges = <0 0x2000 0x1000>;
 
-					rfbi: encoder@0  {
+					rfbi: encoder@0 {
 						compatible = "ti,omap5-rfbi";
 						reg = <0 0x100>;
 						status = "disabled";
-- 
2.53.0

