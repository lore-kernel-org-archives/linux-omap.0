Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3135294B
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608080; cv=none; b=rYRsOR4zlN94+ANgDRVOGpC0Y6RLC0j/InvXWCdpJ5vq5+TtXxlot3WQpuYnC4dxNo8gs4V29bh12iSjp5zIzfZNTwOPeipcay/ASpQUG81+7+/N7cYW+sTRFv5u0GcRMb1hd4iegctRwS/eS8HS/SwatJHxiyDV4oC3Ef2F2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608080; c=relaxed/simple;
	bh=/xpe0WZiMxl/GqX7qwhgJXFWRG2PG+0p92lLjw6JC0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M/dpOqaGhJNaVrAVkigwoXiWJHr6NBm/zE834RUND9CCrI80Rik+/bDwXdeNNY2SIIa5dM1ksvlshjEbbas7W7m5Y+wIfPv9mu/xz1kSXWLc51XSzF/YcJiZqTzm5oKdyHdZJQ3S3jBQbj4ETS1NZcP5HIZl8eC65DZjbkXtAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8YXT+Qe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ISFSMnCi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8YXT+Qe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ISFSMnCi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S927Gs811651
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 13:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wGMo0m1R2L9wwbTRPxCXUEgVOcQ6/Yw3wU/Y91P03Q8=; b=Q8YXT+QeY4P06cQc
	N/4uFGZiGouljnPWHr1Fr80N2Kqf0k01NRQuAeasyWrFpvFyzmVTsMc4hfLHsGjS
	kfY8MdWdpwixcVYhsvoE6Ep5Af5lLrcA1cGYd+LMnvOVUQGEk/czRmf2Q/B0FwRH
	2/daLG1us83CzfFERdEu+40Ibnf2W50lVoPtqVArBInciktD25oQBR3L95U8pGqm
	D67ea37JPV3Cmzggkv0n3HQhYkjW+M29AnE5rPZchNY5DUoeHoCdBv8kAO0MZ4CG
	7mWpd7mI830gRfF4o1taUUhf6H2YBqL4txuVAJKrcCrGFRP5M23b3CiY+Yi08O1e
	oZCHGA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by6qbjq6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 13:47:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a755a780caso7147785ad.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 05:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769608077; x=1770212877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGMo0m1R2L9wwbTRPxCXUEgVOcQ6/Yw3wU/Y91P03Q8=;
        b=ISFSMnCin7fEsT555OMX+fEgRru+rUNLwkUS6MiqxhBtaLjSbY0bkICQHx8fA7m3Yj
         FpbAeeWKrjen6P35KWgOEyAdgXLD9TRfr3lhSjXdycUffdjOYImQBYf+KQYEVV+cImJ+
         xNyXmG0HZlR/sOaVzYanTcDaeF85kX2KVBTpzjERuKE2XM9ryeDZCkaUWUa0D1gkqPRv
         SxiUBAYFgz8+GbIGx19hQO9hWn8VHmvYvPe9FTw/j7MDZ46qdHvQfN95eiTeJJwXYVvo
         ePas4skvF+w1B2iJzr9s76/2/XHsFTnthr02DyLethWKIUfBuLZTh1SfMeIEmqF8ai6r
         MNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608077; x=1770212877;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGMo0m1R2L9wwbTRPxCXUEgVOcQ6/Yw3wU/Y91P03Q8=;
        b=LVxlbZ2IzRjOMMebdhKIqVCWrwIY2JUA2i/Ut07tfNLwdaa3klZkc13COaj6RmdV1+
         gTPKA5KhseoVEX5egxjZ4/+AOPd0fdDUSjTrq+yQk+SN1WAjdL8Oy39X7t5LUw0KWuPt
         RWzktHMrfFVM3lnlH+R0OQd7SC1Wmw5b20XsCHWZarIACdubjJ5LjVjPdfMJfy+v6cGA
         wzlMLuo5BZsz9c5tK8J77OCYeJgANqViHrpzFLxH6hOT9X8qreuPi1kBKYK2eColnuwW
         Ti4MEqQOjYC1HlYiFtiPjsQeiNfiHW37FoYqqrZLVnLdKA1lB4T5UNxjj9v8t3QFtDTq
         G4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfnZwPpJVkTxFrLgBnrg42+8JGgwikOVKybUfQmz6r4BRzH7vgQtunEcMjnNvqRVOZUHDM0Qcj5y0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LjBW3eE/EbgXAsxlu21986qvYAH8vKaE9Tzi1jIUwXj8QrPp
	JXaL/5A8OcUpVu7b6yrkQ5Gx8ZU7O/LHx58yuf71nHvmN++7jDeB4Zy/1xWvlc3S4y5vup5DoNm
	gsf++yaQmQc+PSBvnqSXY7odasLdOdoiF3S3qXZnLhU8WhXc9Zi9S/bXPZPy1saRd
