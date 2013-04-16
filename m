From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Tue, 16 Apr 2013 11:06:14 -0700
Message-ID: <20130416180613.GS10155@atomide.com>
References: <20130410205407.GQ10155@atomide.com>
 <5165E6F1.8040102@ti.com>
 <20130410222749.GR10155@atomide.com>
 <20130413000615.GF10155@atomide.com>
 <5168C050.7030006@ti.com>
 <20130413165014.GL10155@atomide.com>
 <516C3179.4070501@ti.com>
 <516C428B.3020805@ti.com>
 <20130415212756.GQ10155@atomide.com>
 <516D870C.2030108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37398 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468Ab3DPSGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 14:06:16 -0400
Content-Disposition: inline
In-Reply-To: <516D870C.2030108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130416 10:19]:
> 
> On 04/15/2013 04:27 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130415 11:15]:
> 
> ...
> 
> >> From 56598ba51a75481b050433bb38b7ae31a5ed4ae8 Mon Sep 17 00:00:00 2001
> >> From: Jon Hunter <jon-hunter@ti.com>
> >> Date: Mon, 15 Apr 2013 13:06:54 -0500
> >> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
> > 
> > Seems to work thanks:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com> 
> 
> Thanks. I have been cleaning this up and updating a little. Care to
> re-test this version? If it is good I will send it out.

Yes this works too, you can recycle my Tested-by on this one.
 
> By the way, I realise I need to add a similar fix for dmtimer :-p

OK good to find out now rather than after the merge window.

Regards,

Tony
