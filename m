Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1D49363E
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758254; cv=none; b=RS6T2BqPQ4U4Pcadq3TLKwiMyNUVDplh8trwGKQCNM99JaQsf4lNoITIoQmy55Uebu8jTN12CrS1htZIXTqri0T+37saL6KgG1i1TvoVuRTf/ONAjIqgc86kkVob7lqyIZtWh3864e/HQZo22+EFQzYBzuz5HAAV7Rn9q48BmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758254; c=relaxed/simple;
	bh=UzAcr4zFNpEWR8QoTd198zq5n4ye3nqQ50yJoiCIYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvXaFFPFTJ5xpqhCUDGMx13HKBvZN+9cLCjpktnpKpQvD7GFDUSokt4jZnZlFuWWOhzSW8fvfkT94T+mHznMGqDbig/m8sG75BNvriQg6rmyJ6JUk4e9vfgVvMrpRFuMejuMOyDae8xwRKNaTK4iYlP+rroZbz7qhMAdxn4qHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PtVookg5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PtVookg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=x4+D
	9upuaenjWjZ0/dtM41htolecou62jNr6QYJiyhE=; b=PtVookg5iQKTKvaqLg/V
	le9n4Ya6+P6oMAJIDLz7bwQHYOWPNA+2BRkNCTXsIkSwGLgpNiBURb38I31E11/v
	wyApEEHsdo1fn8cJKwT3btI/SLa9ITzwA+nuo3Wnpm2lp1XdBgpsiwQAenbKBIrM
	QG8Xc6p4pZ8059h82svBVX81BzDkOzmualYyeh1bukez1x+Lj8oR+hNVvnetHebd
	qm5aXERfgaHfZGipLKRi7Mzmpmd1dPZmUL6XhA3fWHbO3QPjSnRsKui0Phql/nit
	S6c5I0LjoAkrm47LrwHgp2QV5H/Ux0w6/9+KzOexRguOi8dpJZQEf8n8IpxP89o9
	WA==
Received: (qmail 2660367 invoked from network); 18 Sep 2026 21:03:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Sep 2026 21:03:46 +0200
X-UD-Smtp-Session: l3s3148p1@raRWj8ZbuqC57tsJ
Date: Fri, 18 Sep 2026 21:03:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Linus Walleij <linusw@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Rosen Penev <rosenp@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <imx@lists.linux.dev>,
	"open list:OMAP HS MMC SUPPORT" <linux-omap@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	"open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>,
	vkoul@kernel.org
Subject: Re: [PATCH v2 1/1] mmc: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <aq2LEtdAVJ58mpMr@shikoro>
References: <20260918152349.2101305-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152349.2101305-1-Frank.Li@oss.nxp.com>


>  drivers/mmc/host/renesas_sdhi_sys_dmac.c |  8 ++++----
>  drivers/mmc/host/sh_mmcif.c              |  8 ++++----
>  drivers/mmc/host/usdhi6rol0.c            |  6 +++---

For these Renesas drivers:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

