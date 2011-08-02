From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: omap-mcpdm: Fix threshold and dma configuration
Date: Wed, 3 Aug 2011 00:50:50 +0900
Message-ID: <20110802155049.GF25884@opensource.wolfsonmicro.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
 <1312284857-1774-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46141 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754039Ab1HBPu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 11:50:56 -0400
Content-Disposition: inline
In-Reply-To: <1312284857-1774-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

On Tue, Aug 02, 2011 at 02:34:16PM +0300, Peter Ujfalusi wrote:
> DMA packet_size must be configured based on the McPDM FIFO threshold
> value, number of channels.
> Due to the FIFO operation the DMA muse be configured differently for
> playback, and capture.
> At the same time fix the McPDM threshold values used for playback, and
> capture to avoid broken code.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
