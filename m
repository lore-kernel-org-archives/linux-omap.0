Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352740;
	b=d7qMIXrzUmNVSH0m/reMh+JV6ZH/jd8WmRjYuJdzKVVbIkiGdRbslP4u64J7UTt1o/K6
	 7snGGsIo/ikHKxHXHZDB64VRClgPiTshX0Y55rIYYY7M1cJeSSOYdzgeYxPmhInFk1Ati
	 jEL9MKfduxrOsZLgMiEOU6VLbfQbcTWpwZmPjc11CzhLvQR+utP+bUH1j7R+3FGItcK39
	 3bOLClRlQOsrWwD3vegXGws65I6WbCD2yEgNzkhbsiFaQhmqxWd7QiRMa2EgO+abyymAw
	 ooXhVKgKh/ZsQgwqWxlOCTIoEW4Cdn2OFIl84y6hFnuMPLxYzdORYQp2eblSB0i2wMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352740;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vglUYMqRsBfRkgFk2PnznDRUjloE9O9KIkcFHk2fc3c=;
	b=4tKlILlXNaArrxZt9NgqHo0NuNyW+OtVwD1E49Hz1OXFrsEFvLRxM16Ep5Sy6sxZoJjC
	 lwcVwJv7WnbRGZjZPC2cb6RC7+z3M2U+GLWlkrHNqnFlv8ugue/IsdVrLnB2vgLVVHb2p
	 XdZChD9idy+t8FhYzioNoTIuerotuIvm5g3jch26XDNXQ3Zc2DTRFRDIZ08lMCF8uOoe5
	 bmjlP/wt24Bx03EJEPXtFozW/bV2y4H7fDPt8eP15sb8CxqTxUtRvEZyu/KRUefMU3b89
	 seepW7q/Xvq9exEa3Nxki3UatZgJYGUOHWw7iTbYqziYFvI2h5ZQ4DqkD9EBunP2feg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLoxoJQn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kXc/cDkO";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF28606A31D
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF28606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLoxoJQn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kXc/cDkO
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F9U82374147
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 09:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vglUYMqRsBfRkgFk2PnznDRUjloE9O9KIkcFHk2fc3c=; b=FLoxoJQn7kxkMHJy
	OUE+6G5KiudaIUeA6hPjgKAbndLuYMHO8oFKkpxZOQcHkLgx4esZH8dyG3Atx4C5
	a3J2p0onqxWv5f7lxHCQbvhp+BgIAX8/GSUVHnfPRvD/TNqaXZqy/apbcBwfW16f
	+Yd5kCdAWR2sU9USQAqsoiQ8h0/ZEn33s9EtBTmUwINtMpRgJYRsUE1FQCz6KIt3
	x99YGFA8oEgYIqfxvTQuMEtFD2bR/RFsG1oXQb//mDcZisnqOU3Rr2uL0ZgZIAUT
	GSb4CLCiZgJvbURNFGQACqat2Qiw4fMRhCE8iRgPBipprGVlRIu1uo04yfxaVpxW
	vki17A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj84k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 09:32:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cbf2fd504so76063985a.2
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793352738; x=1793957538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vglUYMqRsBfRkgFk2PnznDRUjloE9O9KIkcFHk2fc3c=;
        b=kXc/cDkOJOgAmi4YTeN4hM3TSgUOA1AVCwI6nsEBqA9TD73CzwHOaP0bWgY081ZLzO
         ZdLTQFA40oY1Dg4es9mO9IBYmtt5LIOTPOFHyPNEUb1FAZP2DpuMk/pk2SedBvK6O35o
         IyJ7qJuXUtCE5KOsmDh+tl7Ef1Yjp86dke2BhpKmUCXY912n21NbtiYK63FVV2PNuuCU
         bXybNsn2HlOI/M6C53CofZ9dfkxGYVGQJFhBH5rFhDHT2cLHlpaWKhuskbalUHjuc6GY
         EixfyCbQyGAG8otlluSk6bC+wg9CsPgZiUwoqhIFaIhiA3RqPEBn/z2nQ27noNkBdPEg
         hfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352738; x=1793957538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vglUYMqRsBfRkgFk2PnznDRUjloE9O9KIkcFHk2fc3c=;
        b=Oc0lnnzODIbP1ob5pDDJHnf60XihnPRTerLEgnvsycgSNwYXKvGoBQJqEPZwXnCh4c
         1uE9OuETdK4xgrwoqQlx+lYtF0n7WuZ07zSOzDAhGV/6/XcmRE+3LxQlyxH//q8AfeZq
         uBw8EKHJx2Ad3KrTiaV8npKw4Rg12RcNx+u0CHJqo1GWCLABNTNRarJ6UJTM9AnKdDKi
         59Scp4IPk8xkKtrPPSqmMiF7wPqS/cr90PrtSxuJMrXL2D0GJjf94lPwLbkksw+5n0K8
         jHP9WZaAngY5SS2mArsONhRs8IDQdO+2zWLpaWjk+PVNqQKUVQjcT5SuyY7VnR4ip0Hy
         6rwg==
