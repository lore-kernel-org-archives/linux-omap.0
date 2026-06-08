Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082553C4540
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926909; cv=none; b=GB/74WP0SRICOukaWYio8A4kC1mYhnPRMVt4HFcF3QtRKrsoFs87Ng7Ry3ax6g0qI2xdLBck527LxODX/WpNUmLLgYWv3PiSyDmgqtt5uau6xWFddOfFWCbTENiWIiP29gQXJQb0TRKhdNa7DcZj3lxvRMmjqtN6mUct57VMU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926909; c=relaxed/simple;
	bh=NcitNjSkfQ4OyFqHaqu6E2atNqkTv+Y4lzGwlPttZho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiuPEUv9AQPSH0yqzBuB82J1W0dsifXHrgSj8W77bMBRY4XSTL4QVe9ocwcYpDbxRKbFjfpDeleSasAGNbm7kC5diXmrHlhwacFL4EnTrSZDgY7ahgiVgg+oeS/syfp1Q5PZG+4wDNOU+D9AcI9LfMpn6ihGRUKbQuPzM7LK5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdTMgbz2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEDB5c2v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdTMgbz2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEDB5c2v"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR3tM3346706
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 13:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+q54AYUt4cvMAgQNkC220cQ0wa4ldXeQa80/giwooQ=; b=HdTMgbz2z5FgTqoL
	IfF56+idyL8eAcP8L6hXXn36m1WesYiTSoIIV33hhmXCc7Hlv1ZtLGhUk7EtnFKK
	H34ZGU4hXYs3zmFWAtfKObOliuNBwwkYNfeGJZeoT/R9R1e0V7bI6cq/EOHg/xi/
	/vmzCmOjypKO/DzYmTY58o+tbGsjMzZoxoFPGl2J4QlPpGNPrZGHLtMk2aBFErBN
	vBFTx4Lt0dGiAaBzc6xFt0nL833sR5dFPz0KghgP3N9zsn3ozbkqAFOx1+2n/aP9
	B1Y0vl/COLI0LN9Ep3/qH+i8pStCLeENyWIwSGd7OiBcmULPTnmnlTIU3EAhfTOB
	5y1fOQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8sc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:55:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cce1cc8cb2so103738976d6.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926906; x=1781531706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+q54AYUt4cvMAgQNkC220cQ0wa4ldXeQa80/giwooQ=;
        b=IEDB5c2va4qQUGSJz3M/oNnLjLotH/FA+/q8pKqxO/HUwU5beeaaql+1CE3cy0XjCq
         wr/MHwhGh7jlalAZZI02QXsmBCSUBmwTurkRzIbjCfdpAj841W+5DHDCuE1blxQesxql
         J7rv8uAqqNJXp1A2iu6iwQxQHAnsEum+Z1UzYVqzvsT70luNen18nHP3SyaMbLO5WA1q
         qfNNBAKxtlDpmk6xYv8EOKFcI3GNrXsLBG28F/AMlqKttGBzI8HoPad8S9nVu1Yh+Vdy
         7h58KJiBn9aDCuYdoVzOm1LiXuLMuR0F0YzM9r2U5Swbblks0bSH3wG5tAvTM9qPxpPo
         7hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926906; x=1781531706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+q54AYUt4cvMAgQNkC220cQ0wa4ldXeQa80/giwooQ=;
        b=j3p+NQb/xn+VLZMs4VCAZOgWHW1xv1EPjoS2cPLobpftGDWYcUc3lM869PjHxN5fC4
         0N8FN+Ws30TgXVejAUsZBHOISClkf3U3plUiCyOeZbOTByB3RbcXMpYj9gIU3BobZSGK
         6X8MnqGR0nrM+TmBmdx/NiJ55lkf2LawnbGCBEBn4oix+mGDIRfzHtL3+D1MxlN8j44b
         Z5Nx/Xhwg4yyBsygIncto90DI7KaVx1MhBaCZk3XgEGndqI8fesFQ9eh91lSqB7FyfKM
         Jrejg3d6hyvg8Dh3lftKLytU0RJUN5erRYk6JOX7a3JELugXk+I+O9s3xUlJIUlyB2KQ
         DNPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/katGDZWp+37ru+vZ0gjrzBemFTGYxnMRh4hJENQEGBum2eBhvkwuQQxwIOPeFkWxK0r3Fp4uZw8X6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/e0gWhhrqOl8lyfJvddYmqfM49KkPS8JoBTOjVWheDfQaXEmg
	JFCaae3Tz5buElQ61XYZTJ8IJpR57ItNdJfVPL0DyxqJuSnEQgjIp3NcnSbbjtGTkfMApVwrT+v
	HmE5lPMrwq61fmKknoVc+vNSZ7xipgEemnnMtm5XD1STMWctzHq+ivMBZGMqHbOIG
X-Gm-Gg: Acq92OGQRoZoqIz10hEyhp1/MRg6sn6D+axIzBB+eYAHZr3Eg/VbW0K39BlfTDaeidb
	R2xMnjoISBYpSNamDYzUSg7DYNcIGR19NL90yD8z2PdeMffFsGyjuA+GEhdWENf/Zd1/b8zK93b
	+e+u8kpLFCD58XLpRr9jEZwrM2IR6S/OPjg2LG87cshbYdyinKfszj1KqpTJVvxRqWGkhtzYjuE
	g5VYS0euUKxyOnxhiyy+PeRaPuhPi8TRCvkGLWIxztiAIlekkI1PWpNjYIYWSRa3e7a/ERwuZaq
	DSty5OuNMXamwG/DD8/zQGQpMgpw9sQsm/DLkAB5o5+gqEtWQFXqB/Ek0pkPKbdfLjzgMKmE7EI
	8FAH9vUqRs+wtatywZqiXDEHsHHd3iLkCLdVNkeCYAsoaNeYzXNtAHg0=
