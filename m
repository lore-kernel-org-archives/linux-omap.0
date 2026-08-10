Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701A3BD65A
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359346; cv=none; b=MlFxrbDZoQo5f6Py8oesFavca6Pyx3e0vaGvTI5J3vUpGcCYG5JF1PrJvKvkKwckm6apUJ3I5d4Xnc4E7prVvEp2rz4vVdA7eGBBskaF76sV0p1AnOZ0PWyZGX4BIPJlpVcFKta4BxosDrg7NQr/fI51nbLYKUZqGwVn+7Uyj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359346; c=relaxed/simple;
	bh=fo5m4AkjKizHv6hKu7rjm3nm7ZDsLovNU+f7ayOVr0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br6Ltk/edWLuElsKvJ6No0hXcad6CxHZJ+NXT3N9i3FEvU8TFAB3rJWh2x29VaW/78f6cYCU4f1IhsGc+1WKvdshuFvFpjijXLJ6p3F5DXjJFLN4ERLhPEhXJEcY0WGccmS/gqbBAk2o7hmsDG1ddBgBPFLANPp+MPjW1fUTd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AgdRiibe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aOu2Y/K4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgdRiibe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aOu2Y/K4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9SPBM890724
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2026 10:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJ24BqAEJPwzbl6qff074FZZsCu3Ipow58eas1iNjro=; b=AgdRiiberGOg55TN
	bPt69zq6B8zegVZPLUoLLcCMzJ11uypxFljHA/ObNfcKDg12Duhm7J9DINSktu2W
	QoQIRENx/PSgRcfz3+pxdTRVYEcR+uS9FmAFaTcbrV12TIqTL9UoiZRst8CvpPXV
	bxT+MvmHJZ/voLcXoVboAxLUV9mL1ybQPKC4mW2l/DBC5W25ht++Z7dRhC7xxHgn
	Ao+t1DEZ5k7G8o8Vc6TE5Z4PZSVU63bF+U9WoR500KWpbVWFEKe03muGCEg9jhgt
	Kq3nNrkrBV7ufy08V4RDFUnxi9wZU/KokRbLiP1HqNrjrSRmU7SiF8W6itZamYun
	xJcfsw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v493u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2026 10:55:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso30624691cf.3
        for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2026 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786359343; x=1786964143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJ24BqAEJPwzbl6qff074FZZsCu3Ipow58eas1iNjro=;
        b=aOu2Y/K4uzuGw5b315EMNkMd+R+i+9pLkm+4zOkLS4+KK6DlDlOHF0TeTABgOkU9RX
         HWbN3uSGUaompsSxE23eS6hee/8gXHKOLv5rd1KiONk1lrA1uRwTiyOtuXhkLO+Wv/CL
         bO5pIUNtAmhPMmJgEbTLbviRGlxbzUlJlHLO4Ew7bA83mORrC/XAc4maO1t6uf73hvJY
         FR1sDfHqUiZnfaryWL/DujPtfsmTr/xNRUHPHNYUTe/dzvOL6NmlqS20Rv2X4BYbi6KO
         0CUGdLhvrAcfBfBxFz14vpM/zp+jzwRCghBId+WBbwVWuP6QAW0zim/kpWM8LYwz3cGu
         pgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786359343; x=1786964143;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJ24BqAEJPwzbl6qff074FZZsCu3Ipow58eas1iNjro=;
        b=AYg4+raUm4hPuMbNXO3flelR3Mq+XXRGG511ODO/m3xb5HWswVyYAXgMdnDmUuf+aW
         QTJKBSjRsLBVJI49H1Cc9DQjg3r9d4n6m3YnzIPAsraxbYYxiuzlrLAHu9WGdSVqikNM
         JR2/u3gJyTNDYCMlnU+59H1Ot3x2PNc3nw4V3UnEXTJF7Ow3tDVHykGJkksPqKCH3eun
         TNOFQQzH1Xn64njmUsYLaIs9zO5pIU9t8Ip6IflH7n4DR+EFZkEKT15UcPMU4oOBL4p7
         asdcGBFn5jnELH9cwfpQLc5NOgJnCarvxDlFGsQxpTQcxJ8gj9eAQSYN7mrwl87zdCl6
         ma3g==
X-Forwarded-Encrypted: i=1; AHgh+RoZHWXlbreM6hPLOk3y4MrSDqf/7pKSq8YBMvYFPLQwYbJm175lwCRWhQNqT7zeM7CMjD+rf/7zUHy9@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpPEf3fOOCtW8QgiO/eq2deiy84to7sBcYUxBWhevSOu4Qo35
	rN6OImvA4usHNwv3Q/SRGsZ4BWrSHmrz42zEgQlWgNws6wpCvMwQEJVU1Q5Q2UegtGKo4E7EfU2
	ca0zoB/4diNuMeXskXxJvv9FfBJbZflaFuXfQrqaZxpEYrrhBunJrAScpzOaH4aAE
