Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950351;
	b=DMaoy1WZCjKyzBb2PE7Bkz4g4ixLMof15dJNLCziTT5SOTHjm7TYrkXjts8txbmkuNHB
	 xj0ABruS+aoeSGdW2FAy9i/QVye00pZMkODO7eaH/ZXU7z/vB+/qbSg6MvBmLFxwQxJXb
	 hV/PwVZruJjC4yeg6v7ZC+qL6SW+Dp09lpCiboaduWcVLibduhYItRgwHnHi+Er5Mp165
	 svisoXGscr50mDM5blNnSr1l1XUaUKGVALXIPNIKVylakYWGKGh+UOoLGxTBJY9qO2Eyw
	 ZrDODqnGqp2XAp31gOIfeDMSQwRDQzuEo0GLbBjdIce6X2d9hEmllMLwzliNQgsI7dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950351;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
	b=W4oO9LJhslPVD1Q2MpLQ7bEbsDCrKVj0+TG/z3oMp1nIdNPv6Cjy1qKdWzEtyvQQZiWA
	 mGC/Gn5Ho0kERFvOngBc53XFBu3JmNQ60RjacSw0vz6kWuzJD7R2cKK6nLjtL2g4Dp8Vd
	 L062NdE5H00wuTOBmPqw/nXcMZqpzKQG6QcI008tvIFqajhuwuPz/Mdodz1U45TdGm34w
	 0uF3RC4xNe9Z5ih6aV4s1lrhVcS3io90QZQDH6b0e7W9ZFbNwTk/lZy0UMDqKBdYn3AMq
	 sB9eY5cEz1xiJwoHamtgCXt5oZ8edLroV0TizsRIkJYR5PpJCQkuXRIOkj/sY8Snn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7rgPCqY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ih9++FCZ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC5606A32C
	for <linux-omap@vger.kernel.org>; Fri,  6 Nov 2026 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EC5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7rgPCqY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ih9++FCZ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R9xl2333811
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2026 07:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsW
	QSLax044=; b=p7rgPCqYB+odh+avUO4albsGPZy6z/7BfbD6Kteey/ab9VcrANm
	5+CRN75zF5/ejoRfGvjAjmXTieKue1+9B6y55QJmgFOMnUzEQ8pyEU6Qv1auAjCJ
	KiZxI0/gwrHEMwyuOj9vtpXXxdqKeB65C6ApdtFssJbEPvw0bnVnQ4uxScj7/zVh
	r4fVa2M2uplH5IPaTeUz9MB/wtPmPiH8dwNdx+w7DTRVknfy6cUwFOpmD8fJg4DM
	h8It700mwRdQVB8Pnym8XjfDleYNsYQcJsUjh3jBawqDbNq0PI/Qp2gMjqwBDsGP
	QQMpgXk7RtRnBFLO7WqyMD9w29HHBf3ZjGQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p99q0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2026 07:32:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so119384085a.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 23:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793950349; x=1794555149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
        b=ih9++FCZxaFaxuxWsDX7zmGOzP0FZl5enoQiiSjgpXI8Z2JaET8rc1Dalx0Qf627m2
         GNJl2kOJBz60lrKhzOxpEA1Z5kRvxPWOe1ozWE2EbB8rUq9gGasDEDa1Yva/VAPlQk8c
         5Btl320Oh4sMTInOqQuD950ciit9Ikd1G2q3XOpWC5M+tpFl+JGLzKTh19/ZVwfK+l2k
         ZAuXVSRm/dKO4IkdzWWrpnuBSOn/FJtOQn7AEJ+eST56S5MKkCxO3uTJelagJ4Vp3ZgJ
         y/SyGHbwHj1kV0YBSZb53VhUDqrGoyXwu6KHLUB3YLhx+oAk2/6TYdgOEY4imsjFxcC5
         EPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950349; x=1794555149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
        b=cEZmDkUJ/sPTElI3/EjXPJZQN12oL97lpyHdfBgEDaAmp+CQJSAKTx7kaGiboDzGZr
         SAcEdTMnhzCft3p3QuUR1lqbaIOVaoHoxSLGIeC403aLnZeOlC9xTbna9TC+esLOay3j
         aUH23RFuL9+MILaYTPCsiKOUL3eM+e9DnNKiFiQ7YjQIEtDZmZ2bXpFus9Y9VdL6hxGX
         vS0UM5RelnLaJU/RUr5NFTKTtl7jnSD3NtMzmfYDiplD3zvjYfInAjNRzENvM+Rrq4h5
         gJJRBLpK5KLX4BB0Ve488T4DtNZ/I7af3mMSpH1KBrYd/3X16JSmf7suVO7AZ8XItSCf
         5qFA==
