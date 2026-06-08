Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476F39B4A5
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951479; cv=none; b=i76cGfijpq74PtLdRuRz6ueFve5rtasY96TbW23kwP0b2h0tx0zNWRfbxrsIDg9UzYaJf96MiIYk09MyJ2kBe5Yv8dCOdR4XfVUbKSCyiHj1pi3mp7JR/2gWxd5trJVi+kr4DTJaTdlF+VlyXNyA1voHA83K/VAL5mMYVN0leK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951479; c=relaxed/simple;
	bh=5Xa72kw9Ltgd7CByB7B5latAUb0JYhrgHD01OqlPHas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ilm/XrMXyYkEYKRdSm2sOhqTHhfPcERIzf3GQp/fXt2kugnSGr10lAidYM3vk1mnoC6kD7I10N6Kpzu7AuXM/oSqsBEtOuWET6Iq8OeJxNWiG5aDWDIgSKFfnogqJNaGGllD1EbYrywEaLfCPBoAXQOvi0zm8Yt8217xEG66ArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGT7HmAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FpS3M9uW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGT7HmAO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FpS3M9uW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IwikP276256
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 20:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JZcc6TPeUx/2ww8Z8bbTx4
	r6S+aoLRf/jpoC61OzVbc=; b=MGT7HmAOHcVdj0yATV7HMAwbU5uk4J313+T5nm
	84kICFmcHfToU9Lqm9Zj1W8my/y4+rF2I1dGopuun62rFv8Fw2trVIkKDB3yKySW
	qydpBOtZnfMRszANz62Pt50+mwOEp0Ujx4Zp18DgPJCVsRwORM4Er5MujfDwelpy
	ptJDMUpbk/tCmC6s1na0lS+aQUhoepuuYyFJBT0tP7qg8AZABd46rd0j/jD4sGWe
	Pih62qqCqyu29l++9QOUW7MKDU7kcjJF5AxMJXi8jD4J37DBGonSUMg6w0aopY6s
	ItlzeTEe2ujWvVOt4J54RBTMEjcYrpwJuSquw8sPHnljJNCg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptjv5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 20:44:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51768072950so66849471cf.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780951477; x=1781556277; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZcc6TPeUx/2ww8Z8bbTx4r6S+aoLRf/jpoC61OzVbc=;
        b=FpS3M9uWNviodCwpv2bLtoVECRrIQVkBxlMUstq/FCM6RxHg+e0vPAcN6CHwLPUegJ
         Mm76Rkr+yHt4v6VOPb3Xb5IQgzFFJ1QYU43evugRLHNOzYa7R9QZyK2hqMRScVi9/++D
         U+3DnDdnfzhWifpJeFW4EAVKll1DkfMZ6nWtPGsJh9v4h+ahc6hqKcUKT2byGpXBMpli
         KqPD4ApjbE7WAmtEs6qL49I+Xxxc//DczzqtbF20h45N9wLAoHC7JgCgz6b9nyg4nqEw
         DO4VpO12jDTk7mYgXfWPeZjdM5RrJXpibDGbVl7HTBb5lQZfy4tPosr9FIZgPZSgnAc8
         uwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951477; x=1781556277;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZcc6TPeUx/2ww8Z8bbTx4r6S+aoLRf/jpoC61OzVbc=;
        b=XYkTmUH8+BP21fWXOdOa2ymEtMnN3SUPRGjsiuqhKLhetiG7anPc9tFm9EriqzDhRd
         tUpgiz5Cqmff6B7f0XA+6h3lYh4IH66FunBCAhJffUHrPlM6qZpnsyujAfH2qdxaqTWQ
         gIDO69nZZRjjj5dslTmJ8mZyVx0+PqHJp3xlY/swa1NBl1r5rmRv3y4sM0ZWgT6RxGST
         OvzUwnKDDBRNr1IgtKNRcP0z4Xx1Ao+lBCa00bxrtm/UCktZOs5E160FqNhi+iyCi+NO
         xmMXTWq1F8dclpXs8lnGIPQjrgTkqkoBNyFH9BhqZ2kBBJenEHsXQxMfJ0925ASIbMNQ
         PKXA==
