Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB03AD50E
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221141; cv=none; b=dSddz/i+UvmqR8j+yrcR2XMSdMXWRdcMoINbhGi28iGVkuJUCq/gfApcwcxepWfTham93JcOOGVFJWJc6XPn2Yv3It7LGrJm/kYmigfN8ibC10BPxjw6LrUe4jflt2kkn61j4bpalyZHrI+eonpyJ42gwa4786FDuSOskgbRmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221141; c=relaxed/simple;
	bh=ZPVU5JAD0G3zNAsMm3ugfHbvrIMcX5y6iChfTSPxP6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buSC1MBeOl/7khHLSK+/C8kGDeCUBCzo8PjTJOiunATtCXqmeU88lNoYx9Ncjm2jXkpb7v12HZcrB88EO68bB28AQ00zHRBODR4Iy9nIjSukGXsZyP7hAdsZA9ogUg3o48QZg3IX5LjvfecjiUabYftXyWtSt7QfrG/hV1jXh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLSywdr0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kO+sMz3U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLSywdr0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kO+sMz3U"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEwdKM1739337
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 20:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3wfY7LM2bRMSFj1p4TlavvDgvQbeZ9zhLH3qVDU1zzs=; b=iLSywdr0hkYvxXhK
	LghFUhVZFuSySY4BIXmU2wLbrT9N85rbxMuyzpixIE/ZjJbn3ny1cFQBHtMF1hMZ
	ODYqrzn7eZmTjqOLr4lYLIeCb3ed1baBijcgBxpUNmfgDxWbQ2eKo9rUr2PCDMRK
	78XhJGi8K9jVCPZRRgMA4f+nO1+JC5lwSKhDAUg6rGkkJizu7zzoYlNGHbmBZhfq
	zsU5dnq4nZBn6q++XUPzSiiK5bHplXrcWjDqV8W1eloq8/8EVOWVOPpHKg80AREj
	BfvtbUCWcgVopvoGFYg5JJXULo2M5tym8nsaWcF4MS0gvWT7ucu3ZakPivsxb6UD
	SAn2Uw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3q98yq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 20:05:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5752402f55aso3410441e0c.2
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779221139; x=1779825939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3wfY7LM2bRMSFj1p4TlavvDgvQbeZ9zhLH3qVDU1zzs=;
        b=kO+sMz3UpayelTTeLL3XXrtI+/T+UIC5DNjLvE0EjVwFiKsSeIgScllWBIRvWYKwpu
         tqeR1QlBKTDRFyJ3wXv79/22+cc2g3CyGEkXHojNMTLte9BTVZjEbtXJTU/0RR/uxqhU
         GLO0CJsXAXFmyTrxBpkahrsnLSYIlvkNGCgcmjxkLg/hVMu+YOj7OkCK3BbUW7r1w5Z1
         Cuf4xp72Rgfcu4rpMv9qUxT6CPQjoRMxvRtP1AsUeQpdmCULOwy1TUnkkjtqk6UDeJHM
         5pC/bmYaPBE8LjUnSDm37dYrSfgU+04FwRPwOf+6yoz0L1oLUseOkF1WyPawR95C9tHT
         rQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221139; x=1779825939;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wfY7LM2bRMSFj1p4TlavvDgvQbeZ9zhLH3qVDU1zzs=;
        b=ZM701M0i+RjhOOhWUeqPnn+WBEqhmev/NJce6UZ9CTlYoI0N5+wmtGeKc4AobbqDAy
         uC7QxevCyyudOkYFpkl8FS4q6VA9TqOyCHaboiSGKOxezBkOTpWnGmobqAQwi+O10wnE
         uPuSE0m0jTk/LlWho6v1zYDL/NPoDtmh60SRSShJbWHmvtiZQLnJuJGn7Ae0DwjbmJOW
         zooGeI9XQPbM+4etZqAfN6qenjSOyMXIvt0ACoK6bZMJY58nzA8qgmIq+jB8iEwzbMjO
         e7TxzlCPR1Comv2cTFtyIli/tZ5nDWdORu8RySZNUEVG2Fw/6rW0fbdlcTaWxf51wZBl
         LdBg==
