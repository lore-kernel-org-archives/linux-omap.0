From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to <
 83Mhz
Date: Thu, 9 Jul 2009 18:17:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907091814440.8616@utopia.booyaka.com>
References: <1247134702-12704-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0907091440480.8616@utopia.booyaka.com> <DF4DCBD3DB270B419320B577AC0C3C8602E2EB04@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52726 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZGJARZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 20:17:25 -0400
In-Reply-To: <DF4DCBD3DB270B419320B577AC0C3C8602E2EB04@zmy16exm62.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Limei-E12499 <E12499@motorola.com>
Cc: Rajendra Nayak <rnayak@ti.com>, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghongdemath, Girish" <girishsg@ti.com>

Hello Limei,

On Fri, 10 Jul 2009, Wang Limei-E12499 wrote:

> Thank you very much for copying me!   

You're welcome.

> During the investigation, Richard and Girish from TI helped, the mail
> is attached.

We should probably add them in the patch description too.

> Rajendra, 
> 
> Yesterday night, I sent mail to paul and kevin, I also submmited below
> patch along with detailed issue report and analysis. 
> 
> -#define FIXEDDELAY_MASK   (0xff << FIXEDDELAY_SHIFT)
> +#define FIXEDDELAY_MASK   0x00FFFFFF

I prefer Rajendra's patch -- it fixes a bug accidentally 
introduced in commit 102bfe0bcb4e5985322b5f30b1321f2be1ad1c20.


- Paul

> 
> 
> Thanks,
> limei
> 
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Thursday, July 09, 2009 3:44 PM
> To: Rajendra Nayak
> Cc: Wang Limei-E12499; khilman@deeprootsystems.com;
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: PM: Fix freeze when scaling CORE dpll to <
> 83Mhz
> 
> Hi Rajendra,
> 
> On Thu, 9 Jul 2009, Rajendra Nayak wrote:
> 
> > This patch fixes a bug in the CORE dpll scaling sequence which was 
> > errouneously clearing some bits in the SDRC DLLA CTRL register and 
> > hence causing a freeze.
> > The issue was observed only on platforms which scale CORE dpll to < 
> > 83Mhz and hence program the DLL in fixed delay mode.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, looks good, I'll queue this up for a fixes series to rmk.
> 
> One question: I got an E-mail on this earlier today from Limei Wang
> about this same issue.  Looks like we should credit Limei also in this
> patch with finding the bug.  Is this acceptable to you?
> 
> - Paul
> 
> > ---
> >  arch/arm/mach-omap2/sram34xx.S |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/sram34xx.S 
> > b/arch/arm/mach-omap2/sram34xx.S index 481f912..9be09a7 100644
> > --- a/arch/arm/mach-omap2/sram34xx.S
> > +++ b/arch/arm/mach-omap2/sram34xx.S
> > @@ -113,7 +113,7 @@ return_to_sdram:
> >  unlock_dll:
> >  	ldr	r11, omap3_sdrc_dlla_ctrl
> >  	ldr	r12, [r11]
> > -	and	r12, r12, #FIXEDDELAY_MASK
> > +	bic	r12, r12, #FIXEDDELAY_MASK
> >  	orr	r12, r12, #FIXEDDELAY_DEFAULT
> >  	orr	r12, r12, #DLLIDLE_MASK
> >  	str	r12, [r11]		@ (no OCP barrier needed)
> > --
> > 1.5.4.7
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> 


- Paul
