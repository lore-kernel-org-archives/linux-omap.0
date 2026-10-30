Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358000;
	b=mfw0LgCwsWi/1rnoDgsGxt3QrTYoD0PkTtgl8x44ETicywVeKJaDz3CWizddowYbrGGU
	 axlCLTHmUepPiF383ixiRsSt/yq+JvlfqtyUb1MAtPwkEwRtNA/k2J4mUju8aKvbPvt9/
	 VelTWnEysLtUWTWVqYrR2vK5J+jEFIZK+O57vsD7SMnOJgmBQTcCEtZgsBNNvoUYNtAW4
	 j0iAYAmMLhoAZUQMNC/0aqwXyTT44NxerpQ5lMmfqsqQiNoeUgnM/ahtyEfl2CPSMmy+h
	 3WBWgW+AbJI9OW0c/U8UubnRa6G1OUkuqSm5Pcz9yy/4yuwb3Tgfmy6AMgoQ6uFcaFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
	b=wH7F5snTe+wH8YKqpqEVXLB+LmxwDjKQlw5TPFrQ5Vgm+3uo9IgWu5wkdnwLbOy2J7j0
	 n1iKwR9qOxEMd4EIUaft1zvgUfd3b/fQIK4xMjsqwX2RISSPLQylNSvlf82E7z7hCERvf
	 BU9Tm1BqmM4Ve9wL7pT1LPHECL0ImgPBz3zbfMYjLiPEUEkUICc/rD/70MDy5U86duktL
	 6lfoD9Fk3DY/Ut2olQuxX0VlsjAXJ4PROPzpU1nOq6YWHRkZOrZ3Fsd/qtOX1fVGIDe1N
	 v2HDFnDQ0QX7zVACg9A13pBjXFeOm9RxuYU+Tqe6WrtIoFjBf9pb0h3j34e8PiKZO5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXhLzYuk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aesnGZtu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8F606AC35
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 11:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D8F606AC35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXhLzYuk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aesnGZtu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F4qE1120741
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 10:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=; b=ZXhLzYukr7bRodcp
	7FjdszwOLwwhhddZ5mkLRr7V2Xr0S01L9vr17r5Qo9+W92E27JW/x03551CT/Ceg
	1pUgElCaL/hPgfwfSI3bAFLLoUH9W+HFRBveyY4Tx8Voo8DYnfJPTdnurU+DrMh0
	MfRLMo3F+CMnUIAed0I/AinSC5zSTTdCrpWDtL0zg3xbGwDly4uJwFE43CE//Iiu
	tfxdV5f5nW/lGegRnzb2AoeMXrGhbLBvqYqusTOFGD6PeUm6E+TB0nMgZ/OeiUr+
	GjNBXY9J4KRBNel9CcE1p9Zeqge9VcVHf/lj9GKqJTamq2ay1OY+Z5Fl4CLPGve8
	zX/J3A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pjjpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 10:59:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad7030e886so704232a91.0
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 03:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357999; cv=none;
        d=google.com; s=arc-20260327;
        b=BIKjGVdEz9RSL+NMLOsyr8YjODAit91uRkXlADWmaJb7Sv9sHWnhE+SkYSP3ybPZZI
         5fXDwoQUKu0AdvKWfakansinE7ZlwuZvoM8yZOb9GsC3WzAo/3p0qULv+QE0vR1Vhlwz
         2HSwEpSxkXFbuYihesA/G89hqVpZF90iRmvw9KiEqbB+s8F99l/l+UH6yaNC7Icite52
         MyTeznS9gqYbQntDHzgYs4oZtChyq9T5xkd6n34bCgpOvSNSeb0BwWaW9Vd3JfRe9DjV
         vnyBdaoHfQFA3C5J1WRVBYmOgB/3EX7JOn33Fd6oYepzt4YbVR1qrzrvSzQk/+sngDNc
         /PFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        fh=RU5Amo4cGm8N++S8GGfRv7JzrGgkh+mXaEpi1YZLUhs=;
        b=ALVa2qW0QZgh2B5vNDU8s8K8PrQuqq7V/aF1hVYc0OZba5NauNNnRp5IglopGr64B6
         O759lWINvDfqXxD9DXOoTEEwfS/LF3n/3vbUcLZgas0KfCQpo4ghWTgYh90aHrAcbt7M
         rZqDznLAZKzc80XWs0FD2gDAXX2iHOklUViP4pDEOMrGPMiH1aSoztdogn1ucv3SxvoW
         uOjK9Dxq4iFKkfmJyw3E8M788B6/DxeX8fjRISR0AZAK/DxnvLl5nps0MB5bk+pBDU6V
         neZ/y3U/jN4Sig4oNCFPoc+qDTbxsywBIzoyXjsvvyxocM9c/aEVmry1ZXwG6fyiCf61
         at9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793357999; x=1793962799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        b=aesnGZtu3RqWp3zIchK+VbFOxHdOXpm2qmPJNhIABRM2KmQlPr+3PAvxFXnm0iYIIZ
         r4OOcimTQ32cHV9Qb+hLS33EZvHAol5jqLc/AldRO4hVRtda8x4flN5NIEC6mLoP+ECD
         hylyJsHhoSFdSkcS2H/Q+pNdvAn1tYQ+Jh5WyvPD/4cR/NN2ZfM+EPIejVOCHdv5EPeD
         BybHizPZr62tQb5eBMbEhOjBhX38kZSRukzEVX/JIMFMPh3iS9cP1XoGCdWrQKsSYAqu
         k/dYiCOyvpOjyelVc1EEICEQgwG0VTKyqH9JAORHSVUdrtxA+T/WEFQLpN02oKyWXGht
         C7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357999; x=1793962799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcLCsoU7qX638cxDk0Jd/yubXQHRR3XeJ9m/9WOyvSs=;
        b=V71YE2I4SHymg1v8ChN8Js35aWUVbsV3gvIh97LCzd/QCv2qFyockezoHQkEerrmFV
         QVKbCFf1KPvhRHb1lJ8mGXAo+/y4Gp3y6e2/Q8HkImPeHqe30q8CDibn2l0OVKVgB/Wt
         mtUXvwYJ3CkK5iUhVhOWgzow4hVFFTgUYCGvWASXk211Q/hE0RApiuGfe9ott83t559y
         VpOwN+Lj897iqnMoja8LZSjcmjYf+8UxViPZgDz/3jAslapEsY/pmsNDM2T9gNwA1EI5
         0glU9mBSX7yFRVurG5M282bvLWs+SWGtyllj6QON59Htcb/F8xl7iUVQN3u6xDVT5Xfc
         8yWw==
