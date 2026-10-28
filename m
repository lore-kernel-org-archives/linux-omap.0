Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207721;
	b=jMrTtcHDosVMJAmAqUVwKJLvlWFhT5wyZEhyvtXZivc8Gi9XstjepmSbZ6zGO8xSZBUP
	 UZlchvkOO8KqivLKtfOQhw/NFPjj7LsFmBXwitTftvfrkK4wV4C65htBmLs4kfJlGc8SL
	 WlP9vEFAknmwia0N8cb6jW3MkehBlDIgV5FMLUGGOzyAvU5QUvJiSsVLTxUwpSC/idY0F
	 eURkXo6nzR6McMWeqIGWpMmg281pfc1SH3Q4RkajMqhIVxwYzHPKZixVferiveyeOUA2U
	 SeH6tYmAOYXw3ZfIBKNTFILhTpQLZIRCEbvRGRynToPPoTKhI6KqEyVaswCO9+rLB1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207721;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lVpZBBd6BcZ1naK6hAARqkOrw4FgaJ6r2PdCGvRJwb8=;
	b=CMmNkqpPojzW6mwwLLWvSE54mxY9Va9/I+bXYqyjrBPCpkuy62J4OLPRv5BvdFtv6Sun
	 V/NzUsQtn6GfdeG04jCRyUnRtahB/5USsc1L7UaxvT4dXFjUuE3H3YtNkq1AthXEVzvON
	 8wicZBzjC5iBhZyLUAAszxUpy0J8jos1dOWrSx1VCXdi37Z/H1hTAzXVIlaBal3Yi1GH3
	 Sh8iE3ryvRfDq3dFl/akBjW79ZDngO2xprRmHy185XzwAfgzJhQ3woLfD4RKHJEFg4Wf3
	 YSriPuWKwM1c/vlc9D9qpgP4e3DIDco8MzuDJvS/q6Vp/oAIrLRh3P1UuSTVtTkiiRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7Hj8i7j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jri6dcO6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13431606A326
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13431606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7Hj8i7j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jri6dcO6
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAZiU1458862
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lVpZBBd6BcZ1naK6hAARqkOrw4FgaJ6r2PdCGvRJwb8=; b=X7Hj8i7jl0lBI2KF
	k7TFqn9Tc3lj749cD6LOZeC0HwR1QUFE+iI0dwxg4/z8RWtWEQ2GyihGA6f1BJ4w
	3YrIO9zjYPr/+jUQRBGh7hgKDXC0I4McNqX4pQDVpQ2WhMd/2vAzW4GqHmR8oJTc
	qPlAfVAAgIcDbQtHtPM3xofUQUUVR49e4uiDisC8HTtveofrpTjIN4g8zd9Jjyu4
	ccTphFQMEsdQ1KZ1m9vecfQnnmLB0DYAEZef/fr7u3PdPuBy8RlbPNVCybUUrXNg
	kFXV6ueVBNOm0QHwfRFHL6zpL0sFKGma6j6GaAS2h2YowY0qBtYCws2K4EZDIhLI
	Yw7ouA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82tua1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 17:15:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89ff475a0deso1177432b3a.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 10:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207718; cv=none;
        d=google.com; s=arc-20260327;
        b=e7vvutlRl1igWVG+UQOozXlT4z6CbMWoJJTcwDZZyKg39tmW+tyuvN8UN/lFDE+v0E
         iJlOc4fx/nfSLrLCyIfXUvOsqZQ6UFLh6+wgFHwexCOStmd4Rfu5v3/UKhp+VHlLbngE
         xkuKcZDz4PxUv5cPh/RnfIaMSH4HpYZOHOFCMpOmZlypW1hUqf6x5cWawnhKwfhhZ4rK
         0+IfZqRYj0ejMhGYJH3srRf4RhheYrX0fBFol1eaD6iffibeSRAT8DjNVdf1MTpTnZ93
         bWZKUTxVtN8TFNJCEBZcH1aNnR+91AhlulN2BCXrx9xTgyMnkm+tCGhYZCHVIPIXRrEw
         /Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lVpZBBd6BcZ1naK6hAARqkOrw4FgaJ6r2PdCGvRJwb8=;
        fh=BvGG/DLC4b7nj/47tg+wP0iPfaD9gOqJKq7iQQlz/hE=;
        b=AbT7tQTzef7DFnu8luAqH0iEYRKp/pneHO81gk33mTbtdv1O54GYvYMlkzYKFnGL51
         ZGhqE+76BR8v75Nsnic36vZHHw6fHkDACTCZzJM1psBrkvtx3fQUZgNIK2WMLstCnze5
         u5s/H7KG1ASOxPl24DYQb6MDCfQax3/d2ePHWXMzGmL628ouAsiCISkvlvaO7yM89SCc
         kuKWq51nAzAeWPXZiXdi2oaNwVOjdrHJB50YgNwZl+RHSM/PpDMTlALTfi45C3JezXHn
         L0tdPMspQIDQyk6CasnvQXFL9IjXFQ2DB46k+/PQ/Rk8PqQgPj0OFyCFT64/4o1XT30K
         jOcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207718; x=1793812518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lVpZBBd6BcZ1naK6hAARqkOrw4FgaJ6r2PdCGvRJwb8=;
        b=Jri6dcO6GdVeZsHN91aNFsUMuzuIpN87bdMxFgGxN2h9zQXB00Ndl8xmtR3VIATfl9
         Hxal0NM7Gm3fZm0VX2Gd13Vkaq5TRUotBdyEcHQrPL6j/U2Z6NcWg0aniA+WP19I5bW4
         WZBFIP9elNOxz6QQt1KbtUntklwdUEeGbX/QSoHl2EAOgteOrPAxJYFerjbomTHRhLm8
         tSNE/7/0VvnJuMSD2YOcg3Ob7jtmNBVgqijvypDzgOqOKAwBaEMGqBf8f+NJL3NRcVBG
         YYLmFs1nfuKJEjB/x+Neiq26Sg2m/ryyuAKi236ij8IbdPhWfHLUvyXX5g2Aq5FxLW8C
         ovjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207718; x=1793812518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVpZBBd6BcZ1naK6hAARqkOrw4FgaJ6r2PdCGvRJwb8=;
        b=tzGvmW+sjBNHgdK1rPSAGB9seNhcWWguxKyCnJA3sm9eW8rtUkx1pk1cMs5NiZmTYF
         7ZUIDD23KAOmMgqNWE5FB32zauzRfy4EkoKx5buuX7q3g9aIs51jljNQ5jqmBiU6R9iC
         ATcdlGzCBQ+ggB8u1meVl8Qpl5YcpEK39/uNJv3iZ1yVxeoqSgA7t+c7NeVgI13upsKv
         YrJherXBEYC5WuKptoS8EwuHYnLhcaA2fnKO02yJchtQqSYbANS65N70Pzbnn2V2gK9A
         IwwdtLMHDF+1s84sdz1xdP1WV8gilQWbP2a0MYskZE0MHcVwJefF5eq5UhMDJgZZQTre
         ymZA==