X-Forwarded-Encrypted: i=1; AKwUvBz+coiH+6r+kdKj1LvKM5GlXvMCtb3bIlYNizzTl6EBwuG8bVJPXKMXnAavqm+Vw65UPjo8nJuMAKUM@vger.kernel.org
X-Gm-Message-State: APuU4Z8rFYVe1bCs/BJvM0e1/V/N7jANAlYZiVJ/SgrOce21IrwhIH38
	OyeDPpjuO7djFQHGGocBWg7HSUwGeqWoO9OlF1gl8xV8rPonAvJ2+AIn6B0gDB0BODdUc+sJUZY
	+FBPPZL4tRM9LtVTr+SxGnc8yKse8H8TNOZJvP1dUhmdb1+d3p8NLqy+SDmm95bgY
X-Gm-Gg: AYBFou1//V/R6AyUORg6Wp3iOSQu64aeE6eUbIEUSbv5wNqQpS0CtDh9RrK3Xbb60Jz
	4pgeFBe1Uwtk4YMvzcPA6oK8pXN3pYoWhP4Sw8ko0CjqlUu73IBy0UEq1Ff70Cxr4cn/nOT/Z5r
	1ETWShBdUMS5buhFdowrvprTwL7yN6pK97gYEUEcV9NGAF/j9U6hhuNZFCN6LX5JMpqxV7CAwLE
	FgbvMX7N/KrxWTZU8Ljiu8h5s4HjK39uFOPkKkI9Oh4Luac+cqReRxA+KitqPU0Edb2JX6Xqso6
	Ndqe/T70mE5bqaqmyOHydWCmh4gJjyZ9CuGYD/E2FkhAUf+iefN/RhQZgpc5K/CuceAMa4U6pY7
	IrSGIH4FNfxNfhQCawezDaUIFyjdYNwh41tJOsgwwtJ023TukyuIeaaAmbmbx8Q==
X-Received: by 2002:a05:620a:63c7:b0:93b:ef24:bc8c with SMTP id af79cd13be357-945f3556183mr233350685a.47.1793950348506;
        Thu, 05 Nov 2026 23:32:28 -0800 (PST)
X-Received: by 2002:a05:620a:63c7:b0:93b:ef24:bc8c with SMTP id af79cd13be357-945f3556183mr233347985a.47.1793950347960;
        Thu, 05 Nov 2026 23:32:27 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b73b97d62bsm17070775e9.0.2026.11.05.23.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:32:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mithil Bavishi <bavishimithil@gmail.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: dts: ti: omap: espresso-common: Fix magnetometer interrupts
