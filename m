Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A635028D
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837593; cv=none; b=IrC0j71AjfgvC8cOQZWJkifrRk6xe4GLNCQfxfSNOgv1dCrC2suW3dy4jTJgxPDWwYISfagFBLovqEcKQ0lCmBoZQaxFyqh/rf3lnOO9wUj9bp5/w11ZZkHOmiJL+IihFVtDR22gzO9WRc4fdDM18EE4JS8Bh2PW9JOzKH30SYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837593; c=relaxed/simple;
	bh=iacvmP5MKst4koF4pQzdNY4+k8gIR/r7nU+j4v1o/rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2qJiflNkS++Q+a2zZg0KPT/8glhffBqbuLqBR09d9Z2BH0vgSLMiMT0vUrtd/+ayMWaQqnIlKWSRzidW5UPqmfOT7E4OXEPYup8pD1o7LwfmLGP9gEqaYI+dK3XH0CXLeqpQKWU72f+oJZfGcn1t5X7Oo1Hse9lyj+hWYJ1G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAQdRWvv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zg73osz5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAQdRWvv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zg73osz5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNQ6Bq2061057
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=; b=hAQdRWvvV0G+NLiW
	MEGF9Jf95N7zQMt+9m5bmPGFLSo7Eu9+Mt03F6fs+Se1rzZb6pK1IW6IfRGnhR1Y
	o8ODSwJeWHfhUQUeazDO9mCdk9QlBo4vAeoXYSwgR0uaIuKCxeXh9bFuQ1eLb23N
	KDcGNM1YBpWlOOSI87m3Xfjb8ZyG5mxvfyVWEEZEWgqQboKe9MTk6uJhXGSORwts
	sNYIDpmBhp6n2XqiB3YvgX3VwBIC3I+pZMDCysz0hmBryFQJxW5Ni6liSbnKx2Go
	aegRmaZmzQeBegQGQEYD2xBPgA6stAI4RC2dePjjcbGPKQ8VRsE/OsSEjYVyiwuS
	WdohNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wav3d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71156fe09so3758755685a.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837588; x=1772442388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=;
        b=Zg73osz5AKhDUjaTIc3+GKLwbpDfrSgd72kdmouFXx30Paj+HuZQBcp4i83JIZi18y
         ehqaJb0eQUjXCl2VmnK0WiDa6KvIg76HAEuir9NjoZTux9uKtMF5xhNAaxe2T3ROfhp5
         Ibgb0BbX+ooeE6buWAfO/xcycEAP7VhFDlEAw8B2HDI1ulI6sXmlTTuApYFrnIFE8WS9
         qMn/J7m4OSCdEL8CYLvzxktvurwTUTZk9X8G/AQ1qcLIZerl7aB5pAdEqHoeO1cAa2z/
         684xdgAlrmGU5vBx8rFtpMA0SDZwUP6H4kQtgrHLMu5CVDDalUUicOJ3SPnnelwBTCIb
         2Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837588; x=1772442388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=;
        b=OFJJSUgE+Pb8ltc5zcj/+k51A4TzI+7wAVjKBS4c/c4FW9zlFR0jKU1v3yX6ayW0ce
         tzqOyJmAFc5zPysi1Qt4avejZmvTHVe46Ra+JbV0N6kM84z5xnwvUunJp6U+lMcFJvRR
         /0oYHkUZHITQxy2OSEsMGcvtDwpO0eXU7m47KpxeI99P0C4XdXHXwaRvb29JnqEC46DB
         W7rV/zqSsecK292IVwGY7tvOggxisvjRlDTLzzICxzL1ye0Cx0uwy52GhvbRtTbzHrly
         98n4MZFxNIbWP0Yhs7fxPm8jA5cMBaL7ixSzKp7goWvoW37Fxll+d3n7aCiX7ZyfX/wl
         Yk1w==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ747oUMAi0IvTrJ6h/rjh9PWtBjF7szSPOLkI9XG/M6kjQzKaCbUt3FX0JrlLrbinKqCbsE5IGVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnHR7s+XnglRm4LnkKY2W0z5nQ0rPUyx7xU2qE/gco3F/jf5f
	goSiZ4CDc6I+pY4kQacA4feos3tiyY7o/ODsdfAwqWy4ZAX/tV7n4QWHz2GRXPeHJFU7eRDiR+n
	KVupbYt945cOZRilRthA4284Huev0yvdWlVbt23fdqMFZYRYxo0xxW1TyfDnFCHu7
X-Gm-Gg: AZuq6aKtu+MSdXLnbp5Ni63otSSQlaco5IfqL537/bQGKXRcK7LBETywOmxmc6EDXPR
	xk0E7N/gRtAe6h+ed/lXjdmzSHOE0sWcoLMUZHlAI5eMqF/rGW40ae33pmEHpFcGs1nA6Pbr97V
	BxPGSw1adpXcgcSMO5zTX6skh2MWq+kPYYDGliy9z/4zoVTOqTyJ5z42t1fngpqgyTPflzqu0y+
	iiYz9jl1x0oNf2aIDCKRqX1YSyYxn5bTnrnAlipuFWqVINi4Qe9UuwN7c6T4mZCHJeLDCCOwzl1
	RMCZ7ZhQYBnauODd3igU8g7Uy0dyJg3059IXGVJphqV3sdyxffTr5JHxZr5Am5UYRmuodVjCS7r
	b7dGGAK1ldT+Tv3JQGgfYw5rUhVmEp2/15/3MtoNu1+9oTVmy2XKl
