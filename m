Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D53914E4
	for <linux-omap@vger.kernel.org>; Tue,  9 Jun 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018747; cv=none; b=QiB2gYOZwkyeHGXDyQzQJzh2zmeIrbEnZ9w/+c503aJVuRdjGZL3cG/iYRQ8s6HZh1Cd3zRonKBGcmfJ12PU+/MfrjLXl6ohIEbW85Lv68mSN4V8hlb14GkkRvWOd5cPla7vb2AdCKYS8UJpPTTH9DGHZRovp7VYAjmTNbcNOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018747; c=relaxed/simple;
	bh=w1ClKgLhZ2bUXZdj2FMLv/c23L/8Zs6enQ18IQWTTuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FteXogsOQPvbMpGyjEsmcLlQO/0NANjRUs2xLQwkOFoFaBbJoCQzbMixAzocEECzexYDtMsriVzE/UvVroBCH+R55csBTCl5PN32y0yOu1Exn7bLmjdogcOGmxpYZms0/DIkNUmntzgKP4yKfr3rUcWgPo8Z4luNkDnPZAjt3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDiIrBYd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgAO5pLn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDiIrBYd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgAO5pLn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClatW2247956
	for <linux-omap@vger.kernel.org>; Tue, 9 Jun 2026 15:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMJJ/z4tFmq1ROVKLM1UW2J9lXKDuK2hxDYpfB3TmLM=; b=iDiIrBYdlotazEUZ
	OPyfIz2PkBmylecDyPLU/witxmar0q3GzSccaTD+NWakxvgNkbsvsVuse8mbKM55
	JrvpdhjNnxu5vrgjM3o/xKotsYmPQOC694xMre/ZDTukR44deG7U7wv0A1F8FqtD
	6DvzJ1QzQiDLKGPD8/+KvdEpxVz1pwUKFO6yW2PYA4QDUKyMnYwm8jvT/WN7eVPY
	GCAyQHzpLVRnwBL5xfa50FOUNDmOOS4n9TkSLM+VnZcdBQtVrVnFEQwwWD8YbzAH
	CJnrR5NOd2Urbf4Z5OQWk079PAF9gVFuDEIDrRLkCb13gaUKSJsCpuK042RxTnMo
	69cKEg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeethca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 15:25:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84256bee9a9so3606543b3a.1
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781018745; x=1781623545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMJJ/z4tFmq1ROVKLM1UW2J9lXKDuK2hxDYpfB3TmLM=;
        b=kgAO5pLnUZ2Tq8BSLT2w3NwZrN2wzhH77x3jTduuqk/ElhtZn5EQK7sikKmund5UHn
         2rbIXta9a/AaWIcXH09jS5UOje+2H+sMphGik//VTMl7D+X18HEGuFMezRDUwnrSB8cy
         CB9cM8zAU6YAeBGpYZPQ5az4/SxL2w6UFpvxALuPp5+6t2zmJAGjZg/RDeBqDZpVv8tI
         N04A1Jsf263SjmNSOnthItYkJgU+Ode3FxGc1YQjxH4HoEdkHlx0ey95bzkKUfl/bLeZ
         jG4PTjoBWz3XmWvoDFJdtKDVIUjlTrjM+H/09nbKcgseM8+sOmO3+JNafsmsnIfuK7tV
         Tatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018745; x=1781623545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMJJ/z4tFmq1ROVKLM1UW2J9lXKDuK2hxDYpfB3TmLM=;
        b=N+auF8nU0ohmm8gTTwF1K40Fyi04poJAuCgFhDMewFPPgha+qznUAHUCnVg545NPL/
         i7GqV4S2IkxMB7/7YEVPii7iJokqyVGRDmijL60SXP1wEikXbbiVDRXNgMxXuEBDqiOF
         27n//qwyU/Kj1WykniD1l1jcBhEn+StMnBH50YYeUVlj1Aujp3OW62jsOKyqsxs5YoP3
         ASKcAVmyXUyBmfbWm00YBd7DIPhAjI4DXR4gKLs9GIS9YlcgG0i80Z11ssOaEN3btCK0
         leAn+GpuUZGoH0Fl01kUyW/4YSo7NbQ82MaNe2SJ8ec2uQMjung9rmcerqlI2jzu3QxV
         N9lA==
X-Forwarded-Encrypted: i=1; AFNElJ+TFaEPiQQw+EATCO7f1+7yvYd9zgLTrAdCJldDmfjRdAuBtLZy3RLW0tP105+pzMuXsGnDSYawfKa3@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9idPpf8Y6r/VDTO9KoDYS5HqY+9rC3jC3M90YXgj2mNHbqO1
	OpQByiizmVbonWk9tlTrdUy17lvIOEBdkDljOMEhPQumPkvbINgiaGhoh1O/qetn4LSd1SaUZ+w
	RBIzCp61qHjXwg+iN/Oa04dW2+d/jGQWyLgaM/5GhP3jxoxkHZenL92+sHCZkkkNy
