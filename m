Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70D332904
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504970; cv=none; b=eVvhRID8pc1rgp9WY/Ymoyi0fBTGkIHJU7/Uz3i6fsUoyRZkpNJf8bd3/27i0RFlovDgSLiqWFPjW/EaqVwe2t0tO2YyryH9aeH9ni1Sz4tkDda0RlVsY3L+UCy9sVUmvdQi+huiH3cPq6qjgiXZhnIbELPV/ylJcZMsITOaGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504970; c=relaxed/simple;
	bh=fngx/NCf+/N+HScEHfbKqwGhEzf/fUg4MNQWFqsEczE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWsLCfUlvDmSKzzvWVhV3LlUj5+mbSkp96K8Sma0DrS2DaB8nO/qs4vn0zcPaOEt6qCL1WkyNG1i07a6HbkdzjcKPMsDN8iatj/bhzBT/HW/D7q3okbnBlU80ngpW/dzgrQfkzRsJscu1De2d9+IaDoC5gS7dLnJoHA+uWxrAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7To+Ioj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zx53euiU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7To+Ioj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zx53euiU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UE82496030
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 09:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vvlvwl1QyFdXJth2eYeA5TIEczP4LPciKUZRTZ+rabE=; b=T7To+IojkhBG8ZEO
	HE6Qoqu0XRQsxt4ddkt51TOn+acN4BA44nEUEqpNUbFCc87saL2AofL3nRqLj8i1
	aQ3BmwQmlgIBzljkIa/CoHWIzFxuccXrGRpx+F7Dvr7F+jaLMbDg/J2eDOJaHnQ/
	iUSjECYtYgkTcXIdFMbU5V6rfQgDZVZGacNh99aPERt07liTUKVZMFNu11Yt4qOO
	srx+CkvrZD6t5L542M/t4zGVzbP6AoDpPMkuVzXKeZUhHy/WgGY3S7nkTZeGbkun
	AmZ/uoXLtmLbExIwQNxlNEm9ghMZ5q3HwcOaCjj1bhlprMi9z7ZOjUmGfO8GT1UQ
	/ChUvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bj30d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 09:09:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52fd47227so950831285a.2
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2026 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504966; x=1770109766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvlvwl1QyFdXJth2eYeA5TIEczP4LPciKUZRTZ+rabE=;
        b=Zx53euiUHvdDTpXi1Chm50fLYF5YfpHv+HyUZMU9qBr29WrFjCRVgeeKXWgPYh9RR3
         PT/+2I1IpU2wCoHG8bW2ku7af1HO1B6nbwB6P6SnmPIjhuukhCgV8k1HHAH18oMpaWS/
         clsht0b07Bp7fi8spnoDbSiXJH8P5loJGKZkUj4bnB4x+KZ+/AjwEscqL2ig0xozjHTN
         QoZ0LdXyGYZDXPr22hIp+9svMp4koE4JDcMC2dMQtOKgCPtjhXsAlq0Ya0eNRRX/oXVb
         mAf6kVl3eRnoTWxwF/UCYZBon9Ipnoem/2ytg5C/sOcw9H4jEXGWqgKjagLZHp7aYZWG
         n9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504966; x=1770109766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vvlvwl1QyFdXJth2eYeA5TIEczP4LPciKUZRTZ+rabE=;
        b=AemblC/T7Egx/7wPq6knH9EbO2Hu2ATHRVNwIPqwdMlsO5/SrpNdntjQTNPI8NODui
         sQxEzLqg/vnxtfEsyFt/uVMW3DA3wAy7+n36BvStXjkPyMJBrvbJ/oSOR+N7u6Mp4v3b
         8g3m+iSLYdT0kkyqiJ2Pm8ENOgTO6RTjtXgMGd9s1V5Wh9p8JKmbhVbPyyryShdmPFsE
         CnjDJK0JlT8VaSVNyrc72099dVaMITsMMBAillviFwB9KtFcy+o7OMr1J5lWqGLZ1I2h
         2wtbe3yc4fznQyslpkyKglxw4A2ucw7TUSUg6G+IRXF2OoA7z7OnXQEnIEjPqqhvm6po
         p5EA==
