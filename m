Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17F34F47E
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837593; cv=none; b=OErOfEt4oPOVR8oQ2j9TyaxZgAWRVxDuu9UGWbyQFj36RPg7dr/pl68aBlyilcl8k0qXya5oXLy3zezuSztlTpvnevKDsh0xu/yuN2YG0IzST1mWBihEvzIgVRB6QBdJFKPHHSQV0oDMUeZrpzJCexyxtzSDYDGXX6rVjAXTjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837593; c=relaxed/simple;
	bh=rx2dtWdEbZEet4K2jCNLxIpDHbio19pJqqBXzjxrlr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5OpBCEB+wEIDJr5nU/e48Nr1RtQWZLzkuDWmO4MBsyE4tioy4xFb6jwRSXPUsInJHJgt4z6UHuRVN77IjLlQKZaC1iQwqA1DiGaGpMSE1pae+pFoIkTyoJ/3+uzVpP+qrh7qKo991WyTnPnUSeblgu2adwcROk6kM3dYnS5OFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VohCfQdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ix/ySmlD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VohCfQdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ix/ySmlD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N5QSvC2917608
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=; b=VohCfQdIzABLDJmb
	Fw038ZU0I0zohd5ZrlgbtoUHT0ieW1PFZXc8rioSQuz7MeTDwfTB8XscACuRc/Jd
	nUaOZ1g6xn1krs6hx3IM0wp/eoG9ZHT6JBAMYLidRoP8ogNZ4Ur4cdUvm3vABeex
	pTlCGPUjnNdVbxz/D0uiBmYgDN5vRVENYXBOsPjyUdHCLW9bNPLCywWZlhPxogmV
	Sc/qCB7kBRTt187PfITDacTUfcuzXjy/1e9A36D3lhB2joKKWdOkQhCUEWwlxQpg
	+31mliVns/XJIeAz4EjcCJYUyxRRVKgBNEJ+GOwRRkVWxgzmgJEJuZ0nCqcO78Rs
	jtFvEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf603m37h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4817f3c8so3650777985a.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837586; x=1772442386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=;
        b=Ix/ySmlDqmkfh7DkiNWWJXqoLEgprGZBCux1nrF3L1Z22u8v5lSULD2EN//vavinmC
         K3OKjg40n0FNjzBT6y86d2osDvBBe3/Pyj9xwX6KoIeNmhYXnSBCggnItXS4t7utT56w
         duB3Cu9kXb/XKyTUp2qrL6mlHE717TROCdxW/Wq07T36m6fIP5h+0q0T48LEadEuUgaj
         Z6r+Zg6Rjpjobdff1RaAAsDcqWwitNtJfgtDRuWjpCVr4wufZAvyQHkBy4jQBp/tMRaf
         mrtfHydNKKw78qXNboXGMYp53BCRgGC3GggKcYqTA4rFNfP6pCtXZtcZD4tPAKWNQvml
         6QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837586; x=1772442386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=;
        b=KJ4BOmo2a4sQXKxYJUNd3bcrjOeh0s18bLjFdh2uDfIe8O8qXRRr/GXFeTtsANdHnF
         JtkZqI8fqx+IcvTwHimSBs1Oboa+xPgpwb/BBqoBnbnBgSpXKJ9DHq/lGG3w5+KuoDTz
         dl/wvbbHlR4bJlMuxOZzfsYupj3Gnqhcljeky3bxRIF5a59gi/w7SZv+4Ionh4duuuX2
         rcPfk8SCzH5GjzLcvx2+AbWqOao/XJkRfTKGJVdVJuhAnA7c1VuA53FYuAYtlnwSka25
         hm1b2+sCAZ3OKtE5HsP4BkApU6+WdY3y7FFOoSBHVyZ8i5wcAH1xpZxlbZ9R1UM8IDuG
         IR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV32Ucx83T6f1KIL2H4yPIZg4alR9Ui3SqE6SgMLy2Ngm0wdSwwfIrXeR0UY9nbLUk0G8vBkuJWL6A3@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUOntK16Td0GR2/B+w9offpIRBfNsrimUVeum60vs75Q2unZu
	+NTu6xtzResaF9UeA2Y1oADgZwtuiwoS/4AurLeEJfwxcUzVk9GC5qSuPfpLUKIEwdHiUAsU77m
	y9wQ2OSG06bcluul34mGdmV/HaZyV+3R8OSwWWWdbul83KIxE9UB/6YFTEadFPVmQ
X-Gm-Gg: AZuq6aKQBlhDE02pVMCB0tmP2OEDDxSBVx6y7I/3M9tSQZpiJdlahXxYVxv7r4OUvYM
	w7w0gaYFpPoBty+iCOXBIKAFyZWIEiJHKR3sxqYBTf79N3tQ0f46qcXZARqFigROE8ewOjsTwfq
	zUW00CaFDHlWwU0O5bPoSKWFFy0EKs7LtCcJRth0pbC0Ij1gYoIpf7DELpOixMO/7kqwI4tlA2+
	vQUBRanBONiz4BQQe1uoh6+BtmlKo63sJCWfMw9jslnHunzGstu8dn0xMKtls06SCkpIrKbmHRJ
	QgjW1//qSKn0ZQmeJkqqVre1PQzrntYCsczP/FAW6NQvJBK58kd1dcNo7yogQqKZBbVdHSrUMqE
	1/g2FCzDSesPjYzHPSOgrAN8ARWxan7nWExT+MOkoJ1UVtlmJtN9a
