Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BE463B61
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851002; cv=pass; b=mkJa4kaCDHbeUyWCjHxFVTTzFDMruYo6ofrw3DOz6eqPkUSrM0hSdfTuyQO1YuYSqxUKfTdMVCM6HoX3oRG1m8QWZWiBYt0/xzWsRZhhMI6naNJXld3oY6kc+WBGF0kM/StFexjuKcjzSwqiSg1k39xsisfJvptfyv3uWIDrEUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851002; c=relaxed/simple;
	bh=TjY3JwvN0KkY4QTihEcPkyfz4jaDpiXty+YBU5vi8WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdausaH8b+79qTQcYVhBhAMVX7kunyTXzRY+gHFhR/EoS3KmALftvOJheby4gEzbSuqpiDS5Ia3g9cLi3L3dPnCUWM/SW4nBgcCgPYae6ika6N9OK0ytMglGUavlnHRP720QWUgpCjlM5RwdvAKjF7pgRhK+oIUANW/rd6jdsNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4jUvbaO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWTELEjP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4jUvbaO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWTELEjP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674D2xR24031584
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2026 13:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=; b=H4jUvbaOV1LrAUlY
	3vwxDgGhDrsObzJKOQmJNSyj3CAEpXUskFeT1UeP8PeJd3TVpV+t98BtVgJ6VSvK
	L2ReD3uvsLlWnO7lAMVRWAnBX3Te2G0ftyx9jxp7V2VIQ4d5zFNURDckw6xo854p
	KPJjef8fqQJEcgV0udrbnVj/NqRHwDL4p3FDZumpxpdRi1t1Gnufz4752luSAb0O
	KowheWDi9xDI0bq8u3qr+SXPMJIICh5xAhrTHyuJ5woHN/omiqzgbg7o3VVQ9ysW
	ciuqHO+aUXKd+XHo4uUJ/BXYoygE+Mg6wd415MB/eC4h+xuY5O3npy0JXQmQG3L0
	3FLq5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmg05tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 13:43:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so815875785a.0
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 06:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850999; cv=none;
        d=google.com; s=arc-20260327;
        b=KtvBnNxGev8lPoRJH9ejcU5EmsVeC2f0T0FGn/bQy8echhdMqgXz/mSWLqmQK6nLMt
         rGv3v30EPMrI4fPdSvcgTrvWtJoA9mpRkfiTyZUjLwpkGpXYALJ5rKPIsAbIbljEs1aK
         j7iUn/uzQYmS80o7R38usjCjHcXgHXWNhuyvwXhXDfNTDwyXCTrcEmrr9o6pKpEkAZFa
         ucc8ipyqf6SHGUs8iXWeBOTj4nM3bwYT0SpDg0zBa6YlS7MLNyqaIq/Mpg+DTZLWAB01
         pk1ZZpu8snm4b3F2EirB37+qmXxdYp3EXKwbLvCN0SB4MQuMwVr067NcEsmivw9kDmI1
         mnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        fh=tPQa4z9qMEXzHNDirTDBdUXNSvrw2HM8fGPrMAqtECM=;
        b=nuN4BwrCkM+yZMuA5jL/W1sbK8GztuZoXSU6zM2lH2RTzfhl7PgoTJib/sYNH9Wr8x
         ZRQPi0DN2k0BHYJCWO5JIQOB0Luorz3RRGfFdj1DaKHn4U2/YOIJ5x9hMcOC1jeepeEL
         A+WWRH7YLTsWy4fRWeRb3OT6refLz6L9RFgAA7W/z2Bk0hV4NA9ArFsdsh8mWLvYHwhz
         YQx60bpc9BnuV61NhpWaB3MOIF7mHMxTq876zJHO2qj3OEzCunCgF97B8uVcS/5J4QDH
         ulcOL6YLzrS7ho3vxl3kra9K8AfWlVYhW37fBNn9HiBQ3UdgNjA8eJn4ByonaXcqjQcg
         jrCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850999; x=1786455799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=LWTELEjPj5bx+0sxeV3csThFcUc8P/zk92IMiNytIDYWzLkS6X7a0DWrZ6CBVS3oro
         H3+Ok3pYp+LGhCRdYc7ley8CkaDFvc8bPPtlO3IDL9fRJSrcrLt4Xxrg7JhgGSjqL/E8
         6JCnoZ37TP0tAgdLCcgoRrm9pHWTN0XGqHuqXNC8wkEIsKO58A7vN8fsF9bUYP9UIUEH
         4lQqfL0AKDF5PdDPxIqD3JLb1MPVuUu6e5YYOUTp+VBhDIeyICC8eiypw9LCCu6/aW1W
         E755mlYYexod5dT2FdCtSJEm+S7WbSXvUKP0k0YUKroQubywms66tKj3PlZnwEIbViiQ
         d6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850999; x=1786455799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=IxgDhKIQjch6lhossOIMz28fe05cwLzfd63b0PdSdTlem0WZbNOSo8tSOSSJ6CdQIE
         O2ApGH2Uq+HZltUAEzeHia8MihX+RqAe6MB2Yl/kAVmAVhZTPKQeVJ6ag+LDr5aDsoCo
         t8iJiR/ml1O65p708ow+h4vPOYwkBGhWIp1ryKg1Rk/+Pwk0DSVslrQXxydwOQKpca07
         Inf7wupIhX+Bj3qQLrhzmdxhF9uRTyF4QcPxVeKq35e78pOImRoKmC6UgWtw82x1bmoU
         fQq0JWOS++Xwzhj48WQGR91iho+suqzOx205QmSKOu5spg/rwDQuwG3pbPdzJBNdJEbg
         fEFg==
