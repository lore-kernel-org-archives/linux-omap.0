Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8B28BAB9
	for <linux-omap@vger.kernel.org>; Sat, 29 Aug 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788032412; cv=none; b=cmdTY8fZhuv0wr59R2/0WstKJ5freJf8fjj6Hut5OZ02dNbzp/2s0CS7uv+dwCbq3rIh6EEPU/bI8C7Ima8Z9xITEleqAoo2ET69SHgt53WP+/UxESORAc3lcvp2Z2UIHTK9KB+n2yMCrMhznRpOf0vfWD25Cxg8lL6vQuyWJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788032412; c=relaxed/simple;
	bh=npM1146Vvb11yWHW6n3x5pHESbaeqKx29NChJljV0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0iaW61+LO46M0j629P/mXx+2c4fkKbTMwyWsxvct94bXcEvn+M6xsxZR137DUlu9M4U2rv9ovYqEUSm5S5crq9IM9iutzc+8xNIk6DV5m52rlM6sO94lVTf2mQ7ggOglgKwzZKtfFuZKodv0ftuNPfQ4R9z4rEN5apNYt3xoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdoNvwp4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VafolqyS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdoNvwp4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VafolqyS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TGx3g53024113
	for <linux-omap@vger.kernel.org>; Sat, 29 Aug 2026 19:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hYiveUwHFDnmvItlqlpCWNnBFXbaG6Y73B3
	LHxHlYDA=; b=jdoNvwp4Agh5AAx8ydtmca/v+hin9R6Yl53471aKYafW1cOX+/s
	AjjusNWMz1D5H/UvIZgtCWpa6DsQnAnEIiq14acSrKeivyNl972n2yo4jIqBkuTv
	TWXhaAGDEfvNmIPZpo4KTZ24ruEvE0wWeLxdtJ+ux/J8AzR5sZR9hHh4QMf4DZzb
	Y8y47ejlxCmFrr/Em2tvaAR9zDRscgZXs0K1ObceMInN2sUz9AAiBId+RfVrbCT8
	uw1/1RtTVVdVtJxGZjcYsayiH/R80DgW0UoYb0vcZdDQG1F24AaoXPQ4aUImfhWN
	Q+oCPv5XlwI4p40dcbUuhus5+tEo/O/i6Lg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdfhp01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 29 Aug 2026 19:40:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so54908311cf.3
        for <linux-omap@vger.kernel.org>; Sat, 29 Aug 2026 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788032409; x=1788637209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hYiveUwHFDnmvItlqlpCWNnBFXbaG6Y73B3LHxHlYDA=;
        b=VafolqySzT6b5rwzFq+Bw8dPbT0nFafAfHW3KlTEsTEtV3Z7N4cjNB75zH7iFDViEf
         Muqx6T5Ftq/G8CgHImILgiAc/WfTMMUR8ZNMnhzA5Bf87CAM3wNgfWfa8BzqTAeK3gCe
         56nqtC0E/tfG1B7kJCiPpUW5NQv391pFwQfDmEIaTLX+4SFQpzBt9SZLgcZOXB/gcW6f
         IexlGbU7PRPva8ObzvBk/b22BK6nkLL1Mt8z11vSla4FcVf51ubLfWejnKBJVEoQBtOD
         +jPx9MVYLznZWK1BGAUqCuEDrzJ69LEVPwL69KtbcUJndYnenm8BmlTEf3MkxdgRIdYm
         vDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788032409; x=1788637209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYiveUwHFDnmvItlqlpCWNnBFXbaG6Y73B3LHxHlYDA=;
        b=Ixr6DzzShCXys6sIyzFwvm8QC+Ijgxh8wWdv9znYiImD98B+a9b8xeUUabSs6z/7PT
         VS47RYHh/s6JuU/SiZziPntIgEp5w9E1xTFoLIWKmYAy6bQ4evwOCBH0wX4noxbjeQv+
         k3cXvoD7PsI1xx9ClFZ3J+Xs5ENzyGy2gM/rfTKRM+G7CO8LLA49HXIYFa46oIWAEH2N
         1fP5PeDmcg5dZncUqSHjCRyxs9e6q3ND5DiMfbX4Z4zoQEhwGkhV7+DBb0Ps+HwtlfE9
         X6tEX/4GA4Ak7ukS7JAHF7RIkY3+BPoHF2C2e2A2Gtw8L/67DxTR7MecOqPd6dIf/H2A
         BUag==
X-Forwarded-Encrypted: i=1; AHgh+RpTlHVqLx77EWi6yTThyie86YHAFDNNFyqS9N3sY5bAOj+bcCl1ELQTnkNotB0eAUVgcJYXCSMQnTxJ@vger.kernel.org
X-Gm-Message-State: AFuF++m/5f3LUJ1fePYbzObAtwAitS9MVOIUIoPzJEldyX7AJ///lzfX
	udlTyZ0AHLndLWh6bMJAhFK3YxDa0UgYTKRT9/uf5iOfsP6WTRvfalOrXq+tROE8epbZ0jXmxjf
	qiEsQY/3yzNb+TRRGR8pXP0zGYoe5tmiqLJArVpmBn6eGQiD35w8gkUwid8fpHGaF
