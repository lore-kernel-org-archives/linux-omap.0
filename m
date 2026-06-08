Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BE3C5540
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926913; cv=none; b=fvFVBuLCnek3MT4+zI5KOCA2k4Z9GAncRwAR0PI8zGbpivoC7R9d/uh5uMGi0ZZWSAoXUOK4xPSzcVXwIfUJphJ8TyhN67bffnM4ErUMhX+T9UedZ0OMeasHDvhrJY51yYki0oUz1rM4TtlIZFT6t5auNFMz97Vw1VW7Ht79ncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926913; c=relaxed/simple;
	bh=1TEC0glULkibN4KdgZrT/r3Q3YTk2QahVA/FaQ9NL6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMdUssNy9dHo7dn0kWFIcZa+wyKf42Gc3eBruSvzgkhbaUqjSd3u2niU8juNag1mFPQ3suNdJGDz2DS5HViYwH1hBvGfWtkf6Ovx+VIJD9dar9wdtQZ6TyaoNorPz+Xs1tBMWRwBhYEO/MTD0VLqpd0HtzsiuLpBzRboxiv87cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ftPFlvSw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b85ziiz2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ftPFlvSw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b85ziiz2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRGk13271826
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 13:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYAENU3bKN6fHyKKtSYTgWQl9v5OPWMHQrRWdi1Q+xg=; b=ftPFlvSwQeIcmroA
	XDd5yCj6CRUGTJPJc43DA7o1mB4Zt8RDsQD+8Y0JoueSjgyQCVwp/bTWe9cfhS0U
	UFGfSW2Qsac9po1OC8IxVaJ/Ptan1zu8thyCM2ZI6wwg9XlCB9jXg1TDsF+RCwWO
	HpnYLXsyv4w2wI3VOM84pAeojBnYwGDYnadIf8i+GFgTMzEBDhzhwKstIIuNfAUc
	i95hLNmdb4f87rZKTYgluUOT0y48Wy7Oeh0/9XhXx8qrnkZLF32sjLE4BTUbfSsF
	KX8+eSDG4EyPUXYScpeSNFxPPzRc2gX0ddG+y4ofLlgg6Q3gGkK5Ulak96FyMUPO
	NEmznw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrks90y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:55:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5176d5d7222so82902141cf.0
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926910; x=1781531710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYAENU3bKN6fHyKKtSYTgWQl9v5OPWMHQrRWdi1Q+xg=;
        b=b85ziiz2/QK84G76ne/kFxp4EH+YInueatgCNhmDMhBnKb1jotrSc6ri/ZM1lvlQ+n
         cQs3FGvGsA2PSfxjtP383uW0MoGFdR+VhzYgNFgkHykVwvS4cn4IUqfIb3/kpd5F8+Xj
         4RDz94DRAtq0XCXb0B9YEgi9lBjZyP1K3iu+FD4R3lBMu76LGDSDiQpq1eDBbsULfqAr
         Dhyap9SRm0NGMVpEnEqatuQeSoWlB0tqzz3PqSwN1Kk2L2DIGrimk6cTz47NTp4jMlpZ
         YtYj6CeYQQun96m46TAl8Y0TMRwreSQnmwzSsDSNzYdHlf9RtywmAWQdcsqJ7sIiV760
         s8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926910; x=1781531710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYAENU3bKN6fHyKKtSYTgWQl9v5OPWMHQrRWdi1Q+xg=;
        b=dS8YHB7NZzGWXBgvUjEFBkQ9uy95JijR2GWHozvkORUmO+mW+GkfD5s3jO5JBV/sQd
         g712lnNTOvbqCLwPUZ/6xvwGp3/oDAWNKnW+D+tdK9O33WsvcJ1H4aJD792ci/CFz0cc
         zjI6J5xK78B8DwqwYeF+ZUF0EO8htCGzVO+4QSRzMN8tBC/ZbmFwOyY6TQ9zgu3uSlsK
         k+pSBIfBX42EmM+M1fmUdC9MfqcQwx9b+XBD9QC9yBvedGAG+obbZdwrQEhGBol56Obz
         1cbDTY8pqmWVHj4mnFzJF08GRb7Ng69nmXW8UnKAL7cQKJichzJipm01EcOTVCp4cZ1l
         KMug==
X-Forwarded-Encrypted: i=1; AFNElJ9LU9CQ89R8i+HTOzvzrU4x/uidI+Rt4YBJGCYLmMgEG4jaXnrsJ7Sf66zVdJzpgJl0TFkanQU1tM0Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hRKIO91wn6MoIkr0GuzQoE0zWzz91wejyCAQpr3EVHEwO4mM
	g0gXvxeTZ80P+8RG5PRLNncdh0k8r7SB6WTw+4JzTJ81kHtRboWx14TqApYqq8iUE7ECzbm6LiR
	KUzpy2cRVDVftlxBenl3J1Qp7mwxRKRKY6+MuXRT9qc1FObvl+PB8hh/h27hem/4L
