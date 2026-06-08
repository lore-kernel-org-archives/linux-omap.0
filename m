Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F8399890
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951482; cv=none; b=iqOUyPxuU44kS33TZXp2iII14u1zjumQwIFEg64llu+BZJKQazeIzcOYTMz86mHw11+ZPEc8Zcdq0gCc+WZ3ivw0+UkmmJMcALAGC2k33ZBlk6Kt1u+kL4RLq6pDdKY3zaEGcLc6nQumslqxwmkB50a6DntbP1NrEd5fj+R8KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951482; c=relaxed/simple;
	bh=GGm0AisNFCyHSk5n1cRU+JBiint9Mvk66lCZxnmAJS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5SYR5Z9Cd//jQRhDmUGIvKlDQeTQKA2Bt+Y3dDgW64gKYa4VsMBgvUA5mb/PDExLa86nqZpk4fY/sIqoWWcIeGT49ZYd5mE5Q7cumOTsLyj0Dl6BMp+nwCy2joSotDYjmviHix2gQ/LjcIpzOKZdSKTl+DAfcHUCimU0vA2XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxqmRTY9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hAzDrdex; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxqmRTY9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hAzDrdex"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IwYH7276077
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 20:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aa+ndaOgUThxNdHVB0ASmJ3j4g2yeUEnhZvQ4B/J6e8=; b=UxqmRTY9puFB7LWL
	ZMu0Qiib4RidpT67QVHaJx2XWnplGgMlJDqfKD+FGvqkOGj77M2IhfxwqatB3Bh6
	MeAf4wYyOGmzSi0oSa3FK7lEHss0rngDg95X8K1nywjpEmgKCuAiqFQ+ONKNH1Ud
	ScjuO2ZDFawf0CTjKgY2LE8K6QdrArARPhp0oQZj6oDAFZ1EwOylfi+IfUKOBtoy
	3onE4g7R4BmbKCdZurEZArH9podQMV73f6cSVxds3g7DT2AIhIJ0jmZ/EQmQwwxq
	+FkX9f+XnfAEPJJQcwup7UXe9Yl/DaaPNiCll092tEMxTZCmQIrpIf8XB9SHUcSe
	v31jAQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptjv64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 20:44:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176cc5bf2aso64991881cf.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780951480; x=1781556280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa+ndaOgUThxNdHVB0ASmJ3j4g2yeUEnhZvQ4B/J6e8=;
        b=hAzDrdexMSnhhtxr6YiUfe+OsaByCoga400gZ1sH73G4MRKVoagpI77KOgreCENw3a
         MKxgo8qGpM95twCnfZ2C6jbzYh4Z70tVuKgy0eRbOFo9WMlQNjMbpOWbfO9uFNgpQxvg
         WmyYJxR0i1PzDEa5Bf0TJz2QmJEOjufJLmRWYHHxM8Wl4wBkltzClkJgE4eapLMH5Mmn
         J7o0Itjs1af2RtVndhae3qaTL9lsjWUE3HxUTPwEEMGMirBxjk2vzTdhrGMrPKk8jwxb
         HMTNnwd4LUUPK4BKIz+F/9QhHb9lQ5y1HRvCmGvmMH7x9TLsmXyWOkBU9t0n7tu+PvHd
         XjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951480; x=1781556280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aa+ndaOgUThxNdHVB0ASmJ3j4g2yeUEnhZvQ4B/J6e8=;
        b=D9Ufl8DOC/vHpFul9YE5NRy+eRRqT3PU1Opqk4xlee5B6A492YrVsryeY5BUKD5002
         0dgrY4s4x3e5+3Lw+VdhzeVeTF2mGD46CV3jsMilJxeSfARek/ocxwljeuX2SvTIq4/k
         s3L50phbbzRp2eLrlqAP9wkIFVsamevWFUt0++9kqOI0M0tDRMRdr+dhSq3fgMY3K/tt
         gTRK1n4s1FcEq9KPTYlSZeOjjcHc6hXiGAZDn7x58SyRJqit4q9DyQO/Z5K4iiL4JFJd
         8MaabZSp/IxrE6fcIQLXgGzbQ1lXnw/qNsRMGGx8Mxg3bO9IbLud8TA0Ae1wcHLN7oYg
         Qc+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Q2hsbANwO/rzI0TbDtFD3hL754+tHAawXb0xCqLY+XQpHZXtB3dtdeClqwHwpmtJqPTuABmYrgMq6@vger.kernel.org
X-Gm-Message-State: AOJu0YwcexG1Vewhl59FpzmbYE6CGzm65X9c7CByMv93JkoNq4XE0tDu
	amUoSyIW/rlvKbu6RV8Z7q46HLi6tnEkZKMuy92mAmOfVHWl2VE7kogmyTDEbXMZU2xh5UUUbfc
	3ZyLPeYdfCQo5EI5HzVueYHceDSjmIFNQGHHPosXBXhjI5B4D+WgwForcRjG/ipxK
X-Gm-Gg: Acq92OEsCS6dl2+tIgnyIkYBKdOMA/RhUhp8ZUZ2w56/to8Z8Dga/n6UaWm4ndWlpsj
	at7k0DyZnl0aAJ78ORLC01+JO19RJv96o6dntszJIpHXlNNFu4yLoYuofks+mpHR3pAwpnscS1O
	+x0BnQs+QQ6p7h/7kIwek3PvcOHz+lYrWUnfhqDOXgf7o+iz4ehcyL5pdgg+GxhQQTKqxGDyYl4
	MjJfEQFA819n91LlOZD1XLq2F02zo6kvSRr4F25Dq6QAtp9mhBZdSB1yL4MENa4rjsWaP9hEyhj
	fkK2qJgR4Ul/6TUoTxwTtpQpPhUgvV/yTa4Ag3qFcMpMEDaKkgVYDCt7BGsNFZaY4+/7te5KXu/
	wv16vtJLVSL50SJD++6ytMQUMInWBwrUSyk0f6kvHmkq93w8wlF+nmQY=
