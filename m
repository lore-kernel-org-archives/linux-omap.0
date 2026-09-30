Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF1509EEF
	for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784083; cv=pass; b=jXl9l8Mp1UtxcJ0G4Uw6o4KgCqr1STNzEs6pQwR5EC7W7f9mEiVlKrmN9Cj835OVfxHajdY9EqQJjN53KRIQZRiY210Rf+bHza+KIz1UOE4UrL7MdkkNG3WdLRKLbMHaW0yApAY+oc8Vm9/0fbb4psnsGr37o2UDpvly7yehgqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784083; c=relaxed/simple;
	bh=C9Jpcl4hk2nflrSgR/CERYh3R1ZRq3nmrUq5WwdvYXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgZyKagK/IHeBsRs9utEPVH9ilwxFwqvvOa1hJyyk0CpBS/DSF6PsBIi/F+j2jogNC7Yl0e1GwSyczJv7sehbWhIyX3HLXUMD8wWVQKLJH4T9pb03nvYvt7CGSmlU+AMzcIj0vWH7OLFgsJD5aaRYs0J6p1pBr4XHYLWf3HSajQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VUqEiD4d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aX9D8cVR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUqEiD4d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aX9D8cVR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxqQW612329
	for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2026 16:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=; b=VUqEiD4dfcVZsbem
	5GZX8RCHmJyFb3qjkdcQwNLzqNju6aF0K9VSnDL+U1q3wnemt8BVqCFApxTj3oFG
	08J35SR8OMmF0t+xG1GMOtsS7wHQzsdk3J+h+cBwGcAK1dRe3OaBsozt85g3yro+
	bprJG/uWAAGUIpdIICKxzunOfuZ5pKiDiQAYJ9dAsNfX0KQ+46EaczysJTn1fJt6
	HDp6fq1Nyh9SfPoVPM7fZ6CvThCNBDFpgNCbUw07XVU4KUZOK0SrzBQI6Fn+vpgD
	DHeYBE5RlwJZUxUVAGFxz1ZheUO/Ld0dB+6MBpjV4j2V4zfw91lzqD3nUN1mw+hm
	9NLyUg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh81rrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2026 16:01:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1778231a91.0
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2026 09:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784074; cv=none;
        d=google.com; s=arc-20260327;
        b=WQMSFiYddKEAyVzVH3pLKm16QYVDzPbgnG9uBqQDlVCaZN/4rCy2E+ZU4aLuXlbRqj
         Y9s+tIAM3QXa8vhbqLERGLgPiOxFkt/ij+e2M7ORqo1MZqtqBGSpW+4sFK/BfJF+3HJd
         IKa6YF8Y+XYoYRfHDg6HGXpdAK8GCxGD21UyRyXMzlk9jboBsQTHBKd58nd+mIX+gn8R
         tVkNbqIXyeI9Erp2kr5IIJC4eUrz+GKtoN/6qNo1z7pGs5F9zZvl16T4Ijg4c/YpjcI8
         bRQ7u/h73Nnbg5zjfvOAbMaXOgjE5r8t8ZhGhzVjv0zkcrhxmF8H265c8SXrMuVFiB0F
         /gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        fh=LQkg2yJ9BY4NchlowqoMVoAhgEkgNI1C6q4Dr76BReE=;
        b=B9D+8RhIEbJ6EmiJTxO6tirlejiBLt0g4lip544eI0CMSXvXiGXRNwp5o3qIwbp2Dq
         ve48QF1L7TKM7HASOQKrvViZJ8fhxwU16xKIrQLdMVhXMvJacW3LmBcPqN41mHMJzRUB
         K3Z6kYdQH7czbJHfQfO9GK3uEnxS18E8vY9Mvrb/wlgZh/Kk6uHRiO9HpJmEGzfUkpM5
         RQDd/Y/I8RNz8nmridoAhuGf4GLC102a8nYA6th7cMuEBH61dDH0/OO8YUTJwSlaHPpQ
         BmOup7ydvYw5FZm8JdUz00bq26cg+YMhVIkBlBMqXGZT6IHKAx1+Yl2KCdeKDb0DzgPg
         Jv1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790784074; x=1791388874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=aX9D8cVRczpi+8aKMJtkS+J5rOzHQzybOk0HKs+g70BAKxQXcHqIid/1XnxRewPifK
         8E+gEj0CFeQuDgoyrqExHOmHJZ+tLXvOBdT7rf8cqslda9gQ/Lp5kphMXnIcGTr/CR9n
         9tD5pLis95K1+Xa9ezIx31NaATqPz02do54lFopaZcRtHoXQE0mqNQB++N5LLRSe62tJ
         K0Xd2y7JojEv4Rr/sHKxcm8HUAyIw3sMfMGmYOfU/UHl0RlV4FH9OoiWt6sjl193qW5N
         sQkK5QQvzHRQJCuDP/OmDE9zm7jOMgFuumXDh3MyIgTDkAxHCDpZRGsH2IWAIARgF7rw
         h2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784074; x=1791388874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=Mx8/N1zj9IuzBBOgNjs5fErQSbIMtZRBMYA2yrCZkbdFDYt2rZWPj2ZSbdRHZhA3+a
         /7V4EK4P2yQ4VxeAIUwvCnSSKeSkqFX2ePlRXZAW24PwBSRWesC7+SNwIwG1mRChmXCj
         2eoAD7snwTZw2Yahf8K7Iycr6rL13a+EzgdKt5Sgan81V77KlL1PCYKBqIDlvzzndv/d
         zOJAA5BbeLjvEQ5NmyaWXsC10to49AQrj2UEmeyaNnbfRddmgblaDRB2kr2eTkov1kW9
         2Ca1pVUJ7XVXm4RrxTnXK52uGrR7FpJ7jp+CWoRFfyCxdAd8v079hkroDMztaFCRq26l
         t9yA==
