Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524427;
	b=MVThRedDyjJjrYG7hN/WYjlw4sm/nrxXPe69EF9a/R0zzREAgn2zJ61kivdKNDjL3DSz
	 v4o1jbHv4eR8HBCpMW/Dmn9CWcL3FFmMU1jkiqzzsYGH6waY9Dx48KfTIiLpba8czNwEK
	 a3mYzNYz9+Yxt2d31mXweGNsuPvczMUe6o3ywlyekE9rbP6XdLs3bBWeIzkJFgDo1nEo5
	 EhnUsXHbQf+KfdosWag44j1+NuqHgChSOkes6gtSfIOAVWmHWANjBLiUymF/ghdwVlnID
	 RuX7SrZyG2vw+wnJA9CX4/WlbLn70rSwLCck4ZvraXLuryKHeoj4C4rEy9cMI/qTD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524427;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jIX6CwEmiY8bIqori/Wd0NcOM3IICfbWLQzxsrQ6HbU=;
	b=A68S44sr79uOG68vhxia/pVdH3YDGVCEo6IUnuGkPx/ziv1MZyyScl2PRSwlu27c5BE5
	 ttxOvFozvCbnj15PyDcP0I7QZkWvVKuI6zOPYWiI4Lsu1U5FoN043Lws5Fyx5yZmFlQ/L
	 HjfWv9Eremsz2UZ8bjZyoizze2XzMGypLErjLiaILDnsifhBwt3sndI9WQtvX0voHj4fZ
	 W37OHvFhlZx2+Y4mVbc0qNWB6gcrh3g4Ck6ZXpxhA/uhnajzMUwP7F+ltEL4duXhRBBNj
	 /nCbFdFFTcUFS4RNzDsFG0F3qxOzVoLwbvtHRsWbKUWfuIsFhCWPyEHwP0UQZKjg1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ncGW22fl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="BAoZjBP/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E9606A32E
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 12:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC2E9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ncGW22fl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAoZjBP/
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAubw41991576
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 12:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jIX6CwEmiY8bIqori/Wd0NcOM3IICfbWLQzxsrQ6HbU=; b=ncGW22flIvYi3iND
	XCdk/DamqlPZO/Fqvz/S6CM+w3yvN85x3dRM3Gg8gzmIIxceeMVhSOPNAnN/Ped/
	bqzI2Q5VXPaMVb0ouTgaPxclk9vX5Nh74tadL/wO8Hl19cWiyqQ2Hwn8KchyvDHa
	WfZo9eW4q1F1bvobBac21KEmJvXq88796LCbM7Uixbv9bcHBhtr3FXSw/l7+jBny
	Yq219w1LVPCIUIFyXapFABG03JZUdEGTYostCo/ixykLoUuxc15Om9qda4RXvaAb
	CwUcVtYHN7ssxyZoZTcagQKxCXvf2Yg8BHeGdsbrTPU8VVqy0HUmq2yOkGT7pR/G
	5azjhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6suauf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 12:47:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94961511b61so754851485a.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795524424; x=1796129224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIX6CwEmiY8bIqori/Wd0NcOM3IICfbWLQzxsrQ6HbU=;
        b=BAoZjBP/RMU+ou9+0QjUrmNnHGhetrtF9eiqAtd+nLY74d9z+XivP6DYm40bEVVcyX
         frYk0ZSZ/MQTi6u32xlNBjMS4IW7afAOXy5k6tVDE94TmpDyTe6Du0zVQ7VdnugcL5q5
         2Ojia+5PsRGJCDBpGQHwA206G067w6/TvEIdvIwsDGVT2PwpRjOexLmQwrjYgLMfwwDj
         1QPygs9vAxYoQwfgXPAJfM4bCpT8YNuoJkDlds/OTvBMIB0dtR0ulFeAtGN0nuaicZD9
         m1r1PC+ZNTjVmYruUlEo8ErObsrrJxGvJppVRki/ybghp1PjDE/XQaLp93R749bEU5lJ
         SZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795524424; x=1796129224;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIX6CwEmiY8bIqori/Wd0NcOM3IICfbWLQzxsrQ6HbU=;
        b=ZxgGFP8Mee4tzNChPZh4xsR7Vhzv/RbZw366QUNBQRe9AmdxGSL04rwePtJ1XZ6vr2
         E6xorml+H23Dt8WBtD270tPfpOJAZSnLMuurLNnsfaeDNM7NgdTS9vK3ViSGp19isu7U
         M+6hAkYdVHkKJJW1YlEv5pt1y31vTx8zXtsQQzkm2RmRVat5zgqke1s5HYtQEDf0Unkq
         BLwmKnGxr8g4D3NJMtpmOcoWRg+cE/QMewW2hwLck2n+ePqpvddgpy7/L6hjTJaecg1M
         P5DY6cqLAWYdGzZU2bSqQoPWj1GqGm5k4gptg3ob3buV4IGoZWiRk0lUy8h3TqcKiDnQ
         JEFQ==
