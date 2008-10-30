From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 11:16:17 -0700
Message-ID: <200810301116.18214.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <200810300043.07813.david-b@pacbell.net> <20081030173215.GU13227@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26092 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758699AbYJ3SQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 14:16:20 -0400
In-Reply-To: <20081030173215.GU13227@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

On Thursday 30 October 2008, Tony Lindgren wrote:
> 
> Great, to me those look safe to merge. Can you Cc Russell on the
> arch/arm/*omap* patches if you merge them via gpiolib patches?
> 
> Basically anything that will cause merge conflicts for omap-all
> should go via Russell so we don't frustrate him further, but
> I don't think these will cause an issue for him.

Unless you think they should go into 2.6.28, I'll just let
you merge them via Russell for 2.6.29 ... they're almost all
arch/arm/* changes, aren't bugfixes, and don't affect non-OMAP
code, so they don't fit into one of the usual categories of
stuff Russell avoids (cross-platform or drivers/* code).

- Dave
