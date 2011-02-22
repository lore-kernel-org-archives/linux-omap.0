From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 5/5] OMAP3EVM: Set TSC wakeup option in pad config
Date: Tue, 22 Feb 2011 11:31:31 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E16E1809@dbde02.ent.ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
 <1295977061-11086-6-git-send-email-hvaibhav@ti.com> <87k4hqnq6l.fsf@ti.com>
 <20110217221933.GC20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab1BVGBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 01:01:40 -0500
In-Reply-To: <20110217221933.GC20795@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 18, 2011 3:50 AM
> To: Hilman, Kevin
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 5/5] OMAP3EVM: Set TSC wakeup option in pad config
> 
> * Kevin Hilman <khilman@ti.com> [110127 10:41]:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >
> > > Set OMAP_PIN_OFF_WAKEUPENABLE to enable the wake-up
> > > functionality from touchscreen controller.
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/board-omap3evm.c |    6 ++++--
> > >  1 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > > index 2a2efa9..5eddf93 100644
> > > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > > @@ -716,7 +716,8 @@ static struct omap_board_mux omap35x_board_mux[]
> __initdata = {
> > >  				OMAP_PIN_OFF_INPUT_PULLUP |
> OMAP_PIN_OFF_OUTPUT_LOW |
> > >  				OMAP_PIN_OFF_WAKEUPENABLE),
> > >  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> > > -				OMAP_PIN_OFF_INPUT_PULLUP |
> OMAP_PIN_OFF_OUTPUT_LOW),
> > > +				OMAP_PIN_OFF_INPUT_PULLUP |
> OMAP_PIN_OFF_OUTPUT_LOW |
> > > +				OMAP_PIN_OFF_WAKEUPENABLE),
> >
> > This hunk doesn't apply because the code below (SYS_BOOT5, etc.) doesn't
> > exist in upstream code.
> 
> Looks like this applies on top of current omap-for-linus with the mcspi
> changes
> in. So I've applied all the omap3evm related patches.
> 
> I had to resolve few changes manually with wl12xx changes, can you guys
> please
> check that everything is working? Pushing them into the devel-board branch.
> 
[Hiremath, Vaibhav] Thanks Tony for merging all these patches.

I have tested it here at my end on RevG version of EVM. Also I have verified NFS mount on both <RevD & RevG EVM's without any issues.

Thanks,
Vaibhav

> Regards,
> 
> Tony
