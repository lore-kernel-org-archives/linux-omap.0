From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 00:43:07 -0700
Message-ID: <200810300043.07813.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <20081029160056.GD20456@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:46013 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753175AbYJ3HnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 03:43:10 -0400
In-Reply-To: <20081029160056.GD20456@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

On Wednesday 29 October 2008, Tony Lindgren wrote:
> Let's do the clean-up patches in two phases, one series that
> applies against the mainline kernel, then additional patches for
> linux-omap. Otherwise we'll never get out of this merge hell.

Note that the patches I sent were in two phases ... but the
other way around.  The OMAP-only patches can go in immediately,
and won't change anything of node.

But since the ones that "also" apply against mainline remove
the legacy calls, they need to go later.  If it were realistic
to merge them for 2.6.28, they could safely be pulled down IFF
the OMAP-only patches were already in the OMAP tree.

- Dave

