From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] twl4030: move twl4030-pwrbutton to
	drivers/input/misc
Date: Fri, 27 Feb 2009 21:31:12 +0200
Message-ID: <20090227193112.GJ16801@frodo>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com> <1235050197-26818-2-git-send-email-me@felipebalbi.com> <1235050197-26818-3-git-send-email-me@felipebalbi.com> <200902191208.45851.david-b@pacbell.net> <20090219203030.GF20723@frodo> <20090225210546.GC4639@gandalf> <20090227184445.GJ11594@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40013 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbZB0TbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 14:31:20 -0500
Content-Disposition: inline
In-Reply-To: <20090227184445.GJ11594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

On Fri, Feb 27, 2009 at 10:44:45AM -0800, Tony Lindgren wrote:
> OK, pushed. These are currently also scheduled for getting reset to
> mainline twl code after v2.6.29-omap1 is tagged.

Just pushed to lkml, there will be one discrepancy with a debugging
message easily fixable in a merge if you just use mainline's version, or
I can send a fixup patch, if you wish.

-- 
balbi
