From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
Date: Thu, 29 Oct 2009 22:29:34 +0000
Message-ID: <20091029222933.GA7953@sirena.org.uk>
References: <1256842337-30334-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38712 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZJ2W3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 18:29:31 -0400
Content-Disposition: inline
In-Reply-To: <1256842337-30334-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, tony@atomide.com

On Fri, Oct 30, 2009 at 12:22:17AM +0530, Anuj Aggarwal wrote:
> This patch series add support for OMAP3517 / AM3517 EVM in ASOC.
> It also enables the required drivers - I2C and McBSP, along with
> Alsa SoC subsystem, in the default configuration for the EVM.
> 
> Anuj Aggarwal (4):
>   Audio: Adding OMAP3517 / AM3517 EVM support in ASOC
>   Audio: Modifying Kconfig/Makefile for AM3517 EVM
>   Audio: Modifying board-evm file for audio codec
>   Audio: Modifying the defconfig for OMAP3517 / AM3517 EVM

These all look good - I've applied patches 1 and 2 to ASoC, patches 3
and 4 should go via OMAP and are

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

if it helps (or even if it doesn't!).  Thanks.
