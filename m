Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09E399372
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951485; cv=none; b=nksS8OXVMeaRF53LtegThHg/9hitd6jyR2BlTBQUr9QbSEHdNTg4WkO7MBosd1AnmNMI2T76E3HFnakUj4hJrF371MtT3VUGrCy3LF39Z1D2nWjoV1BOmfKIpJbpk7+U8TCKDiji4yB38VMYu6/uszR4Q71+OWCpxBOI99NEqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951485; c=relaxed/simple;
	bh=LzrE5EfUbK9IefyGKGGuG3khTkACTjk9dd3YMHxzIeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyrAV7Su+4E2U9O1O1TVP4Sz0lOt+zyVek5r9HVXKyBSnexwfrZm31Qd289XRum4YsjdcXY8jx9Wz4CqOEEZngQUAJCLQC4HSssodt+gDYra6cZU8/6MpIKNnKkacWoZaB+vnEZZeJ3Euzw+5p7liFsZzBtzMQZ1WxI2Z2ojVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTjz5P1w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDeEXy+K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTjz5P1w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDeEXy+K"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IwlAE326951
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 20:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCbndmvYUPntNWcEfQroOqXP5F4vnHs8kXOTKDYVs9g=; b=GTjz5P1w9kvJEM4H
	VQi+8xA1DP6kkN8ZjTsaDvNMxb47Z0roQMXk2bBGNUVLFUvo34XzuZe4tO5cHDTV
	sEdA0uB9VODea+YlvFSqHT+9GUB7uOr9JF13erHY9AyuRaNbAoi/48hp6yQ9hB1r
	ArwRi7QRqpNSe8GjE6sepXyOKCXs7QGQ73URaI46hn2dZ02SkTtesBsLLJHLSRb2
	wcfkQtQDzKOOr2iI9v8dOkjaInukaW/2JHUUOP92cCC4ybdsGi0K/nekqoC+V9Ga
	i5iUpneK+LL+enOeSBdUmg7qMBbtHwh/uFqNRMrfXKRTeyakZyoMM+X5Isw98rhF
	b0f1CA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8jvkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 20:44:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517600719a9so81410771cf.2
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780951482; x=1781556282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCbndmvYUPntNWcEfQroOqXP5F4vnHs8kXOTKDYVs9g=;
        b=XDeEXy+KYvT4YeFEmm5Pl93NjMoYLG4Wu9o7xI/iae/2/oLWTdBwTr9Q2AZAnDyPsz
         vo0DmXx3ciJdX7fNZnNqbVKaj4/mQcQFFtmue0PtOct/nBY29hElyUN0Fa1vffCOy5ak
         f00lDQ2tK0MTB27QqrXqs0yoNSeTTN9/h8pP7xM+x1gsnl9RSWgSq8BeIRUg3BbxjsLG
         Tj8ElToCUA5H6496to90I5dXY1esqoV5Iur9Nyr8AxCBmdqY9qAvbjVjZLThdj0fnp+S
         azhyfZvDpzbzdixG8blEwiHtymif4Mw73I0BjcY9JyBuQOqy5tjfP5TDHp0/9CchprEO
         hLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951482; x=1781556282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XCbndmvYUPntNWcEfQroOqXP5F4vnHs8kXOTKDYVs9g=;
        b=q48X0W5XJepUZZgpMiwfBiRZx39I8DMcFpwsN8bDe//po5od8+Ad1RoJV67U2TOWCk
         zdrwHF8sfyQb+ac72LMrBY2dsEuDWQUADHbqQmgAxm1jHZ1VOuMkBeMcU/4DBdasiFog
         0AjnXpw/iflo3cBli+o3UfdFvINrKaxYsrofupTjXpvHUb0N3KhVcjVKMFrbbVXqcy2V
         CfcWO/DqGaSoEwo2d5fsVCpY9vm/lM2oNq9ODIKW//vKtcUj2YNKdJ0Zjj4NH5LIAY9E
         IHvxFiRPqCYaFZcAersmdOo0ucSXOdwF1o+uggpr3QbXIYYEPM2DepWW9TC4Pj0gb9Ws
         TLJg==
