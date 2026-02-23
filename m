Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4834E743
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837585; cv=none; b=cwFo8nFpWdpcZm8yDsxND4nK4ewjnSZ80Vz59Rt2oIrqOvrcDfWffYypQrLwi2t1aJ4Mb6QclKuoMe8ks6MWiwJggv4mK8gUKbLwkSr/sis9J5qoqcc5c4mldgfB0S4CY33zo6qSCZ8zWssGAK2jSEvpuBekBPATQXGB3Ff85bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837585; c=relaxed/simple;
	bh=TC55XBmh7XavSMEvFloOiPWsoDIu8+74KUdcPMB2Bs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XT1NWVqWWUh+HZx1EsuKe6wiBWXJAhgZLIshmu7OBKTWdzwzUf66GOZQVA6g2eo4w8ctnvJD1RwBFcKRY2G0/kchGhyyTMVFRAh46Mny0YjXyCh9xVxxN7fYsu/ZFSbHVbcIEU2aMoyBVsxm0kYvwUp223zOBM4GZqgQTNy51Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItOQAL6U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h5vREGTO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItOQAL6U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5vREGTO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MHAqPq1060334
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hWSZ9zXmCEERN9u2nWml4hs+0Q0AEKrVf/uMBqg5ZEo=; b=ItOQAL6Un+1g7sCL
	BNrPifQpEh670GxN5RSQnLf9WxHoyMpBIJo4hdA1EsRYnHs4zbpuOAy2vveAavVE
	wbx32eKhGXoYfYPKvijjonrTNyr8Vz5/vYlAy8sSG1VylpgelYVHl4ndaLxM+ndp
	b4NvKVCpz0QF1+to94yt9a1aah80tKP8VqMGZUNxJ9Fcp9oFPScqS1Ia0HFG1hZi
	x0aN9TfBBXEXDCeGUYKQLaL6R7sa7KdjDE7FeEBxlGgxYvosmDwbe/sYMlq7q0Ii
	0cTACN5B5ooA9spPbUXdoEMAQRLhQMG0mEYR3DA7Bc67X61Ft42/advBcJCo9Hhu
	2lmn4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9v3dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3fae6f60so5358487885a.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837582; x=1772442382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWSZ9zXmCEERN9u2nWml4hs+0Q0AEKrVf/uMBqg5ZEo=;
        b=h5vREGTO2i9/RXoKxdh/kvH3n9JqHHOO4dRc0j7oh3WoAqbbrKoutX8cY5G95d9ROg
         PXwekzJx1eimN3WinKwRItVnwp1uagaj3CrJswUogms2gpEmdtUbRoAoXq8m62tqzVFU
         YB9+zgJ7xDqoOltk9LkpA9ev89HvBjSxxUVYxEIL/Ge8o9z6pzGc0g5L9AykWV43Nffn
         HRLHKtr44uTM1xeSuQP7MBQmJIkEVl766pvHXzipCUMmrLZ+nCTqV25g+rEp1GAjhy2X
         Pi5zmBRdC3+aitTPQlItFCChOA05jzmwlHNkIDEEDU3OHxwTgvnaqImgp0cBSF5X5gTq
         ts1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837582; x=1772442382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWSZ9zXmCEERN9u2nWml4hs+0Q0AEKrVf/uMBqg5ZEo=;
        b=UId7Kcj8pqW+JSZsBaiS8Ez2NblIKMlLZ/9zxySHwz0f7a5DUQjWsgJ5GWff2s35Zl
         /0kGRnrQIaeicg/REwNOXia4qU89VeEUt7dCGcxHS3780ds0dX0mSaU80ux6TB1PoARl
         X0sq77gM1vwnC4gh7d4YQUB4SMnQseVqs4wPRvkvxcgJfUPlitl7qfk+JQvzVi1wUP1i
         ED+4JD2rfUJ1lMmijX30WZMpHC494vgUUDk9lpR5cEhzQm4uVGHBxRoukv16AExsuf5/
         t7S6y1fHdRSmP5ti6lth4zaemXBQ0ktSrgh2cy4mc/+Su+HzQoFEI4XW4XNGEFZTgCnf
         T9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX/S0yHJkTXdELkTrSENl5OeK7N5CFA2UGWU7iImgqa4jZ18M3Mig8cmyGmDluvpQtQ3xJFJmR8CGw4@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWpDyzsnejJOUfSDUaYeD2b4rDzYIupUDqqJjyhiCNcJRENEy
	ENz8LRrrmflQZ/D6PeC3u6unL1vEez7wCnV38nZ7kr4kYWOZcS0+gVWdpiV4LsWI3gYOD3WcOmn
	j2OJOjrDivvoxNiiga5cdPSksAd/vgy9istmreBhOYko9GVqJRzE4jZcG9RhJC4/5