X-Forwarded-Encrypted: i=1; AKwUvBycHasXgq01QLYPFIyUOps1F103MSaEkiU5JrPyrRHHkLLdzn/4BhhRe9uuOiZhw4yS0myf707OjI66@vger.kernel.org
X-Gm-Message-State: AFq9FYKE59Wuscx/2jbg+Kbdr1Rv3/nd+68Ma7z10osk9EtxrjeiTlq3
	FLPMBlTcICxCcqv2xSKj3dvAaoh/6rfKwLPT0aWdCdGtsBAt08ZswmFZ5vyg70jwKfgCkXgaLNg
	fPdm0GbfN6QDSsO/RIUMorqTaKQch0JwDckd99Vfb3ODd4sTsqInTYyalA0D8ULC/wY9tLBOjzR
	dmI6xvISIX7mJXQfCzmMsEoJ8hkxssxZqwaLNBDHA=
X-Gm-Gg: AYBFou1ilhRGwshw6ObF4iJhK++ENHdZ3Pdvvxq2v9Hx2b7OImu7ri+clb3YdfSIl8K
	DUqhHWbwWxAJ/jJu2efyMwkG313W7zmbG73ggI9iTz0o5KPcqv3YxGeXuJY7UQbmBCkGuxjry1i
	yO55IPxnKGA/NQIkmRohUHxmLNko4luh9W7YFb7n4QrM20x8xzpl9H3JZ1xA==
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3ae8985c4e4mr1479447a91.64.1793357998959;
        Fri, 30 Oct 2026 03:59:58 -0700 (PDT)
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3ae8985c4e4mr1479432a91.64.1793357998487; Fri, 30 Oct 2026
 03:59:58 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-patch-ektor5-dm8168-mmc-v1-1-2d148ca0f948@linaro.org>
