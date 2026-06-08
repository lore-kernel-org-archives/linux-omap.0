Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA033A7595
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951488; cv=none; b=QQwqXUfsuuoK4qw+Dxvx21XHkiv/rWgVo4R4QBGqJnMWeyEtEbDVa+ooypL26rCaun2WhoX3risbu4bqKOfXb0LYXRoi2PD2AQQkZznumwiRG73uu8rYzlnxNNkmxQN0b1W4VDF/ujebWU16lrGMsLJI0enIZEoTeKmKD9nJnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951488; c=relaxed/simple;
	bh=zNRMiBZ+kNoq+YW6OjKzvRqTqFQ1HwTaXPoZQ7puVbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPzZUiHwtQdw1HOFTJtAbKocZvii6V/d/8ZYdVT3/FKBzl6rdonJdNTaV1Zsbk0foTv0/YU4VB2F6vZr2NXsFvCLSzW4fLimSNgnJgBeJ7x47PwzPb5DBNtk8MZQvnTenTPUZW0gCEuzXjLoT7j+gFywHtzjqrhbJE3ZuY3zl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWBLau39; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5YPIp4r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWBLau39";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5YPIp4r"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IxDCC237008
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 20:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnNdb5A9Du7XL3S7Wq+Il5jXREGeZ4aI2BZqdspJTvM=; b=HWBLau39VSb2zMQO
	/Ml8jwYT0rEb8gb/VAweKx0UkoIcasbP0IGXoEJyTlP/f4S8uU/GTbJW/Ax6UjSL
	3axjJbav2yCZj7CRjPdtOK6dGebJwG7EuGsdtx6xUT4zlhLVg/QfEApQpqJaYUfK
	1UE1LKphVG0/OmOikuXU9gtBJLPjZTntGDvbe5lfPMuF1u+BbodM745l2WY79Adv
	svDUUsI+8ofstrWAdMxc2qwiNX9nAtVQnaTzeWXTdJP3P6hYhtwqojI0lmr3owpB
	QrQ5UJmoPod8P/7r0Eym5UrjUmr4rrA86K/WznIkCjh/UfXF7Gzb9iRnG4YFmuQC
	w+37Gg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rt6qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 20:44:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5175bf22b1bso68810081cf.3
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780951485; x=1781556285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnNdb5A9Du7XL3S7Wq+Il5jXREGeZ4aI2BZqdspJTvM=;
        b=R5YPIp4rBkaam040LclUjj498st+Rttdf/mbpu8iDsI8SwwCW6xFsRzc4NNxJmlAyW
         mr84QZ07AlGkAdKpslUKpSkQAfqWz91BzE8a1//8pwkhelV5uDgPTiikgmPjikPCONnR
         E3TDXHaA6ZbhKZafEuLVLlvbo5OE/Y2Tb1ZFCgM7s4YWCXLiPxrl8RL9iW2uWe4jgTZn
         QvZH8EZezAdDUnRX7aEaC9p42J/3NKFmudHZB2IK1CGPOmPKri9uJlzGqRmGM15klKOt
         pYfy0x7+oCMQqJ38rCMwKNlL4IVjyFEsZuS0Z6FBzL8F24iap7Xm9vBtbcpU6z5PsiSd
         hSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951485; x=1781556285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnNdb5A9Du7XL3S7Wq+Il5jXREGeZ4aI2BZqdspJTvM=;
        b=I16a7+DX9MTLr3z+dQXsUAYRMq8uZFXIUYPV4HOvyFOaynQUoCLNI8QiFHMeZTFAUG
         aQ/qm6hZ8MRNfIeKVdM+pqSPHNlQKKh2WH5jfjhqpr3dLWUdZwAEChuP7y7ZalTMBbO1
         QWtcSW8JEm/Hb1aYJOwXPw6KQaaAMQhL3o0C5I7M8xHdntSS3+Q/U2k0irXid56QGI1W
         9nMXvqJJjI2lXziwOYQrYRgIJCMwuvorbl67rz9HsrJeJ6j5ef/vzSwQkUfMFUDIgOHB
         HKCjTWMzRODVWV4KR0Chx3gx+AZuFA79iVSNaCPNlOaIZiDbbotkJ4GdTFyRt7Kawy5N
         H08A==
X-Forwarded-Encrypted: i=1; AFNElJ+PbGsF2qMrpm7CtpIZ/iY+8lWcD5e1FPaP+9kgpK4knYZeNf2TcMD05pfM52VnmvcnKSqCV9ePTpRg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMT7qo4qzQLuGwoBeNwxbwwGOoJDafmRnFtx5UR2FxeQAZSGE
	VKMHWy7nPspvcSBlM92GenKD3hpGdxnyH/kEVsriLekmSm/9Wd0AI5DRrGz6w/AbUgPg8wo5DMK
	0m4CaFhwr+szvTIf1HXPBXnyOgNQHPMdQLU+oskbJwGaWXtN4NW/tF101qnFwulUf
