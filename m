From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Tue, 10 Dec 2013 13:49:13 +0100
Message-ID: <201312101349.13564.marex@denx.de>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:52388 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab3LJPNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 10:13:23 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com

On Friday, December 06, 2013 at 03:24:41 PM, Sourav Poddar wrote:
> The patch series aims to add memory mapped support for TI qspi
> contoller and also add support for the same in serial flash driver(m25p80).

My question is, shall we not wait for the new SPI NOR framework to be well 
fleshed out and only then implement this controller driver on top of it ?

I have a feeling this patchset adds quite a lot of ad-hoc hacks into the m25p80 
driver, which would become dead code once converted to the SPI NOR framework.

Best regards,
Marek Vasut
