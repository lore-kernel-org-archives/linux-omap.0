From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH ] McBSP:Make the free variable update more readable
Date: Wed, 17 Nov 2010 10:29:42 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C004133D3820@dbde02.ent.ti.com>
References: <1288778337-18815-1-git-send-email-shubhrajyoti@ti.com>
 <20101103121818.e86f56ba.jhnikula@gmail.com>
 <20101116213548.GM9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab0KQE7v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 23:59:51 -0500
In-Reply-To: <20101116213548.GM9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, November 17, 2010 3:06 AM
> To: Jarkko Nikula
> Cc: Datta, Shubhrajyoti; linux-omap@vger.kernel.org
> Subject: Re: [PATCH ] McBSP:Make the free variable update more readable
> 
> * Jarkko Nikula <jhnikula@gmail.com> [101103 03:09]:
> > On Wed,  3 Nov 2010 15:28:57 +0530
> > shubhrajyoti@ti.com wrote:
> >
> > > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> > >
> > > Using true/false instead of 1/0 to update the free variable.
> > >
> > > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > > ---
> > >  arch/arm/plat-omap/mcbsp.c |   10 +++++-----
> > >  1 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Next time, please also Cc linux-arm-kernel mailing list
> for your arch/arm/*omap*/ touching patches. Otherwise
> I have to repost before merging, which is not nice.
> 
> Anyways, queuing this for 2.6.38 merge window and will
> repost to linux-arm-kernel along with other misc patches
> at some point.

I will make sure henceforth. 
Thanks,
> 
> Tony

