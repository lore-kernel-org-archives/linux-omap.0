Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EEB1DFE22
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837582; cv=none; b=mImLTbT20XpMrO97IAfCcuzXfstrSuU+//B1p/DYSKqGrN+cCZFwNVZ8jyhYrKrmGn+Ixro5ub5pmnY7ZxGBlaMUplv1zZ70zjvubBLqc1NUDCb2fX/Eq9vPX1eq8os+SNDvnncDdZ3iMuZkvNSkvfgYHbM3x1sVXrI/lKC2828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837582; c=relaxed/simple;
	bh=bo4ZGFeMtG75ouEjaDX91gsDwyQD1Njwy7cFmjSQfKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+dVopGvyVn1o2ZBLPaf0sUtH+smw0Nxfh110Btwu4Z9yCvY0s+PiUNQyn+PITfcQJVQ4EjLK7tMr4UVaIQAl20HwNPxQgSDLIneVB8D/I538KMgd0tFf17AwcABep5WDQEl0cAmv4agwaZzi+8CDQraPE/MVjEpVJRj2pNaZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YTPVxryj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LsUddBPM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YTPVxryj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LsUddBPM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MINtxF3076321
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fvkc9n0P50/n/5hQkbKBw3GiCDGmeSmMMtzN5wuOhlQ=; b=YTPVxryj6fttLgGH
	RWiNJnaVeeo8IXYi2a3nlPBXYzOJFg0kJ4HXHffcmY6mZdjVYU2wXAdIsyyQT7tZ
	8WYSYv2AhIedEBKlTyxZkZx9AMvqxdYsCOm/bnt4EeQJAVzW04YL6yvEERQYgjje
	5sP1WZMCbioyRMX1UsmgWRwqmqh2/9alRdwP6EgHoLgWEN7mA8VGIA+Jrh6Ey8fd
	DT9P4qG6PX1QDnvA1EikNyIVJsC6mwmSukurC88Wvv70LsLT//e8TSKTXw3ft+B2
	ilwT1WABBYuJz9NErBcdW9CXPk0vvmJFxJ0UzbnW6o2nnczCoFvlYX2DhECHr4oj
	S7lMlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u8m253-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3a2eb984so1170982785a.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837580; x=1772442380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvkc9n0P50/n/5hQkbKBw3GiCDGmeSmMMtzN5wuOhlQ=;
        b=LsUddBPM6mGisO7gE/oVDdUgo25LLxyKziWwMQw2zVVQRso+JNECJjnZHJn28mTtNK
         LzenD5NZ/Bl4CMo8F5shHxHD++myBYHyxmRMpvGo9yId8w21j+zr7YDJWeVG7dpwYPvA
         DmT9Rj2+a9/hVIzyaoYzYA7eTfUaU24uOZnUblvRzE2ke6BqsPK/xBtmmgE+2RBUhfzz
         uvmmZHL7b2uYNALP7SmwMO4LNYe1MO3XQVRElZpSzsHJdiPzIqJvioWltdjLDUuES6Ud
         kt1dDXSTeBh7D8pOXCwqv3wAJoyF3zXlh8KISN3f4jfvH3Wozz0C2+UwBRl/Jwfb+yIZ
         fYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837580; x=1772442380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fvkc9n0P50/n/5hQkbKBw3GiCDGmeSmMMtzN5wuOhlQ=;
        b=TjFe+nTpOurx7YO7uNkxftOeJ07pHIv50713YGkkBUgxc02bnSdM2iJEviDQHNR1wp
         435Oy0rXcU7brbpngtQI2qJ7qNupJmo+1l9V2A3PZsLLnBNxpo/mbc4dkIqHcx+VNWtk
         39G+UBFfrm0crqP1dSck9KTBraw1DcP9D7lHCoEX+csiaRRE5xa30t8/z3zMhEJCGjjd
         wuOd+ZQG7/zwXTYti6N4T73zVcEqdkAzVb75Rhpkbh9FcmPY3hNKEKHjWAyuARdUZOpl
         sz7SLRi0gnZKtXTpZpgE2puGq8vvbtgnQ/SaeXoiPRpng7L8NyM2iBh9cQJBf1maw604
         z/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEr+d0FHfgkPB28KHk/0BFfhsByFYose4PfDdnq+CBslUwcX8cJgBXoLtYrn0jKhPk9eVa7hu2bB/m@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyBBcOUMjiuuynGvWvrXpiWwtc1suYtw/PTL/J+0DSjAu9Tu9
	5jZvMJzPioKIXo6BgmqQtIf7PuMTnlqBWS7J3EKfNwanl8uWAgTuNNo9nhyUtUs59czUOG4nCJN
	OiRhCp/5SHnUTCeyvUoq80UVusiFJLgeMRH0eF/L/32SCqfHkcC1+rgB/IZLHJqVU