X-Gm-Gg: Acq92OGWhxgDJW+p7orBDFHErGB0k+xacc3crdUza6nKI3UG5VVXaFp8GZVXcUH+0Uh
	OIclkuPsVPB+zP9MdAHnV0uHnFlrL/LYwFFWFVaaOYEwE3eLhWZ0q6hwz51llNnxAmDhsQ8+33k
	EyKVF8Jg5RNpgE3+7uhgFPkGN6twmrwxYi5gfD0uo+yD65R8UAZYQCYgfLIRhPYgKgzlODqLsq+
	n0rhS+XWh3rlVI4CsEnl0OYx05o26IxoNcn2glEkcFp6l7TuYnZZkVk6FsPjylD6AZ2TmL8VBxz
	nIj/tMx4SrAv1gbyPb1kc857mUl2GVvYp0fFQnZbO3WzL0vjFCPcRVvodnQKhiG8g0MPKgDORXf
	6AGdd/e13YVOc34K/PS+FXi1oEk3LKUbH4ik96z28oyvnUH0qrOmSV6U=
X-Received: by 2002:a05:622a:4c0a:b0:517:6fb4:5796 with SMTP id d75a77b69052e-51795bcbd6dmr233492071cf.30.1780926910316;
        Mon, 08 Jun 2026 06:55:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:517:6fb4:5796 with SMTP id d75a77b69052e-51795bcbd6dmr233491291cf.30.1780926909757;
        Mon, 08 Jun 2026 06:55:09 -0700 (PDT)
Received: from [127.0.1.1] ([213.55.209.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm385972925e9.5.2026.06.08.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:55:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 15:54:17 +0200
Subject: [PATCH v2 4/4] ARM: dts: ti: Add specific compatibles for SCM conf
 nodes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v2-4-0203e6c249dc@oss.qualcomm.com>
References: <20260608-n-dt-bindings-simple-bus-syscon-v2-0-0203e6c249dc@oss.qualcomm.com>
In-Reply-To: <20260608-n-dt-bindings-simple-bus-syscon-v2-0-0203e6c249dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6102;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1TEC0glULkibN4KdgZrT/r3Q3YTk2QahVA/FaQ9NL6E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJsmr1TFF2JsnFS66lCU+8F+0p5qJHQWm/zbvh
 UkJEZ5dWPuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaibJqwAKCRDBN2bmhouD
 1w57D/9Om0+Ap30Qz61CKEnvch9Did/wqToFGxnJQ2JdOkEcVRs+TGjLUVktj/NMHJduyiKdC3H
 lvRaXHDPMR8luF/OqbQTvidsT53QwUYNkShjaM+gS55P4+JqH0KxtUBolOmJkWqwSNRgHdAY+Kx
 skRFzWFXkRZyyxp38XHyZA1dgD4TmF3I133R5s53OEpnCLOumMbl9i6/w6MC5YUj0LjMXDAFja8
 Z4wE6RVLg1vXq0aLT9VtDKIHjVc7DqzNSTxGKCJnYTyL3wxT5RrS8072zPpikKv597dy6XSf5r7
 vhWE8W31x92IsGmgSi/o8RyoLO1xxoigfrASyHElWB2FagqUhvjZvBGqfPuk6+W+3ReFqXIGh4D
 FzO4zxE7w9RXGsGUgLwZr5/0sPPogfOny6q/8tOFN2F5cex7JgkZIUFUyS+81GzbWoAez745GlC
 GBE+vXK/J4EH/gkdp4MvIepziyvEU1lWuxX9tqVl1e2vFzoV6BdJc/P1ZTFzlD0BgO481VMEs8I
 5YTZEc9Z3Lk3ifSt7azZoc7d9HMxorm+6PrdYBLX5YWEh2vAG1KgvI3e5HkcreiBj4pZgI7K2HI
 ilHvb9PY9Vgic3JVKyzxkr7EHYTu5J1B5Ey2SVC6mbf4FLetntazJNiFS8U1KUWGKCKo1/l+Mqq
 As+xdcBo5ObiP2g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: 3EXzfBbPry7lons4thwOmnZ8NTVN6z4I
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26c9bf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=bD1TNsHgvEXzglPpcYW9rQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=50gAi1W1AAAA:8 a=EUspDBNiAAAA:8 a=h0HYIqCiEIHQYu1o55gA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-GUID: 3EXzfBbPry7lons4thwOmnZ8NTVN6z4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfXzN3mnqraeWXb
 rGb5F8WQ1fCLlF3JEuzX5vqm24VCgzOrLbcow90VxdgbaHiresPn6j6Fi+5YfNXJcvbWlH4TnrX
 R9FOCnXAxSbpMFcHz7PRY/B08136g+fCbuHja29UV6EOsyfOdmKtY2yZxxkJiTDRwsRZGWpZC1N
 QzToeovPRBj1GgWagUgwDB0RVH0n7JD96l/dV50LMytOoyZsa9/JCnjFE0I9Vsw00BLHjFIjTqq
 ++rlf3TVa4KlCtq33hKHpUQSlhPgbtfpz5JAyAAfpNTTiJPLW1qlPNrVxkAJefvaVec+ABZmNfX
 MULUmU3Gdd+egHgASPmebdeLFwk3VFbxKjHCJv9jWrHt0JeNIFlNsL4ZMhdZUgnq5FfWjzd0QYt
 ajxRoN1W9A1S5lZoqk6VwobLkFOSRpnctWkhlt6mqY2+7iZJCe70ecnu5paYOdwSx2wHoEH1/UX
 pPWz5gQ5k4ryUIvLPeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080132

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

