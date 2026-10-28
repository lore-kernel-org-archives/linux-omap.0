Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207693;
	b=u8b6TkkKDFuysrqZUGlihImue2BwzL8805TEgAihFTUdyfjimrz+gd2i5wYVIy50vpri
	 2tYZE8iZ/z5K6BxccYCSYMzVW1NINAY1iqVkoaj3qsERDDbDCvI8jwpIr62MtUN6vZCc/
	 mHAbwzW/wuQH4Z21L+O7JnIiqbwj74Nrt0O4DgBG0xnFLUfBamiUzCEOxMqXI0nvvPddP
	 Vny4l0EEAA9NR6/yM53cFrxpNT965wkyfoTXfTzSgnjyg98X76NbT5pUR8zgyLt/IPSK5
	 wneEYaF6zz2jpZnXGwyBRyzBFmhkXATaNcRM86R0J88yV4+U/QrQosi+/elUmt6nGMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207693;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
	b=hvvFwXoLwArknelTjRvnxSEmV/j2hlOkjf94RAG1a2k215jHVzhn/W+cV11axDdyyLvF
	 vPrA8Bc5ZmXYlkZ7Q83ujGkzXF5GoLc9WffqGCe1N+I4/nc3DZLNXcAmQv/5qEOI+4Ki0
	 Sy4iwOO7wO0zTqOQHQ+CSwhfdwv8SyP+aUl+twP0we6vro0wNIyJrNOOpb1zPpdU1ozhG
	 c3dKBiJ/va5ROYz7PBeRY3K3NXQV8Yo/MyJnvGslM8pJVsjR7HGyPV0x35u5aGZJnMh9L
	 FScNoQiBENXtXZ3JjeI4lA9S8FzKgy8+BfRbRPwNZ1zqvGGQkKApebwb+pLqvb7bw9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iRx/cHJz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6B606A321
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE6B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iRx/cHJz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA44O2568839
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=; b=iRx/cHJzTqSXbnd1
	EW3bP32/wrfXEOSOuU77enf5hCUcTggU6ya/hrvzNSMUgjsuC6lXdTTgyhqlHwz2
	FWkwmhdMjw8VVKcjIEbzYxbPy8oanDTRhKZ2EGuSlvEHXm2Sev6VDKwfEcFiU0PQ
	7Yf/Jj+GOjTb26gUfTRKcg5bJ3iV7J9qkgE+X15PswAU5aSMqiqCPR3I77Zt0Gb/
	A4RTIe3B1dyoeNLI38LPq5QkwzYLzeQ8DMbZNwEYBnVjlWDsYSHtOhCDPg2MmO5J
	pixrbkq45iRF/3qnKtySL2l03ZHCv3QXtl80Je9mG/g2uwATw3lPF+BtbiKiy7rd
	nuHwGQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk12pvsqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd60a365440so856915a12.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 10:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207692; cv=none;
        d=google.com; s=arc-20260327;
        b=W/IwkNeVcKcSKgVI0S+jeMxFs15qvLSvpiCjzvxRxgR7IvLqHKhNaVPoAXGh6t4tar
         UZTLIKkQrY3yqWkfSB/JAk+asGiFJ6meVIDEPcM3z1JkzYlI2wqiJtUUUsOp+VHTvDYN
         TwQfZHLSirM0xNgh1/1A2I4XGXrP4iOtsoITruMEA8NAcIU3UycBYEBslD3+S0Ql2SCe
         d7vXEoMVxJuK5g6jmz0D8E5C3uIZK6Ajp7FWtpgQ3cg+iB/m+5WBIU7o6ecHft0kYbiv
         NsARBQih2OW5F3qDlsZqTuvkwkEgnKd534xvNUBWEnRGmWhvLsc+hh64lAuGElm6KDx7
         PpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        fh=hqqhKMYwazHe+NEVR/4gWK90kh0sskDd7I5oeDZQSPc=;
        b=EGuEpeckcHhuTKklNE4Sn+OiAElFyFJntvNL57crVx13CMpWNy8EBikqXgrK9H/fvD
         xeH78cF6/7EcSPW/rBuYx3P02zb1fYqOdXJFryFn0wKI011f1Zbfgmq+RfTrR4LAX32W
         6i4aylvtg01EApM/iaPlZ4KODmaRja0X7CdJDfUaVi0a1+0SZElp+xIWPbDXFItffRx4
         PfwoTMOzNAmZN3CxczCcWvd7atYoAwOrKZDeaTorQLUFT8V7Zw/p5M4uMezohQIDAdYS
         VRV69+LomqD4T2QlLEBT5DdZ+ToGHMtVvLXco6Zes/fQszGcSP9ZpDGgLjAOYKj8rHQL
         2IcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207692; x=1793812492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=NarLSL3fQSwvAx099tbHHoxIxEBj2QGMim9VohsnJNYB6ULicVUZxBD18+xAk70wY7
         +W4f54noecwrkJhWzeoVeC24EQcJNnwLYMlTyXOPyzTLSWQ9yCx/ur+VlC45E3K4JhBh
         bLbA83a5c+nTMfmFoPkF+WNy0bJte42r+iO94eIt55JcbUxzN4Ns9FFyurSQql1rHBBr
         0ogbdvqumyWsNUK64zGv6bcX+eyUMx6kwcpVDuLtWQ/F10yTatXj4LdMXoYLzvA5LbXz
         TOSsoo7sQQRbYrlG1H68l5Z8BbZqupsyujqrSen/7aYZd2pJeI7Qn/E/ztqSVX53pxeU
         qrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207692; x=1793812492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=zhuAt45SEHyOP6JU3gGsPONfxC6Gi2LeKO+gkugPyoNV2y2a/1KfXiK6EeHkk7iWJe
         o0GvGsDO/lA16va43+DVKqbaF267TVA4JqyB0UawRkk0I/HsnUa4MWNXs21Yu85Z1sVS
         0eZdgh353KCeemGYSqSDRQjL3BvGicsqwavoqRZ8SXG/6q3DA8NvxrugrbZQ/MydGkKS
         ahKcL7NC18eiTSImmBfpgeZUntZo/zczV47aEYZNx9ZwK9DY3jUaei1sLh7fMM/pGPDJ
         Ra1fGRcGCj1/VHdsNewQlCz54WWmYi1pj3cLc1Cr/RPY23l2ErYFtsO79GTCX+HDQSo9
         l1RA==
