From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] OMAP2+: hwmod: incorrect computation of autoidle_mask
Date: Tue, 4 Jan 2011 10:22:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2EA3C@dbde02.ent.ti.com>
References: <1294091991-2078-1-git-send-email-tarun.kanti@ti.com>
 <4D21E048.2040005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36497 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab1ADEwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 23:52:54 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p044qch9009736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 22:52:48 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p044qbuK021340
	for <linux-omap@vger.kernel.org>; Tue, 4 Jan 2011 10:22:37 +0530 (IST)
In-Reply-To: <4D21E048.2040005@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Benoit,
> -----Original Message-----
> From: Cousson, Benoit
> Sent: Monday, January 03, 2011 8:12 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP2+: hwmod: incorrect computation of autoidle_mask
> 
> Hi Tarun,
> 
> On 1/3/2011 10:59 PM, DebBarma, Tarun Kanti wrote:
> > Autoidle is just a single bit setting across OMAP platforms.
> > In _set_module_autoidle() I am seeing 0x3 where the mask is
> > computed. I believe this should be 0x1.
> 
> Just a minor comment; it looks from this description that you are not
> 100% sure it is a bug :-)
> You need to refer to the various TRMs, stating that this is indeed a bug
> for all OMAPs!
Ok, I will make the change.
> 
> Adding a "fix" in the subject seems more accurate to describe the patch.
> OMAP2+: Fix incorrect computation of autoidle_mask
Yes, I will make the change.

> 
> Since is it harmless for the moment, I think it will probably go for
> 2.6.39.
> 
> > Baseline:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> >
> > Tested Info:
> > Boot tested on OMAP 2/3/4.
> >
> > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> > Acked-by: Rajendra Nayak<rnayak@ti.com>
> 
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> 
> 
> Thanks,
> Benoit
> 
> > ---
> >   arch/arm/mach-omap2/omap_hwmod.c |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> > index 5a30658..da49b56 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod
> *oh, u8 autoidle,
> >   	}
> >
> >   	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
> > -	autoidle_mask = (0x3<<  autoidle_shift);
> > +	autoidle_mask = (0x1<<  autoidle_shift);
> >
> >   	*v&= ~autoidle_mask;
> >   	*v |= autoidle<<  autoidle_shift;

