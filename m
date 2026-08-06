Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910883909A2
	for <linux-omap@vger.kernel.org>; Thu,  6 Aug 2026 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999541; cv=none; b=RDc4R8Yja87bp7a45JV4+9WqXgvBu3otHV39mJSG92e1TS7s+r0KoAXwRTu8n6Q2AuSnfho6lLrdYbz9Hx4Q/UpnyeHLTHv4IA7YnAackIzOdPMSwl2mtN+Y1jKkG9iuVnglDBCy+RRloCzuCGpVI9Otyu/ZPfpLbOA5KiUnpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999541; c=relaxed/simple;
	bh=pHQwSKjpLEAMdLzZ9o3QSbfFDCwexHOfFq0kxCpbjr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR9gjrehwiaesscoSfeX+QXcI/Wr7dem1enQA8gESbqv/3C5VOBfriPwQJsxaSi5qRdDqDd91qM0t7RAaQXirkapNZbvceW2BRHUVuFGynReSFC01xvzxqGMyVo4+r2OmifB1rKCeIhmX0fzRHaol5QeIBAxsq/530koprGscsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFJqv8+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YTmPzBHC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFJqv8+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTmPzBHC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763wl3B775806
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2026 06:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oqtjzKqO0s4vfwuzjcjCXGjqdGQzIEGEvjz+ew4ipDE=; b=nFJqv8+MFJQf5za8
	P3gql0ZRWVn2m+LClM/2MQ/N4/m7+mlxIcnGIN7vjTrGcw2PrakoL9T4Or2cSOxW
	WvZClbxSMwro8dDuhJbdQaGwdCKzCeMqsfaUtZu3zxKO4jgMPoaK5wjsNpgY1WTm
	/Xb5M7C0GMw5Zksgx0JVQOrHupcMpH5cw84Rkn6vzkDevLFs8bzoaT9s949owxKq
	tHhCry5HATmJiU53av3WtYbZzRh/aGaklzVF7vvcgdcliQiP27nPa1SF4GG73OcC
	blgtMjjuRMu/MJkoJuufkPQ4uuCXa++VSZ+ZNHq+wOgog+9uShT9KQc/UWusooa3
	Nc640A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8gn6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2026 06:58:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so19526531cf.2
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2026 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785999539; x=1786604339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oqtjzKqO0s4vfwuzjcjCXGjqdGQzIEGEvjz+ew4ipDE=;
        b=YTmPzBHCrl6OO2PGkrJEu0lH5SvpHuxRbYAPFW6CcE5fAMHXUZW8fLeBjXYu0iXZ2N
         lv4IERRueUpkxLiVT0A0Zfk7MszDeICUoAHDmJC7AuiVR+AGv9sRnAlDkfbtiu79DVu2
         5GX2E/rE9vlwh0WIs51QTuNZVeanehb8nK4traTxLpQJabMk/QIjsf7p0wb8ojMCcd16
         xjKePgzg4P5Zm1kMhb56GW8+J9Ddd5KVMPynVSz1528IsHP6BkWp+/ykndHp1pwHz3iX
         fK1pPcclN5u1XYY2ZbSmgBfAwDamM9VZBQB1b+34MTcdSUQmCo8tYmqZY+vefi1MGXzP
         k1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999539; x=1786604339;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqtjzKqO0s4vfwuzjcjCXGjqdGQzIEGEvjz+ew4ipDE=;
        b=puULr4MfAvftcf/M9rorSN5F5BYUonv4xcbDHxlr6KDe4DxWM0VtS1e0SRmmPpP3/l
         1lkyLhlQi2Zg03iScijnZXedAFzWCb9h6iby+9o+2sz8oEeDXKjNoArU1+AaucZcom+5
         bDuvF3IMafFDzvNcwmC297xIOWhSjkf0/KIoG7z1+k2GGoi0MBqimCAuMsdxthvGzs8k
         m8Z3WOhVo/GxDjay17LFnHEGnzr1aFF+Mgh8GQVbn7hZGTHaH1hgWRsvrjXobcEgJX8u
         HsTEGmUGENUsCpxUYHTVsNDmzyGt3xl0Yu2WQeFbLOmRgOHE8YZyMRS8fey2eNh8UqvR
         c+Yg==
X-Forwarded-Encrypted: i=1; AHgh+RqKCFUQNC7u00WcPf6eTgB61iIaoeyaO98m54Rj76tvwGZd5NwwPNRcf6xi4WEy8zbNBqTZnuiXNEo7@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDwvUpySOtg6Fnihjqb3RO2DPtKcDyOHdlmIj9BxsBxvECNxx
	5GsHYVIT1ptGf2EyUGLTnzz8QMCb00NzrtAk5gg0b6ug2BPe/sBjBaDaKJQ1pQGytPUafkNQrdk
	1cxMVj3jCdn5vvi9hoER9QxM8x4NniUvfgc7eEEb88PEQ564rGeNQyx+senA/2l7+
