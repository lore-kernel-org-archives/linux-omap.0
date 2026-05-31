Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409F36C592
	for <linux-omap@vger.kernel.org>; Sun, 31 May 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225463; cv=none; b=kpi5Z5SOYK6yDVTIoWZyjDbqT8jd0qKzSm7OwC97409vckRU25DnYwQQUGnSo2oIBBMMvyyDlKMnmYSLxQ75a6il6oPh7Cq+V9ICudwyGMPCmO3/AFz34NP3LyROUcEr1cfaKpNNGSNwIkL3z3T1pkt0vVkm5zCeZlFiyjfnpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225463; c=relaxed/simple;
	bh=gQgB6pCJf+GriAx5hQxx+duECe3eb81+tPFKBekHp6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKkgcvlU6NU+NrC8ijRJpab5WQ4ToCd7mqoGRMri7lDBVzuTf+wCwOYOm4HYb9jnwhgo98FQE5Vnh+vg3DIX2R6w8wVzK1XDdp9Dnn4gPBOcAiyGsflSct7GgpUcDrzmNmC5SYblRMegE48u74PUUqJaJP869IgL1nq856Jet8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OlSb3CEk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oh/mm0KG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlSb3CEk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oh/mm0KG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UJ03Rc3838769
	for <linux-omap@vger.kernel.org>; Sun, 31 May 2026 11:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=q6slP+otLsq
	SiADYxKP8GL1dcmB9BvmpiCq+84zJwkk=; b=OlSb3CEk3mS2xYKbUtPRCdDeMaG
	OKx2NSnDb4EdqYTG0hLc+HtNwCYS8JBRJS+qYGRKpXNv0qhFlaAr5W3SxM4ENYKO
	nEZyC3O9KotVnwf7ejzH2dW867GBuUv9vb2GwJK/deOCfyZheXA/wUogpI5tk2pC
	EUS/FH41CeUpQJNjnQB723oSw5LAR0W5z6gHFvROkqYfZg0AlJ8Ndn/NBlIe6Ovc
	P90cjpnAAhjMG93i6uaakbCFE0zRCFbmyAp6vaf19o0Nd1Eq55lQYYTaNr29/fxq
	Dcqjb82OaJsf/VQov7zFied8VUj2qPmrNPXSfKhkEDvwEQtgKZ1i6saIcLw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fbgmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sun, 31 May 2026 11:04:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a0e93eeso15690681cf.1
        for <linux-omap@vger.kernel.org>; Sun, 31 May 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780225461; x=1780830261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6slP+otLsqSiADYxKP8GL1dcmB9BvmpiCq+84zJwkk=;
        b=Oh/mm0KGbDD8vIfAFhHBSBofk3py7FcLqPXOWproJrFsQLHwRJLJdBk0TxuEFTNpHw
         DiJul2CwcDpD1DuSReVh6dyfne3wzXLWYwUOyo8z9v/viL9+JJVOfZbwiVUnWloD2hwd
         OQo9GN5jZ7C4mtppRxYouZ2xVJpzoqIaQ0UguJQDKf2Y/0OzwEyTKYfUW06mLwW5wTFN
         v18cskhvWmbtdsNsVPARsWASOOPmFA5qjehPj/rtOA4ILL0vzz0+86UNqG8GI2JH/FMO
         GGYJccTRaSb5+AtjIMylicivhprmuIu8In/+RSlv09rTwv3Vxstgu8/3UR94hymWhKRc
         cq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780225461; x=1780830261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6slP+otLsqSiADYxKP8GL1dcmB9BvmpiCq+84zJwkk=;
        b=nBnqEnLx2od+/kI/ukl0kTEMVuoolzAVgHkwPSWD22dsKqQre/HXzlfITOf2X7oqg2
         Dagoney8BJgy8/FiTm4dH4uIE4FeSYyfjl6pFm1Hi0NHcrd+LFd4VdBzU60GiyBs4cgk
         5UtcYN1yM+671AMEd891FzVGdpw8i0SzGS/mhiVxYzAfGef6rpGRs+i3i2r26lpz/zo8
         nZJ0bbX1A8si3qS9xq7ARdg2Up/QD0P1whFQtJdGEJm3e2ERksyKhOqEeTT6VxuAYpzB
         DMni5MmKXWN65QZTxqVZawumevCMfQCV8GmxaQaaLwI+bpFqDUQKBpZSINCMRujVPDao
         QPvw==
X-Forwarded-Encrypted: i=1; AFNElJ9iKCK1sZQyLm2HonfhsmV2eCjHh3vj+JUvcKAjNmfJk554UqmONA9zKJf4Edxc5ZrfHcNik3rpLW/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yzouy7tLNaz+M9XYp2Aqone+I1YxVv5k5Kv7/sHJVn3UsImlBR0
	WMb/ERBzMmG+MhxzcCGz8AwVHmVoQ01KeZ1gBN3DBi+NZAKsRk/LjJzDsJGcECOo9lx75H/JbV+
	0fl+jvDAzctBWTW0IKP8Cio0HmHtYpq6IaKokUarBX+p43LfydTn3UCdKSb422mnQ