X-Gm-Gg: Acq92OHyto/h8Wl7uCH1MVf6oluNb4t8cJshpEQ4V2na5LoWjKO/6qWAyCP9Zj8nySN
	bCtQhwDL4kqHoo6ygLpN1JT9QxIgaJpd8pghbuo37qknh8Zix3jOP4I2lPw+Fqyj8sBclQGiQlU
	pnTJfttIcerAhHtoJ34IZSzCyXZVIqCQX9b67i/xahVTqrIzHzNGmZOU+lMWb90Au1A738SieU0
	tyH6HYKAnP+nwujNtv5gId9hMvMccpoYD5JFQjCmhyqkElmcyuzHt2fkFps/necHMOj247BZa/m
	XlLhkpPJWCms06WnHNcwlWuX9mstUXSXv4kjqz0h3qQivv9gktYJCNJ5vWioQL0v/JLXj/PzXZs
	6NEVZvuj4ys3uaET96FDpoOXT4+59Cqy6xNt+SacSXERMWF9fwF17fKU=
X-Received: by 2002:ac8:7d83:0:b0:517:9570:c1ba with SMTP id d75a77b69052e-51795afe738mr243823441cf.34.1780951484682;
        Mon, 08 Jun 2026 13:44:44 -0700 (PDT)
X-Received: by 2002:ac8:7d83:0:b0:517:9570:c1ba with SMTP id d75a77b69052e-51795afe738mr243823121cf.34.1780951484239;
        Mon, 08 Jun 2026 13:44:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm44018439f8f.32.2026.06.08.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:44:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 22:44:26 +0200
Subject: [PATCH v3 3/3] ARM: dts: ti: Add specific compatibles for SCM conf
 nodes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v3-3-4eba9ec1212a@oss.qualcomm.com>
References: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
In-Reply-To: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6238;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zNRMiBZ+kNoq+YW6OjKzvRqTqFQ1HwTaXPoZQ7puVbc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJymwIBEPDBUQiQY+pkcr+TbTVfD9i5SdhfMAZ
 hSaGmpSeTGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaicpsAAKCRDBN2bmhouD
 1xLWD/9pqNYoAEZ8rLlubC1gMxi4cjfVYg0mCjs+op/jGQOndFLxLesoYW5bg4Xwg3BoijToPXl
 dYa4isoqfRj3UjVoVpZLUs1e49a5zcILG3YcBDPTX7RIUV3cR9519ovpRKmI7qkvlIWAF3FGwqk
 p/O/ldAHxklVYoBoMZcS8Yb/wCcU+9zX20nseSgepbpebW2ZTTLBIU4J+TJbfTCgLOVrT1q+3KE
 U/JiOpsCXvgx6Ue9AHfTzotbO+dqN2+XQmdkQzM7tP47VtSvkqM4iEN190Pp8be6pNnPZA/Db+D
 oLdZwiLRrGyuVf32c6eCMwp8aBe0r4zOrp2SrCWJtuZ+Wy6d/HyHlXSz75AAlpYfkUih3fjIJEF
 jpxAuq9DVb58+vV+bxVWuNbziv9XkQS6ABXjf2ulavDex6Y/Ik4ZT7udsXl7T0yaBUxS433NkRS
 LWPjKOreHPon7HdxFYw9RSp/X6dXb9XSKHo4D+Snlj49czkcT6/ZOVWwzh0dO4ScvSK0QqOOQ9+
 XJE7kSKEln+PPS/UDEeNiOwQs99rmNiBHmNhntcg5fjDKuvgn1sMGkenaJ1KjuIucCGPM+zYBbp
 NltGEW8z/Ngjaj4HbATilGpSG2FPzKnCBUxp/TeODAOOUmTWlfy109mO9yckBybe4lzGA5l60qT
 ekeAycc2Y4+PKlw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 6RLZNW74X0wH90yeIayYDgEMLU-hGqke
X-Proofpoint-ORIG-GUID: 6RLZNW74X0wH90yeIayYDgEMLU-hGqke
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a2729bd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=50gAi1W1AAAA:8 a=EUspDBNiAAAA:8 a=AwmKQTmtiYQHBMsDbE8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE4OCBTYWx0ZWRfXz+C/tjqfKkz0
 Wynb0G6Ro9ezNysd64XKntwZsrcfTMuM/H+hTh+O5emKqShceJhF93fyvref1I7HHpb30hN2xkn
 SqDValyZW13J5MkpohvZkuT+XnwKf9DaBkkhnvTJNs1hOlnJYCW3aAhNIJiyhBj1fIbLGiuiDMV
 yNZwD+WEaEkiwl8Xi5Fvdv9rYFbXeg2/onH/aMrrhkv4xSNA+6wB0V8kKmIhb60foldaK2DN2Wn
 LBfxqwD8hcdmvz7OzHJwz2mXFqptMGmKpPpaNKDTCKMyMra9WKZ3x6v6punn4KTD+mlfUe5s3pp
 14PUG0xbzW4tFkPcDCF1gWHxu+ma0lfNVwX5rJclm7DQ0VIrQOfKaRJs0x4f/azs0dbn8ZmrtoK
 YdC3VxCVFWpa6t8YRxbZNKiovvw8ali3RjBU5gk9uhnSAT2ph8YBJJaWVJR+bwlAdl+LRjKsqzE
 I+CTE+zb/sPpnCvhk2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080188

