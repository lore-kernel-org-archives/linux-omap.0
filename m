Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DD41F7FB
	for <linux-omap@vger.kernel.org>; Mon,  6 Jul 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328652; cv=none; b=VqnyFHudVZglp5cGu5ZH1S9Q+guL/6fdO4BFbuesuVtHMcXgvHNQCnjCXZeK3vNF2zC4U9ORuMP49JWTlw+V0/alx7tGnk2+6OJA/K5fkq/7XWyuCoKV1/10PSBI1rSNTz6n2IVfxNadcvt6iCY2NdFhsS/w2PbGt+PHMqTYIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328652; c=relaxed/simple;
	bh=sT5lFMV2RMY7vRSqwJD1AOKYGSl09riOc3ychpQZt8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbfBCs/AtPIL8VfoH4hpM3/tn7N14EGWU2IA6deHtNWmFhA9OL542kciT7vK2WInojxhUeQwyYMvovxE8U0jsNW/jRtP1znpDpJQShEos20Jb3f5j0UHxiTqzYLB1N/3PA81UaNbJ3S2hlEpu40RxwpBu2zqqnwjbLMyl0N/2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XA45LfBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X8Fq71hh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XA45LfBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8Fq71hh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693uNx4151598
	for <linux-omap@vger.kernel.org>; Mon, 6 Jul 2026 09:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=; b=XA45LfBC53IPO1K7
	vk/+zV3d8feWJ1hpXmoeKJsxQFmqxpLiwsdiWbAOhefJ/eH6s7dlAM+z/T1dGY8O
	BthVqwvMSC/GRRxTyzyPYI3p4c8S28gvs34IZebYYK0Gb8In+tijNGSbDvvF0yWw
	AU4XfH6UC4ZUIQM/s5sgxknyqaPUrlCdbqahTiktg66o6715FBVfFaU3Jl9JyFee
	XoAjt71tkfe7x93BJXL1W43STyEjy6/O81d78M8fuKS5jGi/5kTLQ2EH4WIO50x7
	Xmgz/6f40zv2j/ZM2D7oqsYc13iyBIXVMcnbgRxdXEtOYZQzbm9RIFgffowZFvLT
	i/yKeQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs88ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 06 Jul 2026 09:04:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d30035dso22939961cf.2
        for <linux-omap@vger.kernel.org>; Mon, 06 Jul 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328643; x=1783933443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=;
        b=X8Fq71hhwPZ/i0wzqV/6+OoXGSxOIPuqmrq3NC9AjtF75JMxl2Rtsqo2UVjhXz1W7U
         4dc9hdrqjod+bdjVgNSdgSKt6SGsSfXc5r++Lx7fbqxHP0ylEe+CFe3Xo5xt3MTchhrm
         FaDVtuuj9e35cjF+L+jMlwoo4oTcvAHIrN3mL9FLE3PWY2Nw8NM/S8a3SmOuKe2KxmeO
         5g8GJzZdPfuIUUQOmMFu3GhA+D6saXyxv5fXJB1XPsGdbkGeNx6IWfMX+18K72VKN6kL
         1MpwFVsxwubD+/uXDzWiRHbsRjVVa/tyDV6tD2VNhdCobvXS69e2li8Yeuxag8+fdGYP
         J7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328643; x=1783933443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7g2NlMcR+OJ0pQlyVRLd2L2YHSIMDkKMc5JLil2y3U=;
        b=GMbcylced0g/Ek2LDiHC4ynxCG+8WCAdV2WHWYChb1IcL0mxvki5pyN9/e7pvDX8Sw
         oGN3bxcdS5yFcPMZUsuOHK7em5cr3qpV3kildProDyyhduH4LN0WPKtkYL8adlg9v2YM
         qBjzTVPF8y9EfnuVVtoF0/8ixvs1acaupyn6vkPKnwINTaT5hAE0XiWP8vaIVQ5HsVkE
         QzT4YX9aTCHtJ7mNCgXXwFdU7TO8PBvkPt5mwUeCJ3PmAd7166RFWhaE+94/TVNnvhtf
         uAwSFfvQw5EuZ27MCBUdsxGEMJahB2CjUQ+Q2o13/bsJvRcdRYxaMevtRsQ7d2ixgHFO
         gDNA==
