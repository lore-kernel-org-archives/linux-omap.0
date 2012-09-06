From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: ams-delta: fix card initalization
 failure
Date: Thu, 6 Sep 2012 15:36:35 +0800
Message-ID: <20120906073633.GC22330@opensource.wolfsonmicro.com>
References: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1809544.cvZPIRmRr5@acer>
 <20120831213103.GC5495@opensource.wolfsonmicro.com>
 <1939338.OUN9Uq58XY@vclass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60428 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab2IFHiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 03:38:18 -0400
Content-Disposition: inline
In-Reply-To: <1939338.OUN9Uq58XY@vclass>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org

On Sat, Sep 01, 2012 at 11:09:18AM +0200, Janusz Krzysztofik wrote:

> I see your point, however for now I can see no better way of referencing 
> the data (of type struct snd_soc_card) then passing it to 
> snd_soc_register_card(). But for this to work, I would have to register 
> successfully an ams-delta specific platform device first, not the soc-
> audio. This, even if still done from the sound/soc/omap/ams-delta.c, not 
> from an arch board file, would require now not existing ams-delta ASoC 
> platform driver probe/remove callbacks at least. I'm still not convinced 
> if such modification would be acceptable in the middle of the rc cycle.

> If there is a simpler, less intrusive way to do this, then sorry, I 
> still can't see it.

Like I already said just make it a static variable.
