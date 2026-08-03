Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB879395AD5
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737966; cv=none; b=o26RbfRhNEManE95a646Jt4ekczCqzAbGVkOrxqkwnc3W7dJV5JV8LIcwqUNENelvOr0qkHnnaR1YXLux1Uj4srla5qu2vja0SmD0hSaVi/JDr8Acj8xT8aPXe/siO5Uk//csQklzAXTRncKNFUbdxYQP0U4xu8rjQQUBl0BRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737966; c=relaxed/simple;
	bh=a9Uuvxnh6ZCSM3JKuUBmksfHVLpBRtAfPN4ynlQ/SVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpVepNRomf+flCTUrO8tW5er52yAc7ho05F4xBACxlLp0R1nRVWoq7vr9aYHQegxF0biFj5mVReRL4qSxsOii6nW2kfM1vE3Prcj3v9yXGaiqdSaiYPKVitXuqUzlHwq0R7lb9udjgkmvqIeyYT/wO1Nf9XwV5x8aTUOMp/N3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEEEBpb+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AfuRL2/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEEEBpb+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfuRL2/C"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LVr0G3299836
	for <linux-omap@vger.kernel.org>; Mon, 3 Aug 2026 06:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iAA6AR4Qa5O
	wiZACrTqpvVVaUaRfGGENSJvkJ2dCBlM=; b=SEEEBpb+M+APqf6ZY6CjXDw0iaX
	+OriZpKKG1NAoTn8SDyil3a92eoh1XYpD30MoMgvXoNzSiRaxbxYUC7qZW0mOe3I
	JleXhU9IEADo7lwFppoP27CaNEdBewRB+WX+DFn7cNs7cUQgjlqh8cDnQNAkfj7+
	t1jMH5Ul2NcWItEDqSTaFXTTg2ucZ6uxixpZwnh6ABq4J+09iAMothYHN0mqmfYx
	9yNLVEqvfGLkOUsPpLaQzvozC6S4X309nqVwLZdoGvtqUKDBo9xrTZYUl9MMSzq8
	Wn4g3OjjGzHv7Dh++MYoDEoc/Ermbt7MhIv6C/UVFUAnEVjJqvcaD4N+iIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8qpvs89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 06:19:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0199faafso30302091cf.3
        for <linux-omap@vger.kernel.org>; Sun, 02 Aug 2026 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785737963; x=1786342763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAA6AR4Qa5OwiZACrTqpvVVaUaRfGGENSJvkJ2dCBlM=;
        b=AfuRL2/CIRfzEoZIYICUMUY2NgM3FJ6QaBmws3eCDYyOhcdE6oDc8Vn1qhh6b7qsRu
         RRB5V6GAVJlAyEVVPXlX6rpNT90sj5CMLJ0A2F18TKiney6h1xfjtnUl7QveMQY0vlKl
         WjP4N36fEwB2J/iEzNbDExa9BZdv5uVJPN7kUUDRO9F4676ocshaB67X+fEYp58jUaZs
         Ddm5DY5NLsy9omevAPx3T5LmOHEvq2wA7C9ydSNIHjvRI1PkSKMdBFqfhIe0UNOIsvqu
         +Dawz0GYkSuvmo9ucr+8uSWH/XSbRqABlopxQd2PZBZ98Z8nnAZZ0uvFgxTmB2gTwRNH
         /PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737963; x=1786342763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAA6AR4Qa5OwiZACrTqpvVVaUaRfGGENSJvkJ2dCBlM=;
        b=iB39CPobVqIMCfiD7INhaTy9qkaebLjCEoZ9cMJeaSfWGMXSVBABdyu23dHbn5TKN3
         X+JgXQQvchxCjakfr67QcyZkpFyx1Ft1txvzax/UKoTkXyDYAmcykx+sshlEAnIsa3It
         VKldlUEKX2pm891Y9GMkEkm4cp1Fn1mM0uoEwdw9omFj9C1q5Gr7NT+H+6x8DzLNY8pT
         9ZoyNKVmMpxb7IHv0u9LvJWgd7lbWCcR1vxnYcZb8E5e0qaZAc5eiKPkfDbWIWs8yY1a
         9P2OSdbR37neIGp89GeqLgQs3Gg8YNaRx8juK9On2ofB0h/Asv1OjhN5U7+/PNUtgdhE
         L9dA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0MqBbC1sl9iF52mgDrn5ikhBI7qp+0KqsuP2pY6ANwVNsxZBz5NI/g9Jbkj5d0tz1wcLFMpEBY6mm@vger.kernel.org
