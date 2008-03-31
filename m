From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] Fix TUSB6010 ID register offsets.
Date: Mon, 31 Mar 2008 14:52:32 +0200
Message-ID: <fb249edb0803310552r25151364l7e345af3f166e2ac@mail.gmail.com>
References: <12068131361588-git-send-email-balrogg@gmail.com>
	 <20080331075810.GG26502@atomide.com>
	 <20080331085825.GB4467@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:10887 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbYCaMwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 08:52:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so428755ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 31 Mar 2008 05:52:32 -0700 (PDT)
In-Reply-To: <20080331085825.GB4467@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 31/03/2008, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Mar 31, 2008 at 10:58:11AM +0300, Tony Lindgren wrote:
>  > * Andrzej Zaborowski <balrogg@gmail.com> [080329 18:48]:
>  > > From: Andrzej Zaborowski <balrog@zabor.org>
>  > >
>  > > [Sorry, the previous patch was a copy/paste mistake, this one should be
>  > > better]
>  > >
>  > > I have no access to the docs for this chip but I'm pretty sure the current
>  > > address of the two DIDR1 registers is wrong because it's outside the
>  > > TUSB-specific register space.  The modified address in turn has a good
>  > > chance to be correct.
>  > >
>  > > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
>  > > ---
>  > >  drivers/usb/musb/tusb6010.h |    4 ++--
>  > >  1 files changed, 2 insertions(+), 2 deletions(-)
>  > >
>  > > diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
>  > > index bb25c3b..f2036ef 100644
>  > > --- a/drivers/usb/musb/tusb6010.h
>  > > +++ b/drivers/usb/musb/tusb6010.h
>  > > @@ -225,8 +225,8 @@ extern void tusb_allow_idle(struct musb *musb, u32 wakeup_enables);
>  > >  #define TUSB_PROD_TEST_RESET_VAL           0xa596
>  > >  #define TUSB_EP_FIFO(ep)                   (TUSB_FIFO_BASE + (ep) * 0x20)
>  > >
>  > > -#define TUSB_DIDR1_LO                              0x1f8
>  > > -#define TUSB_DIDR1_HI                              0x1fc
>  > > +#define TUSB_DIDR1_LO                              (TUSB_SYS_REG_BASE + 0x1f8)
>  > > +#define TUSB_DIDR1_HI                              (TUSB_SYS_REG_BASE + 0x1fc)
>  > >  #define            TUSB_DIDR1_HI_CHIP_REV(v)               (((v) >> 17) & 0xf)
>  > >  #define                    TUSB_DIDR1_HI_REV_20            0
>  > >  #define                    TUSB_DIDR1_HI_REV_30            1
>  >
>  > This looks like a valid fix. Hmm, I guess we've had some unnecessary
>  > software workarounds for tusb3.1 chips happening :)
>
>
> Ugh, I'm out for today and tomorrow but I'll test on wednesday and make
>  sure it works.

Thanks.

I only checked with usb-net, the only difference was that I got
"dieid2" instead of "dieid5" in the dmesg (2 seems correct for
rev3.1). The machine is some n810 proto (says N00).

Cheers
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
