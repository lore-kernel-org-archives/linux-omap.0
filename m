Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0573C3428
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926901; cv=none; b=K0VZDU3AtJlqHv2qO+Wg+PSDlmqsx6cVhRGpFMbKwKUTCwLJWwgmp859DMvw++s9WoJGFRzJy4Kbqz3/PZPb06DpNMjg1M6FjnewXOZWxNpmL+OmIbx6sZ4M5Y0Zw+pxginoZiEddN4Bkm7S004FFhNdBtogDefId1a2SyzudD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926901; c=relaxed/simple;
	bh=H4Y30PW7n7YwDjrf08mPfxYtg1F+dQiEuh0m2Rr16mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJAkR/FZo/mgDLbwYVlb5kGWy65BBcbGT7UOexzPFZSq6dxOmOzr3gkVqnyT1Q0wh9k+bLr9tuXS2K9Ygpz0T8ODfyjCcz2aPhr/kXBE+35stmynorV76agtJvQZ1JKV+wl0TLQ9Px0SXvBXwboRSjL+e0ycRlPDXAS4XB/VtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYpbfRSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3p8+xP/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYpbfRSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3p8+xP/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR6Ab3300418
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 13:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q7Ea94Rrz+UAH3itxmW5/gMgVCOZgJd2bHTd3ZfBZeA=; b=hYpbfRSlRhjxcN38
	GnSZlzDqT2XzTYdZSGTisRorqCFjwIv9YzM7G2BoopwHnxrIVbonG0+6Nz7r0Xx/
	SShVIKSd0kEA3wQY7lC1WuNiQN0Ht8MUyKxj6irPGD2Wnz5bgkVk7P3qBjSogDx2
	h0v6kQuDACZskcJNkPV2ihMEVyJhj6Nk76C2JxGsahUfqBRTrG6bLe3PRfkMyH4f
	VTM/F5vvc7Fw05pQehhB4PwwlHhCbtQuDMOoVD/9LSvbfKjpBgw22C49NpdqJBTi
	gwa3AmccsdtuDy3KeYFhbifTPKXSZ9xTEOh/Q2gvmj8i6A2pnhAY1a46AHQCKsGc
	ZExAaQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuna901k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:54:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5176d949c58so113495211cf.0
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926898; x=1781531698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7Ea94Rrz+UAH3itxmW5/gMgVCOZgJd2bHTd3ZfBZeA=;
        b=P3p8+xP/VEXXlXxbeXO0Y3GWOIkLsIwQLjFPv3qEpYoXG6eotpyDqZteOacksR+ddn
         +jL75yyzRzsLvrLRck2eC+r2Uan0LAQvIpoeWDAcr07EHcPe3LCDxRaBx5iOgrw4r2cH
         j59wL8RnVAm4n9GyV0yv4+S2fl9s+A2+bO4m+KBQcenDe2TzWCEE4FYzprUcdUVW7B99
         3lNRO8UoNgzWgCv2EJ35hvQwVIHWihZK4z3++kfCCSX8V+m1ouTTNid7EPN+fN3J1i51
         U379SxWEbYy0CyBnYansXYmsjEc9sY6SnTKGL20qxcWgUewOpQaixIR0LxqUTR07ExAS
         mK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926898; x=1781531698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7Ea94Rrz+UAH3itxmW5/gMgVCOZgJd2bHTd3ZfBZeA=;
        b=KReez3JVchR0DZvT3e5Z8QtR2domqk1W9ULfeiSHMMyScy+cxaJwQENRD+ks2vR/Hw
         u2moqOii1VIPZzEim4Iffa+digdhYvL/8IGAXPVuEEL7uPGbyOM0cQFQ6Rewgj9IUs3s
         wPuWSQ5hyEPQOhvP0zjYDGMIo2JwYHhUJVvPbO+T10JGV15EuQKL2u0Mx0Ncv+BIElrq
         y9xggCqaLmgISbvWWBdoALsZWMzogMxljR/0bX18Y57WJCQtgZP/xdtqn+0ffzsegUBu
         /7ekMjKnWYi9jQ4jcTQZTs8ntruModv88VxuLjhvDvxL24wdQS0pHkfl6MWCWdy63DDk
         Oqbg==
