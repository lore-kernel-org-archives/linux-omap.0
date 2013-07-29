From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 01/11] spi: Provide core support for runtime PM during
 transfers
Date: Mon, 29 Jul 2013 10:56:07 -0600
Message-ID: <51F69EA7.5070704@wwwdotorg.org>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51203 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691Ab3G2Q4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 12:56:11 -0400
In-Reply-To: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On 07/28/2013 08:43 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Most SPI drivers that implement runtime PM support use identical code to
> do so: they acquire a runtime PM lock in prepare_transfer_hardware() and
> then they release it in unprepare_transfer_hardware(). The variations in
> this are mostly missing error checking and the choice to use autosuspend.
> 
> Since these runtime PM calls are normally the only thing in the prepare
> and unprepare callbacks and the autosuspend API transparently does the
> right thing on devices with autosuspend disabled factor all of this out
> into the core with a flag to enable the behaviour.

Patch 1, 9, 10, 11,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