X-Forwarded-Encrypted: i=1; AFNElJ+pVp4gAQujIIhLSq7UmBm2wfg8kP7vvpmKVLh8aA0wwg59yk5MQXhDbR570Il32ex47Nt7haGFzrP2@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCLAxKjD7bn0Ds/qMTLD0c7i/EbLtqyvVwY+JP9bUm0Ekga0Z
	rEyUcdwew+B3MKZySYDIZ+do0f6U5PYombsWd6AvgxJbdBRem5SZ2JDJi6lLxqkgfA2C1fSP1YN
	87fZmjQFlOsdQ2oqzrHpGMPnegmdWeeB/2fauvXlw3FVoqHOn2gdxMMc8bQV+UrWP
X-Gm-Gg: Acq92OEN7nlx9jYvSPTu6vtmn9xt6GLeRKuIhdjWPERrFwnXgVnqgVtkdt7wHmvP0Qu
	V260SaJd5IVrO30trGW7djGGXR0HCSjPgJRq7PYkbRDlIcVHWo8/hkCW5ajvJl0dC3v7Y+rr2rU
	22uzXgT/KfXfxhwRmFq+8qOPZTZYdlzbY/ZA32J0yHkuuhQ2aiLCMVb9OMR55ysax+1sHVoKUMW
	pLhv9+EAMZ5LyTo/Bf8FQNO3Rb6FH4u6OA0TAA0ckV7Yp+mjKlbO+KchcF1ottrl8h1myttsy8j
	OCam+MHmkPOK3ctfWuVPsgqf5CSjcvAdJdVgk2dHoF8uiP4Q9P6aKXE1Nph92o2CLsXXIPin3zA
	XHkLdZtRp/G5CaxD5fJsVBxMtFcYbKBkxYTzng/1nVQCEWv7c+iUT/h8=
X-Received: by 2002:a05:622a:1f90:b0:517:75d8:b95d with SMTP id d75a77b69052e-51795c0cf7bmr247057341cf.40.1780951476619;
        Mon, 08 Jun 2026 13:44:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1f90:b0:517:75d8:b95d with SMTP id d75a77b69052e-51795c0cf7bmr247056621cf.40.1780951475888;
        Mon, 08 Jun 2026 13:44:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm44018439f8f.32.2026.06.08.13.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:44:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/3] dt-bindings: mfd: syscon: Tighten checks
Date: Mon, 08 Jun 2026 22:44:23 +0200
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQqDMBBEf0Vy7soSRbSn/kfxoMmqWzSxrkpF/
 PdG+wO9DPNgmJldCU1Mou7RriZaWdi7AMktUqarXEvANrDSqDPMMAcHdoaanWXXCggPY09QL8F
 uYrwDSgrbpJhXqK0KLeNEDX+uhWf5Y1nqF5n5rD0THcvsp+26sOoz9//aqgEBNSaUGZ0W1jy8S
 Pxeqt74YYiDqPI4ji9iGIV15wAAAA==