X-Gm-Gg: AR+sD11VMRWkK1KRieKQG+SaPN/ZrbfMj9Cz0QeUF96/oAZbb7W13d9SIVcOPpnD4PL
	paOMWcGVoxe6St+znK7aZjQYJjqSssjDE+XuxDr09iRgWUJ8rLsPnd5LyuVa4SkRzgoZJOZq6Fl
	A0ACQH9SmldpESOmwS12aoU3ptMYF6Blq4YHL4vXJ4T8S75I7UZjxw6PH0qr4l2KnAiRr/8avO1
	EuCApNffUVj8T/Z4htsZYi4S/9Xjao9D0nU0Bh8QJevlZqetb0r9kgpZS/dzq1I4KNn4wSjvAy0
	dqbKl0z8q/TCHAcqfHuUjnZD7XjM+6cBMNlfrpa/FOBBvfDOUw4objtkt7o6/mYukLvRSty9J3s
	XqvsfbISg+UW7Eq6EipGsRD4ku79M8Q==
X-Received: by 2002:a05:622a:614:b0:528:3b9b:4f55 with SMTP id d75a77b69052e-52ce5f619f8mr121059461cf.6.1785999538780;
        Wed, 05 Aug 2026 23:58:58 -0700 (PDT)
X-Received: by 2002:a05:622a:614:b0:528:3b9b:4f55 with SMTP id d75a77b69052e-52ce5f619f8mr121058941cf.6.1785999538214;
        Wed, 05 Aug 2026 23:58:58 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a718bsm4195513f8f.5.2026.08.05.23.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 23:58:56 -0700 (PDT)
Message-ID: <dd1ed327-d7ac-472d-8dd5-6c2b8d892326@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ARM: dts: ti: Correct white-space style
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260805143315.cophjbfukfjlnbpz@hesitant>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805143315.cophjbfukfjlnbpz@hesitant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vHoSXaCqToWLXWxZdwORbw3V8yahD_iI
X-Proofpoint-ORIG-GUID: vHoSXaCqToWLXWxZdwORbw3V8yahD_iI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX2YU3MA20Yh3W
 yNpW2y5NfLpKdQXPDxCGxZWXRgxhi0q8iLXRv/0OLcaFdzDjSSeOExlNSor6EdHgux/RpXtIcUw
 1KuXzaBSq1Mptmr8dFgoiqBnLN4R1YhfPtMUJAgV3B5ILqc9WNfasukjGgsNxfBFl6sA8nGMnDc
 3wqAp+Hu64ZOmxA3pFcfH2lD4NE+ghuiBku6UA6hfn9a6cPoWGhAg5xYzzjzqMZ+dWa6KQg9AXe
 R26x+1QduI3jP1bjShbdv/7LA8lN+g2AOy1L+XywzPzvjK7sj49sCUJBg3PhmvbXgtLWIEa0Jg+
 avp4XnZZ6QMOBRnU18zAp/W2jNWt9i6Thu9rP9s//Pvf5+v2tGmGRh9AMZ3JwoXaS5yTcI9623F
 3YEFm6pQ94P+WlXNW7xY1tO1NMSR4A9vIHNb8t36LzszuwxwawLCgSKfL3/Pf8aY4vD7YZ7wRHF
 68gGMRXnIRZU+VAgBAw==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a7430b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ePTH1f0eZLyOlSlLpuUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX2eN5PqAVs+N9
 toYURA8kLDCnvKMw/Vqrk6TuQnu6aeIogsmlL+AcfS6+0VVAETLJdqZ8t9M72uvk/3q80JaUFZr
 20yhSjBHG2QCEDSFQd9YG+iRSjhKtUc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060052

On 05/08/2026 16:33, Nishanth Menon wrote:
> On 08:19-20260803, Krzysztof Kozlowski wrote:
>> Correct a few white-space issues, like missing space before bracket '{'
>> character or spurious space, which will be flagged by dt-check-style
>> ("redundant-whitespace" warning).  No functional changes.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> Changes in v2:
>> 1. Missing space for serial@2531000 in keystone.dtsi
>> ---
>>  arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi             | 2 +-
>>  arch/arm/boot/dts/ti/keystone/keystone.dtsi                 | 2 +-
>>  arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi        | 2 +-
>>  arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                    | 2 +-
>>  .../arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 6 +++---
>>  arch/arm/boot/dts/ti/omap/omap4.dtsi                        | 2 +-
>>  arch/arm/boot/dts/ti/omap/omap5.dtsi                        | 2 +-
> 
> Goes to Kevin and me - Do you mind to split the keystone part out probably
> for the next window since kevin seems to have send his PR and I just
> finished my tags?

Sure, I'll split it.

Best regards,
Krzysztof
