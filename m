Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2C346E43
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666125; cv=none; b=a2yKmpr2/R/2D01LusiWGkKFJO2MPM6RUspg+U/jD3efdVamaY7oWxiZLu9IuA+15V2v6wxT9+ModAtzZHyYNQ+0noTxz4jtWkELImHqL4U2fmjxc1hxpRbUwDu8GrtTa4RPDqMIi2JzaN63RBPHzhZwF5ZvKaYEMGAhqnJDsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666125; c=relaxed/simple;
	bh=qszUiDvaOO/n1E+7SSEf0ZKynE5xJbrnBglcmF9RpRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE3txR/wQkYfy8+xmJDDkU96Wnh24N/m9Sve0ryg57EwXQLPzFrSCOBrtw97XA3NkJfRrV/aOSD96PUcgb4Z4n9aMiDIZxDT1f5rtMUcdV5M9JSyxhNVTwfx2o8KnjTJ3NWluPPGb0+NSL9948LIJ3ikJIPCm6LyriUMgnhMFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2N8kMTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EdIZSgeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2N8kMTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EdIZSgeH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47KKb3241648
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 07:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=; b=I2N8kMTZGHQUaCTS
	cfu1f1pKXwfVUf+TcGGez2yj0leuv+1uMJLmWRaeCYMaOuoklGOaGM3srSVhePBg
	QgOcnyNbKc3TmVKIbymmWpnkEoiV81kE3OqOSpv5AWUtJg/GOMmZ5rOy+QdEK1c0
	ci4cjR/5G8sVnIRhLpkku6ywTlwKmh0YmUBCfl80oGRV0vl+Qyev09fuEeDpazRd
	XNsVffcSLDE/JaGzMYO6lK+HR+FRH+q91UOIOSGh3wg3ZafqaUlg5lE7FVLzn7zu
	kMy/lIkdxqtJm4h6oytwB3zeBaRHtESWbPRZqFkZgumyia/EkqSCk4UVYGs6DpDv
	i1Z3jg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144snj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 07:15:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so795887485a.0
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2026 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790666120; x=1791270920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=;
        b=EdIZSgeHh65ovBoSHvFu3Xv//a/h6NvfIYcDkup8MoDLUZEoyJOepaEEVYYab+PJ/t
         EDNC+tta7f6cAtMqKeqGCzI9+7yPyx0XILLV+q8CgtaIfst9itN1Gs/XiC5Ny3apk0E7
         qy1grRjT6K7cFTeOAMYD7w21K3KFmBBdGQH+PC7unxhteLxiP3YiNv2x+/OTx/4PP+HR
         XvwoN2yhr1u+mVww9A/bS2KIitsPfFZ+/7JNTliPKM64WdtXSW3H7M0AYI3d0/U5IjGX
         29yXQFkT2AVttERpHK3FONo91YTD3OrF3VaxbD7ynfKLA1KVC//t44wBeh/05PcksjWl
         bJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666120; x=1791270920;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/utobSwhxghVA2xnPXVZCi3XdzkIWIdMCAeXFlgaONU=;
        b=CBPP+MV3LHBmj/zf1HCLC+4qNp3manJ6odGdLJGJRtDqkr7B4mlmgI5UlCQTIMAe4k
         /iR6vJXU4Bv0e7J+F+s9eqVdwq+hddmTYAOPMGwHQTzni5BikqceA9TdDiZbTfB6djuC
         bM2aDei14I7cfqoSnVvGT7wdFa5dIyUiGUaQ2LGxSJS6aVK8UYIruNXwp3a+SOkZN7mE
         MwDP6fQRYHn1Yz6UJLo//lpp4xRulDgGF0XWxLAr7UOKEbo7Hc0GAPPs6e/kiSwXHpZp
         5afBcB5L8P+AfuJLuvzr2sQiyQABN55xARNFKtYBHBzg0r0jC/qle54uZM28V1XXa3Tz
         xROA==
X-Forwarded-Encrypted: i=1; AKwUvBxrc3axq4cdo2l9s+bJ7l/I3YvPdubQuUoGN/rh5mviA7U7kPpqJBnccXKDFYL3MoH8q2GuF3UasW0S@vger.kernel.org
X-Gm-Message-State: AFuF++ms9RKwAgsKL/TSyNRYZekwNvSFASQEif/zPlebGgvGy4P2o7G+
	/nf7wtUMxeWgQ/qCKHrIP7azF3t2mJVr41hdNJMPiMRgJ27t7YO89okcYq6nNlTFMxzLlcUllzT
	xXZMrDUTpwD3hB5Ht42Jgiy7Q8zRadaCYS0rDdsNI+kab3IMTz6bscvatcLltgOds
