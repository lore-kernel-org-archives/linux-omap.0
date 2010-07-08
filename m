From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [omap1] omap7xx clocks, mux, serial fixes
Date: Thu, 8 Jul 2010 16:50:47 +0300
Message-ID: <20100708135047.GA24913@atomide.com>
References: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
 <1275431571-28547-2-git-send-email-darkstar6262@gmail.com>
 <20100705132245.GZ15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49747 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab0GHNuz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:50:55 -0400
Content-Disposition: inline
In-Reply-To: <20100705132245.GZ15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

* Tony Lindgren <tony@atomide.com> [100705 16:16]:
> * Cory Maccarrone <darkstar6262@gmail.com> [100602 01:27]:
> > This change adds in the necessary clocks and mux pins for UART
> > control on omap7xx devices.  I also made a change in the serial
> > code to only try and initialize two UARTs in omap_serial_init, as
> > these devices don't have three.
> 
> Was about to queue this one and then noticed you might want to update
> this according to Paul's recent patch "OMAP1: clock: some cleanup" for
> the enable_bit?

Hmm, I guess you don't have documentation for the bits.. I'll queue
this one, the bits can be patched later. Looks like the other
patches need updating though to apply.

Regards,

Tony
