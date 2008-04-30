From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 4/7] OMAP3 EVM: add onenand flash support
Date: Wed, 30 Apr 2008 18:44:36 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C02E71F71F@dbde02.ent.ti.com>
References: <5e088bd90804281629n5bb4eb0cu3eb1704e521548cf@mail.gmail.com>
	 <0841370d1474c97fc74cfad2116790aa@felipebalbi.com>
 <5e088bd90804300608p4b57e07bxcb0c317d036cbc8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbYD3NVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 09:21:10 -0400
In-Reply-To: <5e088bd90804300608p4b57e07bxcb0c317d036cbc8e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Steve Sakoman
> Sent: Wednesday, April 30, 2008 6:38 PM
> To: linux-omap@vger.kernel.org; Felipe Balbi
> Subject: Re: [PATCH 4/7] OMAP3 EVM: add onenand flash support
>
> On Wed, Apr 30, 2008 at 1:35 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
> >  > +             .name           = "xloader",
> >  > +             .offset         = 0,
> >  > +             .size           = 4*(64*2048),
> >
> >  should be .size = SZ_512k,
>
> OK, will do.
>

Sakoman,

No need to re-work on this patch, as Richard mentioned they all depend on the geometry of the flash and might not meet the defined macros.

Regards,
Khasim

> >  > +             .name           = "uboot",
> >  > +             .offset         = MTDPART_OFS_APPEND,
> >  > +             .size           =  15*(64*2048),
> >
> >  most of the boards use .size = SZ_128K here
>
> This seemed strange to me too, but this is the way the board ships so
> I was hesitant to change it.  A change here will require changes to
> u-boot reflash scripts, etc.  Might cause a bit of confusion!  What do
> others think?
>
> >  > +             .name           = "params",
> >  > +             .offset         = MTDPART_OFS_APPEND,
> >  > +             .size           = 1*(64*2048),
> >
> >  SZ_128K
>
> OK, will do.
>
> >  > +             .name           = "linux",
> >  > +             .offset         = MTDPART_OFS_APPEND,
> >  > +             .size           = 40*(64*2048),
> >
> >  This looks too big for kernel only.
> >  SZ_4M is way enough.
>
> Same comment as above.  I am hesitant to change this without more
> discussion here.  But I agree that it makes sense :-)
>
> Thanks!
>
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