X-Gm-Gg: AZuq6aJfmqMWJqUqBN5FsJ1fhFd/dxkFO1DwUj9UAKNUdSClgZ3v4XEFExRLJstlGz0
	/zn1b7y9XgK43oztPTrWjVjO6LLuhQMm3DmD/cPh/n8uUMmZwr+ffCxZdiGBT7PRaGTCegU2KGc
	qMVVRaaAz/b+2eIeNERMtgMXumq9sGVNe5djhO36L9n3YgvAEEICDmB+1nS/fRrZCVqOIHRRuPV
	aXNhqFZsfRzMF5jkPbFdGP6wb4xvEaf0hPguvWQ+5ELR0VWKR35pr2zajz/X41EctHFBMBrJjIz
	JAnNi1uw0LJB6akvx4LOSs8yDmhkf2yMr9SxlhJv0hbcpMfo+IgeT9Fr6r6arRp8IYdM4RurJhy
	mIvqdxDivtpUuZy1obR/yIJr1JHo0W56+Uz2M6DHJrXwDElENbGzz
X-Received: by 2002:a05:620a:198f:b0:8c6:a587:377f with SMTP id af79cd13be357-8cb7bffe749mr1695559685a.36.1771837582018;
        Mon, 23 Feb 2026 01:06:22 -0800 (PST)
X-Received: by 2002:a05:620a:198f:b0:8c6:a587:377f with SMTP id af79cd13be357-8cb7bffe749mr1695553785a.36.1771837581510;
        Mon, 23 Feb 2026 01:06:21 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:21 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:51 +0100
Subject: [PATCH v2 05/12] i2c: omap: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-5-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TC55XBmh7XavSMEvFloOiPWsoDIu8+74KUdcPMB2Bs4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh1cgZ8t5g6Eu+YoXhXwpQTHi3u0PDANGTOZ
 Ae0vjnO/5yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYdQAKCRAFnS7L/zaE
 wwgCD/9apGwYLbKP/+X8XV0CrL2TpbVD/yQ1v+mwXTXzC2F0pORGRN35JjluieguYXFndYxaKdR
 tFZGjy50KQb/wtE7KYKXDQ2vWD6HJKH7FLizL1sVHQ7zo2GDBMUrZfw46kio+YiG6Is+Y1LYS7x
 +WX0RKZmhXLvUyNifbPFoZi2cCSTnAlzLHtIb+UJKfzgib+aVNaVB/OH+/srM5mpP4oDifAlwgx
 Ikc9+u0lITu1cL1gkDyoDKnj2lI/aWKhrc7mKp8fiSL+tBfUMKVYrKGus5GOIlEgoVa+iUhARC0
 zjrJVesZJEPf6zXrnmLcNt9AVMPczA7pz70Q2tp65CsbqZnkc/30/gYsr8AENPhTQLteN5BMo02
 086YUnhbe7k0pExpN7GQxKZosadOo7IUnEmhL90snzNzrE1Et39/xYOE2UJq6ii4a/qtmW2uegk
 52VogvSFCULCBjU1Yjr0c6FvBcFABmtCKBqsa7dawmKHWBtVF3vFskxY2lu0/bROCQFZTv+7w/k
 IxINEGTeEsbhCnd7d/eAywrwe3khM9Pf1mA72OKQwXI0ez9mYSar2yrKKTrBe4GKH/5lFWB2+/2
 Y9/ssBYQd5bBfBM8TxNtTpP/pY6suqrCVQXH8nBZw5nsL2f3q2BHphXOV1+Aha8pNOS9Vw/1Uae
 suI+G4XhCD+wAIA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXxagMWlJyfNV9
 KiDfRbrtwMsqDXmfjAcRd1Dgcs+VqcF5pjw4GGJbmXaByOc/I/SWrLxCBaqf74/FPFL6tPwhVkE
 EWk+t8X3RNFsV4oc3S103hOuwfxIZpPeTodMKJSztfprLHqWfRFd0tMh1x9JCLdxRzrtlKRqpb7
 YqMcU6LxyLGjqZ9peXTCkbc9WL5QybEFloe8bSQZJSl8bgftTutlpGHyPjevvv3CnTPeDCVYutG
 Z7ou9VFNEg5EUBSjkswIPrhL2CMHOYAbdCyg9/tzFZt3wu5Okcu8j5jp55Zh7nM3Cno9/rGbCQC
 xPbRJFqBZuukETa1JtTyf04hO+SkZ94cdunoRy9OeLlUQEGAl6Kr4r5oMmUKsVWBuOarmO0qVi2
 HztVAVh5hyM/O5BO0DUUndJiKHxNT23w/Omzp3wK/ddRbeVLd64tfht3BNoggo/NfiRBIraGThy
 /FUqafNoZqgAU8or91A==
X-Proofpoint-GUID: RT-RpcBgtTUcen_2qs9bZ8dLauaPC3ko
X-Proofpoint-ORIG-GUID: RT-RpcBgtTUcen_2qs9bZ8dLauaPC3ko
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c188e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=50gAi1W1AAAA:8
 a=EUspDBNiAAAA:8 a=H-w5s1-Ky7DYDkcl1QcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d9f590f0c384340dd31308bdf9ed0cb1a1a2ba8b..f95f31c521314e1d67f3d5b34bb44fcef557624f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1496,8 +1496,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	strscpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->quirks = &omap_i2c_quirks;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 	adap->bus_recovery_info = &omap_i2c_bus_recovery_info;
 
 	/* i2c device drivers may be active on return from add_adapter() */

-- 
2.47.3

