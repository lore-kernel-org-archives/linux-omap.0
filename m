From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] Minimum set of omap serial patches to fix merge
 window breakage
Date: Tue, 16 Oct 2012 08:53:45 -0700
Message-ID: <20121016155345.GP15569@atomide.com>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31051 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754329Ab2JPPxu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 11:53:50 -0400
Content-Disposition: inline
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121016 03:16]:
> 
> There are two options to resolve this.  The first one is to revert this
> patch to bring the driver back down to the pre-merge window state.  The
> other is to apply this series of patches, which frankly I don't think
> is -rc material, even with the above regressions.

Yes reverting it is the way to go as we discussed in some off-list
emails. I think everybody agrees that this is too intrusive for the
-rc series :)

Regards,

Tony