X-Gm-Gg: AR+sD12zibt0kZn6NntbnzgKU1mwTp23ShMhCLg080ToRs39krGJ3Z0YsF9afVgGa4Y
	yUezwhylnF4lZQ05wNec/zyTQHZpoWmE0Ksi/043uDi+hoFcY+ded5ALBgXMKxSYefkn9gUMBwT
	NcytUsK40tVqELfulLVTaqxJu5pir/E+366muRvOYk069Ax5h903hUl3T31+j+ybCQGqabFSu6a
	7GnNfB09BFGjGX1PNnzXu94B5X6FChoWxMcsLB25qbI2TBnP8tQ/n+0zwiSw8t7OzIYlKrsLIgW
	XQ+mE3EPiE7PNdV1jTdYxO/drNpG1abU9GZCBfRpiGKzzQ3mtMOJii7Edbczl7ueA9f0jSSizGa
	MC0R9soRBAufctnY=
X-Received: by 2002:a05:622a:1b16:b0:52e:2d19:b27f with SMTP id d75a77b69052e-52fb94d570bmr202997501cf.19.1788032408886;
        Sat, 29 Aug 2026 12:40:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1b16:b0:52e:2d19:b27f with SMTP id d75a77b69052e-52fb94d570bmr202996951cf.19.1788032408324;
        Sat, 29 Aug 2026 12:40:08 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20737sm10575647f8f.22.2026.08.29.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 12:40:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ARM: dts: ti: omap: Replace spaces indentation with tabs
Date: Sat, 29 Aug 2026 21:40:04 +0200
Message-ID: <20260829194003.107677-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=npM1146Vvb11yWHW6n3x5pHESbaeqKx29NChJljV0/4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkzWTt3j93a7KYuLzRBWHyovBmCMBPhjrE64MS
 CEQymWF3nuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapM1kwAKCRDBN2bmhouD
 18RmD/9+y88q9lBhidpRg3jItQYfGbtek5b9Kivylu10x5064geV2lw2v+5z/nEhxw1Z8qlVhz4
 qF1cTGL7CDz14+i/tVeW1mx5Mlv2QXDdg9Qoq4dCVgOW8AiMsjZh1Ml6S+5DhHOYon/eQDyX51p
 ykF5M0lmL4a2/MjYw3I7fjUs+iOIAc09OQDV5TtAbt1d0bnptcgmCgoO9GmQaJWp6DkKfgHrg2y
 L/G9jcoMLr5rWGW7u7SOmNss/5YL77pzGpa8MG91/BZXquFwtC+hA/C51x+yEslyMxZ3Xa3sunZ
 ae1Dmd3gJhfDGPr3GlgLnd1Wb7iVnpCmlasLsBbwt3nIy3zhr8qPcTN8v8nxYXNjFOFKMzTA+uE
 9FZDSRThmKy2Zk+AtZPnFBGHFBUo8LgyCUB1gULwpv3d/rmoQaDTtSxY5ISsU/y4sUGw/kegLzZ
 uUma3LT0F80+txlhNbema2Xf3EFIcAUedYk7O4azvb/JvbsLb56trRXoTuwdBaKZJiDmCWIVu0Q
 vb8ATr+zLlRW1Ze7DsidUkkIzqyo7k6SEJcOQFILOKAgVMSOs74HiFYA+AOAyD6uFZm6c6Kr++f
 77mQ8ydScHGGqschQWFiUl4ThXDALqOOSh+dXfpXxuB8pIVB+9XYPYRqwgEbFscg1ATcuf/Vlqt tZ+Ex7XsfTGsZRQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDE3MCBTYWx0ZWRfX4AjLgeEvmSe5
 9fpsw49mJ3hCSMRz76y8Chb32glv23l/aNOiWySFxLMCN54yEE2CSMq/qVQZx2lByxia+/W99sB
 aqoZSAUxSKfeeD7Y7hLp274sF/9bLizFm5bsaiZ+KfNHLVyRRgtE9HkYeZP7d3Cn/9YNpSG44L4
 1FZC1scFNl7H/5uXpKVjNwiBPpeLcd8Ou3mz/sHpN/ASxswog90jfKUDdNoSbHGiUVARA2sdAo5
 0lWIS5qTAb34pja+46DVNuZit8LrYot7eLkv5UZZ8NDZDrFxL55FLndOUTneQMAXBPENI/FDeQ6
 kIxelnqOCOdkeSQuk5AkAeg3a/aBLUFo7Sx1m73Pqe7E9eHz5gb7W6LVYU4O6B9Y9s6SdR/t7BV
 P591Yyi3CsxttA6qURZFs/K7O5a986T6GDXDB3UX/feNP99uOy96vVB074VCfng1rSVecUmY8/a
 uwdmSW/vr5Ya9b+R0bQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDE3MCBTYWx0ZWRfXyK0lNZfDI2hA
 ihUCKGGHLUAVst4MqySDIo6BDFRYb/mL3UixvlENHu/RIQ3tVXIpBB1ayRPTCa8TnC6PG35FCTJ
 4sGnkxtnKiFzyKs2w7F+S7qRo/+wTJg=