In-Reply-To: <20261014-patch-ektor5-dm8168-mmc-v1-1-2d148ca0f948@linaro.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:45 +0100
X-Gm-Features: AclHuK839QpP0W8Kp5Bw8lXv87QTBV3y28VjWmXAjWXxKjbBKuJA2Nd7uXoE2uI
Message-ID: <CAPx+jO9ui40cF6yqZdEQxx8FcHfrmCtKO44GVKcjwd4FxnvbWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Do not log error on probe defer
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Ulf Hansson <ulfh@kernel.org>, andrew.goodbody@linaro.org,
        rouven.czerwinski@linaro.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX5wTFa17ULmd7
 EZGiGQBTg3lbeyAapNH7Y1r2hW7QIaJZC4Y5ODZnRa1HtvCprDRPt/7j0Ocjw1qgiCoqmTUScbA
 ZFMP5V+31GpW1aY2fJKwmlv4YK0RwsO7xnGWAS0WDZCoB5HNjBn67Qzf4WLZQ8Usn1wNLLQ3PVT
 pnU1FxtMz7kiP6wtpdrumvZiYX7vxefCGq72NykOguz7dvFdvBcHHEmTVN6n6/lcclUARjVyIPx
 1ggjo8KhapOEbZ2qP8+b2rnZFhSxVJkueCc5nmyP9/XsAwe6dLDuLahqwGNfgKIbrRa+0bRX5qU
 642ixbixFCvrMzBI/CtPvYA9e7fpKA33hyPKyTfFUQYKZu7zTxzzg6woTk7nOuBDesiUEhrFwtR
 gPMlRxvx5ac43+TxfOdcdHC24hjMskDNDGzo1Agi1xbEV23gEhyQx5qkTWWCAXiEEJZTC2CV76h
 mLlV9/7QUOiagerWn0w==
X-Proofpoint-ORIG-GUID: ETxfNindto5mh9dXQnhDfSznAEMKHjxt
X-Proofpoint-GUID: ETxfNindto5mh9dXQnhDfSznAEMKHjxt
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae478af cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8 a=V6vyg7vV4w0SYrr6CqYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX7qvrf71ORZn6
 dOKZJ/ytWBLYfQcEBZMex3a0EKkNgemViNlR3zd7mEeFF7uIEaZMtv10YrapGlHXTJ6hGlhDJQR
 3Woiz/fWu+tzkGoBVEUumjiQeyA+Hh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300043

On Wed, Oct 14, 2026 at 7:44=E2=80=AFPM Ettore Chimenti
<ettore.chimenti@linaro.org> wrote:
>
> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>
> Do not print an error message to the log if the return code is
> EPROBE_DEFER by using dev_err_probe instead of dev_err.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index de5a3b70107d..ed52adb38fd5 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1892,15 +1892,15 @@ static int omap_hsmmc_probe(struct platform_devic=
e *pdev)
>
>         host->rx_chan =3D dma_request_chan(&pdev->dev, "rx");
>         if (IS_ERR(host->rx_chan)) {
> -               dev_err(mmc_dev(host->mmc), "RX DMA channel request faile=
d\n");
>                 ret =3D PTR_ERR(host->rx_chan);
> +               dev_err_probe(mmc_dev(host->mmc), ret, "RX DMA channel re=
quest failed\n");
>                 goto err_irq;
>         }
>
>         host->tx_chan =3D dma_request_chan(&pdev->dev, "tx");
>         if (IS_ERR(host->tx_chan)) {
> -               dev_err(mmc_dev(host->mmc), "TX DMA channel request faile=
d\n");
>                 ret =3D PTR_ERR(host->tx_chan);
> +               dev_err_probe(mmc_dev(host->mmc), ret, "TX DMA channel re=
quest failed\n");
>                 goto err_irq;
>         }
>
>
> ---
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
> change-id: 20261014-patch-ektor5-dm8168-mmc-138c9ab3f014
>
> Best regards,
> --
> Ettore Chimenti <ettore.chimenti@linaro.org>
>
