From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: boot message is not an error
Date: Wed, 18 May 2011 14:28:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDC82A@dbde02.ent.ti.com>
References: <1305644565-26233-1-git-send-email-premi@ti.com>
	<1305653621.2694.4.camel@vence>	<20110518084552.1e65f00f.jhnikula@gmail.com>
 <87pqngxu74.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58606 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396Ab1ERI6k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 04:58:40 -0400
In-Reply-To: <87pqngxu74.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Wednesday, May 18, 2011 2:27 PM
> To: Jarkko Nikula
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: boot message is not an error
> 
> Jarkko Nikula <jhnikula@gmail.com> writes:
> 
> > On Tue, 17 May 2011 19:33:41 +0200
> > Kevin Hilman <khilman@ti.com> wrote:
> >
> >> Hi Sanjeev,
> >> 
> >> On Tue, 2011-05-17 at 20:32 +0530, Sanjeev Premi wrote:
> >> > With current level, it shows up on the console
> >> > despite using 'silent' in bootargs.
> >> > 
> >> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> >> > ---
> >> > 
> >> >  1) Couldn't find better text on commit message.
> >> >     Any suggestions?
> >> > 
> >> >  2) Though pm34xx.x is changed, the change itself
> >> >     is no related to power management. Hence, did
> >> >     annotate "pm:"
> >> 
> >> Well, it's a change to PM core code, so PM prefix is fine. 
>  How about:
> >> 
> >> OMAP3: PM: boot message is not an error, use pr_info
> >> 
> >> Also, please Cc linux-arm-kernel, and I will queue this 
> fix for 2.6.40.
> > ...  
> >> >  arch/arm/mach-omap2/pm34xx.c |    2 +-
> >> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >> > 
> > Does this bootup info print here bring any benefit for pm developers
> > and users?
> >
> > For me it looks it can be removed as the pm34xx.c is always compiled
> > and initialized for CONFIG_ARCH_OMAP3 so IMHO only error prints from
> > pm34xx.c are relevant.
> 
> Good point.  It's probably better to simply remove the printk.

Ok. I will resend the patch with removal...

> 
> Kevin
> 