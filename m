Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1835B62A
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837601; cv=none; b=jr4GKzU50oKxzb27hmKBzgkz4Sch9qEOlYZ/jTNsXJcEM87TA61V+txPryzdB2OLkr3ikBuWvELXr2Uv6qfSIa5L06c1PA2qUNZpE6cC5J37VbtZsY7MES4c9mpsUADzJxY7XfjUIZuw+MmTy3TEatrxOsLJtduN3VASq2xbq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837601; c=relaxed/simple;
	bh=u9n9l0NVttKMXo8Cm/QnZobv6JruCHoppeN1fvpKWko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRAwp27+ifzAtwsCPfykghqkEJTbbsB4bKX69hKUo4Aexlvy1yuVJjEp2UiPk8Cl3a3Wfz46qwGxjXZQtjgKEtWyvB3dAOXZOLoZy3gLxpd8f5VnBT65EsgCzuv1gPwkooRor5dsbfUVfVxoyyaILbC1Aw79cJmc8TNqgmBbkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ks9LgQaZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gw95vzYO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ks9LgQaZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gw95vzYO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNXlfc2565272
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=; b=Ks9LgQaZ3rISUUiB
	UPhLyg/wvHNrMuQ5MWGAkiHx0iTOMmkXYe3Oz/aqmkvOAKX51jAY4jDR0H4ZoTL9
	u3f8F9FGGFVb7seJ0dt4qNmUb/HHrL36jZ2fKTHhNqsTIv6HNKltCodV5RFZRSoF
	IeGKpz/KS4ztmolA34vbLAiIibrhLpIcBlIHcGo9llC5ajpnrOWXzWr+PkFnC1b+
	9g6P/WEhspfqn4px8qqJ0cmtjRLXgrYitdoEVqVNtMcSPtixCMNKxHw/10/QXYY6
	hV+QRuOd+9Sl3vBXhlqaFfuKPPDX4cVO5T5OpDBDeiIGS9wYL+6vHU35jWCqbSw8
	9V6u8Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyv2p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb6291d95aso2681149085a.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837595; x=1772442395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=;
        b=gw95vzYONNCteCUXzl3Gp84NeTEEcbsXinpAA/yQq/Eu5NrHEnM7KMukZI5OhvoGKA
         64lOaa8p+2/lna6ezxB4riqRbcc5j26LzR3q5QGTtimh0Cyrrc86T1hiVnuZlGm2mMBp
         DN3n5+Ml5Ym4YD76tFXOc/xX24KSpu0UEaUxCbisGV1FwcnDmTm7pPjlitSeA/Ys5xoO
         25rj30K8U5hpHsFOhu9VyphSaoM2PHbo5njezdxBnrIoxedrnrpWycches2++11x78vG
         a1iXf5pTuNSJCnD8eufLCEHR0l2Lc35QSgESoG0kKYt/db+0+ZOziM1ZQTiWVaLdrNkh
         tAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837595; x=1772442395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=;
        b=exufHEkz4vzqrnyhX8tZFYqLSFH4nSpT71lROeM8iUH+Y2O9uGQ9VbyUNmcqNEOqfT
         Iu4d+CvWLucp3q6dsy1BDCE/Eo08JOODkqGg9H7yrSApgFAs2BQB1BIhmEpxdXA9gscb
         Zolt8vkyygtuEcgstIp28i49N5+AbAFLPwy8EMbiHlJPdLTG33TDdfe6DbHFDawREjn3
         vwz9Bf3Pg2ZsbyecJDxgIp6+41C48vTHw2kXQjwODxWKWXzKLNJSIQZk2FboWdu88UiM
         cOIXpxJh08rPKkHJgEwf7AYX8+lnUUYerVN6xpnCIOjWgyj0cibR7w6MHvv1cqeUs0cq
         5SfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0bvDrnr87PlPT7AhTd4juDDi9j4jE+GdUpbw37/6MZWoLSH95nOUIpDvCHO4QPjFHJ7PZtOFw7KdW@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIpAJ/SAmLeNLbjTCDtnt8cqwOdwuvC7LVIykdLMLV9ta/LLo
	PNRLXW+W9uIbC//os+tr+OcYvVCPffmdWHI2DRbxK035wucPRRXKqlDHrWjuMZhA2fI++B8x0WR
	OyFc5Bi7hF79M3u8Az/3RRRcff9ffSrEdtdznZdQUU13gkUG3SnHdtG/sUp+9QLoW/g1LAuQo
