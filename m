Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFB393DE2
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549766; cv=none; b=WPzTJSPVveXi9FTa9YG12RBTCmGEvrXjEnZPapM7bpqhvsQGTIfUn/47r5pSku97CTeOtECzIMUPmVE6Fb9OHIlZlR4ZqlIQ/ytdrjSxLlIX25ixJ1IYBcPEx1K75LKIJUQ56UhCdSuUe/+iW/UqG24OZbgQkUXin0XbJGFdErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549766; c=relaxed/simple;
	bh=2RnMYeqxbIG3xtIeWfFsB1hg5NMXMzWhzE+LRApt/Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkh4yD1StM6HMfjeTm/QPfWhJNYN11xmwIC4cmGCLteMnyaqAEEU7v3QdoBcG4AfNTFJZAdaiQt8IdMaQiqOX8osUbgmDCnT+8xzjMYL0EbQkr+NoK+MCoDWnnlvtVi0sA+hJePpHWFYDgU2a2cUNttg0ISVEQJaOuwioHOQGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENRwTg0w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PPHXqAny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENRwTg0w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPHXqAny"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9fTi3898192
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 18:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=; b=ENRwTg0wQgzSXmjb
	Mfte1+W3mldM2W+BFRwd5RobDOHcS6s8+faGOe2/GKEJD9WDyst+D6RhEif5zxkB
	f07S0mjqTvx+yjrj1RV22kPs2lTRdBsFTG8Bm6Flb9AIB6BxNP4kZeg7Mr4CeZiH
	r4AN05B/ZgCQNZqrsF40onb9wXoeab19z7+GnYtCUeQ3/EpHuqsyPDLIY1OTOPwj
	BpPfmU9Z0JNE9EFMybPlewCnDrMBcv008XOVT5vhTlktjiHVgD0LP49Omsr9vvQx
	3060uUgJI8cqVgNyDUGp9xoPwxoOzWirQICEKpKbwV6laGntEqoPrjAQGofLKPqP
	6chb/g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kgab5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 18:29:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a82f78a20so2473832b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774549763; x=1775154563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=;
        b=PPHXqAny6U8hgvEK1fVGS1FyMGn3MsbmCwEG0VS770aUO4koYz2PEZs2iaTrZbHES7
         Op9dt7CURpMY/EDzA7ef3W4jxCUWBmxgLltqvk2Tnl9wFdVYd55GYcOvGsblkSm60862
         haxm8KWiYHMM4AQofOuBc7PQg1G7tNf6iPJE+gpQ3QMkvywOl0QGa3IHaAHSLtuypchd
         0cgITdEhrRoK6tfVbWsUGapuzNWJSEBM5+DmOTVHfkuUzKXegMs1kxBRmsDQt1A5VXc4
         z6v3paSH6S2HAhoPGsyKVvh9WXIO/Lq/H53ckU5mXzAEZM32ZxPDB9GVW/T5hG0EenAd
         BAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549763; x=1775154563;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhld1R/N1HGh4ArMHTWbMovB6Y0to3d0n9zJbwkChvE=;
        b=gtqtWv3WJkbHywarN4DyojcjYgaEDCi3VbZ1M99BXUKRvZKXgByfejixJJ8WkLY29v
         SHDY/wd42rOFiO5Uv40v3W/mQ6Xlc2rLM99OSu2oU+ZFXwbXMs1cDcEFgOfozK5jwBBT
         guQRrnR9G+bW80HUQdr1RUI+NH8KyF+WK0xpxZewt5bg2KmON4IAH6zRsfrfQY7YOTAq
         Otok8YF6wF4TaHi/Sop8yrOSTEQwbetdpPZfvXvQXp/qH7vYyKB6Kxthb2klv3MYOOIB
         448oYW0Lu5sutZyYA3gguxbSspEVyCv+q7FcIVyCVZmGBSL04efQIcEk53EK4jH3sFxX
         jxOA==
X-Forwarded-Encrypted: i=1; AJvYcCW06ttoiIaVqZ4xIk4Hr/T2pFH4Fs6+ECyyU6JFWf7H7WZoYt+C/EaSpWXt0wKkUu5QpIkZp+SEXu75@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt09/kA/VIoDV3dTm/++yUz+pgyt71+lLYzXHud0hlQPBSBcZN
	tiyqi5J+XmBcS83gf7Ca3GPBq/8SMvHaZtWsQelQs/GaV3o64qwAlFpQcy5Ep2x3sGlFVgCQfIt
	g38m5H57i4n8tROBBb0Pkr2IMkW+A8Rcf1qomGD/DfefVODf3eXmFJsjV3Y2PUjZ/
