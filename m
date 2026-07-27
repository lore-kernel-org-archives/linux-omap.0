Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444242466D
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169529; cv=pass; b=sbptbMlKnXDBKcv+5HL3uqA2CVRScsANBBTOqeEUi50PQhUx9rZgOZLamTvvqXrJ9oxAg7juohodAZTqb33mpHapgSU1fcTOC55WB2lCDEwUbmZ5s087A9OmNCw1Hgte7fpQeIjGj2mY7+fKvLLWeBCFqdfgt1wwbaKqMNBK+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169529; c=relaxed/simple;
	bh=DR9jc94UbAZlc1vz8P3KBFPfy5DTN0ZpfMKWOEzc4Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLgUJKWu4fxby+3Oqj5euiJEA9HJMMBLEqZd0ZT8/Aphs+ZWjmAIkAetfJL6wTYaIXyxmuSsruf+uoU2eKdoOfRfWWOjyzRL4sB+6gQ3Sm5Mt1CneJt2m/JfoibQn3H8UlMqg4/jlOEZKhLh+sJgYVFO/F7dXtK9nR8jioVhzfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vrxl8EBv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qkm4wZKG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vrxl8EBv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qkm4wZKG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDm9wr3823625
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 16:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=; b=Vrxl8EBvs4Wob3/n
	8PuDPaUKBKZ7kKwmyHpuopdCrT0iCYW4BaPd7K1JbrB3vqPbswCxTMEG8ty3pNz4
	iY/9UW8EZtLS6gGaws1k9Sk1HNi+1Cenyj7RczhzrIp2ksVUmtIasFbhgSOyJ0xj
	Q+lFMfb7T9jPtpoT48OBh+iQwDCappAyW7xR2DRkUZNPTdw2Pf8yOBmYpcMF76eR
	E7P89/FRPqopY4ynFNylLJhCAmyZcuFcgow4QpyllHCkF4Sx5FmtYiHGbS8///y4
	Sey7W10aclJeJzOWTca5Du49TKp4NwPC5TpME82lGJ+29Tyh+CL2GIWrmp81x4Ip
	U1/U8g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbssdy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 16:25:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so46502986d6.2
        for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 09:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169526; cv=none;
        d=google.com; s=arc-20260327;
        b=XTUCaHaA2kpviteWD3spMVHMDeade432AWNXrX0hnR0hY8M7wq9+D85qinsMr8FUpI
         2ZgqOKMQRWeiR1ZPxO5BZty2FtWUOurpFJ3iaouo7x7ec0bLQgeAdp7Je6DtI2C2GNQ+
         mVL987SprwJLTpCJw9w+j9W1ZUoakzM5z4uI9jqroZEHgFJiUuQh9rHjISrHFU9+Hb6N
         C6o3obxLx1LOJygIiihW3e3cvJVK+9lIvpu0oT8ufkTJdh4yXFYMmJAqEyKPYpPcKM3l
         Fk964hrEJFBJzMteTVUotTrUKmZ3psov4pq1kUklA2k98T7gVEBKHVikHpTKHMo44M3f
         uQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        fh=VoqFfmsBkbjtM4ltUTEzQXI2b6egAdIpcO8BJ+2XL1o=;
        b=gyM+12lwrMIhWm1o8TfEalUG9DrbXfb2URwOKlz7mCshsOb14cVIMSG6uGMshZCiAi
         NmAKOS3zjATGsA2jNKXIKReMLmbUjQCRnvmj9ijI6RKqPltfFciZyEGshs4uvVGFxkVy
         +Nd7wUK3Wjxvd3nAr9pvXTbR/2pEVMK35i0lCTMvjcdLXeORafm57BasMG0UM6bzwOJh
         NPv4SXShUIQr+t9Ajv6etF0rl7QEQSATqvSo2N9rOu28V3EIYcF4aEJj9HuEcuSzAUIO
         b28SLAC0Aac8ZxdBop5E/s1vfVv4l6oRTWtuhPSyq/dbOZR6mpHk8bvhVqaM5btPL8Kb
         nsvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169526; x=1785774326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        b=Qkm4wZKGR8XYlrtYIvAncA7I7KouT8TxIgHJDLUsys9aBSwgaqtb+lDSQMtu2whd+c
         87cg7lEG8IqhNn2WPePTKnpA+4oRWo3KesEuIhdLyRoTQWhiGJpPz5CKCdLbLWblmbLB
         Pj4bXBe7+OZiSEn2qzmwTEaut9lIA88BI5UAC7G9nyXlVoqkLts65sCjLKLvU5l+OOUm
         n9RBLYcLHxAlIOv3KpyhO4opg3fSekqza7rNCFp09tkecLujbUmlp0c3tVqh7JV/ESA/
         dSVBjwVQ9uvXWuXSFPTmLq5x44zD7JvwWxLhyC4uMknLNO2xEGrevpWbcbj+HV6Ja4Uy
         kAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169526; x=1785774326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        b=N/3b23F7vy2YHRIpN4dyO3D063keDNHn8f3DRPwA/Ky6RDnEJDX07zmTwvvkVUy6ch
         nVYPJVEQjQsdNPw9wgNeOFXiKgTsRXN4mNYw7LaybL79QdrxEgVMMbWx0772OaD6MJ2a
         9RRw2LkokFxXsBfZPCu5C0mZGM38eoFsRVJQKCtwEgXyol063cfzW6IDRQ5qlFjE9Kis
         W06cXDv59ZEGDIcLk6fBNOaElAOpTjOrInoGYUo5GLsRm4cGkfzrv+Y7RJ7/lsXfUWtm
         qPIpwz9sfHasMxQdqFNu6E9yOlzVsbrs6RD+yy18t2C1irq/ZzRJWhcI4zRGOebXOpca
         F0FQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyjoZrwerlLN6/+2H7/90/+d0w/FYlKzveu7omj69tYpajdiIuTHMxZ+TX1fLkoAQjN6Cwte+i/9zm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcad8NbVVStckHisJlf/8GvfOAQwGs6vLA2jEjnNFUtgzykP5Z
	X54YFQ/PHj5nHHZomOsleXkd3I6hIMNlh6ZvmPm4h4Sy0oB1ah9OL16MV3tWnC1FMmCeFXRC1Nd
	aYJ/ysMkdIzHf5+Mh6v0D7EhfwzcOf+y796ITIIkGuFmVIJb3APzElBIvN1HhXBBPGQoMTkSPRE
	IAanXopJmLlRqyivNIaeC9beCmtcoFdBENjxmY8P4=
