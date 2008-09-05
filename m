From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Fri, 5 Sep 2008 01:16:19 -0700
Message-ID: <200809050116.19619.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <200808311406.14234.david-b@pacbell.net> <03da01c90e91$db22af60$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:32029 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752699AbYIEIQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 04:16:22 -0400
In-Reply-To: <03da01c90e91$db22af60$LocalHost@wipultra1303>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Thursday 04 September 2008, Madhusudhan Chikkature wrote:
> > OK, this one may need cleanup ... but I don't disagree that it
> > should go upstream.
> 
> I had fixed several comments provided by Pierre and Russell
> before Tony merged this patch. But then we have further added
> several fixes on top of the driver. Do you have any specific
> comments when you mean cleanup   

My main concerns relate to board-specific setup, which might
not end up impacting the driver code as much as the code in
arch/arm/mach-omap2/hsmmc.c (and its callers).

Basically, if you look at the hsmmc.c file it's got a LOT of
board-specific stuff hard-wired.  The way it *should* work is
the board-XYZ.c file passes that into setup code ... and that
info can include things like "are all 8 data lines available?",
as well as card detect triggering and writeprotect switch
access.

There might be other issues ... but it was rather easy to
notice those problems when for example the HSMMC on a Beagle
comes up with truncated functionality.

- Dave

