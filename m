From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] twl4030: move twl4030-pwrbutton to
	drivers/input/misc
Date: Fri, 27 Feb 2009 11:49:17 -0800
Message-ID: <20090227194916.GK11594@atomide.com>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com> <1235050197-26818-2-git-send-email-me@felipebalbi.com> <1235050197-26818-3-git-send-email-me@felipebalbi.com> <200902191208.45851.david-b@pacbell.net> <20090219203030.GF20723@frodo> <20090225210546.GC4639@gandalf> <20090227184445.GJ11594@atomide.com> <20090227193112.GJ16801@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64730 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbZB0Tt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 14:49:26 -0500
Content-Disposition: inline
In-Reply-To: <20090227193112.GJ16801@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

* Felipe Balbi <me@felipebalbi.com> [090227 11:31]:
> On Fri, Feb 27, 2009 at 10:44:45AM -0800, Tony Lindgren wrote:
> > OK, pushed. These are currently also scheduled for getting reset to
> > mainline twl code after v2.6.29-omap1 is tagged.
> 
> Just pushed to lkml, there will be one discrepancy with a debugging
> message easily fixable in a merge if you just use mainline's version, or
> I can send a fixup patch, if you wish.

Well if you can send the patch, then that would be easiest. Patching
based on the description usually cause something to go wrong :)

Tony
