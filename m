From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix broken NAND on Amstrad Delta
Date: Wed, 21 Oct 2009 08:54:58 -0700
Message-ID: <20091021155457.GI16230@atomide.com>
References: <200910210239.55194.jkrzyszt@tis.icnet.pl> <20091021005134.GE16230@atomide.com> <200910211253.51518.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62001 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbZJUPy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 11:54:56 -0400
Content-Disposition: inline
In-Reply-To: <200910211253.51518.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091021 03:54]:
> Wednesday 21 October 2009 02:51:35 Tony Lindgren wrote:
> >
> > Let's just remove the omap_cfg_reg() calls from mach-omap1/serial.c, and
> > add them to the board-*.c files like you suggest above. We should be able
> > to find which ports to mux by looking at the enabled_uarts mask in the
> > commit mentioned above.
> 
> Tony,
> I can prepare a patch if you haven't started working on it yet, but please do 
> me a favour and give your comments on another, old but still not answered 
> subject:

Yes, please do that patch if you can!
 
> http://www.spinics.net/lists/linux-omap/msg17692.html
> I have just checked that temporary solution still applies cleanly on top of 
> 2.6.32-rc5 and corrects the problem of otherwise unusable ASoC over McBSP1 on 
> my Amstrad Delta.

Well let's try to work that in for this coming merge window.

How about we rename it to dsp-c55x-common.c? And only do the minimal bits
to idle the DSP if called from the board-*.c file?

The rest we can move to the old dspgateway branch and rebase that to
the current kernel.

I think the right way would be to update the dspgateway to use the iommu
code, so let's not add similar code except to idle the c55x.

Regards,

Tony
