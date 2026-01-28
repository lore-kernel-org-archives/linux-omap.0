Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E9126BF7
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589283; cv=none; b=Jg9izBAaJAYb3OIPdkF1soQiVcXuWHJgCopoh1IPxdqM2owXchQ3/fFC4yEtmFPiyjeVj7V+sgQUeosWxAII1Hn57q2Huvl8XqqRXkrldqJPAuRi4hByygOZZ+2onyOWsyYvm+sH8WPkn5IJKrqjnO2vrk0vdRBC5EhztvjlSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589283; c=relaxed/simple;
	bh=4GoATlini5cili1q/r1KvCweFB/L3qHkAYqZeZLC6mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPTiEoDAbqqwG7uSwhhDg3wleMtyZKPVILdzGYGj1kIZ+F/cvF2q6Y6lid+XCgKRiSIhQqfx/Z64GJ/KOjny0pmLWdrCqd/TDoR7guA5QOx0/bjHHYJqaWucZdLiPqQhA0XBiV+95R3LHlFZBVb+SnzilzZ/CJH7RPu+jj1vZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lGbKw+I9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnTujBVo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lGbKw+I9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnTujBVo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S3aX4s2477157
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 08:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cM4YbbwLxlZdfa/MZFQvlcZ2nOy3bOu5nF8W7uOLFm0=; b=lGbKw+I9Akb8+JeN
	FNznUn4dYRHgNc9AE9xDho7KEPgFPgMVeJDVj0ux3SPp4M+VclSG0jc5hvKr9sZo
	7GXD8AuISrFE10THJ1Uh+St09Urv28hxMGVYpARkIMl/j03oW/ZyxUp/xuFKD9xt
	6NFXAp98SxfAw0uYGIz4CLsmwHJG3gNAdPrK9W/urRXXszKIJ3NmYq3DZYf1/UJ9
	mZ5InWanGkhlWY9896Ci6BXXgk0ZFubrp4Br0vONjFfkNbtTymSuUFaB1cjR9D1b
	Ljm0PYMo0e5rmrLQYBDr91A88R6q1bBLtuE5R6hifg4vMMUN3jEmCNrLWJKgx2DI
	mEh1JQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by20y2hfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 08:34:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5e166fb75so1699114585a.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769589281; x=1770194081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4YbbwLxlZdfa/MZFQvlcZ2nOy3bOu5nF8W7uOLFm0=;
        b=RnTujBVo1A25Ixz5iAvMcfwivTha+EPCES3e99PN0Z9iiYYaKIPaDuxiU6i9KfQEFx
         esU4iU2ElfXkT5g90yY7EBCDVvpgAUJlfKpgzobaUbQHQ9izjYiHHUMYkBvHPXpHoq00
         kq374NCv9p8oXMMiO+eA6urxJf+OrpBnfYrd+6zgOw0orAh86gw9ta46JUkPoarjeeeh
         bEaF60/J2pAPIBQ/NsRUcVtjfKrKBCOq3Pqh9y1YHFQVWJm4svcLVsgMyZDP2pBPB23q
         rgQsTHurEtlgyR8dBGQ4XmIeFMH6rIEQvbAUN2aU0EqaXbrckYNKKp5/akK5KCML0w19
         7w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589281; x=1770194081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cM4YbbwLxlZdfa/MZFQvlcZ2nOy3bOu5nF8W7uOLFm0=;
        b=Nu7kQcGiMVP1VuDjvNk5l4/whsKgEMgKuKrrx9O7lM8pjtAHiZoiH1VIvS5Ol9eLdP
         XumYEdhfG3qRKjBmM3iNzTTbsdOasOrLdDw/D0pWZJUQbOYfGnZIyHFebOtfllm2sN61
         Yp1pvic7KWMIjZYxQmoW1M52dS91PN0HjePoPCWJfxo/c1u/UI0XfWlfi3STsKYr4d3x
         i6oZhyMYUYTryX8pKjqixemVLjweOADT0N3ild8oFZFoM7zNZ8+iwHaTKt/zxscPhcrC
         bpYdqqXc4X43R/aZB5S3zUQKrrcxgpMyji5NJsCGuBNkij7YYnVye9UzXdhwXUkcmsB2
         rJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCVt2BKR40YWGfz8TCmh/JJJsDK3TlaZDL2FS6SY/YMARxyMUU1wKkCPJaH8SigAKc+nA1TN7CpwIWMu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kn/n71FUI0Y166XfUoN/z3gV+qcAPJLJyyImGeMpmQcWblDA
	gehwXBKEa8V2rE+V7DfTaLwOS630r9cSvFYzLRrwtCj1AKKPFTU4s+jgddYmC4txn1eUSlZRt3T
	VBSz4LBCsGD/2cQEthx0MNgBmlewGnsfDLNa3BDC3AGKiYwP2ZvyBxCUQoqtszG+B