X-Gm-Gg: Acq92OGd9/aebiWTosQLA2MJZzFDH/0mRhtEsIB33XLRCGm1QhDN1KomYQN07Bxu39P
	Ct5shheoWJslQ22Wl8aP7Rdk54PPHceaRUSc3WTfUzMAQg6nPhktnci6F3JLXjbrZMArCEqRGsV
	9vUYmdFO6+Uo3LP0ZqAFijUHNlEHyuaXQff0YtpYnlm4inUFZHBJzggt+mO8h4J63AWmX3JlTjD
	R4I4XI6BmxvK+X6hzKGHpvvEZlscNEra8LVU7tp68Ax4pENyOgkKy72mbYvf9A6BLbDwUTy58pP
	h29HzGsAfEMhwblELRt+W/l+WiTPY5rhJj2u/prXhd8CXwWQTDn/J2YImRLMq/h62XHisLJjT7+
	xVKTPUspU+09xYWiGFQ==
X-Received: by 2002:a05:622a:8348:b0:50e:60a0:acb4 with SMTP id d75a77b69052e-5173a838046mr73270861cf.44.1780225460648;
        Sun, 31 May 2026 04:04:20 -0700 (PDT)
X-Received: by 2002:a05:622a:8348:b0:50e:60a0:acb4 with SMTP id d75a77b69052e-5173a838046mr73270441cf.44.1780225460123;
        Sun, 31 May 2026 04:04:20 -0700 (PDT)
Received: from quoll ([185.12.129.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3595ef4sm16512872f8f.37.2026.05.31.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 04:04:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/2] ARM: dts: ti: Add specific compatibles for SCM conf nodes
Date: Sun, 31 May 2026 13:04:06 +0200
Message-ID: <20260531110404.12768-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531110404.12768-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260531110404.12768-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6047; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=gQgB6pCJf+GriAx5hQxx+duECe3eb81+tPFKBekHp6A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqHBWoUkdC1t00LG5Z/pDDyr0UaDVw7avJ2Fdxl
 U4fpJLzSsOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCahwVqAAKCRDBN2bmhouD
 153JEACQkXmZEtvMKkwxO7N45pVPZJecUTVJPS66Qh+tTXzPvPBKkpJ+AlBYCWU/VlnAILKAZMK
 zF1O4z9rgw2LLRpiNwOI3YY96aBBf76/rNCeSvcRE/iok4BPtQpzdPx4QUaLzu0N9gesVKGuNnZ
 bAgsf0QSxRcEbdL6K6oqbDjE1wWvmzpwEHZyP3HqZOQVpUzB4RSUmygBx1r+ZMlhsZrmuiqTJAF
 r4Muny6ciIS6u7tyuYZsXK1AGmRLxaBkZe8g72k6IxhAJhF5kUNVjoflHjgmsg/msfwopZPRUoP
 Sq/4kcD2FfshlQIRlo4agarZE/Miw6Q1buhjcVr/64e3pT+HsKvXR+wxvOckl3rcNk9N1QR1AOX
 B6Ls/C/ZB1GwfRUuYa6kEtJ0sIxwf2jA/SQPm1Yc6Z9eGjZWgQE7o4cUHc6yFPSKtwXdo5y+GmT
 MK52qXcGx8ECfydaH3WzVxxh08YLj0m8n9JjJJbKW14ap3f7Fu0aCS9oFgLEAbE/1fSgTkXwyLb
 8gsRJYlA6XYwdCMWy0ICMNiiUEoBFh3vpOFcP16AFcc78SVpBJRcSI9HGoighs6W6XsG0kocQ0+
 La66zQNAVhVT7/PaN2L+FXr1wYRi4r4T+Q2l95qQM5W5NF3QM9flZMDTcrqvW6l25nvzaPNGC5n /d57FT1XegQUFaA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cK1G5WtpTo4QCORWyg2lwzzID_VtXywL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEyMiBTYWx0ZWRfX4307Jvd3TcOj
 0l+3nvGN30YhItDbwTZFfQXK71amupx7h6AnUyl9wr7pMEBVoKDF2Z4cUt7DRHYJBiU78l2p/nk
 49+bL77Jq/tpSrh9XQopm+35MMn/6+M7rAOFoEUIO7OGm+dBP0BcLnKiZAPBtyh/Sb8Bi9HexbI
 Wb1MtUz45dofuog+8OMqxx0s9C8wGz3pt3c3NUdmYF97LwfUlg1+7vp81P6b3FKEeT+6ps5Toig
 0F3etoz/mdH7L2eYTFvEKgUFPf+9YIL7yzHysdun9s8jjgD0Q7dvVrhMe7m2vNzvcG/EwUDDO7/
 6RCTAmbzD3SfWen43HJXhigc5x1gSWWMJSXbfAlVUXoDLBHfnIRCUzkboaVny/3KvC8yeM8svm+
 dIZpiU9BI7Rkk7QhsI89o016O/KFE47n/9iVa6QZDe54H2nlFDPN3hJkcY6e7zv++uBUUznYaXi
 kqihTJoouVFRDcuJ2Sg==
X-Proofpoint-GUID: cK1G5WtpTo4QCORWyg2lwzzID_VtXywL
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1c15b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=3CdwnVXJlszSr5aekAfjag==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=h0HYIqCiEIHQYu1o55gA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605310122

writing-bindings.rst rules dictate that "syscon" must come with a
specific compatible identifying the register layout.  Add specific
compatibles for these devices.

This also allows to solve a different problem: "syscon" is contradictory
to "simple-bus".  A system controller with registers having their own
functions is not really a trivial MMIO simple bus.  These two cannot be
used together, unless listed as an exception.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index 915870eb5c99..3350128db22d 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
@@ -96,8 +96,7 @@ omap5_pmx_core: pinmux@40 {
 				};
 
 				omap5_padconf_global: omap5_padconf_global@5a0 {
-					compatible = "syscon",
-						     "simple-bus";
+					compatible = "ti,omap5-scm-conf", "syscon", "simple-bus";
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

