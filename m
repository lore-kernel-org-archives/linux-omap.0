From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 01:20:12 -0700
Message-ID: <20110715082012.GR5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
 <20110715075024.GO5783@atomide.com>
 <20110715075825.GB2611@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39452 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964935Ab1GOIUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 04:20:18 -0400
Content-Disposition: inline
In-Reply-To: <20110715075825.GB2611@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110715 00:53]:
> Hi,
> 
> On Fri, Jul 15, 2011 at 12:50:24AM -0700, Tony Lindgren wrote:
> > * Jan Weitzel <J.Weitzel@phytec.de> [110714 01:34]:
> > > Am Donnerstag, den 14.07.2011, 00:34 -0700 schrieb Tony Lindgren:
> > > > * Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> > > > > Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> > > > > 
> > > > > > 
> > > > > >     Have you added that 'i' at the end intentionally?
> > > > > > 
> > > > > Thank you. It was a tribute to vim.
> > > > 
> > > > :i)
> > > > 
> > > > I'll fold the fixed patch into your original patch. Will also
> > > > keep the new board files in testing-board because of the code
> > > > coalescing and device tree conversion effort.
> > > 
> > > So there is no way to get the board mainline yet?
> > 
> > Well we can add it even before device tree support if it makes
> > sense from code coalescing point of view. In this case it would
> > mean creating board-panda-common.c or similar so the code can
> > be shared amongst the panda variants.
> > 
> > It seems that some GPIO pins are different and there are some
> > difference in devices connected, but big parts of the code can be
> > shared.
> 
> isn't it easier than to just add a few if (machine_is_xxxx()) checks and
> another MACHINE_START() to board-omap4panda.c rather than creating a new
> file, shuffling code around and then adding a new board file ??

That works too if the init_machine does not get too complicated.

Regards,

Tony