X-Forwarded-Encrypted: i=1; AFNElJ9gmJY97hNV09jPK2zfNve/AAl+VeUe1WklkrhZLPm+WFNOCoAVsiuYXSHdMuIgIAR2A8QwJo22zFZC@vger.kernel.org
X-Gm-Message-State: AOJu0YzdT5uEy2NFopPU7XFQlzCdjWNA812bmxHHXLTySCH37sDezPnv
	YuB8tYPddMe5gIbCWVeHMvUZ/9hL/GDm7tyuu3T9/0pitTPI5y+iAM51ZDHmGBqyAkJMCyLbvw3
	AI92PLRLKZeCNnRL/rpnkl/JhJvXhFtrRmjulCiSdHp8+kpOR1llOgBW1/fVU3uZK
X-Gm-Gg: Acq92OGxPFcD/ay5wVXk7BkeFY5ZaVw2EzfFSayfdxfqxa/V6Bgt8HNJ6opNR65D8GC
	WwvlMSsmtgkyulJaJheFjgIvpgnXzZvAM8vQmB/kGSQreHj9se1vaIaAO/ntPU2bfhMCOsahjxW
	W5MKtE6VorHBciR2G54MHwtBcyILXdIGrBJtUnaRbtvGwAmWn+MO1iy/17Ji1FO+Kai86ZGmcju
	7SVP2B/AjZdCJoz576jdorzG3x0nkBxpDyR0BzV0nFWxIbwiZp0E/MaYuswKj2q4ptVjEKX9lQe
	VpSqiueoBRSfNG4iLSPGUh2ynsmWihxkikVf0lDLXk9MDkxlBeoPAKN1Eu54N/8h1/plRpu2gfL
	Z/LCPHarmpT1XYNdcRJgYFf5LjMln4fpX6StZ9G00OKN8wPTF
X-Received: by 2002:a05:6122:f93:b0:575:a5b5:3233 with SMTP id 71dfb90a1353d-5760bfec79amr10925165e0c.4.1779221138944;
        Tue, 19 May 2026 13:05:38 -0700 (PDT)
X-Received: by 2002:a05:6122:f93:b0:575:a5b5:3233 with SMTP id 71dfb90a1353d-5760bfec79amr10925141e0c.4.1779221138525;
        Tue, 19 May 2026 13:05:38 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm47081598f8f.9.2026.05.19.13.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 13:05:37 -0700 (PDT)
Message-ID: <ba355ac1-a276-40af-aa7f-d10f01ad5721@oss.qualcomm.com>
Date: Tue, 19 May 2026 22:05:35 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: Silence clang kerneldoc warnings
To: Nathan Chancellor <nathan@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260519132548.315229-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260519161402.GA3527449@ax162>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260519161402.GA3527449@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Jb4nCZKfm6mdF2QuTs1_nb2hdkJ-M-cW
X-Authority-Analysis: v=2.4 cv=LcMMLDfi c=1 sm=1 tr=0 ts=6a0cc293 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=PT-e4Ajc-_VN2gxaqdIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: Jb4nCZKfm6mdF2QuTs1_nb2hdkJ-M-cW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwMCBTYWx0ZWRfX5BPLaePmeUEX
 GbzuaXS7Axk4WXgUJxF+5YdnH3YBMO8iu+Ux3HXNzjP1Ns0Lfot+CiGNZBsklPZ09kAMx/d/5aE
 wEGuNAJuI+a3qi/eKyg9m0RKx5XJChIQF5DaHWNkWgbv6GF9Q23nNPWSQsxk+b5EZjBq5XZi852
 JSX6ahfksIGweGHHP1QlJV4kVpfXl+yK61gb7A/OQHnzd7XE9AGs3eyr446YAUBKvjrSeR6ZcfK
 AXnH10nJNQN50uInlEs44blLtzbT1IHMTDTXn/63Y+MTOKjJbKhrludYoi02m6sGCviMaqqa1C1
 9i4HqTQSJ8al1s0sI2wT0u4SODiou/ek0PEbBAtTitIl2tL+AKzlS55z2jNwOwdjvPG38a2eKeV
 gMK1ihV0Q8zth+UHDcfVqRkPCZY8FC3k6kch9lURcaZydbin40Zo5syvJeY/In/r6EjTyzXDsZg
 VH5r4zOWThmmQj8/nJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190200

On 19/05/2026 18:14, Nathan Chancellor wrote:
> On Tue, May 19, 2026 at 03:25:49PM +0200, Krzysztof Kozlowski wrote:
>> Recent LLVM prints kerneldoc W=1 warnings, even though a correct
>> kerneldoc is there:
> 
> I don't see how LLVM is relevant here, a GCC build would show the same
> warnings since they come from kernel-doc, not the compiler.

Hm, I did not verify that and the warning just popped in my W=1 builds
of CI. I will correct the commit msg.

Best regards,
Krzysztof
