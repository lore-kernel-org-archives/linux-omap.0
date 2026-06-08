Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E853C3C0E
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926904; cv=none; b=eFsiENwM3Ve9SRU/IQPTMssXAHk9AZ7VMRMu8u2xZW4TudWVT4KxhPZn3JZiT6K4hHl2QbY1zXDCvv3VVzB39ui8gFwFK/m/44d+LBV3l4gt8zstuzDGdKXSIXLB1dzfaY/4BFSTqNYGif/dx3G4KLmot3UiVTLtBMPi9nFujZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926904; c=relaxed/simple;
	bh=lpvEF+gT5fcjZ09COuS+KduhTUqK+dyTIeYaqErwUx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgRBO9gtBl88+/SlNM/t3dU6DerRVbxsmpPKO6I7/FP9gUBe4zgdOTojDMz34mLAmGuZIzXRobzzAnF2E2Ww/t8GN4SsJs+xIugN+xT7KzznQYjqowg6aMM0RQ59w5G2J8rixa0atEieUhvSHJ3N7AtQAzWyiknMeG6xsU/SV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HE8V9I89; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=crQ3bb7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HE8V9I89";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crQ3bb7I"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Dl07v3275598
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2026 13:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CE0ywq38rbkHvJyR+YXsYczNfViYtChFgXOkvyQ3mBM=; b=HE8V9I898hiEnvjd
	WXThoSGLHy1Uov/QdRACXp+qCvo/yPAfD3XNHA+UdSB+0b3D1D5J4dICKdJSxQob
	Uhe2nvdy9YzePsEHGJifH7aXA2hBFy/zAM8t+gihx81pgZVNAs76vMYnAvpg1CZ+
	vfCj9EcM5L2utHz4ohjBgDZyZNzXqSEIl8Rfj0lgc2QZ2Wn+K+rHxgGqn2/e9C0I
	gFGoMdRenILm5f7ighMjrxkkcUXMZVqeDH897zSEIrySUdEKUD8RlPIGJMBpPElI
	RCWoZh4Ev40/FIIGP9H5cOwqC58kttiPFY8o/HfoT8FeKj4uqkr1aprpX62j2Y9h
	DBi60Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx4011n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 13:55:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccf62978bfso124921656d6.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780926902; x=1781531702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE0ywq38rbkHvJyR+YXsYczNfViYtChFgXOkvyQ3mBM=;
        b=crQ3bb7I6R1KNO2OEEz8jI2+w5ytQTxYF86mCH3h7KAHq5tTqjDG0MnNkTGmSh+JXL
         rBWkaytDHuDB+Z5aJ9J3zjjsNT3E0TOcclZyyfUBoj4OqxF0hM8qnPlji90TMuL09iOn
         ko3aRlyt9Bb16e2X+eZ7YZTkZKeyjyOHj9yTnytBpUZUeFyvM+AuH44+jEUU+Y8wr0NT
         F3imRev/aQJ3QGKH4DIUabXmRyQEoJpn6FRSSHoN/kxZxa+5CEjzPGvcjdi3ai9GIJ8l
         4X7UvyNnUmFyChM9ujfLu6lyuCToWPYwGgObIaYvGRncHWHJmztAU/vFGLjD5cQXfb/G
         2Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926902; x=1781531702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CE0ywq38rbkHvJyR+YXsYczNfViYtChFgXOkvyQ3mBM=;
        b=FDa3Rw91RA8AvoMjM94I9PldbK68kCBU6H5eB+1PTe7gC39cYIreneZrCFSnM6jx9j
         Pgswi37dj8yacrUjN01edz8E6tj0xP1+t+hR2hBgYBt4bkeoXT6eHbWPNFHq4vDIEmou
         AS9eE889rr91Ge+2Gx/K5QXOP/PWFO9DtMcv0jqxqg/z4joXJ9eMakKKYbZkrZrGelBJ
         yf5oKc8toa2PBrXyE89jHShhGT0V20dcPTu8eduDiPzN2SSDd8cyW49bcdDlS/PdvVsi
         QKmaCDZ2ka9b6elCnMMa2AW1M4CwdlII8+7XTfxUKs3Ce8KYCYXQcmVghT6JkJAUH9Z8
         xBGg==
X-Forwarded-Encrypted: i=1; AFNElJ+szfM4f9V+3dTUMynVQNMI3K/961AxRXLiBS657VkIPdrsjkdheEopvflrh1rePAt23ctb13TEhy7l@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRoVEDiv2PBTtZD5oSzSRrN57RftRcKLRtRiiPqWWIalmZy7f
	fa8Qs+SZfVDXjQzFA0I/0Zlx0uptablLGixnUeLSiXKg4P5tbaOOcnbON8Kpq9/mOs0VyuaGZ59
	cFFD+sMEd+Ey1Z9Ogvv1sOH1CjDC9xC1t9TJg6Ow0EJghQ0XlA7wECA+mrQZkHpwi
X-Gm-Gg: Acq92OEafPD0mlKMzaMd3d3GITpN0TOBXl5fUpNvMxtPWnwDJvmVEFoapNmter+c60f
	Q6HXi86ckcDt2PIY1Zor9YMF6xPxUzKWqSBLasi6+CvbXHQLml6zZIK5r9eDPLP+iiGHTk6Lw+H
	MRFRoF/LM1FogplhRH5R9XqUGie+KvwO2tb9rqf0xfB8HZg1ss9atioegPFQSaVFVXAHWPlED15
	FDOtPLuyuGgHU0E1ppU1zDkwAYsqKBp/Yf0PuTTM2gcu2/LYc5nFM/LRKRhaRafZalaN/j7Ga00
	+jFjnc0kto6blx+DL1UYhEttBbfvCx6vzwXwHP1X7Eh3YiCzf8PYO6W2khUs+ErPdQOB3Q46qAo
	onVPPOORUv+3t0xTp6qz7EeesQdufe5JQchCLX/Au+bXbKpCOBZtzWGI=
