From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH ] McBSP:Make the free variable update more readable
Date: Tue, 16 Nov 2010 13:35:48 -0800
Message-ID: <20101116213548.GM9264@atomide.com>
References: <1288778337-18815-1-git-send-email-shubhrajyoti@ti.com>
 <20101103121818.e86f56ba.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28137 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab0KPVf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 16:35:59 -0500
Content-Disposition: inline
In-Reply-To: <20101103121818.e86f56ba.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: shubhrajyoti@ti.com, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [101103 03:09]:
> On Wed,  3 Nov 2010 15:28:57 +0530
> shubhrajyoti@ti.com wrote:
> 
> > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> > 
> > Using true/false instead of 1/0 to update the free variable.
> > 
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  arch/arm/plat-omap/mcbsp.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> > 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Next time, please also Cc linux-arm-kernel mailing list
for your arch/arm/*omap*/ touching patches. Otherwise
I have to repost before merging, which is not nice.

Anyways, queuing this for 2.6.38 merge window and will
repost to linux-arm-kernel along with other misc patches
at some point.

Tony

