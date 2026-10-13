Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BE3DAC02
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884030; cv=none; b=gN+DolBs0yMBTwyQga6imFChiRcoRIB6ZO4BwrACzaoQ4J56hyMgiJ8MyCce2FFTWYfgQh8NDIjOVGJBcqoFQnvPa6M9oo9Z/otnn/IVAF6Olhq2iChOW831ppXzWRjP2Yt5aOHVR6JvkRQ8KexXCJ82alFBQX2LLHArN19UcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884030; c=relaxed/simple;
	bh=nLb1b21lzxvN+3LUVcKLtkwh/UVCiSWzv09Ew8JyhUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/T57uGeHIYV1LFWC7lhClQ3m2+JMouZ4MXgXff6cTbmW/363jer2b1GBhdkn30ejG+hgu7bRCouLmgVJfUSwREJxCWcnfdviRCZSrkVSNmN6eR5f4rjRp3vUfqdI2lbl57RelVgN5EG4PkQuzJYTAuPY7WtsaIMnhY2SCDMO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMcDl5sq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AbQVWc7C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMcDl5sq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbQVWc7C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D3xC3D3475956
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=; b=lMcDl5sqN8wEVEP8
	HsyYkfddnslcDF4/8qIWUyq3e7XibpgV7Dc6kudmFMEZUMMA6XTLT+ZPLhhTARX/
	F1Nz1brkVAP1ggGocu0rWlkV1KWTuum7ldiT3q8BMhpacjAAfDufh/qnLjKAJaAX
	HMvGXlfmO2DBShkCS3lggTt1Z6EwDhOvty+B0w0DEYZe/gdYbLZQO8j4xXt/NTJk
	EEfpadfFqtoVbQC4QSIu9PlCBYvkAMwacVzfsyF18j/U81hrSJ5ugrJh3ZI2xscw
	nagv8w/uvX3Ka4TUym8VZBEgOvwLgHBPc+QY4kATF4sBhr/UzHgaO4Wm+qctIMbU
	BkWmpQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j99ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 09:33:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a082c014aso598971885a.0
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791884026; x=1792488826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=;
        b=AbQVWc7C2IX2FLKljFQV07uHi/AvUB2ERFdkcG3Vo2zJ5JeL9lcOlNhc3aGNws1r5q
         8xxSbHU7vGd10JMABRrYrWTwiS1GN+eCAGCG5C+fD3a2zrUDwB0XsFxCLCG3MOcOVXbW
         CMAOfvUUCM5NJ9m3gDj0rOsANXTCetVcdsa0L8q3TV4zYU5GIRql+PLmH/MfR46HCwwW
         4rzuGwPXa9EcE8rnhPs8zOSiVd9Cxxxs703V233tVc5UVC1hwTdjGkAAOuK7wSBGXkHB
         aGijSsbxnOy/wTU8ZddVI2B8eEpWuPyF20gH4i7d+cKuxk3EwpVdXRxSBAjXZJS/bKNo
         1lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884026; x=1792488826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYeOkeit35ph64NPvNCMkB86ITDKOLzrRswMYB2OP18=;
        b=EuGZFeWbLj+tynnmU0Z2aSpe09y502mTzabFWttjPNOujUCrVPBc6eIGLmDxCt+8rz
         T6D3mDinY0z6U1g7s5UmcxSkmU11wG2GOIN+wAU3eG88ys3SMyuOWb1i4x71un9PrtRK
         MNRHbqRSMqUOwXaPb3jDSWHTNeQ4mzV8ULSkx0DoToiT+MNL823ne0YS6tc/8a6KbKi5
         fYY/mbIAVM2RHDGgLUGHJSk/gY1uDWkOdChihegIp2wCURZ43JaBhdVbzGIJSMB5cSLi
         SicI5+aM1kSh8VGplhWgoGKvIe5a7A0f6AeBR1YTw3VBp/35vKxbBRExU8RYnGsc1wFx
         FrcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI8wD3+n42W44PA5pdQk6iYAUAmp5n/SCElPmtoLp3fZxq3s+lfadRY5+iW1LNKlAab4l0tW4Htej3@vger.kernel.org
X-Gm-Message-State: AFq9FYJMYlW15j+OuHql7Oq59Xg2J9EdveAVhn7S44WNouXXj1Udw4FR
	NGFYMpiPgPryGYccbzkN3D3vr7YQd2ciH/L9v2fdT0pvZ2tSlnKcIL5tRpVdCMTbbK9nCgQVWpt
	VYD6+XwejSvHyIj7YtYU6Inz8ybZPAW5nfDKppSx28vQRy/in0kt6vZgl/Y/NyNKO