X-Gm-Gg: AR+sD10CXsU/xazUPV3AtjdohUEHz4QAjG9dusBhYbLqqQntD+Rdg3iYLrLJirGtX8D
	fHSa/yU/pPTVBRgSbXckUL7Ssah5mNtDP5x/rnIOdWMXVXGKxc08nYwnwJeCWBr7k3XVRsDFbow
	h656fbWRHMCpGEGkLw2fir9Dz98UnBXo5kHn0P4cSBMgle2KOc7XRhptfHBw==
X-Received: by 2002:a05:6214:5d05:b0:8e8:b302:8afb with SMTP id 6a1803df08f44-9081244d1cfmr3824226d6.0.1785169526566;
        Mon, 27 Jul 2026 09:25:26 -0700 (PDT)
X-Received: by 2002:a05:6214:5d05:b0:8e8:b302:8afb with SMTP id
 6a1803df08f44-9081244d1cfmr3823726d6.0.1785169526070; Mon, 27 Jul 2026
 09:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726215740.34574-1-rosenp@gmail.com>
In-Reply-To: <20260726215740.34574-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:14 +0200
X-Gm-Features: AUfX_mzV41Dy28150FZEgEpdXU8-rxizSSlUanYnPvCzcsOwdi410NZkRx_-cM0
Message-ID: <CAPx+jO_EbGZcWCWt5FX00o5_8c-DBeBkweHpXYx9iyjvcaNt5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use platform_get_irq_optional for wake IRQ
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        "open list:OMAP HS MMC SUPPORT" <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: H3Yp46Xc82T5OSaIV2PufH9TiSflXZpV
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a678677 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=MSWvbS7IGcdmO7bg7fYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX0mDAq5YGEpgc
 3Oecwa9zZO+szFC0tdhxIHpX8G6MMblZR3qJm9a6wyKS06Pb4itLiuygf43YLeM+jhlfRRZz7bk
 WLF6UFAz+Lhvs4JUy0Xeq7zdrnge3UA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXycDf2u2+HWSg
 fgP5aRqcG+lwQUfXW3a+cXRb1pjYFBU0gZKvQbrLmkMjcutYTXFda3vPUu91AioZy/FwoDfSrb9
 i3Wptc0TkiA82GRdBtVVzSW45541CKWo8r45nd/JC56A/L32aWk7mLDz/ZDaCcpSHcYJ7SQDAVz
 ca+ZJrvTotskBvri7wBhPEGTyuV+NCztTigRG5VHBBSlU3cBpp/YqNPvQQDpvmCD7zODlQ1oMlp
 BLwQG35vY/MiSUgpxDzD3CgM1zSavqp93SSCmlVEf/tUA6dfPZ/zHV82OKpH+uTDT/4I5h3zTtp
 8dTI9Nai9dNJEnAMkV4GanYUtcb3IuSoaJsECNYzPf46SnqYRLdQauoSU1lMrsEuyDh8fGT9w83
 qIRY8NoMNb8uREkBMiNbOiLMf7XIjJgJNwDdXBi94izi8ShEe/GG967KdDMkMlIHq9ecjrf7s58
 yRFoN7Shf9d3e/UpnnQ==