X-Forwarded-Encrypted: i=1; AKwUvBwx7TV8NAioEDi4BJe8WEGpwoMxKfDmrBK+Oo1vfelVnpCtWcAILi7/lg1y7lyzuCPZH05gBm52DAg0@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/3EoS7FTM/YpilWPKYco2KVtWKXkhMIWS9znh5SUfM9IO9ReI
	xJa0C9yI0FOHc9MhsvR2sxOSVlGzyPj6/d1b7NtqKsddVMIMBcB/CS5lqij4U0ISD60ieBBNlFo
	vC3AyihomTDGzCBOvrJNyizdHIAHdqbV+aDbYA+bI3Kdeo+DWcBHbsPEzo/5mKoNzSx4jj+2Gjn
	sQ5giNfh0AKzblQafMu3MOtfFF/ztGruJnSHFilCo=
X-Gm-Gg: AYBFou1YMOD+TUQn3SwMeZXvBtSfFaM18rrpGGC2ulvDRjxNoY7Mwpxte3XV0L3iPFP
	ZwcwqK4OvNrE0IuFPZ9VY6f8Oh7qEto8kNDVxV6owgrAxhIeTDr64WJ9eUNHwDqLJGzekjMul5S
	LHmty63QwUgpJ62GvOZP+5ydKZMZnTsDaQSvrLKeUoBgwfpXVrrIFU1kg5CQ==
X-Received: by 2002:a05:6a00:98e:b0:880:f278:6af1 with SMTP id d2e1a72fcca58-8a6e3c6d4f1mr2220306b3a.7.1793207717485;
        Wed, 28 Oct 2026 10:15:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:98e:b0:880:f278:6af1 with SMTP id
 d2e1a72fcca58-8a6e3c6d4f1mr2220248b3a.7.1793207716755; Wed, 28 Oct 2026
 10:15:16 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930182826.766224-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20260930182826.766224-1-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:02 +0100
