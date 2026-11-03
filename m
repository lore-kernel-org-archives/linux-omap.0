Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724233;
	b=WOfsrvOZ0zISm/urWJNVG2+fKCWlyv34ev1XKxR0PzNXMhWrdJo5q3R6JqxJ0fLgdL8I
	 i1QCOV0Iutxp1xze78c7+PayAOfiqUrIGTYBBJ2FSbFSwsDFcpU9N2CHioiJFP3609ZUD
	 jUNZ1bn+iBjiPBSuOq0XqTK4yZi94JUv7tgphsIe/q97Gd+cBydMUjAKPKXuc8YaW2leK
	 BMRX7Jr1qtliB46ZeMSr1YfqZsYS0NGIXj0zICdJuHAV3BE5nEdjqsa+9cLO4nmsS/vPT
	 auKbNHO2mVHiVnspBJRbvD3SKaNpmOEoZ4rogZFp4jN9yGjTJcn3M3jjUnGIdHtDEZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724233;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W8xCoWoLLQfSq8i5Qi+fm11gUA6qTjPeDx6DMi+PVBo=;
	b=Jc4ddGvLJKD7GaazcLdOU5YqM87RU2or+CpocszGSjcC5qUaDnae9Jz5fBFFFsNqYfbA
	 fuJoSL5ABk8a6S2sfhodFF43iThKLcxjs0a3okaF0wt6+YtrlP7dcT84aSo0S3eepBGWu
	 20JOwBhZFJiQ5YtIOhSQvhHDPsIkBFLrMMCjGBFPn9pqhjc3izaCNXN+4uQWn2j8x+Byu
	 /1mQLSXOcS8wMMpnBI7Fm2UGk18HRMBYq00xkX4e+FqngAk79ZuZrNJ5+LHVaLX84pGCi
	 WaHwN4ZFtomHbt4HB+wNRB/8iFTCjCCjDEHLaJAmZ+KtyNcWyzVFMY5OEZxnov0E/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Te7IK0u9;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87635606EEAC
	for <linux-omap@vger.kernel.org>; Tue,  3 Nov 2026 16:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87635606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Te7IK0u9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=W8xC
	oWoLLQfSq8i5Qi+fm11gUA6qTjPeDx6DMi+PVBo=; b=Te7IK0u9c1h6hR0DRAlT
	FHjZyxJ1laoT4G8FkfVwZjVlHMu50gT88cv110WjLlQ44adjFxv1ha0DI274kN6z
	bS1xF6dxbHI7u9hB3i45B/hgOSt+hEJWF/fUt1hHfpJFts5v++IlTs+6EjKtcaiN
	uE7bzFTOVNRxgPJwAe9ZU3K6YQVWbSTe8ewEv3cEEtQishyVYT6Ab37Z9wZfM3Oy
	kzvQMMF3hxCxWoT28eo+kzdCZlJRLmFMLNvZVLYw9k6CmArdhYIShEIJuMDtLNyu
	L0m3E/KJXnZ8MPGcWyUxMv0essagc9gDJ/MloPUwbiiNjFU2QN5WDBOpKChAvr0u
	NA==
Received: (qmail 357587 invoked from network); 3 Nov 2026 17:43:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2026 17:43:45 +0100
X-UD-Smtp-Session: l3s3148p1@jzFJ92FfgJTAwtcC
Date: Tue, 3 Nov 2026 18:43:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank.Li@oss.nxp.com
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	John Garry <john.garry@linux.dev>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Rosen Penev <rosenp@gmail.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Pan Chuang <panchuang@vivo.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>,
	vkoul@kernel.org
Subject: Re: [PATCH 1/1] mmc: use dmaengine_desc_set_callback()
Message-ID: <auoPQVa1LMvluoYM@shikoro>
References: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>


>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 6 ++----
>  drivers/mmc/host/sdhci.c                 | 3 +--
>  drivers/mmc/host/sh_mmcif.c              | 6 ++----
>  drivers/mmc/host/uniphier-sd.c           | 3 +--
>  drivers/mmc/host/usdhi6rol0.c            | 3 +--

For those:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # Renesas related drivers

