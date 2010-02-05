From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/3] twl4030: keypad: Hooks for board specific
 suspend-resume
Date: Fri, 5 Feb 2010 13:28:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E259DED3@dbde02.ent.ti.com>
References: <871vh03c5a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47811 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab0BEH6t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 02:58:49 -0500
In-Reply-To: <871vh03c5a.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, February 05, 2010 3:19 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/3] twl4030: keypad: Hooks for board 
> specific suspend-resume
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > This patch adds hooks to support board specific
> > implementation during the suspend and resume operations.
> >
> > The TWL4030 can be connected to multiple boards. Without
> > these hooks, board specific macros will be required in a
> > generic driver.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> Looks ok, but I think you should drop the 'on_' prefix in function
> pointer names.
> 
> Kevin
> 

Will re-submit this patch after change.

~sanjeev

[snip]--[snip]
