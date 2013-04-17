From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Tue, 16 Apr 2013 17:56:37 -0700
Message-ID: <20130417005636.GW10155@atomide.com>
References: <20130410222749.GR10155@atomide.com>
 <20130413000615.GF10155@atomide.com>
 <5168C050.7030006@ti.com>
 <20130413165014.GL10155@atomide.com>
 <516C3179.4070501@ti.com>
 <516C428B.3020805@ti.com>
 <20130415212756.GQ10155@atomide.com>
 <516D870C.2030108@ti.com>
 <20130416180613.GS10155@atomide.com>
 <516D9B1D.6040909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54103 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab3DQA4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 20:56:39 -0400
Content-Disposition: inline
In-Reply-To: <516D9B1D.6040909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130416 11:45]:
> 
> On 04/16/2013 01:06 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130416 10:19]:
> >>
> >> On 04/15/2013 04:27 PM, Tony Lindgren wrote:
> >>> * Jon Hunter <jon-hunter@ti.com> [130415 11:15]:
> >>
> >> ...
> >>
> >>>> From 56598ba51a75481b050433bb38b7ae31a5ed4ae8 Mon Sep 17 00:00:00 2001
> >>>> From: Jon Hunter <jon-hunter@ti.com>
> >>>> Date: Mon, 15 Apr 2013 13:06:54 -0500
> >>>> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
> >>>
> >>> Seems to work thanks:
> >>>
> >>> Tested-by: Tony Lindgren <tony@atomide.com> 
> >>
> >> Thanks. I have been cleaning this up and updating a little. Care to
> >> re-test this version? If it is good I will send it out.
> > 
> > Yes this works too, you can recycle my Tested-by on this one.
> 
> Thanks. Final version below to fix build error if pm-runtime is not
> enabled (this was breaking omap1 build). 
>   
> >> By the way, I realise I need to add a similar fix for dmtimer :-p
> > 
> > OK good to find out now rather than after the merge window.
> 
> Actually, I am wrong here. The dmtimer registers that are restored
> all default to zero and so we don't need a similar fix for dmtimers. 

OK assuming you'll send this patch to the usual drivers/gpio
maintainers so it can be merged.

Regards,

Tony
