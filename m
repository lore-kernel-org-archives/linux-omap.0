From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Ctrl module register define diet
Date: Wed, 9 Jul 2014 04:28:48 -0700
Message-ID: <20140709112848.GS28884@atomide.com>
References: <1400687328-16913-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754748AbaGIL2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 07:28:45 -0400
Content-Disposition: inline
In-Reply-To: <1400687328-16913-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140521 08:49]:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> 
> Hi,
> 
> The mach-omap2 directory contains full register defines for OMAP4
> control module but only around 27 of those are used. There are is
> a total of 1795 register defines in four files with only 27 in use.
> That is pretty low usefulness ratio...
> 
> I guess alot more was used when we had omap4 board files and
> mach-omap2 contained more drivers but this has now changed.
> 
> So I propose we move just what we need to control.h, were other
> OMAP parts have their minimal set of defines already. Patch has
> been compile tested and I have also grepped the tree for users
> outside the mach dir.

Yeah great, applying this into omap-for-v3.17/soc finally.

Regards,

Tony