X-Gm-Gg: AYBFou1MtoaZ1swQ1TsLX62eMoeARHLJe9jyOSUWagpJMLoOb1MWR7/3R/UwUuDfm2q
	CDeGcjwfV6kX/TdMHSzXBiQLoYyDxhDmHrH29UIX5l+hj0nU3Gv2ZVDrhQn8/l5H2XdHTiZ33sX
	ILcfJUzk8qtW22JFu2JuocpfhJxIDG/IhgqPwY/PtM6HheZhWFBVrFErsdNm3tp4hCRT4mneR9z
	Ao4zZQbvCfVduSfYy5tGtLj3rDwiqR0cOAnhngA8/8jo0A1msXbkJkrEF9AM2G4LA4hVRSIIF8C
	kVfUyvXzhMVBy9BsCrK6jg0Iee+VIfwMkIJMXmaug6VSL0p45910JBwzAGgzzhaLwJvXEDjF44m
	GjtDqh5er1hV4AfA7l3kH8S4V/n+1wJyym3GGAnT5pbdKV40ojoNTcKpYQqqTLg==
X-Received: by 2002:a05:620a:801a:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93c6f0eb1e6mr1223983885a.43.1790666120435;
        Tue, 29 Sep 2026 00:15:20 -0700 (PDT)
X-Received: by 2002:a05:620a:801a:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93c6f0eb1e6mr1223979785a.43.1790666119968;
        Tue, 29 Sep 2026 00:15:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm58408545e9.0.2026.09.29.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:15:19 -0700 (PDT)
Message-ID: <4005518f-5ca7-4849-a256-5c3fd481f2f0@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/ti-soc-thermal: Cancel pending alert work
 on remove
To: Weigang He <geoffreyhe2@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX+1uYr+/PxkLs
 zDITkjrS8VJ4OQp4FhipaaMZzJPNkjymD4qHutAaQdSonQOTGMbVxVlpzr3ftsLfjI2X5s4FgBl
 oAowg9Fm/oUKVd0uprPsp1J/72j095HnItA+L/RVR8ul7ZCgHH+3PQn8WFph1X939MK+6p3tivn
 w4E+VUEtQHE/nAHSWshN7/j2KdhBk5/fmFENuC1S1qVP9akFVTgC4he2+IGfvLs5+uUiKUvlhtx
 B9E7pQ9cSBY14/X4cddFvNo2QHB7q60hWqb9iCl0dAEkl3gok8CP7wjNxJRWzuYG3waYj2gYAAs
 ytzXgJPlCNHUtdLabqYGxFGtDJjdZiyQRGHSCDZ+Krv8gN8UfL9gHFCc3m+/SHcT/nZun1hSb/k
 YvZjK5O9tSheR47kJhFzhXr1m8RaVHpDgqpO7R1k/5lb5BCvlVAIoZF5IjqYI/MSx1CuZM3uU7R
 6ONRGmt1GADPS1pQU/w==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6589 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=xTF1z28j0uidfqTO1jQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: I8bq7ohfgcurnOkHe-eMI-dtC7oL5DFT
X-Proofpoint-GUID: I8bq7ohfgcurnOkHe-eMI-dtC7oL5DFT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfXwH/kt1F7ADRK
 y4c1dTcykdq0QV0s8bxoz8aDJXJsveVY6qAxPBM6SRjcZgTiI1HPes+0+zpNUdB/QaV/2n5W8id
 bxIVM8a0cVfz1wjKzM8hAMRY5U5gCZQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028

On 9/26/26 14:49, Weigang He wrote:
> On a threshold crossing, the talert IRQ handler calls
> ti_thermal_report_sensor_temperature(), which queues the work embedded
> in the sensor's ti_thermal_data on the system workqueue. Nothing ever
> cancels or flushes that work.
> 
> ti_bandgap_remove() frees the talert IRQ last. free_irq() waits for a
> running handler, but not for the work the handler has queued. When
> remove returns, devres unregisters and frees the thermal zones and then
> frees the devm-allocated ti_thermal_data, so a work item that is still
> pending runs ti_thermal_work() on freed memory:
> 
> 	ti_thermal_work()
> 	  data = container_of(work, struct ti_thermal_data, thermal_wq);
> 	  thermal_zone_device_update(data->ti_thermal, ...);
> 
> Free the talert IRQ before removing the sensors, so that no new work
> can be queued, and cancel the work in ti_thermal_remove_sensor().
> 
> This needs an OMAP4460/4470 or OMAP5 SoC (DRA7 has TALERT but no
> ->report_temperature, so it never queues the work), a threshold crossing
> just before the driver is unbound or unloaded, and the work still
> pending when devres frees the data.
> 
> Found by static analysis tool CodeQL.
> 
> Fixes: 445eaf871bf9 ("staging: omap-thermal: common code to expose driver to thermal framework")
> Assisted-by: LLM codeql
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
> ---
Sounds correct to me, so if nobody is against this change I'll apply it

Thanks
