From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] omap1: clk: make clk fwk build again on omap1
Date: Thu, 13 Nov 2008 11:23:12 -0800
Message-ID: <200811131123.12594.david-b@pacbell.net>
References: <1226444207-14588-1-git-send-email-me@felipebalbi.com> <20081113185548.GA3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:35817 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751807AbYKMTXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 14:23:14 -0500
In-Reply-To: <20081113185548.GA3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Thursday 13 November 2008, Tony Lindgren wrote:
> Huh? At least OSK builds and boots just fine here.
> Have you tested this patch?

But I got a boatload of build warnings for clocks,
even though they were just warnings.

It did boot, but root-on-CF seems to have some
oopsing problems.  I think I saw some IDE/block
layer updates post-RC3, maybe they'll fix that.

- Dave