X-Gm-Features: AclHuK_fjeLlk46QsRi5F18GI9C6DkGzMOX85vGIn-tIqSPJA6_auKZfqsXVpXo
Message-ID: <CAPx+jO--zsr3TY7W-o5Jk=L5caDh_HYXi-VZTmCj46ixcE5ioQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mmc: use dmaengine_get_dma_device() instead of chan->device->dev
To: Frank.Li@oss.nxp.com
Cc: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
        Pengpeng Hou <pengpeng@iscas.ac.cn>, Rosen Penev <rosenp@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Pan Chuang <panchuang@vivo.com>,
        Zhan Xusheng <zhanxusheng1024@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Rakuram Eswaran <rakuram.e96@gmail.com>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Runyu Xiao <runyu.xiao@seu.edu.cn>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
        "open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
        "open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
        "moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
        "open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2IdH-bOXv1CDC53KhxKN_-HCSdzwEma1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX6hbK6AY1COpa
 YuvfdWmAN2PYkWvoG5Kz2e1kuntxBuS5uPWTnzksiqe9JgHkm8oRzFl/nPoYbL9zHyWsW94MHy5
 vBHkeKu+WHfn7H0Ah2eeFcX/bj7/1F8=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae22da6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=LDBv8-xUAAAA:8
 a=Gmwv5stBqA-RK-55qqAA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=ST-jHhOKWsTCqRlWije3:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-ORIG-GUID: 2IdH-bOXv1CDC53KhxKN_-HCSdzwEma1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfXyvtlUDB6Q5nK
 bXASfYSp8M1QWpGAsnjS31A1AAvdGmih+3ywKqL6NmBAtQWrd6z/60YsajAZoVH3luPyPFl9ngt
 nVulRMYwp7Rdu39D+N9fupTvO99bGKeyOnbznbaxdJt//bcxzjAskpQiVTdiEff53xykpIF+WSR
 XcSVs4Y7ih1x8+ZEk6gH2cIxF2eDgKFGL+WUfnT8h2pv1nAj2Zxp1XexgNZ52n1B54yjml239sp
 Aei3J32hZWc+tHQFPuuni+B3d+/UX8Mf1S5xW+WJ1JtPhiyz8JFPJfOhK6Hf/4YS5W+g1cy2JXD
 vjb0ajDhoCNBlyMaSeoT+cTnvVXTMq4UFPpPXc4HMLq3aahEqLQGhehw2FKPSf5C7FLzCx3MY+H
 GTjotZJ7gRj791Rmk1ftOBkvHX3jHWR9c25QTc03yFRzfVQ+O61U7IcltPxn4liO1CwYxh79dOm
 +NLOhEzXJupcetWr0lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Wed, Sep 30, 2026 at 8:28=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace direct dma_chan::device::dev access with the proper
> dmaengine_get_dma_device() for consumer API
>
> chan->device->dev is not always the device used for DMA mapping.
> Some DMA engines support per-channel IOMMU mappings, so different
> channels may use different DMA devices.  dmaengine_get_dma_device()
> returns the correct device for each channel.
>
> This also prepares for making the DMA engine provider data structures
> private. DMA consumers should not access DMA engine internals directly.
>
> mxs-mmc.c wrong use mmc host device when do DMA map. Fix it by use
> dmaengine_get_dma_device().
>
> Assisted-by: LLM
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in v5
> - remove debug code for kconfig change.
> - Arnd Bergmann, It take more time to implement move dma_map_sg() into
> prep() functions, some dmaengine driver's implement is quite difference
> and need find good place to do unmap(). It is on my todo list. I suggest
> use this version firstly to making the DMA engine provider data structure=
s
> private.
>
> Change in v4
> - Fix miss "R" at Reviewed-by tags.
> - Fix error path unmap dev at mxs-mmc.c (sashakio reported)
> - move dmaengine_get_dma_device(host->dma) after mxcmci_use_dma() to avoi=
d
> defer host->dma if use pio mode (sashakio reported)
>
> Change in v3
> - add Linus Walleij and Vinod Koul's review by tags
> - Add missed omap and mxs-mmc.c (sashakio reported)
>
> Change in v2
> - find more place, which use device->dev for dma mapping. This time shoul=
d
> clean all.
> - Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Cc: imx@lists.linux.dev
> Cc: vkoul@kernel.org
> ---
>  drivers/mmc/host/atmel-mci.c             |  8 +++++---
>  drivers/mmc/host/jz4740_mmc.c            |  8 ++++----
>  drivers/mmc/host/mmci.c                  | 14 +++++++-------
>  drivers/mmc/host/moxart-mmc.c            | 10 ++++++----
>  drivers/mmc/host/mxcmmc.c                | 14 +++++++-------
>  drivers/mmc/host/mxs-mmc.c               |  9 +++++----
>  drivers/mmc/host/omap.c                  |  4 ++--
>  drivers/mmc/host/omap_hsmmc.c            | 12 ++++++------
>  drivers/mmc/host/owl-mmc.c               |  4 ++--
>  drivers/mmc/host/pxamci.c                |  4 ++--
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
>  drivers/mmc/host/sh_mmcif.c              |  8 ++++----
>  drivers/mmc/host/usdhi6rol0.c            |  6 +++---
>  13 files changed, 57 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 8f4df250a77a0..fb756e8858db3 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -961,7 +961,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
>         struct mmc_data                 *data =3D host->data;
>
>         if (data)
> -               dma_unmap_sg(host->dma.chan->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->dma.chan),
>                                 data->sg, data->sg_len,
>                                 mmc_get_dma_dir(data));
>  }
> @@ -1116,6 +1116,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, stru=
ct mmc_data *data)
>         unsigned int                    sglen;
>         u32                             maxburst;
>         u32 iflags;
> +       struct device *dma_dev;
>
>         data->error =3D -EINPROGRESS;
>
> @@ -1145,6 +1146,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, stru=
ct mmc_data *data)
>                 return -ENODEV;
>
>         chan =3D host->dma.chan;
> +       dma_dev =3D dmaengine_get_dma_device(chan);
>         host->data_chan =3D chan;
>
>         if (data->flags & MMC_DATA_READ) {
> @@ -1161,7 +1163,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, stru=
ct mmc_data *data)
>                 atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst)=
 |