X-Received: by 2002:a05:620a:4587:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8cb8c9d1dcbmr922891585a.14.1771837587520;
        Mon, 23 Feb 2026 01:06:27 -0800 (PST)
X-Received: by 2002:a05:620a:4587:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8cb8c9d1dcbmr922886285a.14.1771837587053;
        Mon, 23 Feb 2026 01:06:27 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:54 +0100
Subject: [PATCH v2 08/12] i2c: mxs: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-8-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=iacvmP5MKst4koF4pQzdNY4+k8gIR/r7nU+j4v1o/rI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh46t9YVusxGMRyOKiO1gXCj7YchvrY73yIi
 M9XKPAvJqmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYeAAKCRAFnS7L/zaE
 w1f8D/9Kr6cIxWLtSoo/iCsrKZvQ1AH7s9U2qJB6pL13Bs2n53X6os+fQTcQ3mW6OqL9+gW2IBO
 hKJyz5n049Yg9UAulAPIB2NwtjSqS+2e3S2e4+YVRmkxHqOdSYiUcQiX7UKJQU51B0sRz4x+Jsy
 j3bdNkn8RXeXakq85CDPNGeBlub6cxzXNysFXSejcPM9tA9av5dQSSq3w9uAg6Z6JlNv2rkjfbO
 Mru0GOD4rjDb05x/1ld6B71rL2iqeiOY6LJ+5Zag0iNaqwpIroZIZGRg8cnygQ3av91fBgclbCE
 wdt/NmYrtU9IIPBwJDv3Jn1NbLe2TjwYYADsuEGwKC2OJeadyxdITubVzqMoZVdr19TWwEhMjVQ
 AEImAkWG/9zFYjU4his2ENsP0xL/V2N6R70qdXddM3VPqQUOnpD595mWRSkqQgIfVG47kt3SB7Z
 8N/tLHhNvG6+30lNhzc/F89tdmILZIhk0D15gcNcWaJ90xx++Ua/MCzmp2wD6GDTuoHkYEt4hXV
 tO1YDz8vjze5y8gIf5ACLG3claNn3De8Yxn7RhBwfuB3pg6YxMWkplKp6r2GbZJdQDHEpWdLJEL
 owN4Lg0hxbwpY928+IW+n+cKYnIuhUEC+JQbKv8kTubPpXwlNvRuGlvIyVrD413i2bk0gWxDFCp
 W78klu2oVB6AoJg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=KJVXzVFo c=1 sm=1 tr=0 ts=699c1894 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ZBRMoY1RY0NPWYz5CrkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXxPgCLdlEJlZ9
 rc10NAS4ThY+zqqui4/mCx0y6Ri0sneeBeXJ0Ilu6dzM/czFBLzR7VqsZRt0ew4BLuoFvD1J2Yp
 76S4WRFsIEX/OhzVRjQDKzf1WheAt5laPSLTLnetPu7L7BSZKXE9oJegGhk9bR4FzsrY9BL2QLS
 7uaKQrs+Ssyz5ezeg/0WdZQAeK4kR6a/oP5geqTQqy+yLt0hbiBpFRQmQYd8tOa5wVTX5zBQt/P
 DoopzIcTDeQehfWfAra5bdITLQM31UXUVdncDGP7ngZTD0g0iTFKXEh2lw13pvEENJjLxlVc+q7
 OTMH8i9oyBloNOTGgd+RrLDBdHOgvE1iyOLJc+FNPaBxLotmrwteMedY9rIeB1JaOqn2CEtg32X
 FVgne4iAXindE8kU3cPl48rqNN1os6R66bsevpYQblvdgv5nA5G10DUGvnmm1T0YceyWBSYm6yP
 ySFz72MGIaKQYV4NISQ==
X-Proofpoint-ORIG-GUID: qFD0JWdvXAfj-CbZ1ifjBDezZV0ufGvn
X-Proofpoint-GUID: qFD0JWdvXAfj-CbZ1ifjBDezZV0ufGvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 08c9091a1e35151bac8d4adb80abdbd29a62b95a..bfbd96ee2f483cd1dd872c3448eaa6a17940d70f 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -849,9 +849,9 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	adap->algo = &mxs_i2c_algo;
 	adap->quirks = &mxs_i2c_quirks;
-	adap->dev.parent = dev;
+	adap->parent = dev;
 	adap->nr = pdev->id;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->of_node = pdev->dev.of_node;
 	i2c_set_adapdata(adap, i2c);
 	err = i2c_add_numbered_adapter(adap);
 	if (err) {

-- 
2.47.3

