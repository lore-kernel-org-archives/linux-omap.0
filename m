From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v4 - resend 11/13] ASoC: omap-abe-twl6040:
 Use provided MCLK frequency from pdata
Date: Fri, 27 Jan 2012 17:58:57 +0000
Message-ID: <20120127175857.GA29026@sirena.org.uk>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-12-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44226 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab2A0R7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 12:59:00 -0500
Content-Disposition: inline
In-Reply-To: <1327405950-6676-12-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 24, 2012 at 01:52:28PM +0200, Peter Ujfalusi wrote:
> Avoid using hardwired configuration for MCLK frequency.
> Different board design might use other MCLK frequency.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

So, apparently this one isn't an actual resend!  Since you flagged the
entire series up as a resend I didn't actually read it as I'd presumably
already reviewed it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
