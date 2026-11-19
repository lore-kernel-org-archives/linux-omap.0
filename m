Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084528;
	b=qXS35YMfMVIbe07qgLmAfhckMmbcXnIz1tO+LtKq+ezSVvQ3hCHG3cHKKf1Yul77XEzr
	 xB19eJ3wZU/GiYf0GoxvYiFv/m92ekyE/CTPN8txvMzwq7yRftKqC3YW1An6pFqyBjTrj
	 rijwCvpAv41EkQiTi9jT3L4Gv0wRxbecBlms9lo8OKf6YlZxSfiaiIExjH4eYAlYkYuLQ
	 wxqo4xxJjMK8tqAE8djbmRXg9RRkJAMj9afc8/UzhRxYszGCCirBxa6+VV6rhOn/3wPCT
	 yJvfzC0wnYl00QgqWwNPEg/5Hya3rM6ZLdPnrpY4VIDXDCgIQe22LkjamqOxFAnbbVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Cnrr4Yn7YHkbhryjrkHy7utpdkTnIjvy/NXUx3UPL3k=;
	b=UBWulGrtiFoSAfOlkYpkEhz2moygHdpSlYXw8ToyUvTCnOmEuwzmmW5H5oGmkJ2O6OMZ
	 Q4iPGP14Gg0LkjAMQxB7DufJvph/Op5iVsKyluKDHdTLtdQ83dAkqrYWVn1TWsolE/wK9
	 jalSPNqQmkAQbiY3iqmP/zJfQ4CHUHjoJZ3BdyghLyzjeFMpsGw/wVD04pbjhsq17jACU
	 7bE3vMunDXRj+eVIQ1cgA2ogAyOeo4cCqDww7ccLpNF9qRJPm4A5XQuV9DeeH2XUKOk2j
	 42q5y+ex/ejHgpdieUum7jab6O7w7NyTlUA9CdQteNJX2uJ9Rb21p0rj4jsvKLUD7+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcfjQf6T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WEs3TUN4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C19606A320
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 10:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C19606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcfjQf6T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WEs3TUN4
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9IM5g2514133
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 10:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cnrr4Yn7YHkbhryjrkHy7utpdkTnIjvy/NXUx3UPL3k=; b=mcfjQf6TW5pUx3ik
	7wCEwTKM/pEtSHAzhdW41rpIfKhqj4q70h6/JeA5SWJgk6ZpSnYnVbrRx75oYPF3
	4z5kT6B9vpPg6GrVHxvN9Md/63GXQDNXlmgRtIHpHaPm9XyFe4BPkg5wTOfcVJas
	/YGBEh42IlsICnVQSN91glTcE4s6J94V2HfdjpbSrY2N9RUrNlFnSHNp6/zILFLu
	O2SFvLa8d0PnklJfX/XiCBQvz34gzWlqPSvF/e50ysT9TbekwAH391s6S0BAQ3e9
	NW1EZzIWD1HHjDK4HLJs0X1083GavdZLWya5MyrJRGc29FLCd6Jwz3cbYtUixSiU
	2jgfnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6ravq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 10:35:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-949b0d3232fso51842585a.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 02:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795084526; x=1795689326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cnrr4Yn7YHkbhryjrkHy7utpdkTnIjvy/NXUx3UPL3k=;
        b=WEs3TUN49r7BzVVrpbPYgSUAmwgV1xmr9y5/y33hD+4EYg6iafwb6FTmPKVO8oHBeD
         zGvIwL19J870RNP6raf/In9ik+rDYBOJK7RkrW3RfgryBKkH/8k1czbAZMSTS1tLSo5c
         +C43d2ikNrTPck27fTbZe433Dw63ZlvELoHti0Ri9upfJZ8x3Z5YLjTouJg4cg9eAlM5
         Ebt2R674t8SNGkvzEfXpqwBO97Wvl7BIBNc0+npBmcOeiPRn4U4wkwoxWP4U3uXK5knx
         m51UpBqTr9NOHDMWoAs6dWM/+qcSP15DFIpYc7/zhdSjAhcG1SZ5H4t/kS9GThAUanz8
         gTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084526; x=1795689326;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cnrr4Yn7YHkbhryjrkHy7utpdkTnIjvy/NXUx3UPL3k=;
        b=gaQtkSfHEqNxXNSL8N+occFVS9FuKnIi68RMuJ7NqaWKnjOdiBAz0S+jsWjv9m7o6n
         EbRjhabVZ5NF/DdcDvQTVXrBaPWz2CPnJl8qSr+VxDFADEqDV6KbThOMzn2nW7Uauo7Z
         lFH5LcApjoXe7540OREfmSR0/6h9E72ALEQp2RH2EJEuwJ6zVyswwe3EX6LkqjzPiLkg
         lLVP3ByDYSCV2GkkTM1/cjKuXl8SJZYEDhx8MJYruovz0H/P2UhjkFq+JgGG0XA8jCYF
         9Zy2YVj3PdkoWMFrjPuM8sHDjY7UGrF5ZyJCtQrvvr9uybJyLoh1DL6b/G4b3ej0aYp2
         u0tQ==
