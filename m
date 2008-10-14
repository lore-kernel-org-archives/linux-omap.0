From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Wed, 15 Oct 2008 00:50:27 +0300
Message-ID: <20081014215024.GC31842@frodo>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <200810140900.55697.david-b@pacbell.net> <20081014212034.GA31842@frodo> <200810141444.51894.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52808 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYJNVu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:50:57 -0400
Content-Disposition: inline
In-Reply-To: <200810141444.51894.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, ext Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Oct 14, 2008 at 02:44:51PM -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > I'd say that if it goes to the "wrong" place and doesn't bother anyone,
> > will get forgotten. Just like the whole bunch of other drivers sitting
> > in linux-omap...
> 
> I thought the point was to have them sit in mainline.  ;)

Exactly :-)

> Some of these drivers are first-of-a-kind, so these questions wouldn't
> necessarily have come up before.  That's one of the obstacles to
> mainline merge that isn't always acknowledged.

That's also true, but then again most of those drivers got forgotten and
never made their way to mainline. If you look at mainline archives,
you'll see that most of omap drivers never "tried" to go upstream.

-- 
balbi