X-Received: by 2002:a05:622a:a593:b0:517:8d40:7c7d with SMTP id d75a77b69052e-51795bcc230mr212098411cf.29.1780926906336;
        Mon, 08 Jun 2026 06:55:06 -0700 (PDT)
X-Received: by 2002:a05:622a:a593:b0:517:8d40:7c7d with SMTP id d75a77b69052e-51795bcc230mr212097701cf.29.1780926905723;
        Mon, 08 Jun 2026 06:55:05 -0700 (PDT)
Received: from [127.0.1.1] ([213.55.209.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm385972925e9.5.2026.06.08.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:55:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 15:54:16 +0200
Subject: [PATCH v2 3/4] dt-bindings: mfd: syscon: Drop custom select for
 older dtschema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v2-3-0203e6c249dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5410;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NcitNjSkfQ4OyFqHaqu6E2atNqkTv+Y4lzGwlPttZho=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJsmqbJ7tPK1z7PP4+30wTCt9SdFWwHN6Wg/IE
 0IMZKMvJXKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaibJqgAKCRDBN2bmhouD
 1xXiD/0bvAbsMwgDv/iH4GOjsfgkjcx7enoDg0cJsvLNFtBsZd4xhalxTE6gj4uWHVG+J3bMnDY
 /SuVoxEhMQKQSzDGj8dNgPWN3QvZNloqownDIyQ72QsFUyRDfneqMVNay3LZ6woDjSievDd1/k3
 4STlk1kmydDgVDcFZrgNl/tGsqrHHceTIzSM04tqPfWfwqMZ/EFfSCVuUAQGHTDYu0lpmt//Nbz
 yO+9k+ou4/Q1AhLWrk7Iy+JE9A9NPktJXArYdBZ2F2OoG7o+2/VNrsxzUe8/cD2sMnhv112NmKF
 TPBfMTpHN4dSEg31hysiwDat4nyJnm6QE6+4KcxOGYs8BC7UsnWIHYyTqdTrGchS0M3ZL3MefH9
 hczo4x1VTv5VauSXHhxYdsFlZQWljOy1QyoqYPNxsT5VedI4hsNtkRH9O6cUOmupz30R7dmlMs0
 HByZAmTh1qZoMpCIyPoYHEDIyuSeAJxG+9NyuwEI/eXF7+O9U24puo3V7hJ5s5i0Ssl1Wn0G4yt
 oFpCdCzNYW9B/zNdPq0CdBqEjId67pCGUXTpoHvatrv3/2pkB1jzjd7x/5/RdqgX/A6VLB9aFhN
 xT8WWq33fnRaaankrv6cL7orUBusK3e4Z6H2baOMbH1Su4jSwVwUhVkHIAYCBv6NEtBqdohMpLj
 i7QkXmR6twBaQsg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: xIDorh4i7f9YF1E6Ey5ZxZItsmNCaXqh
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26c9bb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=bD1TNsHgvEXzglPpcYW9rQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ADPNn3lZBn-UiSoLXagA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: xIDorh4i7f9YF1E6Ey5ZxZItsmNCaXqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfX57nkUpoP04Ao
 sAegYj4GE8QKYhTFDhhp6vTSohKExu993kmSXgMmjh1Lrc8L0iwWMlyvz2q1V673MFD6WlFOrk2
 XHq+gL22RCMOFlB1AJDkcLcaV6mNjPIuNc4A4E1ZwEgGr61w5tICLqiF6QU2jhkI1CSJiFs4IF9
 cGtxc2GIPzb6aKlEulo4PM7x2ja4sL8sQ/GK+SXQD+7U4s7438D8vkyJyQn7HlabbMjNtxCr7Eb
 +VRIqXvtD8+l/o7wvUF7ImgQKp5kL4ERe3ORIMRw0BwHDitfp7sTYJMI/FheHabRypycKNLwpyp
 XXoHkqPDq0m2wYK8wq1l+68olEPO/7lpEy4KjzOD3FgtBeDYCdW0nS81p0fbZX7sxmRnCnX93VZ
 v3VHDCh4MEPfI2XL8/a4NP6eJ3tXeDNIK7Feo6aKGUNwTK13u+v9BnB0+2s2BCDi9vASazQ/QBm
 3lsZT2V4G3XBaKr/vNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080132

Older dtschema <2024.02 required custom select to avoid applying this
binding to anything having "syscon" compatible.  That's not the case
anymore and this additional select has two headaches:

1. Duplicates all the compatibles listed in the schema.

2. Is error-prone, because it requires contributor to add the compatible
   in two places, otherwise the schema will be silently ignored.
   The select list already misses mentioning compatibles:
   mediatek,mt8365-infracfg-nao and renesas,r9a08g046-lvds-cmn (with the
   latter being reverted for different reasons).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 116 ----------------------
 1 file changed, 116 deletions(-)

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