X-Gm-Gg: AZuq6aKemwDd2fGtfC2aEPQzk9rSyymhx+LZtdUd+CPPTlzp9KkJw6JkQi6TtNt58Q6
	ciY3cM5sRGFxe3l/st/xFtAmJ0UaCvAzk3HQpoO7MzIRSr755AzKBKZQM+eZXx8lxPyqDN9XiDY
	4Z2ENAKdzEYTf2K/sNyI8Ux9jjBjTl7ml9KkIu762J6erdL3RPRKOb2hDR7WjC1wGZL81+Huuxa
	P6A/UpQTYmOwZmgOxC2fhkLvNmyLKM4IuFML3LeVmE5dIEsZ8hGXF6BlkvIn6q5yK0V3/DP1ZTe
	u3ktMmU2Dlw/kFLGspyYFKjod9nohUOy+0bNBfTXEIL1IdF6ocP16WdQoVdVrPwl7+j2POdzyKx
	RzMLZvQk=
X-Received: by 2002:a17:902:f60b:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a87120f746mr50143625ad.1.1769608076683;
        Wed, 28 Jan 2026 05:47:56 -0800 (PST)
X-Received: by 2002:a17:902:f60b:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a87120f746mr50143365ad.1.1769608076044;
        Wed, 28 Jan 2026 05:47:56 -0800 (PST)
Received: from [192.168.1.102] ([120.60.55.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c45c4sm23790595ad.62.2026.01.28.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:47:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com, cassel@kernel.org,
        Frank.Li@nxp.com, Koichiro Den <den@valinux.co.jp>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
        heiko@sntech.de, srikanth.thokala@intel.com,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
        rongqianfeng@vivo.com, 18255117159@163.com, shawn.lin@rock-chips.com,
        nicolas.frattaroli@collabora.com, linux.amoon@gmail.com,
        vidyas@nvidia.com, shuah@kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20260124145012.2794108-1-den@valinux.co.jp>
References: <20260124145012.2794108-1-den@valinux.co.jp>
Subject: Re: [PATCH v10 0/8] PCI: endpoint: BAR subrange mapping support
Message-Id: <176960806032.58847.15614322725355216575.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 19:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: qU9Uu9ClDonut37vZmJxKSEXsJM643Iz
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=697a138d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=F3mjE3T3/ow0zpRzCzjSvA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Ux4BfgyPd-WidXiTcjQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: qU9Uu9ClDonut37vZmJxKSEXsJM643Iz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDExMyBTYWx0ZWRfXxtfi8Tc85DkG
 v8hSFIGovJcPw7tpQSWwWO15J/pWv/4cJcJx/noasKcv120Do1EhDbX9dyVy4KYaDDpmhuqcz2c
 RJi4hDak6XK224KW/fLUdKvozbytU/uW4EWfpR1jsq2pY7fXrwHULRBXtIv/V/gp8V8tN+9k/1h
 gVYc6gu/5ssufqbxG+GQipqeXsbKbFAmfllOQAEidtXZTCIrjyYLDhWAHgs1dXICV7Z+Qh5OZbp
 nGVqVFUvuxXtf6DgHHm84yVokcCHFhSKNE4BpphAzH5q0a5X3TkxDVSBUqyaQIDcXYoSZvIW5ti
 TxeKuhBZsuKJrxLufYkGHMa44NiMps8ZPzlWgkgcq1uN7qEQFI0cEyI8xOXaMrGPgtFbMMgZPtt
 D2GyBvOo4ODOlIzGAlTNEPlzwuzdcEzZr4r82IKGT8ZUJ70qRdV0cI9ZsBpG8PeH08Xl6CJRm5o
 rvyv/bmwlRZA7BoNgTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280113


On Sat, 24 Jan 2026 23:50:04 +0900, Koichiro Den wrote:
> This series proposes support for mapping subranges within a PCIe endpoint
> BAR and enables controllers to program inbound address translation for
> those subranges.
> 
> Note: This series is a spin-off from a larger RFC series:
>       https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
>       The first user is the pci-endpoint-test, and the real user will
>       likely be epf-vntb for Remote eDMA-backed NTB transport, demonstrated
>       in that RFC series.
> 
> [...]

Applied, thanks!

[1/8] PCI: endpoint: Add dynamic_inbound_mapping EPC feature
      commit: 06a81c5940e46cc7bddee28f16bdd29a12a76344
[2/8] PCI: endpoint: Add BAR subrange mapping support
      commit: 31fb95400451040050361e22ff480476964280f0
[3/8] PCI: dwc: Advertise dynamic inbound mapping support
      commit: c0f1506f63546308e894469ceb0f1fadbdf9d2f9
[4/8] PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU
      commit: cfbc98dbf44d52738976f592f30c2ca6bb282939
[5/8] Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
      commit: 7d857a3f517df4591d4c85832c4ce5aeb0ddc038
[6/8] PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support
      commit: 530e3701a81b228c369261798ce1b7f63f5d6c08
[7/8] misc: pci_endpoint_test: Add BAR subrange mapping test case
      commit: 622e1ad5e49c6949dd8c97d71f609bd17cfb8813
[8/8] selftests: pci_endpoint: Add BAR subrange mapping test case
      commit: 0ebf8e7943e01b2c38c199228f51adbb89c02425

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

