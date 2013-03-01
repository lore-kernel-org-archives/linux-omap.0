From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 15/15] ARM: OMAP5: PM: handle device instance for for
 coldreset
Date: Fri, 1 Mar 2013 07:13:10 -0600
Message-ID: <20130301131310.GA20103@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-16-git-send-email-santosh.shilimkar@ti.com>
 <20130301130430.GA19894@kahuna>
 <5130A880.5080703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3CANNN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 08:13:13 -0500
Content-Disposition: inline
In-Reply-To: <5130A880.5080703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 18:39-20130301, Santosh Shilimkar wrote:
> On Friday 01 March 2013 06:34 PM, Nishanth Menon wrote:
> > $subject - warm reset
> > 
> ok
> > On 17:41-20130301, Santosh Shilimkar wrote:
> >> From: Nishanth Menon <nm@ti.com>
> >>
> >> OMAP5 and OMAP4 have different device instance offsets.
> >>
> >> So to handle them properly, use a runtime detected instance offset
> >> Other bit offsets and register offsets remained constant.
> >>
> >> Creating a new function is not really worthwhile here as the logic
> >> will be replicated without much benefit.
> >>
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> santosh.shilimkar@ti.com: Refreshed patch against 3.8
> > [santosh.shilimkar@ti.com: Refreshed patch against 3.8]
> > ?
> #include "soc.h" :)
I should have been clear: Did you mean to have it in [] to indicate
contribution? A style comment based on Documentation/SubmittingPatches
+360

-- 
Regards,
Nishanth Menon