X-Received: by 2002:a05:620a:25c6:b0:8c9:f996:81f7 with SMTP id af79cd13be357-8cb8ca92ba2mr819919885a.81.1771837585718;
        Mon, 23 Feb 2026 01:06:25 -0800 (PST)
X-Received: by 2002:a05:620a:25c6:b0:8c9:f996:81f7 with SMTP id af79cd13be357-8cb8ca92ba2mr819914785a.81.1771837585240;
        Mon, 23 Feb 2026 01:06:25 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:53 +0100
Subject: [PATCH v2 07/12] i2c: st: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-7-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rx2dtWdEbZEet4K2jCNLxIpDHbio19pJqqBXzjxrlr8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh352YX7S+FxODzw031A6NZFNXTTScBQL802
 bH0eQGAhDqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYdwAKCRAFnS7L/zaE
 wwkxD/93SJI2I03XT8QYkmz2qqEK1l9t+/u3zcfCHXOkN4VxZpbr3NNH79eKM4Izeho/f9oZSlt
 hpXtbZ1986gfzwMjem3xOh4LrMM5uwhAkYvTyq4h94Z1kR0U4CdqMyz2dFTrYQofwtaEaq0QYtW
 2UsClAH3A6oAmGMw84nzOkOWezWyuWVxKZu6RV7ZQsu2HqHBrksHdxpzAj07PC1rIUIKlIzWeMd
 Gu4R+nGnEsYBsqvU9UahVeDs/ElVSq+sMVG04A+OpeDoih7meDq8ZksVqmkY8aS6MbPgErpJ14r
 rfdmmPGJ3mPF/Mh4pi+uFB3sHnbzbQFg/O8iIZLC0uwQt+5BH8WIDZ0NT3m8EVRfT1Rbmn/Dpk/
 O9Jr2qQugx4m+eo3nFBu/ofAUZ6ode1AkJY10UDo9PneFzFVwYZYyIXmGK/AjWCe73SSYxRjqHp
 7iJNoHcpQ4MRGF0MpGRK5bRPzXF1YQOJtZfABHxUlTVVeBrYthBuFfzXcSV9riTNnNnMATVbp6Z
 IUghQTpX+9+gwWg7mnnANmCyfmulcIHi28C4mPCjS8U4rx45Sl3FDmuowjI+94bcn+XCPmgKlhx
 SFf6HkYKbnTMk7XUh1wNeWm1TMpJhvYhbhvaZ5Lkq3PUnPnLuKmuGtFdtewCOPT+JqzC8AkG8SB
 Wm+qW7Ou23eA11w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XbWEDY55 c=1 sm=1 tr=0 ts=699c1892 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=8b9GpE9nAAAA:8
 a=EUspDBNiAAAA:8 a=5jvZOilLG3lo3iFWl1UA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX3dHmthA+JLOy
 e2uwcRxcRcc/VQhg4IzEP8vuXuIRIkAtOqOIrmKiu5wL1xl7/wKdo9Yap7jWRHKiqHmfLNjCKq0
 PP9OhFRVKTaFjLSpGtX4l9OY9IIHwOqqN2+1u8AAhkLoAe9T9ny75dOSaHX/dXAMFpTRq31Kc+M
 lM6woMU5rkx2ineSbzY46cbG/WhmRQpHIfv0J3dDD4BymBlH4EER4e4efZJVCGk5g7xRu7gpZkH
 RHpHwhVsItaGoOYeO9taAucEyyJB9CNnZ8H5bKIcSVY5nGJfnd2g1uofDjzAaw2woz3OUIy0Vat
 B3UfrTFFfY+aG1KJxzDUGae33AH0RkFRiNp7Hgb93uz0DvyfwhEKW7AIDCgqHEsRSrurpMwRLdH
 0IWPoic1Ky8XGT/yaqHSZF+Gnl5Fov4F1gWspE+V/9olQyMYc7VE790Gq5SNnMUb4u3NdfvQMJN
 /NWToZKb+FzNNuH8KuA==
X-Proofpoint-ORIG-GUID: XZBeTA-mV74jet7hMqR8eXBW_RapHQwH
X-Proofpoint-GUID: XZBeTA-mV74jet7hMqR8eXBW_RapHQwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 751ea421caaf388bc2337026e0860707823546d7..88ee5dfb55e469b64537694224a0fe39008a80c2 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -850,8 +850,8 @@ static int st_i2c_probe(struct platform_device *pdev)
 	adap->retries = 0;
 	adap->algo = &st_i2c_algo;
 	adap->bus_recovery_info = &st_i2c_recovery_info;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 
 	init_completion(&i2c_dev->complete);
 

-- 
2.47.3