X-Forwarded-Encrypted: i=1; AJvYcCXnpMwDGVWxsato9P2DR2SF4lHA440Ib9S5it5kaw3Losfpn+M2i9BNW+fxhy3Lsbb62XV5uI6ah5nJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVRohdp55KNj4MsTya3HFG9Z83L7MpBxIt669tikjbONqX5jv
	NANLeC5TIDx4w921dGMINldW+YPJV2A5n/N/2m2AnzvXRgoehDrmznB22hdkg7s1uQhMDvIPE/D
	x507SbWrMuSVg8QSnBaD3Byk8gMaVGdhQFM3JQPswZYBqILzBjLRqjgqanK803Ppb
X-Gm-Gg: AZuq6aLSXz2HS5OoH+4obWKKyx/nvAlZ61Xfec8g2oIIqqSZKExuSA0axtxj94gZZE4
	zrr87EM5kTQvgpN8yyJD2Wgfa9gvm9xGg+iOKnl0NUDv4mnZalmDQGMZHtvtmWdniVqEOqnz//Y
	pbZXVAuJygQnRvojTyV1OLvn7ntvPE+YKhpN0J2fJsg/e52lJeZtrmCFSgIHSE8FZ9XIIcgqH3B
	LigycxO2StgNBGSfnttUJT7bMVJVldMDbU46GD3F4V1AGZ3ESUk9JPozEGbj95uz4nJLpyag1AK
	Te8f2tedfskq/T3ihHEcosTb/EqxlwcCXC3oq25V/S75XU+SZVuX7Sh+2RLwi973t6+D59SnruI
	bjMz2CEh90rB0lojWuq+kTjMcnz7GSTzXV5MXKQ==
X-Received: by 2002:a05:620a:46a9:b0:8b2:e827:14bc with SMTP id af79cd13be357-8c70b8e5f77mr100446185a.56.1769504966118;
        Tue, 27 Jan 2026 01:09:26 -0800 (PST)
X-Received: by 2002:a05:620a:46a9:b0:8b2:e827:14bc with SMTP id af79cd13be357-8c70b8e5f77mr100444185a.56.1769504965631;
        Tue, 27 Jan 2026 01:09:25 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:262e:d32a:e347:8b74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db7b434sm128163345e9.4.2026.01.27.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:09:25 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
        will@kernel.org, grygorii.strashko@ti.com, ssantosh@kernel.org,
        khilman@kernel.org, linusw@kernel.org, brgl@kernel.org,
        Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
Date: Tue, 27 Jan 2026 10:09:16 +0100
Message-ID: <176950495232.13307.15142034347404555496.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123133614.72586-1-dakr@kernel.org>
References: <20260123133614.72586-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3oWoDlGszlVV5q1_z0VtC9SHgf92fERw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3NCBTYWx0ZWRfX407VlgXNK9ZA
 PKQC51o3q9PMdaDJNqJCgaYaQcpKA/bPxDkfZE3P73p2MUibMd3J2PSNtjGVWtbx5pU6yys6/CB
 chd3jv7FvPo4/oGLzL7Q7YJz4XTpG9y3wmroF5enirdyg3UU8xw/9wTXotu2eZUPh6eiZelKtaK
 dOTn6JVJtVh3wahOkdQafr9QW4DUHFTOXE3IZJBzO57DvRh3ak7RYTHQBlN7s3zVfYdEDSh4+Y+
 XCEZgqBBXLCpt/ePyZh9EJoMc/5ZTfNGNQ7OjdihjUpB6nPJfxxUwefAPjoT9inFlf6piM3ApVg
 c2XaloFYLNggeKe8pdBUm6lHKhdiGa6NFON4S6Uj/9QRx8ctjHKIevUWtyEBNSFPTpzca1TCclP
 pYSOAlcL/WRvxEJaPzpwaHn9TR7qvjREbU6ZxBAJX1OVfGQqW/HQXlbDmYDZes5mPBUoIHObkY+
 U2qpK3dhHJgJ7YMkrFg==
X-Proofpoint-GUID: 3oWoDlGszlVV5q1_z0VtC9SHgf92fERw
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=697880c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=StneJEbOKPblmvvYeVQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270074


On Fri, 23 Jan 2026 14:31:56 +0100, Danilo Krummrich wrote:
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
      commit: 3cb53b083fa665ec14c52962f50b9c1df48cf87b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
