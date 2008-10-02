From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 08:16:56 -0700
Message-ID: <200810020816.56950.david-b@pacbell.net>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <20081002061237.GB7942@atomide.com> <200810021601.18006.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:41275 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753607AbYJBPQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 11:16:59 -0400
In-Reply-To: <200810021601.18006.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thursday 02 October 2008, Peter Ujfalusi wrote:
> commit e85a9daa48453a4e7ffedf174b4358cdb444fbbb
> Author: David Brownell <dbrownell@users.sourceforge.net>
> some drivers switch away from OMAP-specific GPIO calls
> 
> Should I take the relevant parts from these commits and send it to linux-input?

For that one, sure.  The mainline patch doesn't seem to
have gotten queued anywhere yet -- Andrew was off for
a while.