X-Forwarded-Encrypted: i=1; AL+hErEeJwLXEZFVpvzLyQVRc1d7vYZc51YXpKkPqRU70OQ5zrAxcyOiOzkAA3+E9WfRbKokxpLgBdsfjXId@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mwp5e6tcHz97QxdjCSowWKp9G979+jLw56e4apo5Y+ZGkVcSG
	fV/NjJo+88FroDq/cPP2M1e/qw2J7fUtvF0O7uQlr1/qbLCWBaGmPWPnyqOrCMqgRDCdcCZroy6
	SsMbNKmhKxVrW3ocN8d6jJAQyU1i5vu3BdHK0a44rLLfKrGcqlDZLYl1tAIO2IprX
X-Gm-Gg: AZFdTZdpePZ5tak2APlteifXI47jyzCDqeiXWNXDAK3MAEa062oE2ohx1SxFToTWTzT
	6zNHSrwGh4ze9+ppvqMTDIn4u66kOta/qxgUjNVEiQ9cE0qyvezcDIYIp/QEOCIPrTogOlWRU7/
	8Nh2kSMOPoxvchfXkzw7wG832N/sKJ1bVlk2+bWrxAfWftcQsxMmYoOb8VIgk3aoXD3lT2MBzWG
	KzILi34yJbR/UaQ7KrD0RQAenNKhcXoBKea5KE9ujc0WWC6ijd0K/yxY/ix9Cz+lfPw/ssbuwy/
	j0AbPjcvHldRcjuB9qdnV4l+a6KaQQEJmn7M9gsIK7MDfgDPS9TNOJ7CpAZY+iZvZS1MlXectA+
	gq1Ndphw7TqVamxUm9CBJQg6eCPFqRPjC0ybWel9b6RwqYqvl+yAwy+pN8pnrvRYmqd4S4AVGy5
	NNAE1NbnotCh53YTMwmC2VTmLC38RpDDKPyQ/BFlrBCn6vPuWjPkrW5D7KzYGd2Q==
X-Received: by 2002:a05:620a:8081:b0:93b:d7a3:45cf with SMTP id af79cd13be357-949ba9e882fmr2401290585a.56.1795524424118;
        Tue, 24 Nov 2026 04:47:04 -0800 (PST)
X-Received: by 2002:a05:620a:8081:b0:93b:d7a3:45cf with SMTP id af79cd13be357-949ba9e882fmr2401287085a.56.1795524423707;
        Tue, 24 Nov 2026 04:47:03 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm162284495e9.4.2026.11.24.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:47:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Cong Nguyen <congnt264@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Jiawen Liu <1298662399@qq.com>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: do not unprepare the debounce clock twice on probe failure
Date: Tue, 24 Nov 2026 13:47:00 +0100
Message-ID: <179552439935.17414.3815780367440771141.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124085231.3696739-1-congnt264@gmail.com>
References: <20261124085231.3696739-1-congnt264@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gn9OuvvLPqfxrEzeNIwE6pGq7_YRBneL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfXwSycN9reGsG/
 LiMUjC6pcWgCwE2Qs1TIeZzzIsY4R3NTF73jRidK/FOPrjL2S9D2SRwcgELs5AFNszM/lNAHuzP
 OvxKZB9qJvVa4f5R3U6PQOGDDkHv2PQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfXz9pj3C4qLcOT
 XGDxXXfvyZdzR9WkAouIfoQaeb+xveKwnvT/jQZb6kbpLFYv1vcttpn5/DVlVotNjt8t4vgQupw
 hfLBYNH5p6iFgA/YMN3x4ENRUzkANTno/keSWvtaqfbukBKoMwlSPD7b22up1umbws8iwaXIUiY
 gFIX4fQvCiBrDwiac/kF1KlcGNWUL+XpyRAmVRDrfXxEx71EY3D4wT4TSYtQGlfyF8dfuL1Q0VB
 wZ4w9B/+bFVhQyZW/6ui0hcVSIn/onfvId4tu7Gt4yFN3/Z+bG4zDzVJqRZHqHmLhPz3UIO6u8W
 cBiQU9kBrV+NdpuhZlPfJHzlz37OFPkuDNjSPkZToVQj0PwNXshwd7Ccp5cnE9rbgGfMcRfwbFn
 DBzud+dxJPYL8uPDq4KEhLYSl7ieOjVwbRT4NPx+Mhiz3o4/od1pXPB3K278vyXvPzOFnfL869h
 Hv7ULF7CVmnqxJIp8cg==
X-Proofpoint-ORIG-GUID: Gn9OuvvLPqfxrEzeNIwE6pGq7_YRBneL
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b058749 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lcnA47O0JUuAoBXSFRsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240049


On Tue, 24 Nov 2026 15:52:31 +0700, Cong Nguyen wrote:
> The debounce clock is now obtained with devm_clk_get_prepared(), so
> devres unprepares it when probe fails or the device is unbound. The error
> path added for a failing pm_runtime_resume_and_get() still calls
> clk_unprepare() on the same clock by hand.
> 
> When pm_runtime_resume_and_get() fails and a debounce clock is present,
> the clock is unprepared twice. The second clk_unprepare() warns that the
> clock is already unprepared.
> 
> [...]

Applied, thanks!

[1/1] gpio: omap: do not unprepare the debounce clock twice on probe failure
      https://git.kernel.org/brgl/c/b43f14590a30eeefd64e1db85f08f9ecea1821d8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
