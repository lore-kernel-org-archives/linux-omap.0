Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E33CF1F9
	for <linux-omap@vger.kernel.org>; Thu,  6 Aug 2026 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999803; cv=none; b=C9mT4ManL19kmIrT9EGiK4UynvUOjvYuB26NC5jh/23J6mB9Rf2TA/GEohMxfwonifIf9jCrNu7tiuZOdwRD4DvNFwGPN6w4B3XhR8UhtCEdqJZ/kX2iPr03hPUECmx5GtWMbUnYB/2e+t+HlsbrpfOECnvAwW8uQSIYQu0Yr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999803; c=relaxed/simple;
	bh=/IKQ+TQY9VXMG11gcTMkMy4fVJBfmh3YUEAktS4iaas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgUVm2LYOZL/uOvI+/inJ7oN/sEocUhFoeJ93ndoKQIWEL/O0d7h9ouXcbbYEHcLm734G1LLmzLojoRcY/zHiYkmsO3lI0+dzcmpHM/uSx1k72r78C9+R2T+YylPBYyW+OHwDzc/uUNSdsmK87Dm/cgTtKL08qVPjeAzKWjMxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dI5Z5SE2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlMlg0Jv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dI5Z5SE2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlMlg0Jv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763wVIK775062
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2026 07:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+Hzq0sGZDrSQ4tW46ZYSfcrkg3GYuiF8JWp
	UDrkucxY=; b=dI5Z5SE2tRM0gLEyVSAagdsJmt6Tx5llcFpdWoR53ZAJ3tVGrtz
	NQENnVARVmh38G0p9B5Uoqz517lmBLZMmShDxdq0QIv0cdep7qLH5Jl2xJRoz7HG
	0smEbmCbGQ9ctAyj3FX8uQ+XjdrGySGbIRfjp+IZZGogzCrG2maQMOnmpJdO60uc
	ptOW1OArhNJsO4sVYG3QDi59u0d+HYYdjc7iFQOzxfVk9WbMCJ40EqrhRh+4HaJP
	XL8G239QtO+8z+7+4FVTdQupOzZOZySF3RwYrkC5p1rEmNGVzWwXerBZhLSlYC6z
	Bgm89cFhooKVqEtvnXMuoAEUyZudunxpkBQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8gntg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 07:03:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso31484751cf.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785999800; x=1786604600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Hzq0sGZDrSQ4tW46ZYSfcrkg3GYuiF8JWpUDrkucxY=;
        b=VlMlg0Jv72gnmEpmHbhsocydmyQvmZ9vtuFX8QWXsoKd/Ky1FqMDwiFWyjFRCotjN9
         fU2FGLZi+LrRW7lDdSHBlM9f8atWFC7HVLO2gt/ry3EWORVHGlc3KkNgUcN67mLEAGAr
         WbThs54uQnK7onzGie8LKvtlZSbr8r+9SFoeOALoth1oGeep7dCp7shkKZV3TZ+E4HZB
         wjP+3zd1o6+M7pFaqhYcSloZ59lpn4uTg1qjt/4OUF4Ekv+XQNonlpMT6fFYsDCtjJXS
         /jRZvGqILCwIVf0C4NjH6kLerWP21P1CupKNg+AusJUv5682Dhs/d6Ili+vuxtmzDPm8
         fByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999800; x=1786604600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Hzq0sGZDrSQ4tW46ZYSfcrkg3GYuiF8JWpUDrkucxY=;
        b=rw/boBUPJ509lQyumT5HEqACg4e8aD+Bl8QLz6Ql4J+IMhCJ/5wbzpU4qL9yOxLjNk
         VLt6baFIdps0xNpSX6FTTe4T2jIZBWthXP3JizHh1OI50wlDvLY0Misv0VxfxO/NM8JA
         0yk12Z6w/ke8o/VyjIqpQjxzfJCxvsoK1kOS912DtYA4KTWy8SfKjAzuM+4xRfaTfOTz
         UfXqxXekgL5rFmG9oSFHCU8MEQx4BA9Z6HAOlgpTdV7Nfmkz0t7bgr5opC+AMrUB3e2Z
         S+sZN91nGdSX/fbtl2vSHeulsni08wYPXYELI+bsNvOImqdp2l56HZdyLRmek3/mHgVD
         luoA==
X-Forwarded-Encrypted: i=1; AHgh+RrdQxYM9FQRukPuyx96fZfmX/j1Iltl1g7Yu/25IADz9enHANWkxNB6GfCbXHuncWU6Mi/7jwRVFsIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjC+F7aK++eVT1EuLt0bqH25pXEkiRxXWkkOsO5qkjfzSxPYd
	Vy9X5+ONZ8/Qwzf974hy2GpDz9X4y+XBCyus8owDPdid7u2YOtwDXXToVSUZ7CTIe3hcTvvB3Ki
	fOqM829VxcJTKoz9DUvehSwb/1mSlcM0FkBjaMgNvzzQAwY5IXBGzBuXz/vJBTHl1
X-Gm-Gg: AR+sD11gBzMLeqpcj6TpudUwYgPUhwiNfov/88l9uO2e3U+I/76LZvxVEB9O+ohrO1o
	VE5QWe7JaURSJQACCQ5dE94vnOjSm4Mct2lQmSFtc7IN9yKpYEr9hAmpxUb1i76PevB3ADc71xl
	VYtfRjoqnTr28Ljj7A6R/vQALr8EwddVU9hHqqRRX05tJzmOBseOQzn9punHg+rqe1TKY7hGH9k
	1XzGLs3rEsVLt625YfAlJ0CLbZM1KpxC7Ix8zy+mLy3thM1V3OvqzcvROKttPtHoDJ6dgRjT/5B
	vhO+BKQz4LNm2yiK6m3Pv5On0UK9pM/IVYzbO21oLg/8Wk9O13xQVk3N72lVqLy8L15s5pMogML
	SpZAdHtN/j4fPwvGs
