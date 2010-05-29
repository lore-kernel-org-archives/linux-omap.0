From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Fix build break with omap3_defconfig
Date: Sat, 29 May 2010 11:12:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5844CF6@dbde02.ent.ti.com>
References: <1275062022-15067-1-git-send-email-santosh.shilimkar@ti.com>
 <87typrdhx9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0E2FmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 01:42:11 -0400
In-Reply-To: <87typrdhx9.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, May 28, 2010 11:32 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap: Fix build break with omap3_defconfig
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
> > With latest linus's tip omap3_defconfig is broken.
> 
> This subject/shortlog is not terribly useful for git history.  it
> should say something like
> 
> OMAP: Stalker board: update usage of GPIO debounce API
> 
Sure. The subject should have included " Stalker" board.

> or something like that.  The changelog should summarize that this
> API changed (or was removed) in mainline and the previous change
> that updated this API missed this board etc...
> 
> All of this can be deduced from reading the current patch and changelog,
> but it's better to summarize it in the changelog.
> 
Exactly and that's why I just gave reference to the commit ID.

Will repost with changelog/subject corrected.

> Thanks,
> 
> Kevin
> 
> > From the commit 8feb337475aaf, board-omap3stalker.c seems to
> > be missed out.
> >
> >  LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
> > linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined reference to
> `omap_set_gpio_debounce'
> > linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined reference to
> `omap_set_gpio_debounce_time'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
> > index f848ba8..a04cffd 100644
> > --- a/arch/arm/mach-omap2/board-omap3stalker.c
> > +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> > @@ -538,9 +538,7 @@ static void ads7846_dev_init(void)
> >  		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
> >
> >  	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
> > -
> > -	omap_set_gpio_debounce(OMAP3_STALKER_TS_GPIO, 1);
> > -	omap_set_gpio_debounce_time(OMAP3_STALKER_TS_GPIO, 0xa);
> > +	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
> >  }
> >
> >  static int ads7846_get_pendown_state(void)
> > --
> > 1.6.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