X-Gm-Gg: AZuq6aJU04FMmulvknM3K01Z1LmhU2QfjYIoBCv5lBSdY8fyQTFlIGbXkBwqHyRSxad
	2UHAnpOPCA/nLsL9/lVHGwNufkI3sjQLEdgyJcCBV9mC78bQfdGNSvyvm5lYfPVeglH/s/+7E4Y
	zMRd0XZReJoEZu3M4N5FrFd1DGwuPla38hc4pX8Fj0nnOnWX5w7nUxB3r0EiJS6gJuZeSk3Ime2
	BEsTrrnls9Y68Z0ubn/2nry1au2H7d0qkiOynnowiikzzENinh5E3ZLS5CudnmuHwVmkg1EW6+l
	93hjO0WjYJ01gsvwMDyQJOaLFwJ7tlDXJIZI7c1dYA5bwkt+4q9v984jrwNU/1unc5GgC7xTqse
	0bA+JqUW/m2Yfz8fB5cFU0EJkPCG/8dXQ3yxjNNRuPXNPBhhD9iDh
X-Received: by 2002:a05:620a:25ca:b0:8cb:4de9:ead6 with SMTP id af79cd13be357-8cb8c9ce53amr927489585a.9.1771837580234;
        Mon, 23 Feb 2026 01:06:20 -0800 (PST)
X-Received: by 2002:a05:620a:25ca:b0:8cb:4de9:ead6 with SMTP id af79cd13be357-8cb8c9ce53amr927486185a.9.1771837579749;
        Mon, 23 Feb 2026 01:06:19 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:19 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:50 +0100
Subject: [PATCH v2 04/12] i2c: keba: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-4-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=820;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bo4ZGFeMtG75ouEjaDX91gsDwyQD1Njwy7cFmjSQfKY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBhz+YdThvO4PybZoN12qLIFqH/25wCqSXQIl
 /V5UhW8hg6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYcwAKCRAFnS7L/zaE
 w8dJD/0YvmWe+eKNQUwmdkOprYBJLDEghD/tlQF1HC9Xv+6macIkxtbWrcEVLcC1YJ243xE/5C+
 UIpmp60AWCZqWo+w8Sg8lYN5pAOQQcZm65CMDJpvWozdbA1EytRdrcBoInb8e5uTEavrrf29+Wf
 BVX9PajisY4sE5+0sNKu7exBqfC4HULGo41AauatIP0a+ri/I1Kd0apW/jZP8/2VNPB8v2TfyC+
 JKuYxaUJugMLl4OrdX0hqQz9FoJkmdkpvi+eFS6gitLpS4w4XgKAAt85A/zHy8yK4XW1+DfRusJ
 kAjfugD3rNjo9fL/VdbN5pIUwa0HuVuoAFa17emaUlWCoLXUjNs4FG8iimzHGSx07JZE6EKHYxr
 Sqo+fOHjBA/qRv5lJ93uO+uOpIOynNJj7UtaXzx6D1HtPbDeurHQZSQpbPDXbXjsRvfIln6LS0Q
 RmvC1uIZzDMq+Q60D2DATom3xFU5Eg3dtsF65sjpNoyjKr8LEO6s0KwDRniw76k3jrC9logTkXw
 UORxDy39plvEF6KofdTY5fmgKRZX7hIuQiEeDDI9bJ0TsF8t4Ht3KTcOIL3ZEl8otBABbO0qwRu
 aT9bzvxSM+EpZFt03OTbjKBxsEydh0rM2oV/4dJsfK1LN1m+UXvg7XcHdFmLZrABlXLvqlSi/9B
 2/ZzzTWFpvRviOQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: gtGqvUKQgvVRe4AWtixBehGgdBYZsdJB
X-Authority-Analysis: v=2.4 cv=cJftc1eN c=1 sm=1 tr=0 ts=699c188c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=op3mqaDViYxnCTu1ZhYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gtGqvUKQgvVRe4AWtixBehGgdBYZsdJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX/IFhO4Z5rBOX
 hoEaKKF4zCbOjmgBjWtpYZbkFxwnSH9437rMfoZ2kyHNLPlSv2K/Xv7xG9EURajMIH+SFo3WYBP
 ofEL1qtcD3SLh94URd0c8jiLqLm2zb/Hcw77OUMklb+/g/JJEn2ZAASEv45UcyuSAUArVhcV8Ic
 oXjlMpEKla9Cstq/3lr4sER0Egxi7ccmkuDoGgdbYX5NH8oOXStT/N/IU4NY8FTniOvX5WWk+xR
 twhoTyoNce8xsVscA3vkSnrJq1ZokCyKwG6VXUQ1GZETYr85Mie4S+JIV1eogJws8aYBZjdo1us
 4npjP9M2Np9qkvVcBkI1LGCifZfNYJLKw6BiI94tJS0f7FsEwj5NFONr17rgE2WW0Upkl2uwBV9
 R9Co//rT+sfaj+BhU4JB/LuoBi1kA0GO8n8MoteOsH1ytpbP5PBgQFKKDgGoJXij0HUwxVDmU4B
 BemYG2sQsDtxC9rnBcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230081

Configure the parent device using the dedicated field in struct
i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-keba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-keba.c b/drivers/i2c/busses/i2c-keba.c
index 9420c8b342b573da435eeef5a05efde35d61434d..01aa5dd9638dac38dd92500cc8890feb8020754c 100644
--- a/drivers/i2c/busses/i2c-keba.c
+++ b/drivers/i2c/busses/i2c-keba.c
@@ -532,7 +532,7 @@ static int ki2c_probe(struct auxiliary_device *auxdev,
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_HWMON;
 	adap->algo = &ki2c_algo;
-	adap->dev.parent = dev;
+	adap->parent = dev;
 
 	i2c_set_adapdata(adap, ki2c);
 

-- 
2.47.3

