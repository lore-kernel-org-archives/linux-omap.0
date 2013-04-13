From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Fri, 12 Apr 2013 17:06:15 -0700
Message-ID: <20130413000615.GF10155@atomide.com>
References: <20130409212318.GR10155@atomide.com>
 <5165A1DB.3020404@ti.com>
 <20130410182034.GH10155@atomide.com>
 <5165CED4.1040800@ti.com>
 <20130410205407.GQ10155@atomide.com>
 <5165E6F1.8040102@ti.com>
 <20130410222749.GR10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32518 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751504Ab3DMAGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Apr 2013 20:06:18 -0400
Content-Disposition: inline
In-Reply-To: <20130410222749.GR10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Tony Lindgren <tony@atomide.com> [130410 15:32]:
> * Jon Hunter <jon-hunter@ti.com> [130410 15:30]:
> > 
> > Are you saying that you want to use the version with that is using the
> > pre-processor definitions? I was thinking that may be we could do that
> > as a clean-up for v3.11 and just use the original version I posted
> > earlier. Seems cleaner to me.
> 
> No let's do that the preprocessor conversion for v3.11.

Hmm looks like there are few more 3430sdp dt nfsroot exposed
issues in today's linux next.

To get nfsroot to behave, I had to have your earlier fix
from this thread and also revert a2797bea (gpio/omap: force
restore if context loss is not detectable).

Otherwise nfsroot fails, but not necessarily every time?

I could not git bisect it down to the commit above, had to
manually figure it out.. There may also be DMA related
issues, but I don't know for sure any longer. I made a
patch to fix SPI PIO mode and then hacked SPI to always use
PIO to leave out the DMA related parts. Anyways, will post
that separately, let's hope the DMA related issues I saw
earlier are also related to dt + a2797bea.

Regards,

Tony