X-Gm-Message-State: AOJu0YxtT9JEL7HonuqlWD8thp2auWxDA5eRGaoInXs20oLECWKybsjx
	BXeNlJcWPXv0hKDAxkOk6ee/ChMcx1xjHRBz59zCRmBTk/4cRXMTaVh5ic+4Xxs88Efu6OsnU0i
	sMedSrQX55svJC9Ib7euk2RDEe8rlKnk+ej2B1EJ7jCpEzR46jEOsWMwE4aOai/gR
X-Gm-Gg: AR+sD13wMpMP/0i9PV8rPftH/IJPctzCgNm8yXRJ5a47tKhwjQ5/8DXrQB7TU9udZvp
	4BBf1C9+FcZ5icmEKiNOJbZyjJNm0lj+fYLdbxpSn3l8dCEhRLsCFjb9YXETMasuT/Vk4Q3Awvc
	N/CQVCZzPBKbKTMaYMJPLUaj6bgS083BN7nk/QySyKvTRIdkm0qv2OyNUC4kcvMAUzmneNaILEN
	rmK0KtGo88wDMKCZXgXppF3PQDZ9ZjSmrbl73boiYoS+Q5FSU1RBBRsb6qeo/cnDFIuYDmCZoBK
	myZoGAeFaCcpXkvUroYTltqWAeCsz3H4f8QnD3N3c0NaXZX5JWvwEHijbmlrZjkPj93VjcfABdi
	YK44U2Uewh4vvJiBL
X-Received: by 2002:a05:622a:1f8a:b0:517:8a18:7624 with SMTP id d75a77b69052e-52b5667173emr187812441cf.3.1785737963061;
        Sun, 02 Aug 2026 23:19:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8a:b0:517:8a18:7624 with SMTP id d75a77b69052e-52b5667173emr187812111cf.3.1785737962593;
        Sun, 02 Aug 2026 23:19:22 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm318457575e9.11.2026.08.02.23.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:19:21 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: ti: Correct white-space style
