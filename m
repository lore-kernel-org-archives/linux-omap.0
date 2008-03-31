From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix TUSB6010 ID register offsets.
Date: Mon, 31 Mar 2008 11:58:26 +0300
Message-ID: <20080331085825.GB4467@kedavra.cpe.vivax.com.br>
References: <12068131361588-git-send-email-balrogg@gmail.com> <20080331075810.GG26502@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46027 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbYCaI4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 04:56:18 -0400
Content-Disposition: inline
In-Reply-To: <20080331075810.GG26502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrzej Zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org

On Mon, Mar 31, 2008 at 10:58:11AM +0300, Tony Lindgren wrote:
> * Andrzej Zaborowski <balrogg@gmail.com> [080329 18:48]:
> > From: Andrzej Zaborowski <balrog@zabor.org>
> > 
> > [Sorry, the previous patch was a copy/paste mistake, this one should be
> > better]
> > 
> > I have no access to the docs for this chip but I'm pretty sure the current
> > address of the two DIDR1 registers is wrong because it's outside the
> > TUSB-specific register space.  The modified address in turn has a good
> > chance to be correct.
> > 
> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> > ---
> >  drivers/usb/musb/tusb6010.h |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
> > index bb25c3b..f2036ef 100644
> > --- a/drivers/usb/musb/tusb6010.h
> > +++ b/drivers/usb/musb/tusb6010.h
> > @@ -225,8 +225,8 @@ extern void tusb_allow_idle(struct musb *musb, u32 wakeup_enables);
> >  #define TUSB_PROD_TEST_RESET_VAL		0xa596
> >  #define TUSB_EP_FIFO(ep)			(TUSB_FIFO_BASE + (ep) * 0x20)
> >  
> > -#define TUSB_DIDR1_LO				0x1f8
> > -#define TUSB_DIDR1_HI				0x1fc
> > +#define TUSB_DIDR1_LO				(TUSB_SYS_REG_BASE + 0x1f8)
> > +#define TUSB_DIDR1_HI				(TUSB_SYS_REG_BASE + 0x1fc)
> >  #define		TUSB_DIDR1_HI_CHIP_REV(v)		(((v) >> 17) & 0xf)
> >  #define			TUSB_DIDR1_HI_REV_20		0
> >  #define			TUSB_DIDR1_HI_REV_30		1
> 
> This looks like a valid fix. Hmm, I guess we've had some unnecessary
> software workarounds for tusb3.1 chips happening :)

Ugh, I'm out for today and tomorrow but I'll test on wednesday and make
sure it works.

thanks, btw.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