Date: Fri,  6 Nov 2026 08:32:20 +0100
Message-ID: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=8RJTDipAJ01nFwlCTlBHgfjxxf2dxBYM6NOhCug9thE=;
 b=owEBbAKT/ZANAwAKAcE3ZuaGi4PXAcsmYgBq7YKEd7E3fFMNJDfyGX/aXcMtTxYLfHhdXD1Y0
 y1/6eXdqt+JAjIEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCau2ChAAKCRDBN2bmhouD
 18EOD/iu3p6fbMbT7YESIgQYYP3hQKINbqqvypfRaCCJqgJnC3WVinnFkZhCyks950A/hL/Yl4v
 tKNRfOBpKstUXzbhditzVtRNh6pdVtJCwqIpDgUly8DT5rnO5NkadxA412P/bf7E1USIHZddBHQ
 cUXeyFy8Mf+aucVD0h0p6kuENk1lq84r7MbcFHUDsXgTDiYYRuYpTruO8yjhp14KrRs3dhuzwiV
 EWBslFSG5quj8dF9fFmHF4PlcPe6llcW3Q8/IasqbV+8Dy6BNFO3gh+f+ReFPfKaMnRHXWtSRH5
 6ffD/WtTuwJ7ifXP2NEMeJotyZ7mrL9Da6PEssKENC6AP7PXqKUbU+ySnvEVVikNrAKGhaQKm+J
 1eH8ifvsTqtKaUNK9+kHd2PzDBnOSg/0lEv0gwrbhq8L7xfy8kdDuAh3MhTcVQZeJucbTfFLsvI
 1NyA4zq9FrbO+/Rx8ibjpm9jG5IL0Qj04Eah8VOsTfBaxNqL9N4PKs3/BiHeotJy7n+DkT/EpGp
 U558FKOL+nKyL7osnzMcgdqrqRKCtY5K8d6LHkjCB0T+1cQoX6FeSsxflAN3r1arHhuf9cMVN1v
 +8jD8EPIMP6sXordQOhN1zNiIgoGnJOe5eF/m75qidqN2PfnUdJ6SgHckC2KtGW8+0USYujIukO bwIzSNGNhnZ5y
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SxWjkYr8cxttCCPPpY9TjDofL1lLhLM4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX2cNTLb7dRdFQ
 eBj6JrJhHVmtGk9TNMlYMGrREnN5z0rwWo0klL9J3J8T5N3k56teOqYJDM4UQEBFzuK5ZP1kyU6
 TPt1srHoPkrfmhnf/0XdMt4M3nVQ3d2Vxz2s7e3TEWaILQFqZiC+DxrZt3fJxfc8VMQ86rGqKja
 vVtxaqNiLvncuaWc79AyNlyMfPGwNFXmTEqRR62BkFwR586BHSnRXFkxvkiE8H5ZjE0Vlwu1a4n
 NIj5GqcruaYFKxgoaffbOomP8OjDU7avvOhHUEne/TQmhdFlHPj/CpNC+NmTf9In8lk8cJWPA86
 2TcGtJxGLge4uIoLBpBYnm/FziTQSW0iSgYaAnJjI4I8m4kwX1T3VDiGbGGhBcOESc+plFxPgwb
 TmeQKJ4it5LCnnI9Jak80tgrLb67FGzTbYVJd9mxPGZB5wRHBe2E+DkncP3+h2pZIh8UTPtI7F2
 2Dlg8OkUkWX48gH521w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfXxmXmGLdfbNHD
 wpZwX78usptKbsfDO2bzPpYk9ZsDxTZ1rHAdMo/KJ3RabR24wPmY16k2OPxEe2/pNsIra6dXRAq
 QQtt9e/0yxQo9lQTlYkKhl04n6Jq8q4=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed828d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lsuncF9k1chNw8iTKPUA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: SxWjkYr8cxttCCPPpY9TjDofL1lLhLM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060029

Interrupts property takes a number, not a phandle.  Passing the gpio
controller phandle made most likely the interrupt as broken, which could
affect magnetometer driver operation.

Cc: <stable@vger.kernel.org>
Fixes: f768d54723d1 ("ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
index 07c76a80cfff..881580eebf4b 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
@@ -632,7 +632,8 @@ magnetometer@2e {
 		vdd-supply = <&ldo4>;
 		iovdd-supply = <&ldo5>;
 		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
-		interrupts = <&gpio6 10 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>;
 	};
 
 	light-sensor@44 {
-- 
2.53.0