>                         ATMCI_DMAEN);
>
> -       sglen =3D dma_map_sg(chan->device->dev, data->sg,
> +       sglen =3D dma_map_sg(dma_dev, data->sg,
>                         data->sg_len, mmc_get_dma_dir(data));
>
>         dmaengine_slave_config(chan, &host->dma_conf);
> @@ -1177,7 +1179,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, stru=
ct mmc_data *data)
>
>         return iflags;
>  unmap_exit:
> -       dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
> +       dma_unmap_sg(dma_dev, data->sg, data->sg_len,
>                      mmc_get_dma_dir(data));
>         return -ENOMEM;
>  }
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.=
c
> index 6a3c26b7c82d8..3343c8aa1bffe 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -256,7 +256,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4=
740_mmc_host *host)
>          * the parameters of the DMA engine device.
>          */
>         if (host->dma_tx) {
> -               struct device *dev =3D host->dma_tx->device->dev;
> +               struct device *dev =3D dmaengine_get_dma_device(host->dma=
_tx);
>                 unsigned int max_seg_size =3D dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
> @@ -264,7 +264,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4=
740_mmc_host *host)
>         }
>
>         if (host->dma_rx) {
> -               struct device *dev =3D host->dma_rx->device->dev;
> +               struct device *dev =3D dmaengine_get_dma_device(host->dma=
_rx);
>                 unsigned int max_seg_size =3D dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
> @@ -289,7 +289,7 @@ static void jz4740_mmc_dma_unmap(struct jz4740_mmc_ho=
st *host,
>         struct dma_chan *chan =3D jz4740_mmc_get_dma_chan(host, data);
>         enum dma_data_direction dir =3D mmc_get_dma_dir(data);
>
> -       dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
> +       dma_unmap_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_l=
en, dir);
>         data->host_cookie =3D COOKIE_UNMAPPED;
>  }
>
> @@ -307,7 +307,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_=
mmc_host *host,
>         if (data->host_cookie =3D=3D COOKIE_PREMAPPED)
>                 return data->sg_count;
>
> -       sg_count =3D dma_map_sg(chan->device->dev,
> +       sg_count =3D dma_map_sg(dmaengine_get_dma_device(chan),
>                         data->sg,
>                         data->sg_len,
>                         dir);
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 416bdb184ed4c..2d72f56d354f1 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -893,14 +893,14 @@ int mmci_dmae_setup(struct mmci_host *host)
>          * the parameters of the DMA engine device.
>          */
>         if (dmae->tx_channel) {
> -               struct device *dev =3D dmae->tx_channel->device->dev;
> +               struct device *dev =3D dmaengine_get_dma_device(dmae->tx_=
channel);
>                 unsigned int max_seg_size =3D dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
>                         host->mmc->max_seg_size =3D max_seg_size;
>         }
>         if (dmae->rx_channel) {
> -               struct device *dev =3D dmae->rx_channel->device->dev;
> +               struct device *dev =3D dmaengine_get_dma_device(dmae->rx_=
channel);
>                 unsigned int max_seg_size =3D dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
> @@ -940,7 +940,7 @@ static void mmci_dma_unmap(struct mmci_host *host, st=
ruct mmc_data *data)
>         else
>                 chan =3D dmae->tx_channel;
>
> -       dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
> +       dma_unmap_sg(dmaengine_get_dma_device(chan), data->sg, data->sg_l=
en,
>                      mmc_get_dma_dir(data));
>  }
>
> @@ -1023,7 +1023,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *h=
ost, struct mmc_data *data,
>                 .device_fc =3D variant->dma_flow_controller,
>         };
>         struct dma_chan *chan;
> -       struct dma_device *device;
> +       struct device *dma_dev;
>         struct dma_async_tx_descriptor *desc;
>         int nr_sg;
>         unsigned long flags =3D DMA_CTRL_ACK;
> @@ -1056,8 +1056,8 @@ static int _mmci_dmae_prep_data(struct mmci_host *h=
ost, struct mmc_data *data,
>         if (host->variant->dma_power_of_2 && !is_power_of_2(data->blksz))
>                 return -EINVAL;
>
> -       device =3D chan->device;
> -       nr_sg =3D dma_map_sg(device->dev, data->sg, data->sg_len,
> +       dma_dev =3D dmaengine_get_dma_device(chan);
> +       nr_sg =3D dma_map_sg(dma_dev, data->sg, data->sg_len,
>                            mmc_get_dma_dir(data));
>         if (nr_sg =3D=3D 0)
>                 return -EINVAL;
> @@ -1077,7 +1077,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *h=
ost, struct mmc_data *data,
>         return 0;
>
>   unmap_exit:
> -       dma_unmap_sg(device->dev, data->sg, data->sg_len,
> +       dma_unmap_sg(dma_dev, data->sg, data->sg_len,
>                      mmc_get_dma_dir(data));
>         return -ENOMEM;
>  }
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 28aed13549a64..6c0974c494207 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -262,6 +262,7 @@ static void moxart_transfer_dma(struct mmc_data *data=
, struct moxart_host *host)
>         u32 len, dir_slave;
>         struct dma_async_tx_descriptor *desc =3D NULL;
>         struct dma_chan *dma_chan;
> +       struct device *dma_dev;
>         long timeout;
>
>         if (host->data_len =3D=3D data->bytes_xfered)
> @@ -275,7 +276,8 @@ static void moxart_transfer_dma(struct mmc_data *data=
, struct moxart_host *host)
>                 dir_slave =3D DMA_DEV_TO_MEM;
>         }
>
> -       len =3D dma_map_sg(dma_chan->device->dev, data->sg,
> +       dma_dev =3D dmaengine_get_dma_device(dma_chan);
> +       len =3D dma_map_sg(dma_dev, data->sg,
>                          data->sg_len, mmc_get_dma_dir(data));
>
>         if (len > 0) {
> @@ -306,7 +308,7 @@ static void moxart_transfer_dma(struct mmc_data *data=
, struct moxart_host *host)
>         data->bytes_xfered =3D host->data_len;
>
>  unmap:
> -       dma_unmap_sg(dma_chan->device->dev,
> +       dma_unmap_sg(dma_dev,
>                      data->sg, data->sg_len,
>                      mmc_get_dma_dir(data));
>  }
> @@ -642,8 +644,8 @@ static int moxart_probe(struct platform_device *pdev)
>                 dmaengine_slave_config(host->dma_chan_rx, &cfg);
>
>                 mmc->max_seg_size =3D min3(mmc->max_req_size,
> -                       dma_get_max_seg_size(host->dma_chan_rx->device->d=
ev),
> -                       dma_get_max_seg_size(host->dma_chan_tx->device->d=
ev));
> +                       dma_get_max_seg_size(dmaengine_get_dma_device(hos=
t->dma_chan_rx)),
> +                       dma_get_max_seg_size(dmaengine_get_dma_device(hos=
t->dma_chan_tx)));
>         }
>
>         if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 097498a3f8ff4..91502cde0b6cc 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -290,6 +290,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host=
, struct mmc_data *data)
>         unsigned int datasize =3D nob * blksz;
>         struct scatterlist *sg;
>         enum dma_transfer_direction slave_dirn;
> +       struct device *dma_dev;
>         int i, nents;
>
>         host->data =3D data;
> @@ -302,6 +303,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host=
, struct mmc_data *data)
>         if (!mxcmci_use_dma(host))
>                 return 0;
>
> +       dma_dev =3D dmaengine_get_dma_device(host->dma);
> +
>         for_each_sg(data->sg, sg, data->sg_len, i) {
>                 if (sg->offset & 3 || sg->length & 3 || sg->length < 512)=
 {
>                         host->do_dma =3D 0;
> @@ -319,8 +322,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host=
, struct mmc_data *data)
>                 mxcmci_swap_buffers(data);
>         }
>
> -       nents =3D dma_map_sg(host->dma->device->dev, data->sg,
> -                                    data->sg_len,  host->dma_dir);
> +       nents =3D dma_map_sg(dma_dev, data->sg, data->sg_len,  host->dma_=
dir);
>         if (nents !=3D data->sg_len)
>                 return -EINVAL;
>
> @@ -329,8 +331,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host=
, struct mmc_data *data)
>                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>
>         if (!host->desc) {
> -               dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_l=
en,
> -                               host->dma_dir);
> +               dma_unmap_sg(dma_dev, data->sg, data->sg_len, host->dma_d=
ir);
>                 host->do_dma =3D 0;
>                 return 0; /* Fall back to PIO */
>         }
> @@ -439,7 +440,7 @@ static int mxcmci_finish_data(struct mxcmci_host *hos=
t, unsigned int stat)
>         int data_error;
>
>         if (mxcmci_use_dma(host)) {
> -               dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_l=
en,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->dma), data->s=
g, data->sg_len,
>                                 host->dma_dir);
>                 mxcmci_swap_buffers(data);
>         }
> @@ -1125,8 +1126,7 @@ static int mxcmci_probe(struct platform_device *pde=
v)
>                 }
>         }
>         if (host->dma)
> -               mmc->max_seg_size =3D dma_get_max_seg_size(
> -                               host->dma->device->dev);
> +               mmc->max_seg_size =3D dma_get_max_seg_size(dmaengine_get_=
dma_device(host->dma));
>         else
>                 dev_info(mmc_dev(host->mmc), "dma not available. Using PI=
O\n");
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 7c7c52d9e8e72..c42e7734caf1e 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -143,7 +143,7 @@ static void mxs_mmc_request_done(struct mxs_mmc_host =
*host)
>                 mxs_mmc_start_cmd(host, mrq->cmd);
>                 return;
>         } else if (data) {
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +               dma_unmap_sg(dmaengine_get_dma_device(ssp->dmach), data->=
sg,
>                              data->sg_len, ssp->dma_dir);
>                 /*
>                  * If there was an error on any block, we mark all
> @@ -214,6 +214,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_d=
ma(
>         struct mxs_mmc_host *host, unsigned long flags)
>  {
>         struct mxs_ssp *ssp =3D &host->ssp;
> +       struct device *dma_dev =3D dmaengine_get_dma_device(ssp->dmach);
>         struct dma_async_tx_descriptor *desc;
>         struct mmc_data *data =3D host->data;
>         struct scatterlist * sgl;
> @@ -221,7 +222,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_d=
ma(
>
>         if (data) {
>                 /* data */
> -               dma_map_sg(mmc_dev(host->mmc), data->sg,
> +               dma_map_sg(dma_dev, data->sg,
>                            data->sg_len, ssp->dma_dir);
>                 sgl =3D data->sg;
>                 sg_len =3D data->sg_len;
> @@ -238,7 +239,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_d=
ma(
>                 desc->callback_param =3D host;
>         } else {
>                 if (data)
> -                       dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +                       dma_unmap_sg(dma_dev, data->sg,
>                                      data->sg_len, ssp->dma_dir);
>         }
>
> @@ -640,7 +641,7 @@ static int mxs_mmc_probe(struct platform_device *pdev=
)
>         mmc->max_blk_size =3D 1 << 0xf;
>         mmc->max_blk_count =3D (ssp_is_old(ssp)) ? 0xff : 0xffffff;
>         mmc->max_req_size =3D (ssp_is_old(ssp)) ? 0xffff : 0xffffffff;
> -       mmc->max_seg_size =3D dma_get_max_seg_size(ssp->dmach->device->de=
v);
> +       mmc->max_seg_size =3D dma_get_max_seg_size(dmaengine_get_dma_devi=
ce(ssp->dmach));
>
>         platform_set_drvdata(pdev, mmc);
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5ed707..37a8408351750 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -431,7 +431,7 @@ mmc_omap_release_dma(struct mmc_omap_host *host, stru=
ct mmc_data *data,
>                         /* Claim nothing transferred on error... */
>                         data->bytes_xfered =3D 0;
>                 }
> -               dev =3D c->device->dev;
> +               dev =3D dmaengine_get_dma_device(c);
>         }
>         dma_unmap_sg(dev, data->sg, host->sg_len, dma_data_dir);
>  }
> @@ -1037,7 +1037,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, s=
truct mmc_request *req)
>                         *bp =3D burst;
>                 }
>
> -               host->sg_len =3D dma_map_sg(c->device->dev, data->sg, sg_=
len,
> +               host->sg_len =3D dma_map_sg(dmaengine_get_dma_device(c), =
data->sg, sg_len,
>                                           dma_data_dir);
>                 if (host->sg_len =3D=3D 0)
>                         goto use_pio;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index de5a3b70107d8..44c326fd2a9b2 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -915,7 +915,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_=
host *host, int errno)
>                 struct dma_chan *chan =3D omap_hsmmc_get_dma_chan(host, h=
ost->data);
>
>                 dmaengine_terminate_all(chan);
> -               dma_unmap_sg(chan->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(chan),
>                         host->data->sg, host->data->sg_len,
>                         mmc_get_dma_dir(host->data));
>
> @@ -1170,7 +1170,7 @@ static void omap_hsmmc_dma_callback(void *param)
>         data =3D host->mrq->data;
>         chan =3D omap_hsmmc_get_dma_chan(host, data);
>         if (!data->host_cookie)
> -               dma_unmap_sg(chan->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(chan),
>                              data->sg, data->sg_len,
>                              mmc_get_dma_dir(data));
>
> @@ -1204,7 +1204,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_=
hsmmc_host *host,
>
>         /* Check if next job is already prepared */
>         if (next || data->host_cookie !=3D host->next_data.cookie) {
> -               dma_len =3D dma_map_sg(chan->device->dev, data->sg, data-=
>sg_len,
> +               dma_len =3D dma_map_sg(dmaengine_get_dma_device(chan), da=
ta->sg, data->sg_len,
>                                      mmc_get_dma_dir(data));
>
>         } else {
> @@ -1390,7 +1390,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mm=
c, struct mmc_request *mrq,
>         if (host->use_dma && data->host_cookie) {
>                 struct dma_chan *c =3D omap_hsmmc_get_dma_chan(host, data=
);
>
> -               dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
> +               dma_unmap_sg(dmaengine_get_dma_device(c), data->sg, data-=
>sg_len,
>                              mmc_get_dma_dir(data));
>                 data->host_cookie =3D 0;
>         }
> @@ -1912,8 +1912,8 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>          * increase this figure here, we get warnings from the DMA API de=
bug.
>          */
>         mmc->max_seg_size =3D min3(mmc->max_req_size,
> -                       dma_get_max_seg_size(host->rx_chan->device->dev),
> -                       dma_get_max_seg_size(host->tx_chan->device->dev))=
;
> +                       dma_get_max_seg_size(dmaengine_get_dma_device(hos=
t->rx_chan)),
> +                       dma_get_max_seg_size(dmaengine_get_dma_device(hos=
t->tx_chan)));
>
>         /* Request IRQ for MMC operations */
>         ret =3D devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0=
,
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index d5b8a110267b8..668cf9704ac29 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -162,7 +162,7 @@ static void owl_mmc_finish_request(struct owl_mmc_hos=
t *owl_host)
>         owl_host->mrq =3D NULL;
>
>         if (data)
> -               dma_unmap_sg(owl_host->dma->device->dev, data->sg, data->=
sg_len,
> +               dma_unmap_sg(dmaengine_get_dma_device(owl_host->dma), dat=
a->sg, data->sg_len,
>                              owl_host->dma_dir);
>
>         /* Finally finish request */
> @@ -313,7 +313,7 @@ static int owl_mmc_prepare_data(struct owl_mmc_host *=
owl_host,
>                 owl_host->dma_cfg.direction =3D DMA_DEV_TO_MEM;
>         }
>
> -       dma_map_sg(owl_host->dma->device->dev, data->sg,
> +       dma_map_sg(dmaengine_get_dma_device(owl_host->dma), data->sg,
>                    data->sg_len, owl_host->dma_dir);
>
>         dmaengine_slave_config(owl_host->dma, &owl_host->dma_cfg);
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index f8427f071c009..c3edd98376bcc 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -201,7 +201,7 @@ static void pxamci_setup_data(struct pxamci_host *hos=
t, struct mmc_data *data)
>                 return;
>         }
>
> -       host->dma_len =3D dma_map_sg(chan->device->dev, data->sg, data->s=
g_len,
> +       host->dma_len =3D dma_map_sg(dmaengine_get_dma_device(chan), data=
->sg, data->sg_len,
>                                    host->dma_dir);
>
>         tx =3D dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, dir=
ection,
> @@ -337,7 +337,7 @@ static int pxamci_data_done(struct pxamci_host *host,=
 unsigned int stat)
>                 chan =3D host->dma_chan_rx;
>         else
>                 chan =3D host->dma_chan_tx;
> -       dma_unmap_sg(chan->device->dev,
> +       dma_unmap_sg(dmaengine_get_dma_device(chan),
>                      data->sg, data->sg_len, host->dma_dir);
>
>         if (stat & STAT_READ_TIME_OUT)
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/=
renesas_sdhi_sys_dmac.c
> index c7df4da9e865b..bf2b32cfbec6c 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -134,11 +134,11 @@ static void renesas_sdhi_sys_dmac_dma_callback(void=
 *arg)
>                 goto out;
>
>         if (host->data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(host->chan_rx->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx),
>                              host->sg_ptr, host->sg_len,
>                              DMA_FROM_DEVICE);
>         else
> -               dma_unmap_sg(host->chan_tx->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx),
>                              host->sg_ptr, host->sg_len,
>                              DMA_TO_DEVICE);
>
> @@ -188,7 +188,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct=
 tmio_mmc_host *host)
>                 sg =3D host->sg_ptr;
>         }
>
> -       ret =3D dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_=
DEVICE);
> +       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, host->sg_l=
en, DMA_FROM_DEVICE);
>         if (ret > 0)
>                 desc =3D dmaengine_prep_slave_sg(chan, sg, ret, DMA_DEV_T=
O_MEM,
>                                                DMA_CTRL_ACK);
> @@ -264,7 +264,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct=
 tmio_mmc_host *host)