X-Forwarded-Encrypted: i=1; AFNElJ87fwWh35U5BjQFTtqkW1MGDNQkNDFWp1eBVhuqN8a5TaGGZuV1+sZg4LHurgc6iq+uM36jyQJuWvWH@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKTr9A5a70+J5dYXeSXj+wb4Azo7UwCtlqXU+DfXpYAsDn4/j
	wlecLNeSQrDpejCc3nK6sst8ndic9e5RjT5mT/GjMkGZNtzRDgipPwxs9xplH2FLa0WW4IvaNGL
	l5MRM1g75Z0mhpHyozwdPEjn//HM6lIromWb1NbNSl0RrwgoaQ3nYMtHHN+EM++H+
X-Gm-Gg: Acq92OHENBPpHq/SxS48hwBkWWcLqswMnnh7YMrTOFyZ4UNQqDinPuC5iIW3tWAisUs
	ma4mlWdDaBij/aWxtuZYdvSeHFkfWIbkSzNMhnH0otJckEAT+mycyj+EBQTkdPzHHOTYLJMXsqZ
	IxDpF4bPPadogWdHOwO7urnrUOsJqBa6AxijhduJ6lmxz2GD0cgpR2FCxegM5nG/+hMyO7ikj6a
	PqlZhuhQCPs8xFSRQyilhjWbnFQZhK+P2Z0RHII9kIKfhHZKaQf86G7AVEbNuGkJsFEvazoKJMy
	2M4fcS8N6R3msO5OwmxMRmn5po102NidlC69jow95dHpJ9dUdjoMS6sFbeRlBENCpanHjSxXHaP
	1aJ54AJ7DCv6dAWumrDr3BbygPmAmC4De2svcXzQD8KvAMRjHhiBZzk0=
X-Received: by 2002:a05:622a:598e:b0:517:29b1:5433 with SMTP id d75a77b69052e-51795a48088mr230454241cf.24.1780951482024;
        Mon, 08 Jun 2026 13:44:42 -0700 (PDT)
X-Received: by 2002:a05:622a:598e:b0:517:29b1:5433 with SMTP id d75a77b69052e-51795a48088mr230453851cf.24.1780951481550;
        Mon, 08 Jun 2026 13:44:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm44018439f8f.32.2026.06.08.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:44:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 22:44:25 +0200
Subject: [PATCH v3 2/3] dt-bindings: mfd: syscon: Drop custom select for
 older dtschema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v3-2-4eba9ec1212a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6196;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LzrE5EfUbK9IefyGKGGuG3khTkACTjk9dd3YMHxzIeU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJymvG0dY6mMTSdz+7khQam5ej9BFaibSaOMor
 sL7GiV35QKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaicprwAKCRDBN2bmhouD
 10Y8D/9OqnVFNLC9XQmEFdzAH74QzkLpmWa4/Yo24Dy0TIOw3EGXdg443cUFe41WaMbLTAuOD5y
 CP565iVC2lK+gNRwl6lRON5SaJ3Tq+JBT0DcaeuKDAOGL1zmZpPMi1bOBK7L3Kf2/QpwqJjJ3lQ
 a9DB8DL/xyittFuwApbHvqaweBGVA+6GVivznOqsfC13PQH/t1EmfvYBKT+FzjoT2l+XGhjV8Pv
 nQIhqIT+lYhvbUzpIj4qxNGll0nVpRB0kP6nvKxdoTRpoJJXAWuOSsuva1LbvRL/6OBSle9rgmX
 xKShSyxMLcBX4dWrvvGNv2yiqdXYw5CgzUlhJdeJ41h3SvzU/9NZVXg/NtzQ8I0PdshDshcbYr2
 3S9lO402TpGbJwwpLwdGhPifY5fvAyL/HjjLnsB1ybFzsespzLLGvqvboOJVYhbtCpSK4L7i4A0
 xrYG1MJjK4qZx3yDYBqsFv0w/HONbJ7llLNlsgePjl5YDRSS2SiIf0aYRzDEfb89Aa5IAUzZktg
 ADiQJjOhT10Q5vySDleffnouEoffGofTkkqOCxN2vwRubLXL1rsKvuoBEWTFxFWbK9ptiYBnIlK
 slqYglEvdHKc+AkYfFWzp9bc5G6l5qw4IgPAZxGajRpR9z1evci5n3mDi2TF1XxXTrEPqXh/Zsg
 aXNz+LiQCbvBHYQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE4OCBTYWx0ZWRfX4zeZ7sLMNuoW
 J2VKOGfQN3tqiVeuforE1MSYRirtJ6QTKwxMLWaJn7n9sY32/pPMwFUAnlWDL1DEyQpL8lfAz8W
 Q18t8kTkzfV11J2SDOBqrObDlTADJmUMS0reasibCM5IB+pKoGB8wIYAfcP+L0WrNj+PAwFpfii
 0IqK2UM6D3ss5RvHnWhiyNue9ExJ1bHmzVBQS8w/ojuvUymv2FYpfCErpi0As8C/MKNjYPrUNzF
 Zy9QgsVkzycIfU4Y4neo1LAHmTafwOIdFu/vEg/FvCURIc4V92tfPfR5bIfEoSDLdAST2lI0PDy
 b4U5mcnkftUKgc1ADWrX85pOIZJ5+ifccbUBPtF6wCmVNm113BcmRInk9bJmY1H8zyecRlE0Xyl
 H2Vq6YWhPVWoNp80YkALNJ2/lxKIype2F7aJbX7Iamw7EKE6wybFAML9IPHyjm8m4h5Lsfn+oT+
 cyg5Wa+nEtVMN3yn9GA==