X-Gm-Gg: AZuq6aIEJazXjXOYEENFta+hMaEr+XSeUIhPWoZhBF7Aj1nkqBMlx3PRR1jAMWN/s3P
	/Ho82vtb7ccVkaGO3rmGj3kEjBhvTMuVcAwWkFpGZDOSTz4x4YzAs/4agKqX+iJB9yopGaMHq0u
	Z6YBGei1GJM0krrs2tiHNbxhGd7w+und/xdkxagYOiivmTrR6J68pQ0iFBu2X5WR8eGJz5H72Dm
	XYZ9eAarOC1EDsxEd3ynPs96O9He33O0O0M7mGO6v1KgaH2p9KgoHYScYlNXUWIRgb666PBNvnZ
	n66yD2rfpt9G0fYaa2APA0ZorNi8yNNoRK5Cqn1WakhduOL2SKIjD3TvJ3OKVdKQtPPXUzjb3I0
	Ahn6VGfuih4wG4HGbqkhOAC7vSVZeIijUX/dDOvOPXVrvlFJ6NKOU
X-Received: by 2002:a05:620a:d8d:b0:8c9:ea1c:f218 with SMTP id af79cd13be357-8cb8c9e009cmr764190385a.15.1771837594960;
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8c9:ea1c:f218 with SMTP id af79cd13be357-8cb8c9e009cmr764186885a.15.1771837594436;
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:58 +0100
Subject: [PATCH v2 12/12] i2c: bcm2835: set device parent and of_node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=u9n9l0NVttKMXo8Cm/QnZobv6JruCHoppeN1fvpKWko=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh6jRDDYe/3k1buXIvSNZ0TnkcrKdAhpsYOn
 u3Iy5X2HQaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYegAKCRAFnS7L/zaE
 w/fxEACOqkkkfaqNDgIlMNMHdbLfBNUN+gmyyErH+9RBYgw21lotLXldvXjukuDR43t7iBhEwQ6
 v4RmssSTTIPx1IaBN8RKqSTKhl9DxJTZoQG/RWkex+IXlSU6aNk/eapEsQIS/ImmReGyQbGzaUC
 7BGuDxYIhXrvzKsSOw1FzEhWWbMSZ4mtTdk1CZeUrsOGpc4smvhI1+XwAzfjXYf65/NK5LMjc8l
 exdlUnuKLFmfZboiBNCo872Eq0XM7NQmb7eOa67A2jpyxL3X9WXj2R5d1/Fr5IMGeWkZdnRpjSj
 5NU+AHl99u6k9MDIpqfSEV1EeSM0vmqqL/8Ixa1LJa7BDu2RNTN42T2+jCzGg42h4AIkgCTP/dl
 l8qVhh3hgMSHhLhJM9H9kPZwlvkqzO1eLwurRNKpTgz5jOjqwmhiOYxEKoxyr8+0J5LD6n5NLYg
 ZSNAJM/fPknh9iPDrWlWBHqxOKOSrZnLL6HXgCJ42zZht03ftuKgxXbEtQOCU2LIHKaePurzFUH
 3cKffAKB4Yo8oDatXqW/WoQ00bR9iDb5ms+rU2bXP8WjcYq5y2u8vrw+bMM8L/ZuzYmrOzIgmO0
 +mvyxeWTLzka7zKtqqCtpQUs7kT8hJHPP/MEXSqM3WPFQz0WeLm45y/8qDGNiDy+7ahzeaOkzbr
 cwHccInIQJYdhYA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX9rkxtYcRYq3v
 ISs78DgV6RHZxi0aRg+JtRQwk2O5fRUkqQ9v6DuxPsBifcA/J3IgnNHGA6YrHJXv9pO/H0uF/WJ
 /wrsOOlVgsxNLsdevtmI/bjJNFzNWURjdkHa1vL8B9iufS6dMeQRs45D9xzqR5gY7x3LMQPELEe
 ku8S4eCSbEnWYbqQZgq8U16dGJeQOi/aoGa03kF21hMwCuYc9SjqFbjSvJ0iUf6I1/ob2fNqy4B
 jGl7y8zDjh1h/9EYryP81A7iu3UakBiVGD6A1Z1y9kQYW7UawCQJjj2CBTERX0W54j5kDaGQ1/H
 +FMnpixrzaEf3HK9DjrBghnIc1+EAau5wTKXvm9UiEOIrvvHxCLpW8HLmCS/vEczghu9sbHALR+
 ygMeXwMInUbOjlMFzS1Ud+5cXs7BYQeRqhrBCZeRZw8E+7ejg06aBCDWLZjQUf9iijZiCWdeAdk
 Cp7+CSXGcRkuOcdzJFg==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c189c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=w6fcmXAubz_WdynIYoEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xyBCG2mhF42nc7dNBl03LPfDnG4AWBF6
X-Proofpoint-ORIG-GUID: xyBCG2mhF42nc7dNBl03LPfDnG4AWBF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 0d7e2654a534e92a529f27fdc049812359678522..4f7e4a178b33fdd172657cc625a34018b18f88ca 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -474,8 +474,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	snprintf(adap->name, sizeof(adap->name), "bcm2835 (%s)",
 		 of_node_full_name(pdev->dev.of_node));
 	adap->algo = &bcm2835_i2c_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 	adap->quirks = of_device_get_match_data(&pdev->dev);
 
 	/*

-- 
2.47.3

