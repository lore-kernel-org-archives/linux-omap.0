From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 1/4] twl: update overo and pandora i2c data
Date: Tue, 25 Nov 2008 16:24:02 -0800
Message-ID: <200811251624.02943.david-b@pacbell.net>
References: <200811151238.43725.david-b@pacbell.net> <20081125232539.GA11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:31470 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868AbYKZBmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 20:42:32 -0500
In-Reply-To: <20081125232539.GA11997@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 25 November 2008, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [081115 12:54]:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Update Pandora and Overo board-specific code to report that
> > they use catalog versions of the twl5030 ... this affects
> > the range of usable VAUX2 voltages.
> 
> Pushing 1 - 3 to l-o tree, not pushing 4. We'll need to do similar
> updates for mainline too btw.

Right, that's part of why this is in a separate patch.
But hmm, board-omap3pandora isn't yet in mainline.  Bummer!

- Dave


> 
> Tony
> 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> >  arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
> >  arch/arm/mach-omap2/board-overo.c        |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/arm/mach-omap2/board-omap3pandora.c
> > +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> > @@ -167,7 +167,7 @@ static struct twl4030_platform_data omap
> >  
> >  static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
> >  	{
> > -		I2C_BOARD_INFO("twl4030", 0x48),
> > +		I2C_BOARD_INFO("tps65950", 0x48),
> >  		.flags = I2C_CLIENT_WAKE,
> >  		.irq = INT_34XX_SYS_NIRQ,
> >  		.platform_data = &omap3pandora_twldata,
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -167,7 +167,7 @@ static struct twl4030_platform_data over
> >  
> >  static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
> >  	{
> > -		I2C_BOARD_INFO("twl4030", 0x48),
> > +		I2C_BOARD_INFO("tps65950", 0x48),
> >  		.flags = I2C_CLIENT_WAKE,
> >  		.irq = INT_34XX_SYS_NIRQ,
> >  		.platform_data = &overo_twldata,
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


