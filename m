From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [RFC] ETM/JTAG components states across OFF modes
Date: Mon, 3 May 2010 20:03:13 +0300
Message-ID: <20100503170313.GE27062@shisha.kicks-ass.net>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
 <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:43916 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0ECRE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 13:04:27 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

On Mon, May 03, 2010 at 06:54:57 -0500, Woodruff, Richard wrote:
> Hi Alex,

Hi,

> > From: virtuoso@slind.org [mailto:virtuoso@slind.org]
> > Sent: Saturday, May 01, 2010 12:38 PM
> 
> Do you have a web viewable git tree where your full patch is applied? Or could you send me on the side files?

I've pushed these patches to
http://github.com/virtuoso/linux-2.6/tree/omap-etm-off/0

> Main bit I was looking to check was that you have bug fix which came late in my original hack where a failed OFF mode needs to unlock the coresight registers at the fall through of WFI.

There actually might be some unnecessary unlocking around wfi, I'll double
check that.

> > I've finally got around to doing this. This is a rework of the previously
> > posted [1] patch that implements ETM and JTAG context saving. There are
> > two major changes since previous version:
> >   * coresight OS save/restore mechanism is used for saving the ETM context,
> >     so that it actually occupies ~54 words on omap3_arm_context instead of
> >     128;
> 
> Seems you found some nice optimization.  I was thinking first patch was doing this in part.  You read from a port address and it gives you internal registers as necessary. You written them back to port for restore.

> I came up with context size simply by inspecting # of times loop was necessary and looking at values written to save areas.  I assume you would have done something similar to determine size.

Good point, I'll double check with other omaps (at least 3430). I've only got
to test this code with 3630. And beagle doesn't go to OFF mode at all for some
reason.

> >   * a sysfs file is used to control if the ETM/JTAG context should be saved
> >     in OFF mode.
> 
> Neat.  This is much more friendly then a recompile.

You still have the option to compile it out, which is also nice for some people,
I guess. :)

Regards,
--
Alex
