From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMC: Add several missing line breaks.
Date: Fri, 28 Mar 2008 12:36:30 +0200
Message-ID: <20080328103630.GV24896@atomide.com>
References: <1206020243-23355-1-git-send-email-felipe.balbi@nokia.com> <1206545625-12709-1-git-send-email-edubezval@gmail.com> <1206545625-12709-2-git-send-email-edubezval@gmail.com> <20080326173922.GB16223@kedavra.cpe.vivax.com.br> <a0580c510803261107l280eb9a6i60824be3abf09e8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59576 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbYC1Kgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:36:36 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510803261107l280eb9a6i60824be3abf09e8d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080326 20:19]:
> Hi Balbi,
> 
> On Wed, Mar 26, 2008 at 1:39 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> > On Wed, Mar 26, 2008 at 11:33:45AM -0400, Eduardo Valentin wrote:
> >  > From: Felipe Balbi <felipe.balbi@nokia.com>
> >  >
> >  > Misc clean up in omap_hsmmc.c to beautify debugging output.
> >  >
> >  > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> >
> >  Here you should put what you changed just to ease the comparisson :-)
> 
> That's true. But the change was just to remove part of your patch that modified
> something that was already removed. And it still keeps adding missing
> line breaks :-).
> 
> >  But ok... thanks for checking it :-)

Pushing today.

Tony


> >
> >
> >
> >  > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >  > ---
> >  >  drivers/mmc/host/omap_hsmmc.c |   14 +++++++-------
> >  >  1 files changed, 7 insertions(+), 7 deletions(-)
> >  >
> >  > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> >  > index 3d4a7d1..70f6895 100644
> >  > --- a/drivers/mmc/host/omap_hsmmc.c
> >  > +++ b/drivers/mmc/host/omap_hsmmc.c
> >  > @@ -146,7 +146,7 @@ static void omap_mmc_stop_clock(struct mmc_omap_host *host)
> >  >       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> >  >               OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
> >  >       if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
> >  > -             dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped");
> >  > +             dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped\n");
> >  >  }
> >  >
> >  >  /*
> >  > @@ -401,7 +401,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
> >  >
> >  >       return 0;
> >  >  err:
> >  > -     dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage \n");
> >  > +     dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage\n");
> >  >       return ret;
> >  >  }
> >  >
> >  > @@ -760,11 +760,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> >  >        * MMC can still work without debounce clock.
> >  >        */
> >  >       if (IS_ERR(host->dbclk))
> >  > -             dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock \n");
> >  > +             dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock\n");
> >  >       else
> >  >               if (clk_enable(host->dbclk) != 0)
> >  >                       dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
> >  > -                                                     "clk failed\n");
> >  > +                                                     " clk failed\n");
> >  >               else
> >  >                       host->dbclk_enabled = 1;
> >  >
> >  > @@ -793,7 +793,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> >  >       ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED, pdev->name,
> >  >                        host);
> >  >       if (ret) {
> >  > -             dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
> >  > +             dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
> >  >               goto irq_err;
> >  >       }
> >  >
> >  > @@ -820,7 +820,7 @@ err:
> >  >       return ret;
> >  >
> >  >  irq_err:
> >  > -     dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs");
> >  > +     dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
> >  >       clk_disable(host->fclk);
> >  >       clk_disable(host->iclk);
> >  >       clk_put(host->fclk);
> >  > @@ -881,7 +881,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
> >  >                       if (ret)
> >  >                               dev_dbg(mmc_dev(host->mmc),
> >  >                                       "Unable to handle MMC board"
> >  > -                                     "level suspend\n");
> >  > +                                     " level suspend\n");
> >  >
> >  >                       if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
> >  >                               OMAP_HSMMC_WRITE(host->base, HCTL,
> >  > --
> >  > 1.5.4.2
> >  >
> >  > --
> >  > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >  > the body of a message to majordomo@vger.kernel.org
> >  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >  --
> >  Best Regards,
> >
> >  Felipe Balbi
> >  me@felipebalbi.com
> >  http://blog.felipebalbi.com
> >
> 
> 
> 
> -- 
> Eduardo Bezerra Valentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
