From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/10] Rearranging things before sending patches to
	mainline
Date: Thu, 13 Mar 2008 13:28:03 +0200
Message-ID: <20080313112803.GC11653@atomide.com>
References: <1205318750-9596-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64615 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYCML2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 07:28:18 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JZlbc-0009ta-R0
	for linux-omap@vger.kernel.org; Thu, 13 Mar 2008 11:28:17 +0000
Content-Disposition: inline
In-Reply-To: <1205318750-9596-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080312 12:46]:
> Hi all,
> 
> Attached series moves things around a bit to make room for 34xx PM,
> renames some files to have consistent naming, and moves STI support
> from plat-omap to drivers/misc.
> 
> This is all to allow us to get arch/arm/*omap* stuff in sync with
> mainline. I'll be putting together a series of patches for Russell
> over next few days for post 2.6.25.

I've pushed these changes.

Tony
