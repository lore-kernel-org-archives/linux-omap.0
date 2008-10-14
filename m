From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/8] lp5521: move to drivers/leds
Date: Tue, 14 Oct 2008 10:19:52 -0700
Message-ID: <200810141019.52997.david-b@pacbell.net>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <200810140853.28676.david-b@pacbell.net> <20081014171102.GI20247@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:22350 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754009AbYJNRUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 13:20:33 -0400
In-Reply-To: <20081014171102.GI20247@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> On Tue, Oct 14, 2008 at 08:53:28AM -0700, David Brownell wrote:
> > On Tuesday 14 October 2008, Felipe Balbi wrote:
> > > This driver should be sitting together with the other
> > > led drivers.
> > 
> > ... iff it actually uses the LED framework.  Which it
> > doesn't, yet, even for simple operations.
> 
> Should I change the order of the patches ? The patch going to Richard is
> only the final version of it, so there wouldn't be any difference for
> him I'd say.

The rule of thumb is to preserve bisectability.  That may be less
important inside the OMAP tree.  The sequencing is fine, but it'd
be less confusing to patch-at-a-time review to at least see the
comment that a *later* patch makes it use the LED framework.

- Dave
