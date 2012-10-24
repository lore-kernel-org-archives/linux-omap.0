From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Introduce local usb.h
Date: Wed, 24 Oct 2012 14:49:24 -0700
Message-ID: <20121024214924.GL5605@atomide.com>
References: <20121019021816.6693.65985.stgit@muffinssi.local>
 <20121019022005.6693.98660.stgit@muffinssi.local>
 <20121019073803.GG12235@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60543 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161269Ab2JXVtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 17:49:32 -0400
Content-Disposition: inline
In-Reply-To: <20121019073803.GG12235@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Partha Basak <parthab@india.ti.com>, Alan Stern <stern@rowland.harvard.edu>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [121019 00:45]:
> On Thu, Oct 18, 2012 at 07:20:05PM -0700, Tony Lindgren wrote:
> > Let's move what we can from plat/usb.h to the local usb.h
> > for ARM common zImage support.
> > 
> > This is needed so we can remove plat/usb.h for ARM common
> > zImage support.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks, I've now pushed these two patches on v3.7-rc1 to
omap-for-v3.8/cleanup-headers-usb branch.

Greg and Samuel, in case you need to, it's OK to merge the
branch above now that plat/usb.h is moved.

Regards,

Tony