writing-bindings.rst rules dictate that "syscon" must come with a
specific compatible identifying the register layout.  Add specific
compatibles for these devices.

This also allows to solve a different problem: "syscon" is contradictory
to "simple-bus".  A system controller with registers having their own
functions is not really a trivial MMIO simple bus.  These two cannot be
used together, unless listed as an exception.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v3:
1. s/ti,omap5-scm-conf/ti,omap5-sysc-padconf-global/ because it is more
   appropriate (specific)
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 2 +-
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi | 2 +-
 arch/arm/boot/dts/ti/omap/dm814x.dtsi    | 2 +-
 arch/arm/boot/dts/ti/omap/dm816x.dtsi    | 2 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi   | 2 +-
 arch/arm/boot/dts/ti/omap/omap2430.dtsi  | 2 +-
 arch/arm/boot/dts/ti/omap/omap3.dtsi     | 2 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi  | 2 +-
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi  | 6 +++---
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 89d16fcc773e..1e09d2b48925 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -308,7 +308,7 @@ am33xx_pinmux: pinmux@800 {
 				};
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,am3352-scm-conf", "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi b/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
index e08f356e71cb..30fcce33f4b7 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am437x-l4.dtsi
@@ -301,7 +301,7 @@ am43xx_pinmux: pinmux@800 {
 				};
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,am4372-scm-conf", "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/dm814x.dtsi b/arch/arm/boot/dts/ti/omap/dm814x.dtsi
index 27d1f35a31fd..9e02bfa5c3a2 100644
--- a/arch/arm/boot/dts/ti/omap/dm814x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm814x.dtsi
@@ -432,7 +432,7 @@ control: control@140000 {
 				ranges = <0 0x140000 0x20000>;
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,dm814-scm-conf", "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index a1e0e904e0f0..ee0090f7aa64 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -100,7 +100,7 @@ dm816x_pinmux: pinmux@800 {
 
 			/* Device Configuration Registers */
 			scm_conf: syscon@600 {
-				compatible = "syscon", "simple-bus";
+				compatible = "ti,dm8168-scm-conf", "syscon", "simple-bus";
 				reg = <0x600 0x110>;
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index c8d325b0f57b..9df7648c4b79 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -64,7 +64,7 @@ scm: scm@0 {
 				ranges = <0 0 0x2000>;
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,dra7-scm-conf", "syscon", "simple-bus";
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/omap2430.dtsi b/arch/arm/boot/dts/ti/omap/omap2430.dtsi
index 222613d2a4d1..01bd471f9223 100644
--- a/arch/arm/boot/dts/ti/omap/omap2430.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap2430.dtsi
@@ -50,7 +50,7 @@ omap2430_pmx: pinmux@30 {
 				};
 
 				scm_conf: scm_conf@270 {
-					compatible = "syscon",
+					compatible = "ti,omap2-scm-conf", "syscon",
 						     "simple-bus";
 					reg = <0x270 0x240>;
 					#address-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/omap3.dtsi b/arch/arm/boot/dts/ti/omap/omap3.dtsi
index 959069e24730..447736d2e53c 100644
--- a/arch/arm/boot/dts/ti/omap/omap3.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3.dtsi
@@ -116,7 +116,7 @@ omap3_pmx_core: pinmux@30 {
 				};
 
 				scm_conf: scm_conf@270 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,omap3-scm-conf", "syscon", "simple-bus";
 					reg = <0x270 0x330>;
 					#address-cells = <1>;
 					#size-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 4c78a0b28fab..c1afc49f456c 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -681,7 +681,7 @@ omap4_pmx_core: pinmux@40 {
 			};
 
 			omap4_padconf_global: omap4_padconf_global@5a0 {
-				compatible = "syscon",
+				compatible = "ti,omap4-sysc-padconf-global", "syscon",
 					     "simple-bus";
 				reg = <0x5a0 0x170>;
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
index 915870eb5c99..72849e1c95b0 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
@@ -96,8 +96,7 @@ omap5_pmx_core: pinmux@40 {
 				};
 
 				omap5_padconf_global: omap5_padconf_global@5a0 {
-					compatible = "syscon",
-						     "simple-bus";
+					compatible = "ti,omap5-sysc-padconf-global", "syscon", "simple-bus";
 					reg = <0x5a0 0xec>;
 					#address-cells = <1>;
 					#size-cells = <1>;
@@ -2311,7 +2310,8 @@ omap5_scm_wkup_pad_conf: omap5_scm_wkup_pad_conf@da0 {
 				ranges = <0 0 0x60>;
 
 				scm_wkup_pad_conf: scm_conf@0 {
-					compatible = "syscon", "simple-bus";
+					compatible = "ti,omap5-scm-wkup-conf",
+						     "syscon", "simple-bus";
 					reg = <0x0 0x60>;
 					#address-cells = <1>;
 					#size-cells = <1>;

-- 
2.53.0