X-Forwarded-Encrypted: i=1; AL+hErEBpgW1Qgpb9d57ppTpgF7gecah/1kd3GyhWcVNhTFks6f0jfACAp+BKPY4+1FSG01fx9ugZgvvoy1N@vger.kernel.org
X-Gm-Message-State: APuU4Z9mmfzuYi8vHZ/tsnKb79X467WbQu5n5Ucp5kF2b3EQYJd2jQ8e
	3pMi3ylP0f6RgAHFsooS/fSFVXHui3niNBbxVLZ34gmmioSUymP14cZyEGd+HRY9COJEYCrYk34
	fI7+kobi2TqXW2K3cRp30zLbtnPhes7J9PuYVK1kZA80B4gkExvAe9g9UgRVH3kzc
X-Gm-Gg: AYBFou07ifsP0zAOeozRxIXtijqUCCxVpzwxI1UUhP0fn8LcZHBKN35NGONR84jOGwI
	/ITWAM3kF91EUXyU223xRnPbgR8OsA4v4M9nqZdPr6LvKgWVhCJQ93+U8iBKxveH6agFWK/aMCa
	YCQ7Qiyxrj/1GSnRzSFjwj3U75rPzHoBb4qvI45FbhbcQZ50GfQTdaHkeQkYfB+jSg2wJalh0QU
	vh3qdys8/Ll+jUbikMCDJp4PD7PE5MLu4KiKos3eguq/VKf8SSkxP/iK+napil1c6aKChBlzVGB
	Q6s2QOirxIBlRBUpqmlAGVtwhtVEBQuQSt2Rz8TC6WtxwY+0oO22muF832VD85dMxMuQ/M4XWFw
	K2MV0zy5Nrh+zLFdPaAktgROQrRNrjCYErQarw+5LdbtqWLv7zX79S/zVu8zrgd21DGBnxh4KaE
	M=
X-Received: by 2002:a05:620a:4551:b0:949:873d:3dbf with SMTP id af79cd13be357-949995e0f87mr931933285a.59.1795084526244;
        Thu, 19 Nov 2026 02:35:26 -0800 (PST)
X-Received: by 2002:a05:620a:4551:b0:949:873d:3dbf with SMTP id af79cd13be357-949995e0f87mr931931185a.59.1795084525819;
        Thu, 19 Nov 2026 02:35:25 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656933956sm10237506f8f.44.2026.11.19.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:35:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Jiawen Liu <1298662399@qq.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Dan Carpenter <error27@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2] gpio: omap: handle debounce clock preparation failure
Date: Thu, 19 Nov 2026 11:35:23 +0100
Message-ID: <179508449069.49049.11977204683056699145.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com> <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
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
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6afed0ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AXu-sfnRVQekOsvvnCgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfXxHu8n5Jb7VPN
 3EaV8NaSb4zxBD3ikE61xoQbqNhldP0kBFoW+Z0qoP4SCzlvStRY3LdG6XxuUPBn50zULMmnk9e
 wYueoMiPEZDnT/CJuBJpSnhuYazQJCtIIH0krNEV5H4PNb43E/B2swAq05AqibZTVXJeddtkepR
 oPzIlMv+3N2kqXbtjkVou6plPTKwKNEG7PVURI2qZm3WUEQVtrAN9yFbKF/QXYx4VoHcH5n+0lj
 c01EuQli7lq4KRgj8oeNqcdsiwgutxAvy6Y9XpbToLxSmB3OyZa+3/xqWdqIbBiNyBq6HkZ7mso
 4+cAu+NwFJUcbdSypleczkdYGMUQ4u0y0Z1LXtug0dmCdbJavRsKRacnONtsWq01MKc1Jr80G5k
 Cxun/k78vvg+sdj6f9n6XUiwl1NIploOcq93hXcQmnA64YJEXcHR4PvraYfHAKOvFKAQsIIkR7o
 dzoAH2vY+PQVB/dt+3A==
X-Proofpoint-ORIG-GUID: jZkYdKj51wMXJeM8qNkJb9lfgAajJk3Z
X-Proofpoint-GUID: jZkYdKj51wMXJeM8qNkJb9lfgAajJk3Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX+unWhNqAwk87
 m76BsZKv38yfgICb4yLetWU8XRy9oxdZghI4UndCPWUPuuaZ1MxmSMkARUi80shCNVaOLcpIsPy
 wuJhmPhqRB60si7E2FQqn4RvCzSBMw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041


On Mon, 09 Nov 2026 17:42:04 +0400, Jiawen Liu wrote:
> omap_gpio_probe() ignores the return value of clk_prepare() for the
> debounce clock. If preparation fails, the driver still treats debounce as
> available and may use or unprepare a clock that was not prepared.
> 
> Use devm_clk_get_prepared() and disable debounce if the clock cannot be
> obtained or prepared. This keeps the existing behavior for clock lookup
> failures. Remove both manual clk_unprepare() calls because the managed
> clock is released on probe failure and device removal.
> 
> [...]

I dropped the development history from the commit message. Next time please
don't send new revisions as replies to earlier threads.

[1/1] gpio: omap: handle debounce clock preparation failure
      https://git.kernel.org/brgl/c/9df982f1f283d2f2a9aad764dff92e36ed764e16

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
