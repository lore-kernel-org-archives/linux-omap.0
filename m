From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP2+: McBSP: Correct CLKR/FSR clock
 source mux configuration
Date: Thu, 8 Mar 2012 13:12:48 -0800
Message-ID: <20120308211247.GZ12083@atomide.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
 <1331198537-13469-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28771 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab2CHVM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 16:12:57 -0500
Content-Disposition: inline
In-Reply-To: <1331198537-13469-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120308 00:50]:
> On OMAP2/3 McBSP1 port has 6 pin setup, while on OMAP4 the port is McBSP4.
> Implement the CLKR/FSR clock mux selection for OMAP4, and make sure that
> we add the correct callback for the correct port across supported OMAP
> versions.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>
