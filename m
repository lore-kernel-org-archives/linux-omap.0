From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: PM: one more fix for 3.5-rc
Date: Fri, 6 Jul 2012 03:32:14 -0700
Message-ID: <20120706103213.GT1122@atomide.com>
References: <877guhenny.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49742 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab2GFKcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 06:32:16 -0400
Content-Disposition: inline
In-Reply-To: <877guhenny.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

* Kevin Hilman <khilman@ti.com> [120705 17:35]:
> Tony,
> 
> Hopefully this is the last one.
> 
> This one fixes a problem where the CORE power domain does not hit
> retention during suspend.  This has been known since v3.5 came out, but
> there has been some discussion about the proper fix.  The solution has
> now been agreed upon, so I'd like to see this make it for v3.5-rc.

Thanks pulling into fixes.

Tony
