From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up v2.
Date: Wed, 26 Nov 2008 10:41:02 -0800
Message-ID: <200811261041.02375.david-b@pacbell.net>
References: <873ahotc5t.fsf@trdhcp146196.ntc.nokia.com> <1227080924-11555-1-git-send-email-jouni.hogander@nokia.com> <20081126175709.GS11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:24971 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752493AbYKZSlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 13:41:09 -0500
In-Reply-To: <20081126175709.GS11997@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Tony Lindgren wrote:
> * Jouni Hogander <jouni.hogander@nokia.com> [081118 23:48]:
> > Currently mcspi wake-ups are not enabled. This might cause case where
> > OMAP is not waking up on mcspi events.
> 
> Dave, I assume you're picking these for your SPI queue? Will only
> apply to l-o if you ack and tell me so.

OK... I'm not totally caught up there.  Is this needed for
a 2.6.28-final merge?  I'm guessing not; so it'd be OK to
queue for 2.6.29-final and have it in l-o until 29-rc1 gets
pulled down.

- Dave


