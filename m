From: Joshua Emele <jemele@trellisware.com>
Subject: Re: MUSB problem
Date: Mon, 14 May 2012 23:13:12 +0000 (UTC)
Message-ID: <loom.20120515T010853-466@post.gmane.org>
References: <4F97EBDF.7090400@mlbassoc.com> <4F97EE60.4090406@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34130 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246Ab2ENXPG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 19:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1SU4Tn-0001FL-IN
	for linux-omap@vger.kernel.org; Tue, 15 May 2012 01:15:03 +0200
Received: from 69.199.146.210 ([69.199.146.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 01:15:03 +0200
Received: from jemele by 69.199.146.210 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 01:15:03 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


> Actually, I was too hasty saying that this worked even with this
> error.  I can ping out from my board, but any higher level of traffic,
> e.g. SSH into the box, falls over 
> 
> The problems vanish when I disable MUSB DMA.
> 
> What gives?
> 

I'm also seeing this on a variety of kernels, from 2.6.34 to 3.3.0. I must 
explicitly set musb_hdrc.use_dma=n for the smsc95xx card to function.

The latest kernel I have tested this against is:
Linux WC-11003A 3.3.0 #1 PREEMPT Fri May 11 18:05:35 PDT 2012 armv7l GNU/Linux