>                 sg =3D host->sg_ptr;
>         }
>
> -       ret =3D dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DE=
VICE);
> +       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, host->sg_l=
en, DMA_TO_DEVICE);
>         if (ret > 0)
>                 desc =3D dmaengine_prep_slave_sg(chan, sg, ret, DMA_MEM_T=
O_DEV,
>                                                DMA_CTRL_ACK);
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index a205c222a821d..e8d2bd1491eee 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -289,7 +289,7 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_hos=
t *host)
>         dma_cookie_t cookie =3D -EINVAL;
>         int ret;
>
> -       ret =3D dma_map_sg(chan->device->dev, sg, data->sg_len,
> +       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_l=
en,
>                          DMA_FROM_DEVICE);
>         if (ret > 0) {
>                 host->dma_active =3D true;
> @@ -339,7 +339,7 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_hos=
t *host)
>         dma_cookie_t cookie =3D -EINVAL;
>         int ret;
>
> -       ret =3D dma_map_sg(chan->device->dev, sg, data->sg_len,
> +       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_l=
en,
>                          DMA_TO_DEVICE);
>         if (ret > 0) {
>                 host->dma_active =3D true;
> @@ -1173,11 +1173,11 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host=
 *host)
>                                                          host->timeout);
>
>         if (data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(host->chan_rx->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx),
>                              data->sg, data->sg_len,
>                              DMA_FROM_DEVICE);
>         else
> -               dma_unmap_sg(host->chan_tx->device->dev,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx),
>                              data->sg, data->sg_len,
>                              DMA_TO_DEVICE);
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index 8d9d4f362999f..74888260e85c5 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -539,10 +539,10 @@ static void usdhi6_dma_stop_unmap(struct usdhi6_hos=
t *host)
>         host->dma_active =3D false;
>
>         if (data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(host->chan_rx->device->dev, data->sg,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_rx), dat=
a->sg,
>                              data->sg_len, DMA_FROM_DEVICE);
>         else
> -               dma_unmap_sg(host->chan_tx->device->dev, data->sg,
> +               dma_unmap_sg(dmaengine_get_dma_device(host->chan_tx), dat=
a->sg,
>                              data->sg_len, DMA_TO_DEVICE);
>  }
>
> @@ -583,7 +583,7 @@ static int usdhi6_dma_setup(struct usdhi6_host *host,=
 struct dma_chan *chan,
>                 return -EINVAL;
>         }
>
> -       ret =3D dma_map_sg(chan->device->dev, sg, data->sg_len, data_dir)=
;
> +       ret =3D dma_map_sg(dmaengine_get_dma_device(chan), sg, data->sg_l=
en, data_dir);
>         if (ret > 0) {
>                 host->dma_active =3D true;
>                 desc =3D dmaengine_prep_slave_sg(chan, sg, ret, dir,
> --
> 2.43.0
>