X-Forwarded-Encrypted: i=1; AKwUvBx6vH/SjT7SHvAjnmPUpHruJ/I9ztpNWkDZ7RzQPQDUxvWNjwyliqh4A02uDH35HqugLqe5kGB+GplD@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4Iodys1APVnpsOOEEjqWU+TfbKvHQGtoVSlxIguNFSHazB6s+
	cKS6ozjDYgQl2z1/pdbj8JgSc/2nupEO7y2cCbgdrYKgQi6ituaeEx2ILSecy4YSbT0BzKvUZzM
	kFzFFatAKUnKkDbtNeZ/FY35ONpGAIQP1FjPvI+GtxubP3JdozvRvUyO4K2l8yL8cdV5sL760GM
	sfPWLsqrDExKH+3F/O+OB8PkEw07jn3y7InMQ4xqY=
X-Gm-Gg: AYBFou2HJvMBFji3wdbti6IuRMDt5T7Qh+1OOU6QFMcNclwxOe0AuT1Uz0dXirEbuBc
	7VS4VvSlJQnZKNCGR4eevK6j5yF9Z6/TPTsNEb308JGVgP4bFziupqTvOIUymBn9aklmuSTGdPY
	MkMgW32AY4w9pwyxY25tvFNf0f461CYL7zBzg1JDlLvhoqDWhxXn/Kt//rFA==
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-3a4f2c2248cmr54954a91.10.1790784074258;
        Wed, 30 Sep 2026 09:01:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id
 98e67ed59e1d1-3a4f2c2248cmr54925a91.10.1790784073616; Wed, 30 Sep 2026
 09:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:01:02 +0200
X-Gm-Features: AclHuK-_MwI6oqPNb_CFHKP8OEa78Xrn6y9JHyCctq4WiB7Q3lgUKRsQJK161C4
Message-ID: <CAPx+jO8fr+Jkb9u8bx6a7cv0=oD0jUGqZpAamw4j+LVFnqSw-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfX+tUzEu6Rolfi
 aiS73kVGnTsqh0rWZi95wnFVOHv2r9Emga65Lgkc7W460mPRFobsIYoIJ1Bm8KQPsmWe0ObUHDQ
 R8+PZt9lxmR9YUq76dRHxMdjNahWWbCyAa7Bwl0pPjY7paQRH23v25iu+TcVLbHaY21ZpXfZYmR
 urH133YH9mv5Im/w8jqHEISXTAbxipcMZdHJ8DZOhiwxTsAtz5ZRiNa+a0JfHXRxWCQH4XdhTYo
 E+KuzFCo1ScgyZaMn5YtRddTda2R3UOdO7dF8NFS7shRHFJzaDlJutX3xtxtLHq7Ckmg3fO/gz0
 LFWjMjKgwIh/ct56C1YotGDAg4xz0DtvTr9VNvCHn7r3Si8CJJEcp/ulLqXRDiaFw78vJFFI185
 uQ0J7IR+I1d59h+fyuzl5mrazu6tW6j5EnO8Nlw1C6BpskEP0yLWyTEUdlWYoegEFYBHm7PXEHy
 dXjtyAZPS1tRXhwc73w==
X-Proofpoint-ORIG-GUID: hrO08Bm_3FuSJtpz_xLBjmi6xAa4Istn
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abd324b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: hrO08Bm_3FuSJtpz_xLBjmi6xAa4Istn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfXw9dUzX8VcLqo
 gyPUykyLGhSukZ0kI5UKe5O4vk1RPfHDfDXOGNZ5Q8Zb8OsoWcxamEGCLqtd1kTCOuEUH/PK+n1
 hF/MHNatgJe/eXZeXc6ZxaZ06uPPhZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300063

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

At a first glance this looks fine, but I am slightly worried that this
could deadlock. Have you verified that?

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

Ditto.

>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1

Kind regards
Uffe