X-Received: by 2002:a05:622a:244c:b0:51c:a70:5ed with SMTP id d75a77b69052e-52ce618a26fmr146246871cf.30.1785999799776;
        Thu, 06 Aug 2026 00:03:19 -0700 (PDT)
X-Received: by 2002:a05:622a:244c:b0:51c:a70:5ed with SMTP id d75a77b69052e-52ce618a26fmr146241851cf.30.1785999795245;
        Thu, 06 Aug 2026 00:03:15 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26809sm3526201f8f.25.2026.08.06.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:03:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3] ARM: dts: ti: omap: Correct white-space style
Date: Thu,  6 Aug 2026 09:03:07 +0200
Message-ID: <20260806070306.40285-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=/IKQ+TQY9VXMG11gcTMkMy4fVJBfmh3YUEAktS4iaas=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqdDGqawhKP+2QlDWUN3SDWUdTUM5w8jjLNCx8v
 AdDJkCWcweJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanQxqgAKCRDBN2bmhouD
 15yyD/9RqdGHLI1yypLqG5vdYelA5A6TyRLpROcUmySk3mus1j5Bc2K2eK5OYVIj5VxmnCMdtvs
 fEbfBLRsdncfPuORC5ZMuYGx30HBirZrjtnYfoGKm9VEtRsWfyWTGH2q3gApLS3Ce5Qc0GUYk1l
 qdvmgUOZoBfjwftcRUYHCfjXttmZH/nyOhckR59ZlSZDa6MmD1P2d+Ye2QE0OJg/VxsonTXmXw+
 Fa83HBEfmxpPZynbm+q2QIcKlKJdz0JkS9KIkqeTcInN/XYLooQ3GglzZBpNS/dvXpebE4RHM+/
 upAn8BVAY03HIuQrym9sOzThvhrPC0yV9pIOqEr20n63Eue+mrzJhvwU07zy0GpEinGxVs3pA68
 OI5FZjz9P42gfIrnBh0A5EbMnuy+q63ZgFMr0HSg8mz7ZyKnWBiA5nz82gouhep9eP47aQT9G3B
 pNhmE3Bvnw8KsAoMAgoPTtEf0pRYtiHJphx1SNrI0yNLvIouimwnM7pkWWtj51mhzl64nqYfZ/m
 6QShwVd7O8L+jbyDcZn0Ty2UzmuM/WeKsMefWr2tPD25N35oo0iIXkP2YNTz1GuUAA115n3TtkU
 bCv7LeTFw59nHxshz2u6ORdQ/iXpg9blmkwWLiy6qG32ecJ3zkLSbbUy6sa2kE+mHOQ6+7VSokB LGg2G+a9ymWgZgw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 19nvBcmlXK1UqiT8gzdtXTcoIC-uC9t5
X-Proofpoint-ORIG-GUID: 19nvBcmlXK1UqiT8gzdtXTcoIC-uC9t5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX+PLecBQzpR3o
 opyeOxgysi3bKx+opaoErdoBvnBK/UFHTtxIrV3k0Ydcr503ypf365+8v9QEqtg/njEbzFROZjh
 KW2qUcb45LA4qU5vhbiX8h81T65p/PzU3ltaNiCuehhkHUb6lXjEmPX6Jinvf3ju8V2RCF6Rfis
 s3yb3gMryfdZ2ThlyS9t+SdTaXZv5ewZwRfsqkkyVRyBjXlx+96FzdUAJOpDIn4KW/ITLRFMV2I
 NT7DOO4Q60Av8sDzD6NxPJySBCeWBOrP/OawEiaTm2uI8tGW4Fx5AMviYGSCBkpCuHZz30AeaJA
 oKk1Vm3Q188FYx09J8VWoI4HOIPS1zZvBqePu/wdcFiDv6wzeBa61k/+FbSKp73xl5jvGZmFHEt
 m0IDNx1y6j58kpeKxQJTf+wHEtpMgq2V9fSszI8mZNjI2tWuHtZPmFxNccR5KfLnNaJ08nP5mmu
 8B4FJdGYi/YjyE2QOVA==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a7431b8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=9NnyyNtMdtt-i1h-1QEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX+89qfdI8vjP5
 gSx1C/fJ0rBJcCZPVNctvDaSTP6DBSID9GmPqnGypN4TQuXX8Vbnk87q/U6Ag7h4bZxZlLbpXJ1
 iK0k+7KZOfyfusyA4iUGLaTkJGfYKww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060052

Correct a few white-space issues, like missing space before bracket '{'
character or spurious space, which will be flagged by dt-check-style
("redundant-whitespace" warning).  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v3:
1. Split keystone to separate commit

Changes in v2:
1. Missing space for serial@2531000 in keystone.dtsi
---
 arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi        | 2 +-
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                    | 2 +-
 .../arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 6 +++---
 arch/arm/boot/dts/ti/omap/omap4.dtsi                        | 2 +-
 arch/arm/boot/dts/ti/omap/omap5.dtsi                        | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

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