X-Forwarded-Encrypted: i=1; AHgh+RqfOQ2ejElSDzQ5NGCV+YDYhxGgrr9PV4K9YXf/koma5zFiAixLG4wwgS19nR1s3KcyfA+9dqxIsIbl@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj1HIMeT8CmFvOaAbMSSDnkDin27AL+C+WxifjajSYpyRshN4
	uAiRWBJrKYpjkhoTTa/wBid1UFUlJB5U6r+zNqQPF+BYYRiVO+eIn00EE65/Ld8k6/JJW3wLvUK
	XYNxwhvn05bkjPXxbFM8+zuTZhSvXKNRzIMs7DprfUSANkXf9jwY4mD6R6FaUKxJw
X-Gm-Gg: AfdE7cndvQIG/3CgKo5GzYeJk4pDadtCxOBouj9LRqNdaN/dKHUrA4ry/akFzzDqfQK
	T+OvMkPqgl+hryFvKo2hpjmjzr2wUvU6ea2esQG4/viMRNKv7x7mx+JnaRRVXa8UdCxyU5JKhhP
	cWTHEpL6lxn97nKjojlgit+c8mOpINy8qRsn7W9UNEkgHQ1pWOWL2Fqm6BXAnU5WHgQGVA9ngfz
	4r7CWA2MoJHTMttDTIwVe0BHM8IVehQKo+ML7Fsnh3CPpMkMuqZKPLiszEkjb7r/uOvX9doESdc
	7mYNi1TfL075UZl0f2MknFBs9GIGf5uCfiSd//hNQihYBrnPZFX8Kp+q/pWlFIHMhxsA9ru6N99
	I7tB2K6eJtrVVRwXWF2k8TDEwlxg2fP6s2n/k9Bs=
X-Received: by 2002:a05:622a:180c:b0:51c:f3:34de with SMTP id d75a77b69052e-51c4c21a5c9mr124047591cf.20.1783328643228;
        Mon, 06 Jul 2026 02:04:03 -0700 (PDT)
X-Received: by 2002:a05:622a:180c:b0:51c:f3:34de with SMTP id d75a77b69052e-51c4c21a5c9mr124047341cf.20.1783328642807;
        Mon, 06 Jul 2026 02:04:02 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636ea60sm315243765e9.3.2026.07.06.02.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:04:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, stable@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] gpios: palmas: add get_direction op
Date: Mon,  6 Jul 2026 11:04:00 +0200
Message-ID: <178332863765.18977.12844804130835773641.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704-palmas-getdirection-v2-1-2fd85fee3832@kemnade.info>
References: <20260704-palmas-getdirection-v2-1-2fd85fee3832@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c8Wwi0tkTOGwGgsh9g-sn022QQB_IyYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX5CX06AAYn+XC
 gnrnr2HB8IN+VcexETB/CT0rbyYnYCoupoBktTYPwhojTa775O5WILXe+MCWA8UrtYfb702cFJl
 vKECXvCCBVJ6iJYQponobAtpsswWEV/iyvjvguWdefwjpYEeNMJHpWzB96PAL6yiuAkITbAmkAA
 rrcueime7UaN8iAGQM8DFaJ979nXAjGAjQuGcloqfNZc+/6y3kUdOFYgFdDkInsLsJ5mC0Tbs1c
 R/Jxs9qbkrNQio1D3Ooyk1BraVVqfTfxNsTb+iREfdJzXwodkSFL8Q+8j/iqyXSv+ERi41gKI+4
 rx6VHaXUt3taqRVe27olvc1nalce1KFLXEx6ZQSX6eAP6zzkqWerpswo7WRSvPGeAbVrTok0W2M
 WZ4GhX+wc++OG4Q305I8mEA0XDdKQXdyTnup3EDabl7Mwvam9wB48rDuJXqlJ9+0oPIGMnN8UM6
 RGaw5EUa2sNg26dXgyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5MSBTYWx0ZWRfX2wS3qfVACxoJ
 a+HQUsbHYjaXGU0EVOb9itsEvumgIIebvcTcTrP1Fq/1z5N/fHa4pkS96VFMc+AMb0gmJetOUnD
 re3X1PNxXUDmehpe6CfueDogz0VsFjk=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b6f84 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Xj82jd3BsPfj_FevrHIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: c8Wwi0tkTOGwGgsh9g-sn022QQB_IyYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060091


On Sat, 04 Jul 2026 10:40:54 +0200, Andreas Kemnade wrote:
> Accessing debug/gpio is quite noisy without a get_direction()
> implementation.  To calm that down add an implementation.
> 
> 

Applied, thanks!

[1/1] gpios: palmas: add get_direction op
      https://git.kernel.org/brgl/c/0c001f9c0d96cbb533559cfa6177a1daea89a21d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