X-Proofpoint-ORIG-GUID: g8sL8cBkl9PfUNTmdCXWQd4ndF9qefjF
X-Proofpoint-GUID: g8sL8cBkl9PfUNTmdCXWQd4ndF9qefjF
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a2729ba cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=y3quGObI61Sf3t9l_FAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080188

Older dtschema <2024.02 required custom select to avoid applying this
binding to anything having "syscon" compatible.  That's not the case
anymore and this additional select has two headaches:

1. Duplicates all the compatibles listed in the schema.

2. Is error-prone, because it requires contributor to add the compatible
   in two places, otherwise the schema will be silently ignored.
   The select list already misses mentioning compatibles:
   mediatek,mt8365-infracfg-nao and renesas,r9a08g046-lvds-cmn (with the
   latter being reverted for different reasons).

This requires bumping minimum dtschema requirement to v2024.04, which
feels old enough to be a safe requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v3:
1. Bump dtschema requirement

Changes in v2:
1. New patch
---
 Documentation/devicetree/bindings/Makefile        |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml | 116 ----------------------
 2 files changed, 1 insertion(+), 117 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 7b668f7fd400..40c2094f47c2 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
 DT_SCHEMA_LINT = $(shell which yamllint || \
   echo "warning: python package 'yamllint' not installed, skipping" >&2)
 
-DT_SCHEMA_MIN_VERSION = 2023.9
+DT_SCHEMA_MIN_VERSION = 2024.4
 
 PHONY += check_dtschema_version
 check_dtschema_version:
diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9c81010d5a74..b70018bf1bcf 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -19,122 +19,6 @@ description: |
 maintainers:
   - Lee Jones <lee@kernel.org>
 