X-Forwarded-Encrypted: i=1; AHgh+RqJcinF6gTAef17XG6UyehafuyU3i2NJhFbQ09Tw20QvqJh56VtjEGGYxN5QiXEvBqS3w2MqxuIBIAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvUe5hKCPy+gz5C/bMgbxDf8b7X5U5f0Ijv/qvIoHlg7MPiGz
	tiAfGpGmlFDqAqf8rxuPGa/GSrog9P44EU3FwqJEWNZkeYCKAZxX0RgukK7d3pZYQXrvMYuRPLE
	3jPTe+za8OW5HmN047VOOp81mWlf8Fk4Z5M9gwlnlDnFDNIkJYoHdwYCrdE4Ur+HN6/1CWN4XV/
	vJF0vC/zBp12W8OSei98C+CvKa3tblkmlCp/fCKRs=
X-Gm-Gg: AR+sD1386y0l091Qu3C9DAZRTZl1/GSNfcP5/ujQcfWH39103ieTXqI+Bo6r/mgAstE
	8V88q/anulrLhNHkdoD7sjGEw1p3Lzj8U5VqmDP24TEBEoUljiQu76R6h7zwMmfWN+H0DvTHsJb
	cgeXObLia2mJNHuTodXXRlGa0PNXNXRSKenl6pNpP8WnmJ74lq4ZulUlU37Q==
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id af79cd13be357-934a078e708mr2148996785a.18.1785850999386;
        Tue, 04 Aug 2026 06:43:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id
 af79cd13be357-934a078e708mr2148992385a.18.1785850999028; Tue, 04 Aug 2026
 06:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:08 +0200
X-Gm-Features: AUfX_mzfzUVmf-wXZLSEXAVMnWXEdM45wmk6fU0mb5Urir6FFQzHUYENgrkAI0A
Message-ID: <CAPx+jO-P-ytiN4XHwiDQKftUUgK1-eOw3ristbL+r-WV=KSfcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns
 conversion on 32-bit
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Ravikumar Kattekola <rk@ti.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXypBuZ3g0+cWa
 ztoYs1oZvlKi7pQe1/NK468MC9fml6Dn1rJZTgJFQwrF1qNoGg7ss81i7CVf3hx6nmY4kwS4G7g
 Dc/PfJ1P3KYJBkCvv9a33ienXN8lFmA=
X-Authority-Analysis: v=2.4 cv=F89nsKhN c=1 sm=1 tr=0 ts=6a71ec78 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=IeNN-m2dAAAA:8
 a=k1ldLzYygzB-qbcyhXgA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: PEhWaUwEJA-nmgSNj92soyaO_PZonqX_
X-Proofpoint-ORIG-GUID: PEhWaUwEJA-nmgSNj92soyaO_PZonqX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX4jAT55LcGZk2
 yKS1py8Oq+f5txK2zXEKpw2CJZibzFze7/GkKX175F8MrLynai8a7kXQC5SeNn/gwPR7zg2lV94
 gbcXlwF+XUo0frJO8gGpyCZ3VJi6G0+Sg1vj2nf+qOZqpkqYV8+3kFhrvl/TckKRuMdCrTyC9Ox
 9kszPp70QixhrDEXHh03xg+DNNLQI/kPEB9oBbUZ3W21cuw+4SFqZSJpFctQmbY0J2pDPJnpQdj
 U1m/TWmoryD8ZJ/QIXKKUnpXJKMRKiyF0l8Fy7w2hkl3QjBYHU3w8JHQ6/8FW/yzf2uZkIaG7Td
 fVF6S2xSDsQwuppBIzQcrCfC3bgDfC5lT/3H3/rIqWv41Ug8tYgU6Ch/D7UKEzyuGYCJg/9l5w9
 KUdwIyPlbW7BlYNHAUF0gFnYjV9pegD9eVkwa2Lc96uj94Ii1XWqIR63szXVSfq2b4O8ZfktB3B
 YmhifUfdsorNPuoZ0QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Tue, Aug 4, 2026 at 4:25=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> omap_hsmmc_prepare_data() converts the command busy timeout to nanosecond=
s
> with:
>
>         timeout =3D req->cmd->busy_timeout * NSEC_PER_MSEC;
>
> busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
> NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
> performed in 32-bit arithmetic and wraps for busy_timeout values above
> ~4294 ms, before the result is assigned to the u64.
>
> The driver does not set mmc->max_busy_timeout, so the core does not cap t=
he
> busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOU=
T_MS
> is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapp=
ed,
> much smaller ns value is then programmed via set_data_timeout(), so the d=
ata
> timeout is set too short and the operation can time out prematurely.
>
> Cast busy_timeout to u64 before the multiplication so the conversion is d=
one
> in 64-bit arithmetic.
>
> Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to pro=
gram timeout value for CMD6")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..3356ac5a1fa0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *hos=
t, struct mmc_request *req)
>         if (req->data =3D=3D NULL) {
>                 OMAP_HSMMC_WRITE(host->base, BLK, 0);
>                 if (req->cmd->flags & MMC_RSP_BUSY) {
> -                       timeout =3D req->cmd->busy_timeout * NSEC_PER_MSE=
C;
> +                       timeout =3D (u64)req->cmd->busy_timeout * NSEC_PE=
R_MSEC;
>
>                         /*
>                          * Set an arbitrary 100ms data timeout for comman=
ds with
> --
> 2.43.0
>
