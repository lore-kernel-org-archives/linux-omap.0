From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] OMAP3EVM: Set TSC wakeup option in pad config
Date: Thu, 17 Feb 2011 14:19:33 -0800
Message-ID: <20110217221933.GC20795@atomide.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
 <1295977061-11086-6-git-send-email-hvaibhav@ti.com>
 <87k4hqnq6l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1BQWTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 17:19:39 -0500
Content-Disposition: inline
In-Reply-To: <87k4hqnq6l.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110127 10:41]:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Set OMAP_PIN_OFF_WAKEUPENABLE to enable the wake-up
> > functionality from touchscreen controller.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> > index 2a2efa9..5eddf93 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -716,7 +716,8 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
> >  				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
> >  				OMAP_PIN_OFF_WAKEUPENABLE),
> >  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
> > -				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
> > +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
> > +				OMAP_PIN_OFF_WAKEUPENABLE),
> 
> This hunk doesn't apply because the code below (SYS_BOOT5, etc.) doesn't
> exist in upstream code.

Looks like this applies on top of current omap-for-linus with the mcspi changes
in. So I've applied all the omap3evm related patches.

I had to resolve few changes manually with wl12xx changes, can you guys please
check that everything is working? Pushing them into the devel-board branch.

Regards,

Tony
