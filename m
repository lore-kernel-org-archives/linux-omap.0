From: Tony Lindgren <tony@atomide.com>
Subject: Re: compile break on dss2 branch for zoom3
Date: Thu, 11 Mar 2010 14:42:28 -0800
Message-ID: <20100311224228.GT2900@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FA5@dbde02.ent.ti.com>
 <1268307780.28571.101.camel@tubuntu.research.nokia.com>
 <20100311131135.GU20878@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53634 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab0CKWlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:41:09 -0500
Content-Disposition: inline
In-Reply-To: <20100311131135.GU20878@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "ext Y, Kishore" <kishore.y@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100311 05:09]:
> On Thu, Mar 11, 2010 at 12:43:00PM +0100, Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> >>When I disable usb, build goes through but the board does not bootup with this image. It is stuck at uncompressing linux.
> >
> >Yes, mainstream linux tree seems to be broken. Not much I can do to help
> >you there. You can try rebasing on top of later mainstrean version,
> >perhaps it's been fixed there.
> 
> you need to enable CONFIG_PM_RUNTIME

I have a patch queued up to do that for the related defconfig
files while we wait for the usb patch to get merged. Will post
later today.

Tony