X-Forwarded-Encrypted: i=1; AFNElJ8D8B1q/GRVEWPl+yO9bLmYIG3bn7zyTWzGA1pNO4uWz2bkg/XqBUUxVkB1MbRZGrigkN0fTNJrjsHw@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGcqJJWHHwl9PIWx+0w2ptDN+PTC523ZX5Btydm3MCKLe5BAH
	tsdg7L0D6FAYM9Dqw2ZIZTxHe/mqD6WNAEPeG/LnvgxE0AVbMEYkohQ1Y1TCHn1Bv1IJqi9wg95
	WFcJ00xXSnXBl3G8P/6lfystEe/vupIwEFmpFfd/opODjA7SMEQydAvhHp3Junyq9
X-Gm-Gg: Acq92OEgeFq1lZY4KJumCDW3tjOAlNHLmHgjLxylKKRN1N61XvnBmyrF6J4ffVszTK+
	EZqC09Fg959Gkk/nTrWlp7N7T4buE58MXK/5H8x//LFH0YTAgEMHWAhVSkGlWDvQ8UGo81i76kV
	OKsUbjh4HLuoiRLwkDFuaE7NvdtW233jPLqzCGbeUBDRmdUM6sU20MiU2N24ehspk4OQz8XI/32
	mNf/g1TTvnisp+e9kb6F/webxvpZsfeZEd8V/HYZ7Fm+RYzovR8l+hFmxvTVNrrFNmewFVK+5YG
	DYaElGxoDCx453whp8zo2VWlKYJjKIj5BADlLxrkUQ3EJ3b52wMqaWPvkJmbzZt/fWHHycM3VRg
	nRaqVbDWajKsysV3FBt3tzN1EEYEuqeznE3AqMGJeGA93yzqNyWXi+Xk=
X-Received: by 2002:ac8:610f:0:b0:517:8d76:5975 with SMTP id d75a77b69052e-51795afe67amr214335951cf.31.1780926898171;
        Mon, 08 Jun 2026 06:54:58 -0700 (PDT)
X-Received: by 2002:ac8:610f:0:b0:517:8d76:5975 with SMTP id d75a77b69052e-51795afe67amr214335231cf.31.1780926897572;
        Mon, 08 Jun 2026 06:54:57 -0700 (PDT)
