From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Putting TPS6235x into the power regulator framework
Date: Fri, 5 Dec 2008 13:38:45 -0800
Message-ID: <200812051338.45362.david-b@pacbell.net>
References: <y> <1228386306-13579-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:20520 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754399AbYLEVir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 16:38:47 -0500
In-Reply-To: <1228386306-13579-1-git-send-email-y>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: y@india.ti.com
Cc: linux-omap@vger.kernel.org, Manikandan Pillai <mani.pillai@ti.com>

I second the comment on splitting this patch up into
its constituent chunks.  It'll be practical to review
each of them properly at that point.

Like ... it seems wrong to teach plat-omap/devices.c
about EVM-specific stuff; it should stay generic.

And those EVM-specific bits are done wrong too; those
regulators are I2C devices, not platform devices!
Plus, their constraints should be board-specific, not
generic.  Move all that into the omap3evm board code.

You still didn't remove the drivers/i2c/chips stuff.
Move the *ENTIRE* driver to drivers/regulator, and
get rid of all the platform_device stuff.

Good to see this driver start moving into its proper
home, though.  :)


On Thursday 04 December 2008, y@india.ti.com wrote:
> Not fixed comments:
> Not clear on how to implement runtime check for PR785 and would require some
> inputs on implementing the same.

The TPS driver should not know or care about the PR785 card;
it should just respond to the various requests.  If there's
any knowledge of PR785 in drivers/anything/* you should treat
that as a bug (and fix it before merge).  Since the chips are
pretty much the same other than some bit interpretations, just
use the driver_data in the i2c_device_id to describe whatever
differences the driver needs to know about.

With respect to runtime checking, first make sure the
OMAP3 EVM init code is able to cleanly choose between the
two power card options.  Once that's done you can try
turning that into a runtime check.

- Dave
