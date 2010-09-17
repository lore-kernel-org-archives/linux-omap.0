From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 14/14] omap4: Fix bootup crash observed with higher CPU
 clocks
Date: Fri, 17 Sep 2010 16:00:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307CA7@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-15-git-send-email-santosh.shilimkar@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014F13A77C@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C7B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014F13A782@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab0IQKai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:30:38 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014F13A782@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, September 17, 2010 3:57 PM
> To: Shilimkar, Santosh; linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Nayak, Rajendra
> Subject: RE: [PATCH 14/14] omap4: Fix bootup crash observed with higher
> CPU clocks
> 
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Friday, September 17, 2010 5:17 AM
> [..]
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> > > > Sent: Friday, September 17, 2010 4:48 AM
> 
> [...]
> > > > ---
> > > >  arch/arm/plat-omap/dmtimer.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> > omap/dmtimer.c
> > > > index 44bafda..1d706cf 100644
> > > > --- a/arch/arm/plat-omap/dmtimer.c
> > > > +++ b/arch/arm/plat-omap/dmtimer.c
> > > > @@ -581,7 +581,7 @@ int omap_dm_timer_set_source(struct
> omap_dm_timer
> > > > *timer, int source)
> > > >  	 * When the functional clock disappears, too quick writes seem
> > > >  	 * to cause an abort. XXX Is this still necessary?
> > > >  	 */
> > > > -	__delay(150000);
> > > > +	__delay(300000);
> > > What is the rationale for this increase? Lets say we have a CPU bumped
> > up
> > > to 1GHz or something will we have weird numbers again?
> > >
> > This is the max what we need at any clock speed. As mentioned in commit
> > "The timer hwmod adaptation will eventually fix it in a proper way"
> 
> Okay.. taking your word for it ;)
>
This one I will ensure.
 
> PS: hard coded numbers + delays makes the red blue and white lights in my
> head to go off..(it even makes the siren sound too) ;)
> 
Second your thought. Infact I wasn't ok to push this patch to start
with but it's needed till the timer hwmod gets merged

Regards,
Santosh

