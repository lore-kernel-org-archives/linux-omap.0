From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/7] input: lm8323: get rid of global pdata pointer
Date: Thu, 16 Oct 2008 11:39:52 +0300
Message-ID: <20081016083952.GB3812@gandalf.research.nokia.com>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com> <1224020397-2842-2-git-send-email-me@felipebalbi.com> <20081016041057.GC16860@anvil.corenet.prv>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57698 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbYJPIkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 04:40:33 -0400
Content-Disposition: inline
In-Reply-To: <20081016041057.GC16860@anvil.corenet.prv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Thu, Oct 16, 2008 at 12:10:57AM -0400, ext Dmitry Torokhov wrote:
> Hi Felipe,
> 
> On Wed, Oct 15, 2008 at 12:39:51AM +0300, Felipe Balbi wrote:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > pdata is only used during probe to initialize a few fields
> > from lm8323 device structure. Moving pdata pointer to probe
> > won't harm anybody.
> > 
> 
> I don't think I have these drivers.  I also think that they should
> depend on GPIOLIB (I noticed that OMAP selects GPIOLIB but I think
> ecplicit dependency should still be present).

I'll update and resend to l-o, when they patch get applied to l-o, I'll
send a patch via your tree to be merged into mainline.

-- 
balbi