X-Forwarded-Encrypted: i=1; AKwUvBwADrTrubmR3FLNRxqDJ6RSfwEaUp6ew2pIJ3anx1w7e2D/M/aOzHxDty/wJCYDIuOg8VFve5oy4oQc@vger.kernel.org
X-Gm-Message-State: AFq9FYJnZ3KdaknPVhaLv9ZgVcKR0KuY14YriXxB4uLyv/kcbVfqzOSR
	P2c+LWsjEHxlXVnBoGPNJMZUPMw6RIaXq9IPP14IYf7VYQ6gIXej6juRrfK8a3bM674ZgLjl9oB
	h1wxJI6v3A+QiqBjKkXg9QHk/pkIKF/4RIe+aSFYw+jF0xYAi5ObRWUFpUjxAidFPThyoFNxjk4
	P0oDHJ3qme7m0mWUqp03pw1Hni4K4AnV8BZZ/EIQU=
X-Gm-Gg: AYBFou1mpnNnHk9dAJZe+KwebMAQ23+owVMl7mtvhBvVWeMP513Pbwwdjlinsf2qazi
	RqgOIma0iPJZ/vHcHxK9denndWVu24OnERomSZpezIaBsIihUFYsii9mnTlVfLVppGsKuO4dV7T
	UVTyRHAOu22kePdRUlmbWqBOhuEWUtgZdQd1Izk1KiOgrVIEmqT3YxCRJVKg==
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id adf61e73a8af0-3e9023a615emr1998174637.41.1793207691831;
        Wed, 28 Oct 2026 10:14:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id
 adf61e73a8af0-3e9023a615emr1998158637.41.1793207691380; Wed, 28 Oct 2026
 10:14:51 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:36 +0100