Received: from [127.0.1.1] ([213.55.209.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm385972925e9.5.2026.06.08.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:54:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 15:54:14 +0200
Subject: [PATCH v2 1/4] dt-bindings: mfd: syscon: Disallow simple-bus with
 syscon
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v2-1-0203e6c249dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=H4Y30PW7n7YwDjrf08mPfxYtg1F+dQiEuh0m2Rr16mQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJsmo2kW8tcedUBmp80JofuUehC79NguEf1PFh
 XcCbWPOMCCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaibJqAAKCRDBN2bmhouD
 14EOD/9xIcV/HQiHw1XWxvuHk2Qy87m3NTPa2K0+4RU1CP4cK1GoH+nzEBS/ufXxSxtt10zt1mk
 Fy4XRalyypu0RhdaJhAtKMLtpxpAIoFQKIFWIdRKbrZM1tPIhxG71dLTmu8wBXlS/TbTIfIarq+
 /G195Ly7XlZbsA0iqZ+djQbdPSw6FH9u6O7/Nm5cXsZ5OHUo4lhOaFCKZCWGrfMDZds4L3LHTmd
 ci8wqyYIKIHtVeXD7leuCoao/TZjklRZu2Mtr89T4UNkl+NEWeTTV0Yoqm0kIhqc4b3T+IRirNF
 pu8foaoHS2Gl5aC9POZ+aIg6lHM+PiaWyyoDzVRIx12hyT1MeNkczyxCgvvg6AzVhPiWR25Hk7L
 N43afrEN8pDRG2yLtFMGBD0LV+aDsRKZ7/Lkh8qaSEpdjnX64dCHtQHzZvNB6a3BqFZS2GxXoXi
 Zk+/N5t32NAGl0spVTiNXt7XaRqkVj87+bkdxz1g2d68N3Oa7GqkQpM/ZAXFlYz2e3JWoBJGF7K
 SG0GDpUY569JTrAZEZ0aYxkyDPHqPI4qO6M+lJdHLQXlxNh3J1ZI6vIpa+0HG55YhgjGMg48jU/
 MX1V8umG3wHBqRMKe7bLEAMiq16Xfj4PrfoREbeDpFxD7u2+niV0ph+kiyNGaV74xg1Gpvzq3Cr
 clwZfItBTLH+3jQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfXxP/oRDw4nMW5
 +qpVtWIAYpgDT45DvZnDSg8knzoVs04eLLWlCXv1nIqK66yg3zv+McgAw6yWLZOaEbBgADqPZ0x
 MbDbUKXSDXv5hmV5juYibI0bfQfUhFLIpPCHdxkm4tw+gEL3YruwBkbzs6NErjqC92mI4lNm5EX
 ngfwFfERqQoGS+3qpgjE9RCB6pUO0dFYoQQX5J+O+5XPbhGYDpgHzp/i60ufVCYE4YRe0dRPKs7
 kOn451Gg0LGoxSPDjbDP4qBppPSetG4Cy/69Eb9Mi2hPx9lSbbwEcKnKJ7zV+ig7AzdSLQdNOoF
 gvXrcKpYcLD9zN7jSci9lhN9xSz7HHXH7A391kV8STs2PQ5VJ3wLJU2lAfJlHOa65ha/RTgrWvB
 3IyhsT/h8jdG5tJaSUjyyO6RGicpWpBuZ8ZvE4ulNpKnMdQNYW3meZ3xBKlxEsFzFHt2Rtd58bi
 V5PRXqHcuXWu1qwcJLQ==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a26c9b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=bD1TNsHgvEXzglPpcYW9rQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=YC08-fj938uaX1hd5_AA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: RJMgyKGXw2D-1RdLGxIQ4Uvrg8YPP94h
X-Proofpoint-GUID: RJMgyKGXw2D-1RdLGxIQ4Uvrg8YPP94h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080132

"syscon" is a system controller with registers having their own
functions, thus not really a trivial MMIO simple bus.  "simple-bus" on
the other hand is just a bus on which multiple devices sit and the
"simple" means no functions are allowed here.

Combination of both "syscon" and "simple-bus" is abuse of DT for easier
instantiating of Linux device drivers so add a schema to disallow that.

Unfortunately there are a few old cases of that patterns, so add
exceptions:

1. "cznic,turris1x-cpld" and "img,pistachio-cr-periph" are already used
   in upstream DTS.

2. TI has several DTSI with a child of SCM device (e.g. "ti,am3-scm")
   using "syscon" and "simple-bus" but without a dedicated compatible
   documented anywhere.  Add new compatibles for such cases.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Complete patch. I accidentally sent only part of it, built on top of
   internal WIP which I forgot to squash.
   I received Ack from Rob, but change is significant, so please kindly
   re-review.
---
 .../devicetree/bindings/mfd/syscon-common.yaml     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
index 14a08e7bc8bd..315357da146e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon-common.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -57,6 +57,38 @@ allOf:
           minItems: 3
           maxItems: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: simple-bus
+    then:
+      # simple-bus conflicts with syscon - if a device is a system controller
+      # with miscellaneous registers, then it has at least one dedicated
+      # function thus it is not a simple bus. Allow existing exceptions.
+      if:
+        properties:
+          compatible:
+            not:
+              contains:
+                # This list CANNOT grow
+                enum:
+                  - cznic,turris1x-cpld
+                  - img,pistachio-cr-periph
+                  - ti,am3352-scm-conf
+                  - ti,am4372-scm-conf
+                  - ti,dm814-scm-conf
+                  - ti,dm8168-scm-conf
+                  - ti,dra7-scm-conf
+                  - ti,omap2-scm-conf
+                  - ti,omap3-scm-conf
+                  - ti,omap4-sysc-padconf-global
+                  - ti,omap5-scm-conf
+                  - ti,omap5-scm-wkup-conf
+      then:
+        required:
+          - incorrect-usage-of-simple-bus-and-syscon
+
 additionalProperties: true
 
 examples:

-- 
2.53.0

