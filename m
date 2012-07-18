From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH] OMAP4: 4430sdp: OTG: increase max allowed output current
Date: Wed, 18 Jul 2012 12:43:22 +0300
Message-ID: <CAEa47Nqu_b_KGou30u64gsQC_Qwz-X=P9_a5YRTTCCE0mwS2mg@mail.gmail.com>
References: <1342099542-13862-1-git-send-email-ruslan.bilovol@ti.com>
	<CAAe_U6Kza7Zc2SF-ve761Kb2_0Q-9K19qkAZ2eahh-AHrsfh8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38894 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010Ab2GRJnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 05:43:24 -0400
Received: by vcbfk26 with SMTP id fk26so1073304vcb.5
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 02:43:22 -0700 (PDT)
In-Reply-To: <CAAe_U6Kza7Zc2SF-ve761Kb2_0Q-9K19qkAZ2eahh-AHrsfh8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

On Fri, Jul 13, 2012 at 8:53 AM, ABRAHAM, KISHON VIJAY <kishon@ti.com>
wrote:
>
> Hi,
>
> On Thu, Jul 12, 2012 at 6:55 PM, Ruslan Bilovol <ruslan.bilovol@ti.com>
> wrote:
> > TWL6030/32 that is used on 4430sdp board can deliver up to 200mA
> > for OTG port power supply in the HOST mode.
> >
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> > b/arch/arm/mach-omap2/board-4430sdp.c
> > index 8e17284..10223f5 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -429,7 +429,7 @@ static struct platform_device *sdp4430_devices[]
> > __initdata = {
> >  static struct omap_musb_board_data musb_board_data = {
> >         .interface_type         = MUSB_INTERFACE_UTMI,
> >         .mode                   = MUSB_OTG,
> > -       .power                  = 100,
> > +       .power                  = 200,
> >  };
>
> Shouldn't this change be made for omap4 panda as well.

Yes, omap4 panda uses same TWL IC. Should I fix this patch or send
separate for panda?

--
Best regards,
Ruslan Bilovol

>
> Thanks
> Kishon
