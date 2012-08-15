From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/4] ASoC machine driver for simple SoC with twl4030
Date: Wed, 15 Aug 2012 17:10:31 +0100
Message-ID: <20120815161031.GA15365@opensource.wolfsonmicro.com>
References: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34900 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822Ab2HOQKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 12:10:34 -0400
Content-Disposition: inline
In-Reply-To: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Tue, Aug 14, 2012 at 12:07:55PM +0300, Peter Ujfalusi wrote:

> Create new unified ASoC machine driver (with DT support) for boards using simple
> configuration for audio and using the twl4030 codec.
> This driver will replace the following machine drivers (since they are basically
> the same):
> igep0020, omap3beagle, omap3evm and overo.

Applied, thanks.
