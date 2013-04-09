From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Documentation: dt: update TI GPMC ethernet binding
 properties
Date: Tue, 9 Apr 2013 09:58:00 -0700
Message-ID: <20130409165759.GO10155@atomide.com>
References: <1365509490-26991-1-git-send-email-javier.martinez@collabora.co.uk>
 <51644151.2080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17026 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936173Ab3DIQ6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:58:03 -0400
Content-Disposition: inline
In-Reply-To: <51644151.2080200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Jon Hunter <jon-hunter@ti.com> [130409 09:31]:
> 
> On 04/09/2013 07:11 AM, Javier Martinez Canillas wrote:
> > The GPMC timing properties for device-tree have been updated
> > by adding a "-ns" or "-ps" suffix to indicate the units of
> > time the property represents. Therefore, update the timing
> > property names for TI GPMC ethernet binding.
> > 
> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > ---
> > 
> > Jon, Benoit:
> > 
> > Sorry that I didn't send this patch before but I just realized
> > that the GPMC timing properties changed after
> > 
> > commit 5330dc16 ("ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes")
> > 
> > got queued.
> 
> Thanks, I missed this one too. Looks like I need to update the gpmc-nand
> documentation as well :-(
> 
> > Tony,
> > 
> > Is still possible to queue this patch on your omap-for-v3.10/gpmc branch
> > or it is too late?
> 
> If it is I think that this could be queued as a fix. Tony?

Yes let's plan on making this a fix. Then it can be merged during
the merge window or right after it.

Regards,

Tony