X-Gm-Gg: AR+sD10A17qHMuwpMdpFZWrWTTnn8tFqR4ANgc/LdDLFWmi05/PXvLWXKprVGMQgx/o
	Lmxa5LWKhuSbCXC/lMS8KWHS+c/XyUT/XBSMglw9vgEErDAhoMZKXdjmDyPWjdvAw5Fqzl/ZPFe
	N2Fg9w6f3h4PRqmOyVayEbqtnmy12arL4nhZIQdef3DkokNfqmznEwEF97qu7edNOsjfyafva7n
	3jqvplqx/v1I7UAnS45P8D1AEOmv6+8uJHLT74MjA+NQth/BIMWUZo+dZDpJ8Pu2ugUxydtGEvS
	hSSFNzX93WlYSWWeBG4vZz47Y0A9HO27PrzFL433HG0Ji4VN0hbj1QshViGOvwg60xVbIiwrAvq
	ptzGfMKa92GCGGlXKr/Cgpb4Lg/NP
X-Received: by 2002:a05:622a:17c4:b0:51c:1fa1:80da with SMTP id d75a77b69052e-52d0b298380mr320953871cf.40.1786359343494;
        Mon, 10 Aug 2026 03:55:43 -0700 (PDT)
X-Received: by 2002:a05:622a:17c4:b0:51c:1fa1:80da with SMTP id d75a77b69052e-52d0b298380mr320953581cf.40.1786359343166;
        Mon, 10 Aug 2026 03:55:43 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfa2:33ac:2282:82ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdbe02esm196322575e9.1.2026.08.10.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:55:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Keerthy <j-keerthy@ti.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
        linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] gpio: Use IRQ trigger mask helpers
Date: Mon, 10 Aug 2026 12:55:39 +0200
Message-ID: <178635933666.24478.15558797954868182509.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802-b4b4-irq-trigger-mask-gpio-v1-1-948973636c84@oss.qualcomm.com>
References: <20260802-b4b4-irq-trigger-mask-gpio-v1-1-948973636c84@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E-uFa7svWJQdEUjkdVt6XJpmMtP3VKDs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5NSBTYWx0ZWRfX0YSs4Lu2Cjod
 PzOSrQ2Ewl0XuH4EEorKNgqjXXryImDzk36k3hmbqtWtIq8Mcjfb1ZE4l5SDPGbCCS4by+aWDC+
 AvPOCG9HpxnFzvBrqiGeHX6lX3d+wK4=
X-Authority-Analysis: v=2.4 cv=W5EIkxWk c=1 sm=1 tr=0 ts=6a79ae2f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qRw7KHR_QVJorHy5iXwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5NSBTYWx0ZWRfX9lGGYRSTvDKl
 vmYR7JMkzGSZie5PX6TIwM80wu3KozmikdLjL4EyXPI45MVulWuWLHEOKz2x/iZPe5f5fyza005
 is0pKWmOqAcD69Nyq2J87xFC7/X/6VjIe5mUwfK1gSGTHnJhjDC9iswcgBbZZpB02inxN22GxZ6
 DgsbGihjbmIJNoG3T0fgvq7iN55DuSDUCmGg5jIEFjfc6NgSUIjONzHV2SokRXlqdMmEqMcAcr4
 UGpT8M87QOkvjOldG7gdBIUR0tqo8jAStyic2mkC4xcioaePGtQlaDv00u2hWTSirtvwkCg99zX
 Y7qaz7ZFNFKUibYP7ngeZmiu2s/7YGYLm/cPYfrwJC16lo96o69m5Itmv0YKF+WWWxn3xwK2jlJ
 3nRtCcw2DlnsD2eC125xM3l+eLVLSVekQMb6Mf3GNRDpMV81ctihAGZQutCKcMm4EtYdlAXpEpd
 MSttTGTLNWCnbV3WAug==
X-Proofpoint-GUID: E-uFa7svWJQdEUjkdVt6XJpmMtP3VKDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100095


On Sun, 02 Aug 2026 19:40:35 +0530, Maulik Shah wrote:
> Use IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH instead of open-coded
> trigger type combinations in irqchip callbacks.
> 
> No functional change intended.
> 
> 

Applied, thanks!

[1/1] gpio: Use IRQ trigger mask helpers
      https://git.kernel.org/brgl/c/338c551bcd62ff4f97ff02359baf9d6f7f1f9fda

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
