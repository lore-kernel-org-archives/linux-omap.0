From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] DMA clean-up for multi-boot
Date: Fri, 2 May 2008 11:11:44 -0700
Message-ID: <20080502181144.GT8981@atomide.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB02223E1EDA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64283 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761218AbYEBSLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 14:11:45 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02223E1EDA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [080502 08:15]:
> > Hi all,
> >
> > Here are three patches to clean DMA code to support multi-boot
> > better. I have made quick testing on 24xx and 34xx only so far,
> > and things seem to work.
> >
> > I will also do more testing, but I would appreciate if people would
> > give them a quick spin and see if anything breaks. Functionality
> > should be same as earlier.
> >
> > I've removed direct DMA register access in few places such as
> > omap-hw.c, usb-udc.c, and various audio drivers. So especially
> > those areas should be tested carefully.
> >
> > Regards,
> >
> > Tony
> 
> I ran some DMA tests I had on a 3430SDP and they work just fine. Have not tried on OMAP2 yet.
> Will run some more tests over the weekend.

Thanks for testing, I still need to test it on at least  15xx but need
to reflash my 1510 innovator first.

Tony