X-Gm-Gg: ATEYQzyB4OY1SJlO5tQlUOpHu8XxOAMPTRiBhon88/fKsdUgBwm/eBrDCEM89w6qIrz
	Twtq97hLBT1zorLv3ceX8oTmIfxzVdPMJmO/cmhACpSSZkn/2I1/2r2CutPnEwKOMefLyjaIBBu
	ZH61Q7BVtj800QhPLAbCKisRaGGroMzSLXnBT2U3pZqn6JxC/4/RLrSRZm5ThxtwZjPuq6G5ZxX
	3Y/ovncDJ4FU9ydWuUCUg8Z49USXcos7J83uPZgOjBdl6NkJ3CWWVWuZr14woLZ/oWX52w0G52o
	dMqnmVBydy1+KWLAhZOa14yR/+nwZFGZBH1AIVM3FRtpXAglP8YLpK+ifdr/5uHpl8qRzutt0P8
	BThW9VqDkoTeagvOXMIpdc3s=
X-Received: by 2002:a05:6a00:430b:b0:82a:786f:e39c with SMTP id d2e1a72fcca58-82c6e0da77fmr8829085b3a.47.1774549762469;
        Thu, 26 Mar 2026 11:29:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:430b:b0:82a:786f:e39c with SMTP id d2e1a72fcca58-82c6e0da77fmr8829059b3a.47.1774549761916;
        Thu, 26 Mar 2026 11:29:21 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d21777asm3568532b3a.18.2026.03.26.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:29:21 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, florian.fainelli@broadcom.com,
        jim2101024@gmail.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com
In-Reply-To: <20260313165522.123518-1-18255117159@163.com>
References: <20260313165522.123518-1-18255117159@163.com>
Subject: Re: [PATCH v9 0/5] PCI: of: Remove max-link-speed generation
 validation
Message-Id: <177454975543.471319.11131195385745201008.b4-ty@b4>
Date: Thu, 26 Mar 2026 23:59:15 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c57b03 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=YByT1-VEI5v2HgF6YmoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMiBTYWx0ZWRfX8KiR9ZrMYnWD
 dJXiFIcmPFSKxOULCSaH+npW4lcIa/EPdvd8idx14U1L2WZxVs0Y2OIxWfE0rnZNK07syHu/voe
 3FiSdsSRER8vgbXyaPxHXn7nlqJuF6fLQx1P3qP3cg650tQ3e/4g0PvGViWx+dq4hBKWCSw2HLR
 YQuwB9omNEIPpy74GfclHWkJdJwdiXoc+Lroxf/tmKzUcHGqXTlkpD/wBkKYQqQWqOu/kpOJJbw
 16Pp6JTGKOfxdSTn47XVc0Q63imU6mhiiabcFNcWrzf/vRKjFioU69CmbJBrjLz2Xd06EQ3uske
 Hq97BW/EWzudwMU1b63SO9TY623bNb1/Gm97X+HD+BDGXIU9Iks/0EzNB9Z3eAWou+rtE0Ml305
 e/53Fk0EKDx+bXC31RvK8UAkruu1Qgu5byY4StuwN4IU+UTw6U1WY6ZFUogVyIRZBma70oWiXkw
 XdSMFOQIDXg3nWP7s1A==
X-Proofpoint-GUID: sxrsxDJB3Z9YBs76Q2yJpis61MQ3FxNq
X-Proofpoint-ORIG-GUID: sxrsxDJB3Z9YBs76Q2yJpis61MQ3FxNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260132


On Sat, 14 Mar 2026 00:55:17 +0800, Hans Zhang wrote:
> This series moves the validation from the common OF function to the
> individual PCIe controller drivers.  To protect against out-of-bounds
> accesses to the pcie_link_speed[] array, we first introduce a helper
> function pcie_get_link_speed() that safely returns the speed value
> (or PCI_SPEED_UNKNOWN) for a given generation number.
> 
> Then all direct uses of pcie_link_speed[] as an array are converted to
> use the new helper, ensuring that even if an invalid generation number
> reaches those code paths, no out-of-bounds access occurs.
> 
> [...]

Applied, thanks!

[1/5] PCI: Add pcie_get_link_speed() helper for safe array access
      commit: df61f4732adf9de5ad1f5e71b7670710c1597d18
[2/5] PCI: dwc: Use pcie_get_link_speed() helper for safe array access
      commit: d884b0e51459175f17ddc52759ea4533bb752130
[3/5] PCI: j721e: Validate max-link-speed from DT
      commit: 1542ac6d83d0b5706f45e2937de7b4f7b8c4831d
[4/5] PCI: controller: Validate max-link-speed
      commit: d0cc5918a1d539344190cbb19fa3ae0e7b0dca1e
[5/5] PCI: of: Remove max-link-speed generation validation
      commit: 15217c7015c0e1804925693c55d721aad8987e32

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