X-Gm-Gg: AZuq6aJYFk/GfILxBOcxyolf6hLsK+0MRUa01JAWO3ZYfOgUZMyEzpggokXztXkQcwt
	TOfEbG/RD8CE8FHf3biAMyC9uSZqgOSF885BBQ26mWhTLDZ74GyKB/hHzVRiDK410Z8CCunNOca
	SK13qk1MY5ZsgaaYX/UwzUJSOtiygtYDKRBlM/tFs+iLbT0CP/qDLj0iTgCBBgkkA6vHu3wtTP4
	8jYURAvhCqo4AoTehirPFLGusbQ1+bEPl1YF3/HCQXRu4wDOuNzgV6zAAAc/Z79wMTF9QtXBhAA
	JT1zQ0Cml67gb5m3pkDDtBdGlDlEZXW1LXlCdNSIB9TG/wOc6ZNRO8mIBYfYsFyuSsv51GieBR5
	feAwc8i3KmkRm2ZIbzuosi2+Oia2j7snpu6fezQ==
X-Received: by 2002:a05:620a:4507:b0:8c7:6f8:ae4c with SMTP id af79cd13be357-8c70b8d11b9mr554087885a.43.1769589280770;
        Wed, 28 Jan 2026 00:34:40 -0800 (PST)
X-Received: by 2002:a05:620a:4507:b0:8c7:6f8:ae4c with SMTP id af79cd13be357-8c70b8d11b9mr554086485a.43.1769589280324;
        Wed, 28 Jan 2026 00:34:40 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:6cbc:dfde:e62d:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c515sm45165645e9.11.2026.01.28.00.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:34:39 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
        will@kernel.org, grygorii.strashko@ti.com, ssantosh@kernel.org,
        khilman@kernel.org, linusw@kernel.org, brgl@kernel.org,
        Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] gpio: omap: do not register driver in probe()
Date: Wed, 28 Jan 2026 09:34:37 +0100
Message-ID: <176958902316.4537.1901338597465599154.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127201725.35883-1-dakr@kernel.org>
References: <20260127201725.35883-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pmU7UB71meN3OlQjhE532UNuSNAMw-Kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA2OSBTYWx0ZWRfXyBo3ClHdjRkq
 N+7Gyi3qJ1XyZ6USWuoGB13A2SviNNHkBY2JZ0MZRRDxgC9XNcYpjwWvmkePlnnsVDCdHhmecZy
 6my9DKE8ZWiShRCEmln2TqcOlVgSRO3qM1ayDyP+6ChyfzQ2uDog4BzFn3ZaGXSyrmNPnogU3hS
 wSlk9pvDs4X0LbrDv3ze1qpD6gi6WOjJuk5+yxlq+Nt5gPweexUQ4fJWy+QY74JO2YjUum7Im+L
 NGBCaQBQFc1tfiDHpF1ng582AWoyj9ia2hdh7D4Rz4hVTABwHUSCjVRoAjCTJS9StXxFpTSOwSL
 e3+HQ0L8jw7Dt25Cky185hsoL2npsJJmbAch8voRJ3eyG82Rx4d21fQXYGeGFI7T9/+kkFZJrVP
 y7UtMF5g6gBtIvpzDVXyxJmFIuTHRDDEqdE/dZJx00h1cYo2QNgOzvD6dQ/7NisV4nXzm7t5x+B
 6Au+qvRTny3RtxH9fRw==
X-Proofpoint-GUID: pmU7UB71meN3OlQjhE532UNuSNAMw-Kk
X-Authority-Analysis: v=2.4 cv=IKgPywvG c=1 sm=1 tr=0 ts=6979ca21 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NmoZXNGLfAXcYQ8gNhMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280069


On Tue, 27 Jan 2026 21:17:12 +0100, Danilo Krummrich wrote:
> Commit 11a78b794496 ("ARM: OMAP: MPUIO wake updates") registers the
> omap_mpuio_driver from omap_mpuio_init(), which is called from
> omap_gpio_probe().
> 
> However, it neither makes sense to register drivers from probe()
> callbacks of other drivers, nor does the driver core allow registering
> drivers with a device lock already being held.
> 
> [...]

Applied, thanks!

[1/1] gpio: omap: do not register driver in probe()
      https://git.kernel.org/brgl/c/730e5ebff40c852e3ea57b71bf02a4b89c69435f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
