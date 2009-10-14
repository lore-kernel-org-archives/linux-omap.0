From: Tony Lindgren <tony@atomide.com>
Subject: Re: stable kernel version
Date: Wed, 14 Oct 2009 10:26:57 -0700
Message-ID: <20091014172656.GJ12700@atomide.com>
References: <4AD58D69.2080303@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52522 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZJNR1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:27:44 -0400
Content-Disposition: inline
In-Reply-To: <4AD58D69.2080303@tzi.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-omap@vger.kernel.org

* Janosch Machowinski <scotch@tzi.de> [091014 01:48]:
> Hi,
> I'm looking for an stable omap kernel,
> for an gumstix board. I tried the 2.6.30
> and 2.6.31 git heads, but they both
> resulted in an unbootable system.
> Any advices, on which version to take ?

Starting with 2.6.31, the stable omap kernel latest released
kernel from Linus. So 2.6.31 in this case.

Of course you may still need to patch in some things you need,
like PM, EHCI and dspbridge.

What do you get when booting? Overo boots just fine for me.

At least CONFIG_MUSB had issues, you can see the details by
checking out the omap-debug branch and enabling CONFIG_DEBUG_LL.

Regards,

Tony