X-Forwarded-Encrypted: i=1; AKwUvBwTsFadfEAcO3VCYXH2mhBCsiBgqm1oqSsC567kLTaYg9rBcMFAky7i31gAJnli+wMmAyO7qh12R979@vger.kernel.org
X-Gm-Message-State: AFq9FYKeykGMEkynCc6qRXi2H2WAnPNfo0pHNsVCzEmXqsFUQtnno1nz
	bba9CBhBjLJzC+0G4szx3fcYS8M1ZOvDp4g8GnMmMjXf2p+ZWLESIa0dq8hzz/KmyhnSlzRK6dM
	mqmXBFT5Fu0291iMLUUtPuom8LD50WqlYNQI7U1cfpnquxn38Zx0JtsXVSTIhl7AU
X-Gm-Gg: AYBFou2aIWEVQQu+C6jK57HUiF+JZ3sefVVfFYrTmi6cKYZ50eFH3MEDbJtskWgiaua
	MqzHejQjPLYenAqBcHt7/80Nlv1fQIUrEuue5PVzDhGkTHdvt5a5pXDe5Uo3gooWjmux2nIbmS6
	etLos2LYHRzL9y6VUuQVBgcYtW3z4dh+j64t9L6H5uUdcJydIw45Z+W9PJEnBtpR3yi3So9bUgp
	FYi9MomST6JGUl0XfD77zzqyb7oY3ZrkX0Jk2YaVLw9g7824K8AbbhTLDKQStTzeaa9n+ztn65o
	6moxprEnQVvdMOypmXmmef35KmNTrRMty/biYM2hcvjwGmQR39tQ43zBec9Lgs5eF6yrax+B5vI
	u9D3WBk7VXIjylgpow3Nb3PTjKhhS6Bymr+BKye0GS4BUV9lojxFkrbe2pprDpJVNQN9Bn7lxFU
	Gt
X-Received: by 2002:a05:620a:19a5:b0:940:f224:5a85 with SMTP id af79cd13be357-944217ea7f2mr281322385a.71.1793352737892;
        Fri, 30 Oct 2026 02:32:17 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:940:f224:5a85 with SMTP id af79cd13be357-944217ea7f2mr281320485a.71.1793352737488;
        Fri, 30 Oct 2026 02:32:17 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf0b36853sm43532305e9.0.2026.10.30.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:32:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Avi Weiss <thnkslprpt@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: Propagate runtime PM failures in probe and request
Date: Fri, 30 Oct 2026 10:32:14 +0100
Message-ID: <179335272848.12642.3929434225128874772.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029103626.1527919-2-thnkslprpt@gmail.com>
References: <20261029103626.1527919-2-thnkslprpt@gmail.com>
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
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae46422 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nNi_UgyaDUgUb-MLmQ0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 0FNGCV63j2hP2nRr-A9WC3XY3v39W-Zd
X-Proofpoint-GUID: 0FNGCV63j2hP2nRr-A9WC3XY3v39W-Zd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNyBTYWx0ZWRfX5wja/aZzfefX
 yH+OOMyZoN6Kq8m2nqFfXHxNAYD+JaPrgddyVSrsSIzEQhM/UB0UI6PrERKqemJqfbfD8GL94p3
 6q9x3kq371/w/PqEGqvMzSFJxtk4BTz5xBS6G07bjCDjOMOxxdPV0avC8Y2Bde02uLeMKurX2+h
 oWV0dqM5lKcx1XuY3rChGa+tSLjwXqWm6QrimfYU2LHlCYIopNDLmyTub+sU1bItPC5hvkAgX0l
 pvJ0VnyxL9CF+C8Tjz6MX+KQX3edPsKVFdarx/DCsqfM+IYJQLoHXKLeZJkOjaYC1HZU7ainiLn
 gZTL/nI5HXhkyNC9fMngAGA/ZL1jmPqfh3koQyrh/6ExSBTk3mImYqYa18ad8J6F8wO+SWxc7yR
 aIx40At/MgyHnnoKQB36l5xmT11yUlHdE4gum3VogUEVf16q50OwTppCe/lN0mdLXrXs2Apdn7V
 FdZ1Kv6vcf8c8NUQDIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNyBTYWx0ZWRfXzv+08d21Lt5R
 e9ppLB3fXAVAVTZQRepNXDqMZFAGcyBZPYOZW1761HlP90bOu5n845kp+fGJz1f3Mpt44UBsNjB
 D3sX3kPKdsol5OGGIoHBfIEPbU+XjZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300037


On Thu, 29 Oct 2026 12:36:26 +0200, Avi Weiss wrote:
> pm_runtime_get_sync() can fail when the OMAP PM domain cannot
> resume a GPIO controller, but omap_gpio_probe() and
> omap_gpio_request() ignore its return value.
> 
> Consequently, probe can register a GPIO controller despite a failed
> resume, while a GPIO request can report success and modify GPIO
> state even though runtime-PM acquisition failed.
> 
> [...]

Applied, thanks!

[1/1] gpio: omap: Propagate runtime PM failures in probe and request
      https://git.kernel.org/brgl/c/05be1a99d6d68b24cbe24a191e1af67c70193ac3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