X-Gm-Features: AclHuK_ZWeAQi2Xa-B21F76suzhqXwNnsAdO0BsvOyeyMH6jBWqA5XunpZY6OxY
Message-ID: <CAPx+jO-9DXrH+b5Y_TMmiyydLTkCQcNZKrHEy39OK8iYkZ3JOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ToXbV00tGU7tiCUkcp3qynsLeoAU09UN
X-Authority-Analysis: v=2.4 cv=DtDDa2/+ c=1 sm=1 tr=0 ts=6ae22d8c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX248FaP9VBLxv
 +sBLy77QzXjYxl111WSBF9W2PDgq4IUSXRmkQlgtbI+B4YeySv5QmVJptNyKlmuppb70ZBC1Gws
 dX7CGWVRflNuOKS3Q8McuG/mJARveaS6jGKj8MA+oygaJ8oepj/qJ191qLfE518IzcNNpw2OTK7
 ZT+x+APTXIJ1Hx/ielW3KIIcN1MNBdlUBkaN/pY+hyPOllByPq4LhZfCZ96SW1R6u8ZlHTMKERr
 +JDiR7qQEXKFzlq2Dnva7rCUzJLZB7uR5ruhmXzXcpY4zHgPiibilbiLcssqvTIWM8OWRT6G2NR
 aOQPQC6+wkVqQl6b2h9vC7bNLOPD3xmjMNQ+ClqEatIogZZ4+qhL+VDU2+mdm7Ld9qcNUuiqo05
 3sEyvhj1a2zhdJzBg7nf+KerWC8VeJ7YuFcQjuU4rMjbf2MXSmN1Malqoc1ppaDKKyHuQ8whCJR
 t8PwDZPUGXl4tUd3PmQ==
X-Proofpoint-GUID: ToXbV00tGU7tiCUkcp3qynsLeoAU09UN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX/R149sGOL9xD
 2PLF0qx6o5EhmrYvwzlqZLs7K4ziOnbCtYea+6JLaWUA3gGSq38hvOg4UYlmk/HVN4Qiay919ta
 i+yDM1PlYY+omYZD0UY7DJx6S7/7n5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Tue, Sep 29, 2026 at 2:45=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> mmc_omap_select_slot() removes clk_timer with timer_delete() before
> switching slots and changing the functional clock state.  timer_delete()
> only removes a pending timer and does not wait for a callback that is
> already running.
>
> If mmc_omap_clk_timer() is already running, it can therefore call
> mmc_omap_fclk_enable() while the request or slot-switch path changes the
> same clock state.  During host removal, the same window can overlap the
> final clock shutdown.
>
> Use timer_delete_sync() so the callback has completed before slot switchi=
ng
> or changing the functional clock state.  Keep the timer restartable for
> normal request handling.
>
> Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5e..02d288e4e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot=
 *slot, int claimed)
>         host->mmc =3D slot->mmc;
>         spin_unlock_irqrestore(&host->slot_lock, flags);
>  no_claim:
> -       timer_delete(&host->clk_timer);
> +       timer_delete_sync(&host->clk_timer);
>         if (host->current_slot !=3D slot || !claimed)
>                 mmc_omap_fclk_offdelay(host->current_slot);
>
> @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slo=
t *slot, int clk_enabled)
>                 /* Keeps clock running for at least 8 cycles on valid fre=
q */
>                 mod_timer(&host->clk_timer, jiffies  + HZ/10);
>         else {
> -               timer_delete(&host->clk_timer);
> +               timer_delete_sync(&host->clk_timer);
>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1
