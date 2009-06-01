From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 1 Jun 2009 21:04:13 +0300
Message-ID: <20090601210413.7678bf42.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527095949.51ed4b83.jhnikula@gmail.com>
	<200905272058.55404.jkrzyszt@tis.icnet.pl>
	<4A23CC97.1020209@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:5926 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbZFASEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 14:04:05 -0400
In-Reply-To: <4A23CC97.1020209@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Mon, 01 Jun 2009 14:41:59 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> The original patch ported to linux-omap-2.6.27, the last omap release 
> with omap-alsa support, gives me a working sound driver on ams-delta.
> 
Ok, good to know.

> To make the original driver work stable, I had to patch the omap-alsa 
> framework to restore the original way that lack of dma chaining
> problem had been solved in the original patch (see below), so maybe
> there is a similiar issue in the currect ASoC McBSP framework?
> 
Is the older implementation working at commit
d8376cc482b241701f7606c81ad578b90853e175 in linux-omap, i.e. last
commit before their removal?

What I see at quick look from the older implementation that it is doing
somewhat similar way the DMA transfer and workaround for 1510 than
current ASoC except that now the DMA parameters are not reprogrammed
between the restarted transfers. I don't know if 1510 requires it?

> My asoc based patch is also very generic and contains no more that
> the same two ams_delta_latch2_write() hardware related operations,
> called from inside snd_soc_dai_link.ops.startup() and 
> snd_soc_dai_link.ops.shutdown() callback functions:
> 
One thing worth to try would be try to use exactly same McBSP registers
for omap_mcbsp_config in omap_mcbsp_dai_hw_params than used before for
ams delta.

Sorry, have to cut my answer now here. I'll get back tomorrow.


-- 
Jarkko

> My conclusuions so far:
> 
> 1. If the new OMAP McBSP ASoC framework provides all the
> functionality of the depreciated OMAP Alsa under a different API, the
> only reason of my driver not working I can imagine is that I have put
> these two lines of hardware related code in wrong places. If this is
> the case, could someone please point me into the right direction?
> 
> 2. Maybe the original ams-delta sound driver should not in theory
> work as is? Maybe Mark Underwood was just lucky enough to get it
> working without any real hardware setup?
> 
> 3. Otherwise, there must be a significant difference in (alsa) MsBSP 
> handling code that I am not able to identify and resolve myself. I
> can only say that I have seen much more mcbsp_...() stuff in the old 
> omap-alsa framework than in the current one. The differece can be 
> significant for OMAP15XX, or OMAP5910, or even ams-delta only.
> 
> 4. Base (not alsa related) McBSP framework did not change since
> 2.6.16 (the original patch base) up to 2.6.27 in a way that could
> break the original patch. If my problem was related to base McBSP
> handling, changes should be looked for after 2.6.27, if any.
> 
> Jarkko Nikula wrote:
> > It would be nice to get
> > this working since it would be the first OMAP5910 == OMAP1510 based
> > machine driver.
> 
> I am personally interested in this, as I have bought two E3's
> recently in hope I can make use of them as IP phones. But for now, I
> have no idea what else I could try. I have noticed that Andrew de
> Quincey is going to fix sound on Nokia 770, maybe he finds something
> related.
> 
