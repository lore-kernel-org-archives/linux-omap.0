From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: ams-delta: Convert to use snd_soc_register_card()
Date: Sun, 16 Sep 2012 13:44:23 -0700
Message-ID: <20120916204422.GJ4521@atomide.com>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
 <1347823023-24922-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52375 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751263Ab2IPUoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Sep 2012 16:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1347823023-24922-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120916 12:18]:
> 
> Tony,
> Please give your ack on the arch/arm/mach-omap1 bits if acceptable. I
> believe there should be no merge conflicts if this change goes through
> sound/soc.

Yes looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
