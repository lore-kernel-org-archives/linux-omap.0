From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP: id: Add missing break statement in
 omap3xxx_check_revision
Date: Mon, 30 Jan 2012 08:30:40 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317B7282@DBDE01.ent.ti.com>
References: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
 <20120127002543.GG29812@atomide.com>
 <79CD15C6BA57404B839C016229A409A8317B530C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39217 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2A3Ias convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 03:30:48 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317B530C@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pedanekar, Hemant" <hemantp@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 27, 2012 at 11:02:01, Hiremath, Vaibhav wrote:
> On Fri, Jan 27, 2012 at 05:55:43, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120122 23:26]:
> > > Add missing break statement in the function omap3xxx_check_revision.
> > > 
> > > The commit id 4390f5b2cb1f56 [ARM: OMAP: TI814X: Add cpu type macros
> > > and detection support], removed the 'break' statement from the function
> > > omap3xxx_check_revision(), resulting into wrong omap/cpu_revision
> > > initialization for AM335x devices.
> > 
> > Looks like this is already fixed, can you please verify with
> > v3.3-rc1?
> > 
> Tony,
> 
> I just looked at your linux-omap/master branch and 'break' statement is missing. So this patch is still required.
> 
> I can still see,
> 
> 394                 }
> 395                 break;
> 396         case 0xb944:
> 397                 omap_revision = AM335X_REV_ES1_0;
> 398                 cpu_rev = "1.0";
> 399         case 0xb8f2:
> 400                 switch (rev) {
> 
> 
Tony,

Can this be merged? I can still see "break" statement missing in the latest
linux-omap/master branch.

Thanks,
Vaibhav

> Thanks,
> Vaibhav
> 
> 
> > Regards,
> > 
> > Tony
> >  
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/mach-omap2/id.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > index 325e12e..32cf203 100644
> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -395,6 +395,7 @@ void __init omap3xxx_check_revision(void)
> > >  	case 0xb944:
> > >  		omap_revision = AM335X_REV_ES1_0;
> > >  		cpu_rev = "1.0";
> > > +		break;
> > >  	case 0xb8f2:
> > >  		switch (rev) {
> > >  		case 0:
> > > --
> > > 1.7.0.4
> > > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

