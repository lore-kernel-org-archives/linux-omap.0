From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] OMAP4: omap4panda: Enable audio support
Date: Wed, 14 Dec 2011 10:02:30 -0800
Message-ID: <20111214180230.GA32251@atomide.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13714 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab1LNSCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 13:02:36 -0500
Content-Disposition: inline
In-Reply-To: <1323856022-24053-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111214 01:17]:
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

This too might have some minor merge conflicts, but looks
OK to queue via ASoC tree:

Acked-by: Tony Lindgren <tony@atomide.com>