X-Authority-Analysis: v=2.4 cv=B7eJFutM c=1 sm=1 tr=0 ts=6a93359a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=MMfNdgY-GmuYLy5ODHIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: RQkBYzpUonp7qKqs7dSwr9cxvnbvmZpI
X-Proofpoint-ORIG-GUID: RQkBYzpUonp7qKqs7dSwr9cxvnbvmZpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290170

Replace excessive spaces for aligning indentation into tabs.  This will
be reported by dt-style-check ("[mixed-indent-chars] too many space
characters in indent (more than 7)").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi | 8 ++++----
 arch/arm/boot/dts/ti/omap/omap3-igep.dtsi               | 2 +-
 arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi            | 8 ++++----
 arch/arm/boot/dts/ti/omap/omap4.dtsi                    | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
index 28b4f12b82a7..edc84928e9b6 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
@@ -101,10 +101,10 @@ &cpu0 {
 	 */
 	operating-points = <
 		/* kHz    uV */
-	        300000  1025000
-	        600000  1200000
-	        800000  1313000
-	        1008000 1375000
+		300000  1025000
+		600000  1200000
+		800000  1313000
+		1008000 1375000
 		1200000 1375000
 	>;
 };
diff --git a/arch/arm/boot/dts/ti/omap/omap3-igep.dtsi b/arch/arm/boot/dts/ti/omap/omap3-igep.dtsi
index 7346cad84eda..a0717461dee8 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-igep.dtsi
@@ -37,7 +37,7 @@ &omap3_pmx_core {
 	gpmc_pins: gpmc-pins {
 		pinctrl-single,pins = <
 			/* OneNAND seems to require PIN_INPUT on clock. */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi b/arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi
index 92a5846048bd..f5bfa01ee244 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi
@@ -145,10 +145,10 @@ OMAP3_CORE1_IOPAD(0x21ce, PIN_OUTPUT | MUX_MODE0)	/* mcspi1_cs0.mcspi1_cs0 */
 
 	mcspi3_pins: mcspi3-pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x25dc, PIN_OUTPUT | MUX_MODE1)	/* etk_d0.mcspi3_simo gpio14 INPUT | MODE1 */
-                        OMAP3_CORE1_IOPAD(0x25de, PIN_INPUT_PULLUP | MUX_MODE1)	/* etk_d1.mcspi3_somi gpio15 INPUT | MODE1 */
-                        OMAP3_CORE1_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE1)	/* etk_d2.mcspi3_cs0 gpio16 INPUT | MODE1 */
-                        OMAP3_CORE1_IOPAD(0x25e2, PIN_INPUT | MUX_MODE1)	/* etk_d3.mcspi3_clk gpio17 INPUT | MODE1 */
+			OMAP3_CORE1_IOPAD(0x25dc, PIN_OUTPUT | MUX_MODE1)	/* etk_d0.mcspi3_simo gpio14 INPUT | MODE1 */
+			OMAP3_CORE1_IOPAD(0x25de, PIN_INPUT_PULLUP | MUX_MODE1)	/* etk_d1.mcspi3_somi gpio15 INPUT | MODE1 */
+			OMAP3_CORE1_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE1)	/* etk_d2.mcspi3_cs0 gpio16 INPUT | MODE1 */
+			OMAP3_CORE1_IOPAD(0x25e2, PIN_INPUT | MUX_MODE1)	/* etk_d3.mcspi3_clk gpio17 INPUT | MODE1 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi b/arch/arm/boot/dts/ti/omap/omap4.dtsi
index c8eedd33b5d6..6ebe5f6deee1 100644
--- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
@@ -679,7 +679,7 @@ dsi2: encoder@0 {
 						interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 						status = "disabled";
 						clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
-						         <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
+							 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
 						clock-names = "fck", "sys_clk";
 
 						#address-cells = <1>;
@@ -716,7 +716,7 @@ hdmi: encoder@0 {
 						interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 						status = "disabled";
 						clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 9>,
-						         <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
+							 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
 						clock-names = "fck", "sys_clk";
 						dmas = <&sdma 76>;
 						dma-names = "audio_tx";
-- 
2.53.0

