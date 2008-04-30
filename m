From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 4/7] OMAP3 EVM: add onenand flash support
Date: Wed, 30 Apr 2008 06:59:22 -0700
Message-ID: <5e088bd90804300659p7c4946c1he7abde8c9a53e9dc@mail.gmail.com>
References: <5e088bd90804281629n5bb4eb0cu3eb1704e521548cf@mail.gmail.com>
	 <0841370d1474c97fc74cfad2116790aa@felipebalbi.com>
	 <5e088bd90804300608p4b57e07bxcb0c317d036cbc8e@mail.gmail.com>
	 <0680EC522D0CC943BC586913CF3768C02E71F71F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:57794 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYD3N7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 09:59:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so165966fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 30 Apr 2008 06:59:22 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C02E71F71F@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>

I just saw that discussion and I agree.  Let's leave the patch as it is.

Steve

On Wed, Apr 30, 2008 at 6:14 AM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>
>  > -----Original Message-----
>  > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>  > owner@vger.kernel.org] On Behalf Of Steve Sakoman
>  > Sent: Wednesday, April 30, 2008 6:38 PM
>  > To: linux-omap@vger.kernel.org; Felipe Balbi
>  > Subject: Re: [PATCH 4/7] OMAP3 EVM: add onenand flash support
>  >
>  > On Wed, Apr 30, 2008 at 1:35 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>  >
>  > >  > +             .name           = "xloader",
>  > >  > +             .offset         = 0,
>  > >  > +             .size           = 4*(64*2048),
>  > >
>  > >  should be .size = SZ_512k,
>  >
>  > OK, will do.
>  >
>
>  Sakoman,
>
>  No need to re-work on this patch, as Richard mentioned they all depend on the geometry of the flash and might not meet the defined macros.
>
>  Regards,
>  Khasim
>
>
>  > >  > +             .name           = "uboot",
>  > >  > +             .offset         = MTDPART_OFS_APPEND,
>  > >  > +             .size           =  15*(64*2048),
>  > >
>  > >  most of the boards use .size = SZ_128K here
>  >
>  > This seemed strange to me too, but this is the way the board ships so
>  > I was hesitant to change it.  A change here will require changes to
>  > u-boot reflash scripts, etc.  Might cause a bit of confusion!  What do
>  > others think?
>  >
>  > >  > +             .name           = "params",
>  > >  > +             .offset         = MTDPART_OFS_APPEND,
>  > >  > +             .size           = 1*(64*2048),
>  > >
>  > >  SZ_128K
>  >
>  > OK, will do.
>  >
>  > >  > +             .name           = "linux",
>  > >  > +             .offset         = MTDPART_OFS_APPEND,
>  > >  > +             .size           = 40*(64*2048),
>  > >
>  > >  This looks too big for kernel only.
>  > >  SZ_4M is way enough.
>  >
>  > Same comment as above.  I am hesitant to change this without more
>  > discussion here.  But I agree that it makes sense :-)
>  >
>  > Thanks!
>  >
>  > Steve
>
>
> > --
>  > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  > the body of a message to majordomo@vger.kernel.org
>  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