X-Received: by 2002:ac8:7d94:0:b0:517:884d:3801 with SMTP id d75a77b69052e-51795b510a7mr238024591cf.25.1780951479431;
        Mon, 08 Jun 2026 13:44:39 -0700 (PDT)
X-Received: by 2002:ac8:7d94:0:b0:517:884d:3801 with SMTP id d75a77b69052e-51795b510a7mr238023911cf.25.1780951478802;
        Mon, 08 Jun 2026 13:44:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm44018439f8f.32.2026.06.08.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:44:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 22:44:24 +0200
Subject: [PATCH v3 1/3] dt-bindings: mfd: syscon: Disallow simple-bus with
 syscon
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v3-1-4eba9ec1212a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3471;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GGm0AisNFCyHSk5n1cRU+JBiint9Mvk66lCZxnmAJS8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJymuLrRKQk+tXDx2C3XILUa/Vb/m5SqeAMHbs
 hX701Fcl6CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaicprgAKCRDBN2bmhouD
 1xNzD/4owClN9H1JCOAoIzeu7RK56xSXZgce4N5pJJTSqM+cmLpO4VODAdnX9M90nuMT2mDNxlD
 SdZfpjjNTupJPwAZX5x+aSPrqbWsyQm1nVutsjB3jp7H6S8/1OnP5Z4BhuiwQEAhch5x6k4NVvY
 qL447Hya8vixLLsgY9sANwVmoXUKUmziA/9FQDpSgQUsoZsBPSZushtTAtPvFjdglp3PTDWJrSL
 QDkuLE+q61ip5Hpuble0C5lsc2dMCKrlXW6Lez7hvabG0BOoND5THfBuKNChvxJ4qRTArQF/VLU
 AAqUynQwJTUDLRNmHYcsvOuss3E1UqUdj45pZe23Wnlx/0WyPokJRUyqWtxelGER/rgEH4lAp3q
 qItSXbI1oiHviWpwFk0wcXYCZ28ekjTgqi6y+NctPbsPQk0mtADjQiu2eoA9gP6J/gR0fpYjBrC
 Q/en3j42uVe8KxZkbNTMCXke5RNveZKSbcz5vRoSFJiMNphlzRR382sRUXdhW8VSPf5cUIVjqlb
 cm/On61l90dg5x69fhEH+rDEK1Sc8U1+vsUhiYhWoq9jtHVBFEWUxcS5GFohZLrO5VrGSfJb2xe
 WRXhX3b9AoNrhcspfMTcxEmE1w2Z+SX9qPJ50ERHH5VTjFuC2lKRS09/TExgKqaabbdOzG+bCnK
 L1BibnK0fC/izPQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: 5UXSue4JWuc3oo9A2vz69OA_donRE8BK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE4OCBTYWx0ZWRfX0IbzpHvGMI0t
 ukb3ul4U6Ee0ZsROFIXMrm1eEnTjxuAbYWwj9Utaphyca1KNElOUFtOmyrUUHXYUqf6eUP/jK6v
 Y4w64tl6cqh5ycT/WnBF9C3nD/G8EUwfyVvySrycxqpXihWzwPbsTP6rTsku/UfSFzWyQqR/+Gt
 2w+4ADyH44vT0Gf5DAsUKr7lrd3L5prZXG/jGIUjt3PdpvOA8qpfS/N3qoMmC9sk5R/ID0OpYHi
 KDrgxvRohkBFSBOW42hBIRStWYnUMxFBB2JU0+ATePcWEw7yStIgV6HlFW6ilBPXR9WkxhP960r
 wwNpyey0zCV9vjSfKw9Yw21p0rdgwpgjb4t2uuj6MIlDUPeM/tQZQWGQqAzPeTcS39704mZCVb9
 mcQySIt0G+PhnZezTMwaIQ87XXHUwc8xP3PB6MZSUGSOt8UkCcS2alaODX70RbGQGUTm8Zi0Ktx
 CaSYHzePj82C4e18cbQ==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a2729b8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SC3sQ6iH9rxi55wiDKQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 5UXSue4JWuc3oo9A2vz69OA_donRE8BK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080188

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

Additionally, add comments around code enforcing two or three
compatibles: it is similar safeguard detecting incorrect bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v3:
1. s/ti,omap5-scm-conf/ti,omap5-sysc-padconf-global/ because it is more
   appropriate (specific)
2. Add comments, why simple-mfd+syscon has dedicated if:then:

Changes in v2:
1. Complete patch. I accidentally sent only part of it, built on top of
   internal WIP which I forgot to squash.
   I received Ack from Rob, but change is significant, so please kindly
   re-review.
---
 .../devicetree/bindings/mfd/syscon-common.yaml     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
index 14a08e7bc8bd..2d5eef5add54 100644
--- a/Documentation/devicetree/bindings/mfd/syscon-common.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -32,6 +32,7 @@ properties:
   compatible:
     contains:
       const: syscon
+    # Always require a specific compatible for syscon
     minItems: 2
     maxItems: 5  # Should be enough
 
@@ -52,11 +53,44 @@ allOf:
           contains:
             const: simple-mfd
     then:
+      # Always require a specific compatible for syscon with simple-mfd
       properties:
         compatible:
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
+                  - ti,omap5-scm-wkup-conf
+                  - ti,omap5-sysc-padconf-global
+      then:
+        required:
+          - incorrect-usage-of-simple-bus-and-syscon
+
 additionalProperties: true
 
 examples:

-- 
2.53.0