-# Need a select with all compatibles listed for compatibility with older
-# dtschema (<2024.02), so this will not be selected for other schemas having
-# syscon fallback.
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - airoha,en7581-pbus-csr
-          - al,alpine-sysfabric-service
-          - allwinner,sun8i-a83t-system-controller
-          - allwinner,sun8i-h3-system-controller
-          - allwinner,sun8i-v3s-system-controller
-          - allwinner,sun50i-a64-system-controller
-          - altr,l3regs
-          - altr,sdr-ctl
-          - amd,pensando-elba-syscon
-          - amlogic,meson-mx-assist
-          - amlogic,meson-mx-bootrom
-          - amlogic,meson8-analog-top
-          - amlogic,meson8b-analog-top
-          - amlogic,meson8-pmu
-          - amlogic,meson8b-pmu
-          - apm,merlin-poweroff-mailbox
-          - apm,mustang-poweroff-mailbox
-          - apm,xgene-csw
-          - apm,xgene-efuse
-          - apm,xgene-mcb
-          - apm,xgene-rb
-          - apm,xgene-scu
-          - atmel,sama5d2-sfrbu
-          - atmel,sama5d3-nfc-io
-          - atmel,sama5d3-sfrbu
-          - atmel,sama5d4-sfrbu
-          - axis,artpec6-syscon
-          - brcm,cru-clkset
-          - brcm,sr-cdru
-          - brcm,sr-mhb
-          - cirrus,ep7209-syscon1
-          - cirrus,ep7209-syscon2
-          - cirrus,ep7209-syscon3
-          - cnxt,cx92755-uc
-          - econet,en751221-chip-scu
-          - freecom,fsg-cs2-system-controller
-          - fsl,imx93-aonmix-ns-syscfg
-          - fsl,imx93-wakeupmix-syscfg
-          - fsl,ls1088a-reset
-          - fsl,vf610-anatop
-          - fsl,vf610-mscm-cpucfg
-          - hisilicon,dsa-subctrl
-          - hisilicon,hi6220-sramctrl
-          - hisilicon,hip04-ppe
-          - hisilicon,pcie-sas-subctrl
-          - hisilicon,peri-subctrl
-          - hpe,gxp-sysreg
-          - loongson,ls1b-syscon
-          - loongson,ls1c-syscon
-          - lsi,axxia-syscon
-          - marvell,armada-3700-cpu-misc
-          - marvell,armada-3700-nb-pm
-          - marvell,armada-3700-avs
-          - marvell,armada-3700-usb2-host-device-misc
-          - marvell,armada-3700-usb2-host-misc
-          - marvell,dove-global-config
-          - mediatek,mt2701-pctl-a-syscfg
-          - mediatek,mt2712-pctl-a-syscfg
-          - mediatek,mt6397-pctl-pmic-syscfg
-          - mediatek,mt7981-topmisc
-          - mediatek,mt7988-topmisc
-          - mediatek,mt8135-pctl-a-syscfg
-          - mediatek,mt8135-pctl-b-syscfg
-          - mediatek,mt8173-pctl-a-syscfg
-          - mediatek,mt8365-syscfg
-          - microchip,lan966x-cpu-syscon
-          - microchip,mpfs-control-scb
-          - microchip,mpfs-sysreg-scb
-          - microchip,sam9x60-sfr
-          - microchip,sama7d65-ddr3phy
-          - microchip,sama7d65-sfrbu
-          - microchip,sama7g5-ddr3phy
-          - mscc,ocelot-cpu-syscon
-          - mstar,msc313-pmsleep
-          - nuvoton,ma35d1-sys
-          - nuvoton,wpcm450-shm
-          - nxp,s32g2-gpr
-          - nxp,s32g3-gpr
-          - qcom,apq8064-mmss-sfpb
-          - qcom,apq8064-sps-sic
-          - rockchip,px30-qos
-          - rockchip,rk3036-qos
-          - rockchip,rk3066-qos
-          - rockchip,rk3128-qos
-          - rockchip,rk3228-qos
-          - rockchip,rk3288-qos
-          - rockchip,rk3368-qos
-          - rockchip,rk3399-qos
-          - rockchip,rk3528-qos
-          - rockchip,rk3562-qos
-          - rockchip,rk3568-qos
-          - rockchip,rk3576-qos
-          - rockchip,rk3588-qos
-          - rockchip,rv1126-qos
-          - st,spear1340-misc
-          - stericsson,nomadik-pmu
-          - starfive,jh7100-sysmain
-          - ti,am62-opp-efuse-table
-          - ti,am62-usb-phy-ctrl
-          - ti,am625-dss-oldi-io-ctrl
-          - ti,am62p-cpsw-mac-efuse
-          - ti,am654-dss-oldi-io-ctrl
-          - ti,j784s4-acspcie-proxy-ctrl
-          - ti,j784s4-pcie-ctrl
-          - ti,keystone-pllctrl
-  required:
-    - compatible
-
 properties:
   compatible:
     oneOf:

-- 
2.53.0