X-Proofpoint-GUID: H3Yp46Xc82T5OSaIV2PufH9TiSflXZpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Sun, Jul 26, 2026 at 11:57=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Replace irq_of_parse_and_map() with platform_get_irq_optional() to
> get the wake IRQ. This is a more portable approach that works with
> both DT and non-DT platforms, and follows the modern platform API
> conventions for optional IRQ resources.
>
> The wake IRQ is now fetched earlier in the probe function alongside
> the main IRQ, and the -EPROBE_DEFER case is handled properly before
> the deferred probe can be triggered.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..4b5589157c59 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1764,7 +1764,7 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>         struct mmc_host *mmc;
>         struct omap_hsmmc_host *host =3D NULL;
>         struct resource *res;
> -       int ret, irq;
> +       int ret, irq, wake_irq;
>         const struct of_device_id *match;
>         const struct omap_mmc_of_data *data;
>         void __iomem *base;
> @@ -1792,6 +1792,11 @@ static int omap_hsmmc_probe(struct platform_device=
 *pdev)
>         if (irq < 0)
>                 return irq;
>
> +       wake_irq =3D platform_get_irq_optional(pdev, 1);
> +       if (wake_irq =3D=3D -EPROBE_DEFER)
> +               return wake_irq;
> +       wake_irq =3D max(wake_irq, 0);
> +
>         base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> @@ -1811,6 +1816,7 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>         host->use_dma   =3D 1;
>         host->dma_ch    =3D -1;
>         host->irq       =3D irq;
> +       host->wake_irq  =3D wake_irq;
>         host->mapbase   =3D res->start + pdata->reg_offset;
>         host->base      =3D base + pdata->reg_offset;
>         host->power_mode =3D MMC_POWER_OFF;
> @@ -1820,9 +1826,6 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       if (pdev->dev.of_node)
> -               host->wake_irq =3D irq_of_parse_and_map(pdev->dev.of_node=
, 1);
> -
>         mmc->ops        =3D &omap_hsmmc_ops;
>
>         mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
> --
> 2.55.0
>