X-Received: by 2002:a05:622a:2509:b0:516:daca:ea8a with SMTP id d75a77b69052e-51795a4149amr202288741cf.20.1780926901637;
        Mon, 08 Jun 2026 06:55:01 -0700 (PDT)
X-Received: by 2002:a05:622a:2509:b0:516:daca:ea8a with SMTP id d75a77b69052e-51795a4149amr202288261cf.20.1780926901148;
        Mon, 08 Jun 2026 06:55:01 -0700 (PDT)
Received: from [127.0.1.1] ([213.55.209.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm385972925e9.5.2026.06.08.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:54:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 15:54:15 +0200
Subject: [PATCH v2 2/4] dt-bindings: mfd: syscon: Drop unneeded case for
 syscon + simple-mfd
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-n-dt-bindings-simple-bus-syscon-v2-2-0203e6c249dc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=lpvEF+gT5fcjZ09COuS+KduhTUqK+dyTIeYaqErwUx8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqJsmprD6HuAcUIRBVQOXNOcJdz8AQBm1/59E2R
 DiKe8Ecmk6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaibJqQAKCRDBN2bmhouD
 1ybOD/9TTTiTOIm72paZbnNZ62/N87L70A5R6anWHdWGFq4pwhlun9eNRC5N+e3kQ0suiL3JbGl
 6LsQsTwGFhxDADb1KHyJb3IMOWq8anPjedxgEs/SK1W4hSSF7Gy3KRmm0enmIgK5DsvdZvzoX7/
 W0JSVyitDrsCGOQw9OaIXT57J4B9nIfXxFl0BmRBpfSRORSELC406pvTbWQLwF5M2GhYSGs2CO7
 a/zp+KDtNYT7m85FzFo/D+fHOPcLUXneuYROZPlLM64EEx0/itbHL+NwsUCamJ3l/yyT/r/T8rx
 4vpizNrNsHUesYVok8afqlxEjdefNeOKx4P9VCSbVRpkvDJJwMryWSmLPVlweEvRt2R1t/Pj11L
 Xpp2H4ncIKOoJVEG85aUPy9YVh6sonSbQylYfLb0LLlm5b+BxjemGExL7XA/qZ0yOCN5dH+lhCN
 CxpRc5u8LA4fWdrg/GO0KGMeHCTbKeQ5g813ZLYVkbpuBjkBSLAuJPsi+puemCnalsC3qTx5Mj9
 gaXEiAnHsHcbJQNprPAjpqGfTE+ZkILnU3RWvc50jxaWvkJOUWi9K9kwpXS+3/dYS5KdDrOQUte
 rPPlc8hburw82yv+bG5e4D+h+3QYOYB6sQWAHgTNHZlJtAAuqF4ig2gb4tlT2tyFdYOafeP47uJ
 oaeZTP9STt9FJ+A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a26c9b6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=bD1TNsHgvEXzglPpcYW9rQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=iBsvbdzN5SDSf47EeGIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: qNJXb_HCw3G7NBajQZ-ukIe0Qxq5k5Nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMiBTYWx0ZWRfX3kqsGlP/FnWW
 lSS2Dw7v3eXSRFY9HEEXgQ/cPZGonUaBlBOnzGYUQIPbpuvWzGF85ezcYRT8d20c7l6FFn9whzC
 UQfeQTM3FvXyqMh+vkB/PONlPM9+gx9RLNQ9cpYnLGFeTHzW5iI9vLL3B9wn1+JgtXWSZlWtmcw
 4SK7ovFswZo6Eae5RWnxCPWfMD3zVw9xM+/i4aPqKKgT46kSbnuEg1mZ8uGFJq1J+TnrzDE0DpM
 7ZiDn3j6Eg/8MKe6N8l7QS0GOEQ/ZcbsbYqERiT8INxcXgowfCIBBLTevPdGw92XUYv5vXKqX0G
 LXqK5JUr39N2FELpfco3Yj4BRkVYDSN74PvRXn/FcGYZ85K/Y72Kton4ea1jrR8xO7VAmqFkpo9
 rUHmiObYuqPgUtoIC9zjG7yOFVojwS0Of5Ob6zKHrjg8Jxji39ftO1Ad8gi9e1iWxFTvh71YlXW
 OwEscLrpjOAD6y73FpQ==
X-Proofpoint-GUID: qNJXb_HCw3G7NBajQZ-ukIe0Qxq5k5Nd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080132

Commit f97b0435c857 ("dt-bindings: mfd: syscon: Split and enforce
documenting MFD children") split the syscon.yaml bindings with intention
that combinations of "syscon" and "simple-mfd" will own bindings file
referencing the common syscon-common.yaml file and define its children.
That is why it left the quite generic/wide compatible list of up to five
entries with simple-mfd.

This permissive list of up to five entries with simple-mfd can be
removed because:
1. Such case - referencing syscon-common.yaml - did not materialize.

2. All documented bindings combining "syscon" and "simple-mfd" have
   their own schemas.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch
---
 Documentation/devicetree/bindings/mfd/syscon-common.yaml | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
index 315357da146e..b3462e876622 100644
--- a/Documentation/devicetree/bindings/mfd/syscon-common.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -46,17 +46,6 @@ required:
   - reg
 
 allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: simple-mfd
-    then:
-      properties:
-        compatible:
-          minItems: 3
-          maxItems: 5
-
   - if:
       properties:
         compatible:

-- 
2.53.0

