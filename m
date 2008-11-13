From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap1: clk: make clk fwk build again on omap1
Date: Thu, 13 Nov 2008 20:57:47 +0200
Message-ID: <20081113185740.GA17468@frodo>
References: <1226444207-14588-1-git-send-email-me@felipebalbi.com> <20081113185548.GA3106@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46351 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYKMTA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 14:00:26 -0500
Content-Disposition: inline
In-Reply-To: <20081113185548.GA3106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Nov 13, 2008 at 10:55:49AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [081111 14:57]:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Fix it by passing u32 into enable_reg and letting
> > clock.c use OMAP1_IO_ADDRESS().
> > 
> > This will probably be changed by a better solution
> > later on, but at least we make it buildable again.
> 
> Huh? At least OSK builds and boots just fine here.
> Have you tested this patch?

It builds with or without this patch ?

-- 
balbi
