From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 01/13] ARM: OMAP2+: Remove non working OMAP HDMI audio
 initialization
Date: Mon, 30 Jun 2014 00:24:14 -0700
Message-ID: <20140630072414.GL28884@atomide.com>
References: <cover.1403894190.git.jsarha@ti.com>
 <41571cc2e5a93ff95eda9263a4b5808bba7e6e36.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaF3HYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 03:24:16 -0400
Content-Disposition: inline
In-Reply-To: <41571cc2e5a93ff95eda9263a4b5808bba7e6e36.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi

* Jyri Sarha <jsarha@ti.com> [140627 11:41]:
> This code is not working currently and it can be removed. There is a
> conflict in sharing resources with the actual HDMI driver and with
> the ASoC HDMI audio DAI driver.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
