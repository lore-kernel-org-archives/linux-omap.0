Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453743890F0
	for <linux-omap@vger.kernel.org>; Sat,  1 Aug 2026 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618255; cv=none; b=PxkfZ9GCiU4l2mckce66WFvcCYCkYAvOdooTZB/TaKXJXmF4vxBKDloqcO1E3lkYRk7BCvNkIkMsFZt6+tiTANYEYjVAPKAwpVoKNxpjZ1S53MmV/8DOYuyniwjjR1CMHJ4C91ErahE7bASXtU2TIrJ4ECMSJRtHWgkQZf2dzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618255; c=relaxed/simple;
	bh=vR24UIDfo/Bw6iKO4QYnVk6wQDa1uoWMTvq5cvEfc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhPUrbvnsSNtSK9G89pvhbhjMqbtwGLaNtaoo8oWsn7dkeAZbqU+d1JxXAO0flnB7Whn9+ptX2TVd46TAzul/IaSYyA6kfvxIIjlJavevkpj/E7T25gzHVe8updFJDMN4+f0vfh+F2fGLX2nxTCqRdQXS3Nuu61pVnLP2/wYktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRIkFRmR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T2amIVft; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRIkFRmR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T2amIVft"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Ixei13908962
	for <linux-omap@vger.kernel.org>; Sat, 1 Aug 2026 21:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IYU4p83/F7Wb0HbkIUcvVF1Yepq2STjSMJS
	wB3bRmCY=; b=DRIkFRmRcQJXkUiHWaABqfEJuimGa4JqcJN/70kLPP9HZX9mxgo
	2MUpjKdfMRPPVQC3BxwRNyqOE2gsm3OnEsTiIFhUvJdQKt3Z2ssH9+fZUbKmEKgT
	O2kTglFwVlj8QJrLhYNOEkTcoyZgPnpSEHKV+tzrLH6X31VUupG4U6o6OuaNhMO7
	1sz1hc1pDuhBvJyUrpsKyjvv7SGxaaKGvbVK4UalqbuZH/hRXVs2n2emcprswy6X
	27H6t5ukYofiRsT0Yn7xL20TkfgwMTBImfGg5GuHOKX61TlCC/J1PGiI6l9Z4XZC
	/1GyHPfi9GlgMbMUq1W/C0zSratP0AhTgrQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9119n8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 01 Aug 2026 21:04:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51ebdfceddcso23165281cf.3
        for <linux-omap@vger.kernel.org>; Sat, 01 Aug 2026 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785618252; x=1786223052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYU4p83/F7Wb0HbkIUcvVF1Yepq2STjSMJSwB3bRmCY=;
        b=T2amIVftFIuqZc8ETMJKfzXklYluhJbzuQOxhe4zjMWKstuRfiXiwSMPG49q04xAMj
         Gb9ACZO/vVbspYgm7ztBCbLrpwHt5uam0njyw0UTw9k8ojbZ6Axg2jPe/UUbunU0fT/j
         0EXHrK/E3lLINNeBmpfVjx71ERPjkr3RhOKMreq8DYwm9Ynfl9WBRr0flk9qLSEX8Hvw
         HtS9Ord+w6EKEoc6GgOFGRmJ+c78leJsLu0Ed24xRM6zR2irwWg4kpthC7cFa/luP5td
         iqIWnWWQTA8Zi98Zy6b9VGVSliLadCwDZSR0IhdtukVLD/15yPLszKyhxX3Z0EKJpDmH
         3XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785618252; x=1786223052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYU4p83/F7Wb0HbkIUcvVF1Yepq2STjSMJSwB3bRmCY=;
        b=RudAC0HARNjKn6zuaiQBYJ72V0PKd+8ws6j2ipXahJmmDyVK3qQFNi7F54tBZWGYYb
         OH7AvRNDb3EtUVdPXUB9jJvfGfBhijt2bXKdofbvh7v48/l9ouj+izKVfnhJixu1y+Nd
         YW/GRYlPiUeqVrOcIzo40/TyjajwOy33fpW9FRmni5llMwG3epK1AKKHaPeNoNkV+rhw
         WpG/oB5q9kvRGANYlC3CUwBOBq2xMLGbxZbOMtvV855UJdb050KyAjIFiJ84iD9DM6rj
         WGqu24VOXElEMePYf2kNGTIJ/orl628QVzE4brs1D0vuoWStlt49ccLPLStUhdh6w5Q4
         ZRxg==
X-Forwarded-Encrypted: i=1; AHgh+RrHurL4OVsUHb9JK1dqZxO72TQwzQRjYx9z0zlngfUaA3IXt6BNlrc5z0SXc9px6dYER2cM6RSL2ozL@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGgd6aT4oJgbLBztOUhH0OQdmLFdDRIyV2od7vV73NevngfCz
	dpI+fcGpp9ZSzztZD1+jE2hRDC66FLUvQM4pv/tXCpML0v61NLGiJjA2YuIVQNBWc7YBpUW//BE
	UcO4wtEoHk1PgciSbbxkcDx/kYTxBzaO2QTORCtm7DOwiOSNRi0fM88bNrNdQLrCN