X-Gm-Gg: Acq92OFBSv/sWtjVUENXJJHRKPaH2IRjIxvfVA7Nyx6LiJg/lyIELkYC4BCZe08VC1A
	xEMSmwM8ebV1uL7X2qkBjIH+LJ1JIyyGCLJr0IcVxtMwEqAws7SeUB+P8+dIhISa1/nOTOkporh
	Y9P/5BoyqneUP28trPiqqvVy3m9GMO8t9UOJjT8m0FPUs6wNsEHxhNAuM0pzB8mwaKfGnuvibNU
	8MS9FYCDS7HhSFxu8lcaMhDZgXDvOV6Etm3HRhjNXk4TOlpHYX1JR+5Xqe0uvhlIcxTlNruLLS3
	kc79+xz57tmjauO6rshl96u2wysdWHlVjhuUHq8/1skQDyzw9wjd4CaLL2zPWKkkPLWi7llv3U0
	LpG3C0oF4YPFYrnELVWgeg4XEgThHyIs=
X-Received: by 2002:a05:6a00:451b:b0:842:7cb7:a3aa with SMTP id d2e1a72fcca58-842b0f86bf0mr20856492b3a.33.1781018744820;
        Tue, 09 Jun 2026 08:25:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:451b:b0:842:7cb7:a3aa with SMTP id d2e1a72fcca58-842b0f86bf0mr20856437b3a.33.1781018743915;
        Tue, 09 Jun 2026 08:25:43 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282880050sm21250746b3a.29.2026.06.09.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:25:42 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        vigneshr@ti.com, jingoohan1@gmail.com, thomas.petazzoni@bootlin.com,
        ryder.lee@mediatek.com, claudiu.beznea.uj@bp.renesas.com,
        mpillai@cadence.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, s-vadapalli@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, claudiu.beznea@tuxon.dev,
        linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260518004246.1384532-1-18255117159@163.com>
References: <20260518004246.1384532-1-18255117159@163.com>
Subject: Re: [PATCH v4 0/7] PCI: Add common helper for 100 ms delay after
 link training
Message-Id: <178101873635.8877.10733384254725006435.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 20:55:36 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a283079 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=snT30zDU7jmJpjBr2YoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NiBTYWx0ZWRfX9BdOm9DOJFLr
 ik4Lo2OzggYMdx6mwynOk07iK+kiGnOYjjlipmbYkSYG0MgNUO+BnIVXOkPpUIvv/F7b+Smk0w7
 J98MxMg+XcXWxi/B/tLDf/36v2oLxUsQvLNCRg7sinOoOSQbX1EpuajiXhc5dCa4tYOT9WngrOv
 GPZiR4mgWhEtKDEdT+rMA3pFiqJSCCC2ILjhXw4gXM92Uc5S8r3y7lBo+jcfCrkgiCo/F65LMAi
 CZrqeiIWLF9eP40ZYGO4o4ppp4Fn3sKBBoL42VBn7Eyr63u3ztDeM6fbSaRJPrsNpIIFPKOE1yl
 dzB5puvwJ+7a/UfoIBAVHZcf+ptCayrJ8ZR50oQ87I9to+eh2mNrWBb64fU8F9LZHOdLCWEvPr+
 gRjdAxIJdZZz7OUuIPPFdQR3qSvtkZJ7qwgS50cKPKb0uylbUjUxoOPu7Yu5OF0ZSOfSkO1W0Ye
 otXFoNciVe3sZplOfaA==
X-Proofpoint-ORIG-GUID: 92PZC6Wemy5Tww5vuwmFtAz2unsIpaS6
X-Proofpoint-GUID: 92PZC6Wemy5Tww5vuwmFtAz2unsIpaS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090146


On Mon, 18 May 2026 08:42:39 +0800, Hans Zhang wrote:
> PCIe r6.0, sec 6.6.1 (Conventional Reset) requires that for a Downstream
> Port supporting Link speeds greater than 5.0 GT/s, software must wait a
> minimum of 100 ms after Link training completes before sending any
> Configuration Request.
> 
> Several PCIe host controller drivers currently omit this 100 ms delay
> when the negotiated link speed is Gen3 (8 GT/s) or higher. Only the DWC
> driver already implements it. The missing delay can lead to violations
> of the PCIe specification and cause enumeration failures with high-speed
> devices (e.g., NVIDIA RTX5070 GPU, PCIe 5.0 NVMe SSDs).
> 
> [...]

Applied, thanks!

[1/7] PCI: Add pci_host_common_link_train_delay() helper
      commit: 29fbf582e75015c031e7965fdd4084af123b9ca2
[2/7] PCI: cadence: Add post-link delay for LGA and j721e glue driver
      commit: 869317b95fd735684057666a65dd8ef95d4bd669
[3/7] PCI: cadence: HPA: Add post-link delay
      commit: 8dd5d65d0dc750b6890c0102c3992f4cef516196
[4/7] PCI: dwc: Use common pci_host_common_link_train_delay() helper
      commit: 681adc339e4c972b9f7a5ef8c2fb6a2f7737d4db
[5/7] PCI: aardvark: Add 100 ms delay after link training
      commit: 8a602b8bfebbf9a755e8f4732132719a3b298b29
[6/7] PCI: mediatek-gen3: Add 100 ms delay after link up
      commit: 798a96740d61c24f193b82388b681b6a4f102d3b
[7/7] PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper
      commit: 0ae259d0434bc31fc71696355538fd21027d6ebe

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