Date: Mon,  3 Aug 2026 08:19:12 +0200
Message-ID: <20260803061910.13973-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=a9Uuvxnh6ZCSM3JKuUBmksfHVLpBRtAfPN4ynlQ/SVE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcDLh8ba2URPZj9v49PxHB2Btr1v5mqRTq53wU
 lOFbLEjMNGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanAy4QAKCRDBN2bmhouD
 100oD/4329LqWzRRWEqlMFKWjCm+znbGRNk5I7HVjIDUKojAQ91ZpMQ/59uNLZUKFvagc7jhyad
 MP35uMOme8NKA7NjId8h2VERGvTuoPCWVf7KbrhwSfLrDkwX1i1+scIdIWRfbpy8mgtS28IRh8/
 2XY7dqkpsQvOhwavbXbyUSpoklYRj06nDF3ziTEfzoy/UMGJ07Y+G38RPptt+/6JmQsFoqNPcnW
 0APC1ILBBeQqh7LUu7v88eaoRE4vWyOa2p5h1na/mXhmO93tna6oJchvmrF1HgPWIi2H+73+k8m
 0AAbafpY/CPaXxKCd99p7VPir2ie4a7pnNBZQMIKg8C7OgnMYC/CPxpVzRV5OQ2/RDxMmL9zyjY
 wC/3K0fiOJmrzTNAKZP+bXFCnIau9wk34Mq68Pbkpeo3rXLQPhS7SdWxOSRrQdtI0g2yXaRwgdP
 S1o5qFOtgWhRO/iJJ8YsjuOEyuyfq9LpQLQd89viPHv7PhfkaIpo3/VRHK2aD+CtejYu8gA4U1m
 KGyNc7WrUCSyzMXveERcUmkg6PIVttUESL7ua1wwsG8B8bx3Jj1fETihHc4rg2PmeXSrC6qTiPu
 vaKJ112LF5maGrMwhCQxfhh4z2WuSS97IE18YEvPd2E9cvF4YLUCJAmC3JygLYOjTsPim0mYv4+ yXT/Fa7uZ+GUM1w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfX5yh2GOujZqad
 R3W7DXd8wjpKEXlLVpc/Et41Afbn97+THz+I+EEcsesAk3GeD7GRANgcIb+jizilG5XKrKhd+id
 TBhW6z1RQ22HsHE40ie/vchHMsa9U/GqobSLm4gpXg3l7xeb9lvmBI6R8VplISZo4B0zBos3uUD
 NArv90Jr1jGziguQFATVcCKfxYAjcyVBD32jUIvm1fNPGqLuO3Zw282sCIkiq+CQT9SUYohwXCG
 cGa8sYLgreXNYOCVIxXi0pI7JCCIlcoleMuYa2AJLznctRhsPt3Ptg0gR+xDuM09gqhJcT0sxlm
 2lOS2IeoCRVaSjOBJ7Bkkyonbjy9dBqPVhUvzT0wowQTgyx/B9qzzyVp163eDJwWaN4lBxMH7Ti
 Vo7P9a9t8Z6rhFxCM4OGnWhtJZp42673yvpflGp+j+EaIKpFJMvWpgW7tefdY37SOPs3eWBy+Hp
 ok76x9wtHuTmNhGuygA==
X-Proofpoint-GUID: Pq0famUQfXnLMjuiWNkfzcvtVLcOpjgo
X-Authority-Analysis: v=2.4 cv=MpViLWae c=1 sm=1 tr=0 ts=6a7032ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4E_048dy4KWIn0a4eT8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Pq0famUQfXnLMjuiWNkfzcvtVLcOpjgo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfX5+vfvprjlxrR
 mTBDFcVQIAqkp98RUPaHUfb7ttIUdYsdc5JH6WfKHiMLex30lMxHi6Rfcq5eAiUdnDTrCrjxDn1
 nWPmHNgy7LICacFkSF5fMfD54771aOI=
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
1. None
---
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts         | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
index adf4da7dfa2d..a1a878d88e96 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
@@ -54,7 +54,7 @@ AM65X_IOPAD(0x01d8, PIN_OUTPUT, 7)  /* (AH12) GPIO1_22 */
 		>;
 	};
 
-	main_spi0_pins: main-spi0-default-pins  {
+	main_spi0_pins: main-spi0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c4, PIN_INPUT, 0) /* (AH13) SPI0_CLK */
 			AM65X_IOPAD(0x01c8, PIN_INPUT, 0) /* (AE13) SPI0_D0 */
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index dc0d3cf2f985..3e2377160d82 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -143,7 +143,7 @@ &main_cpsw0 {
 };
 
 /* Aquila ETH_2 SGMII PHY */
-&main_cpsw0_port8  {
+&main_cpsw0_port8 {
 	phy-handle = <&cpsw0_port8_phy4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 689ba2ff81f7..d66e71db4697 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1068,7 +1068,7 @@ &dss_ports {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	port@0  {
+	port@0 {
 		reg = <0>;
 
 		dpi0_out: endpoint {
-- 
2.53.0