X-Change-ID: 20260608-n-dt-bindings-simple-bus-syscon-e39df408a02d
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5Xa72kw9Ltgd7CByB7B5latAUb0JYhrgHD01OqlPHas=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJymqXzctnjCZTlgfqtTkKkReZfSxm69dcth3s
 +3KPVCaK/qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaicpqgAKCRDBN2bmhouD
 12o+D/9dEqmiBDrunvPNTigrYZ65joY0Y404B5kMuUHwxnjcIcSDy0bYTIMZus92hnmDEYvpC9U
 i2tw9EoYNrO1EeZYBOWcj+FJKTG5wLwU8EqAG5w3fIa2zQ5rVTe+zDoNtqRzLgckMUTIEZVoWSl
 xx/h49ZbzgXV9CJzte6U0Fp3ycwf0J/HUsNBQqNpdja+HyIoWu5Qd4HWIFShKkueEUH8KcNSwnJ
 1TC2Rn4T9MbSDCBS/0klhPlGPyYvR1WG42P3wjHdLDH8pUHPHYBBPrRNq85x/OK1BKmigWgYkam
 7ZIy5F0wlV+4bECVkaIfnFpsg2p78TeS9WWPQgGmIdmfb0GPbMkK9PkDozcrjmLEJk/QRny2IS2
 79lvO18dQiOU738h5JoKCuWKzvLCoBtiw627Gbqo21BHDrLWo8oF3ZWR3kXm5RUPVnRTQ8EVr7x
 F07R0Zx2p4W1tYV4zFk1IV+3EbHBSbfAJQle3zzH24lTJr8rOPXXbnu+2F2CbirwcO++zy7xoTb
 dXOxD+QhaGr6V/LYklyLnTx9IdHl0LJsEnzLdfpfUal5h6SuMSxFInElOpARadLe8wgkHeegyap
 mybKDxrB8IWZUlFjKaqVHhruAjaUBKUEjuTpgmBT44Z5ACshQzaraQj4ifeRN4qFcde73irdf/H
 QC7QfMmQpvt0MRg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: ctrrROPKhLJo_lSIdeg6MlyV0A2sPt6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE4OCBTYWx0ZWRfXxkxDR+Zwcj+z
 CAQfjJk/uVeF0VmqXooEpJYRm7rFPnTmcV9zPzOvQePOVi73oGfnGc2xck1jGFPCOsilLqivyxa
 ORcPhOmCZoxOkM5FTy6IAm0jACHXP+eJsx/gCeetLUBLOF5mCWH8sLdBha1C6DhAzABnIoK5K3t
 vii8Oa9r9YYA+lu06X0AtOW+pkAnIWqZf2BarQR2O45VsVYz8D7aMW0VIJWnqcjltCmNSXOYDqz
 2ooRcSew3nmkQLqJHas4DLQRIf2LOXVbxlz04Q7mHVCzZjLMFbINFjw+MmPHJ8dgYr7ESG2p7vz
 rVw2ju2gT4Ct5xU0XOZtVA81BIF/QytbidXjN9KUZKorA6BTfW+tGslHAHpegkFev5GFJZNYPlB
 7IrwmOrSeDsCr/PpoAaUez7X517HCKa/lyUd20+kxlgiNCoVEfNaHKMG8Vtyr/tCgs6wjP4sLje
 kb+gET/ykOkyiR8HQIQ==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a2729b5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=s4keiGDSzyMyFUzW_nEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: ctrrROPKhLJo_lSIdeg6MlyV0A2sPt6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080188

Changes in v3:
- Drop patch #2:
  dt-bindings: mfd: syscon: Drop unneeded case for syscon + simple-mfd
- Bump dtschema requirement
- Link to v2: https://patch.msgid.link/20260608-n-dt-bindings-simple-bus-syscon-v2-0-0203e6c249dc@oss.qualcomm.com

Changes in v2:
1. New patches #2 and #3
1. Add missing part of patch #1, thus not adding Rob's Ack.
https://lore.kernel.org/all/20260531110404.12768-3-krzysztof.kozlowski@oss.qualcomm.com/

I tested dt_binding_check and dtbs_check for arm, arm64 and riscv and I
think I did not introduce new dtbs_check warnings. Old code anyway has
multiple abuses of syscon, thus tricky to judge for arm at least.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: mfd: syscon: Disallow simple-bus with syscon
      dt-bindings: mfd: syscon: Drop custom select for older dtschema
      ARM: dts: ti: Add specific compatibles for SCM conf nodes

 Documentation/devicetree/bindings/Makefile         |   2 +-
 .../devicetree/bindings/mfd/syscon-common.yaml     |  34 ++++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 116 ---------------------
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi           |   2 +-
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi           |   2 +-
 arch/arm/boot/dts/ti/omap/dm814x.dtsi              |   2 +-
 arch/arm/boot/dts/ti/omap/dm816x.dtsi              |   2 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi             |   2 +-
 arch/arm/boot/dts/ti/omap/omap2430.dtsi            |   2 +-
 arch/arm/boot/dts/ti/omap/omap3.dtsi               |   2 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   2 +-
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi            |   6 +-
 12 files changed, 46 insertions(+), 128 deletions(-)
---
base-commit: 78f5e68a8d0a1123dd1b007688ccf0e6876a5c15
change-id: 20260608-n-dt-bindings-simple-bus-syscon-e39df408a02d

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

