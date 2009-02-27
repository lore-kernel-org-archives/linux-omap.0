From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module
	is not initialized.
Date: Fri, 27 Feb 2009 21:00:53 +0200
Message-ID: <20090227190053.GH16801@frodo>
References: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com> <20090216113303.GL21181@scadufax.research.nokia.com> <20090227183524.GI11594@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40441 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbZB0TBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 14:01:07 -0500
Content-Disposition: inline
In-Reply-To: <20090227183524.GI11594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, juha.yrjola@solidboot.com

On Fri, Feb 27, 2009 at 10:35:25AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [090216 03:50]:
> > On Thu, Feb 12, 2009 at 12:39:28PM +0100, Tereshonkov Roman wrote:
> > > The function sti_channel_write_trace can be run from process and interrupt
> > > context. It has to be completed before other sti_channel_write_trace calls.
> > > 
> > > Prevent sdti writing when SDTI module is not initialized.
> 
> Roman, can you please create a patch against the mainline tree and send
> this driver to LKML for integration? I think pretty much the only thing
> you should do is get rid of the OMAP_TAG_STI_CONSOLE and use get that
> option from kernel command line like all the other consoles do.

Adding Juha to Cc as he had some comments about the OMAP_TAG_STI_CONSOLE
regarding our products.

Juha could you comment again what were the problems on starting the sti
console based on console= command line ??

-- 
balbi
