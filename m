From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Wed, 15 Oct 2008 10:26:04 +0200
Message-ID: <20081015102604.27c4d707@hyperion.delvare>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com>
	<200810140900.55697.david-b@pacbell.net>
	<20081014212034.GA31842@frodo>
	<200810141444.51894.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:15392 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYJOI0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 04:26:18 -0400
In-Reply-To: <200810141444.51894.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi Felipe, David,

On Tue, 14 Oct 2008 14:44:51 -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > I'd say that if it goes to the "wrong" place and doesn't bother anyone,
> > will get forgotten. Just like the whole bunch of other drivers sitting
> > in linux-omap...

You're not merging drivers upstream just to bother people, are you?

There's nothing wrong with drivers being forgotten. Each driver gets
the level of attention it deserves depending on how broken and useful
it is.

> I thought the point was to have them sit in mainline.  ;)
> 
> > Funny that most of such drivers are for nokia tablets :-p
> 
> Some of these drivers are first-of-a-kind, so these questions wouldn't
> necessarily have come up before.  That's one of the obstacles to
> mainline merge that isn't always acknowledged.

Well, as you said before, it seems we have drivers/misc exactly for
that case.

-- 
Jean Delvare