X-Gm-Gg: AYBFou0i8KDKKKIekHeC1fiw0tmEcsjltGCKjvBw312OFsJCgvLUU0k5SFPjFzlk2qk
	339rm+ra7kO/AwvLWJUeOVs1a65ZOt2wcnWHQ0mnA6z6ANADxQf6Vut6X3no5rbpfa5sbZgzeMh
	+C59sGozQAsXZxxlkthaothLkDX9LiFvsuOvCue8mEnURYxvSx/TLTkKQF9I27I5reJXGQVAKUQ
	6XiC44QVUfaWuzAn8x5gNo6/J9rJaKiDKhcegKH/Vc91hOl3hMcHBph2D7Vet157nbqnQRKEJmp
	m0PeLitv9ZpZH+HvFPNf1mmecTFHY9QeWK2XlZwt6B8+5rIrnstIXPOxBdrBBL99Y6GYhp8Qz5j
	gPWeyxF0tsvGGA/Y4udqkOikVssvq6jyevj7WatZ+M0ghlKGDm3hncnJHYK9tiw==
X-Received: by 2002:a05:620a:408d:b0:93e:5508:24f8 with SMTP id af79cd13be357-93eb9677234mr2019268485a.32.1791884025801;
        Tue, 13 Oct 2026 02:33:45 -0700 (PDT)
X-Received: by 2002:a05:620a:408d:b0:93e:5508:24f8 with SMTP id af79cd13be357-93eb9677234mr2019265685a.32.1791884025327;
        Tue, 13 Oct 2026 02:33:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac3970sm3930449f8f.37.2026.10.13.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:33:44 -0700 (PDT)
Message-ID: <a5e5a7a2-ba8e-4229-af4f-7479e7e8f37f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:33:43 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix the return value in
 ti_bandgap_get_sensor_data() kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260912062252.42762-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260912062252.42762-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XS1XPfJAN_P9xSP1Txq28DBarbSUdo8p
X-Proofpoint-ORIG-GUID: XS1XPfJAN_P9xSP1Txq28DBarbSUdo8p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfXz8rlYwEwNqdK
 gM4JLuFWpL8GHDXepqJgXt0IHpQ6AjFvQq+JRVuyGZ2d1TIFVYnSEeLqLW/+RUgQrGzltcWlINW
 jnzDZD0483onFuVPL76MyH0u3kcsaEs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfXzwCsOrtXNhsh
 KeZzcAW50LJtBirw+EayuZmtbEKPXdkVKmWOY2DcevG636MS7Vd0DynRzOyRSVepxrGFexLEf0I
 PqTH2CoTeVzfDc8XjSzZvy7uCj2rZBj1LLweCUURobMHfMoqGstiKpOnW6ct5CgdKfNJuCXpkHE
 M+YeaydYBSZD1/5O5/S2xRsxa20uzguoFKVRJJS785LwbCyLxYMPBTOAGm26tX3IBwBDTIcdSlt
 m9vAXmakQ5K4ecU0T8eDHz8JBHWz8fT8WL0YwsB+CUqRhcJORhjiSqGbqavs56J3IwLYOHzk4GR
 2FQ/RCZnAE2r2FVM1Ss8bYQsif648MggivCKNLb5KnffGnFDiTgRgPROB9ngUwgL8T8kOP9iOCB
 SFzaApBvOA7G5sXcofmEqWhhmfL9lszGL/ZXfPuAfgLxuVbkjAK1c1gm0nzU9Xoj6N/m1X6uffm
 qV0JzvxLJF3Y2U2voqg==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6acdfafb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=Gq36PuiKL5ZAMQJggHwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130037

On 9/12/26 08:22, Karl Mehltretter wrote:
> ti_bandgap_get_sensor_data() returns an ERR_PTR() if the bandgap
> instance or sensor ID is invalid. Otherwise it returns the stored sensor
> data, which can be NULL if no data has been set or the stored value has
> been cleared.
> 
> This mismatch was already present in omap_bandgap_get_sensor_data() when
> the driver was introduced in staging.
> 
> Document the validation errors while retaining NULL as a possible stored
> value.
> 
> Fixes: 8feaf0ce1a04 ("staging: OMAP4+: thermal: introduce bandgap temperature sensor")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
Applied, thanks