X-Gm-Gg: AR+sD10u19DsZ9XwJbpLdM0iBaOYGG15RXED2QC5gHKCBoJubPFewHJrfWri2D3Xo3N
	pkmqAl0XYxsfjSQj4ZLpRna8cP9HYY618okOFOetz7CNm34TAC+vsMAJY0NJrvA4nqRKvVI5VdM
	fzTasn47dOrv3IU97GDngmRT97KtV1WqJDF5mslw2iD6B14Yjgv3V4+/YCAEr2KNHTR3NOm5Bz1
	6C6QYuJY/Kd9HlQvwuQe8nkgRHH8lVUV1eq117oXUG8QOZT5eqaZoOuhIYyLBNIc5CKdv+aZGxL
	yszi5uOqnnsM9W47ljvYsdWWE6uOweh8oguXy0fnUaFnDKpBT3Lp8DkvoTmoyAUELkJ2MxoMKJ1
	bdk9j2qSJRS9c45du
X-Received: by 2002:ac8:690e:0:b0:51b:fc67:c73c with SMTP id d75a77b69052e-52b566dbe08mr113251691cf.16.1785618252241;
        Sat, 01 Aug 2026 14:04:12 -0700 (PDT)
X-Received: by 2002:ac8:690e:0:b0:51b:fc67:c73c with SMTP id d75a77b69052e-52b566dbe08mr113251141cf.16.1785618251686;
        Sat, 01 Aug 2026 14:04:11 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dcb4sm133984275e9.13.2026.08.01.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 14:04:10 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: ti: Correct white-space style
Date: Sat,  1 Aug 2026 23:04:05 +0200
Message-ID: <20260801210404.383925-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4951; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=vR24UIDfo/Bw6iKO4QYnVk6wQDa1uoWMTvq5cvEfc1o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqbl9EpFsSCxraD0XV9IpYfa+i9uaLlrTz1EQmc
 cSZVgXywFmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCam5fRAAKCRDBN2bmhouD
 1wekD/wNtdAS+3WmBikDsQTLvfFniofxw6ZmTCNmSBEuW52fXMYJlNeoUbUxqHi0932yFjP6ZFW
 o0WOyHfKoC1tQwk+eGRghCw0LDyyPmbPQivfaODH+39zFLmb4E3hVb+yQZAYS+vGnnrxM7zeA2V
 oDR2oO4LFWTGKDeRZQGtpwTIe3vrHuxoJIco9dy8LUrzFWE6IBvomANMTtDfGig2pX9OVkwI5pZ
 5TWRpS2e8SQjyCzSJAAo2JR0OYOOdjQ30eSwe3cYRa1FrEMuzxQ7HRv3cMOWehUbzrDPOouMocN
 svjqpSPLGFO5ltG7lRRGAT4VV+AdIlep6UwzOXTDwGezyiorGXuh1xAEvfSsvgB13CNPoolVex4
 mHm/ZqB+R5QtY0fxKXZxs55heFIiOU5SLfK30ChRlCgB0FQ51DmB9dwjPuphPUuaJffJHOaxYCb
 dIwSISFL0qc0uwE1y2hQclvVU5i2Xjr8NST3QQmWMe4qdLduQZVi4uqMKrAgt8ZZ2uppbF2ZQBb
 gK7JlPKGCnJjuYu06vHGAigeEMbnVeT9j3+sjzAmncQXHLOpqR3l8v1+51SvgF8e2FDuuFtwsK+
 iX6C5B/RBFYc3CWT5fqRjZtuMKo6qMfv+6QC88pjjUWiIfulhU+hRvQ0ZLw/xYkN5d7jGi5IPyo /C8/iuegvNP+kdQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2OSBTYWx0ZWRfX0wZmasovyvlj
 J6lvRtfuhYmC0JYQ+xvhvBqFhlNRUfthOtG0QZaqs2nwGd7cJ5smE5iqkx+IsFoe5Mo1n03Fizk
 h5bWeZjxB9cxmle8WDd22/N6ANq+wbo=
X-Authority-Analysis: v=2.4 cv=PvGjqQM3 c=1 sm=1 tr=0 ts=6a6e5f4d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Hx2NUBF34izpMPi2HQAA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: g55otc8o3sTr68YoRLls-4hLIXyEyNa2
X-Proofpoint-ORIG-GUID: g55otc8o3sTr68YoRLls-4hLIXyEyNa2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2OSBTYWx0ZWRfX6NsVb/D9nhR1
 IjGov4nvFgNxsrykrbUj0b1Lqqxb8xolfjE5UegD9muaTvGYLYzaqmzKmlxHv3Pb4JKo4zWoV5L
 N+hl9gMQvjJRsUNZnFlgfE+8l9BVGm7RNxPzs+SiZxn/glnMbWU3Xw1LVhMu8yQX9Jg0ZSSGcwl
 khYvRkIrHFG0oUfKXKdu3yKqOuo386JU8a0WpNvip064w0pP5+KyJ7vKhqafnuBlg3Wq6wID6PN
 hGUpeARCbZaKAeU1JtR7SQNkZxKmBsHzwBf5jPCVTXUrV3YF2M5PSnRZDzUf22i+RvIUX2chrue
 6qVE5eSWJYlfSqdECujg9EOufx8YBjZLY964aiaIdoQYjLktKTeEy9n7q9I7d2FtU+Dw7W2Ikr5
 OWA2carHgmXZjA+BMt2sFd142H08LzvHqFMHeUBYnvnwwpZlg/svPLhDjFUHfFsC1xiFxs+bQvR
 vp2vUGzI4Zan9TXpq1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010169

Correct a few white-space issues, like missing space before bracket '{'
character or spurious space, which will be flagged by dt-check-style
("redundant-whitespace" warning).  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index ff16428860a9..22c8b8b04340 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
@@ -123,7 +123,7 @@ uart0: serial@2530c00 {
 			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		uart1:	serial@2531000 {
+		uart1:serial@2531000 {
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

