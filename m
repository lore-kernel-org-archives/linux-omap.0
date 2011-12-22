From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Thu, 22 Dec 2011 17:28:39 +0000
Message-ID: <20111222172838.GA29622@opensource.wolfsonmicro.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
 <1324557768-8216-2-git-send-email-peter.ujfalusi@ti.com>
 <20111222130453.GQ4546@opensource.wolfsonmicro.com>
 <1324568573.4138.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40580 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752911Ab1LVR2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:28:42 -0500
Content-Disposition: inline
In-Reply-To: <1324568573.4138.5.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 03:42:53PM +0000, Liam Girdwood wrote:
> On Thu, 2011-12-22 at 13:04 +0000, Mark Brown wrote:

> > omap-abe-mcpdm-twl6040 please.  Seriously, just drop the abe - it's not
> > an optional feature of the OMAP and the names are getting quite long.

> ABE can be an optional feature on OMAP (and quite an important one when
> it is used). Fwiw, we do have a mixture of users, most use the ABE but
> some don't, so it's best to specify ABE in the naming to avoid any
> confusion.

Do you mean to say that there are OMAP4 variants that don't have the
ABE or that some people choose not to do so for some reason, and unless
the ABE might not be there shouldn't the driver just support both ABE
and non-ABE paths anyway?  That's what the out of tree systems I've seen
have done, though the main use of the non-ABE paths has always been
confirming that issues are in the ABE.
