From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 11:38:29 -0800
Message-ID: <20111222193829.GS24444@atomide.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
 <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20535 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753896Ab1LVTid (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 14:38:33 -0500
Content-Disposition: inline
In-Reply-To: <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, David Anders <x0132446@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111222 11:03]:
> PandaBoard has twl6040 codec for audio.
> Register the omap4-abe-twl6040 platform device.
> Add platform data to enable the twl6040 codec.
> Since there is a difference in audio between  PandaBoard 4430
> and PandaBoard ES (4460):
> Use different name for the sound card:
> "OMAP4-Panda" for PandaBoard 4430
> "OMAP4-PandaES" for PandaBoard ES
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: David Anders <x0132446@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
