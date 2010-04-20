From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP:ls037v7dw01: Included slab.h file required for
 kzalloc
Date: Tue, 20 Apr 2010 21:03:46 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EB0CD@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1271756699-3161-1-git-send-email-hvaibhav@ti.com>
 <1271774466.2433.26.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab0DTPeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 11:34:04 -0400
In-Reply-To: <1271774466.2433.26.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, April 20, 2010 8:11 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP:ls037v7dw01: Included slab.h file required for
> kzalloc
> 
> Hi,
> 
> On Tue, 2010-04-20 at 11:44 +0200, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > With recent kernel changes, without inclusion of slab.h
> > kernel build fails with,
> >
> >   CC      drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o
> >   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c: In function
> >   'sharp_ls_panel_probe':
> >   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: error:
> implicit
> >   declaration of function 'kzalloc'
> >   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: warning:
> >   assignment makes pointer from integer without a cast
> >   drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:106: error:
> implicit
> >   declaration of function 'kfree'
> >   make[4]: *** [drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o]
> Error 1
> >   make[3]: *** [drivers/video/omap2/displays] Error 2
> >   make[2]: *** [drivers/video/omap2] Error 2
> >   make[1]: *** [drivers/video] Error 2
> >   make: *** [drivers] Error 2
> >
> >
> 
> I already added this include into the backlight patch you sent
> previously.
> 
[Hiremath, Vaibhav] Great, 
My daily build generated this issue and I haven't seen it neither in linux-omap/master nor in linux-omap/dss2 so created a patch.

Thanks,
Vaibhav

>  Tomi
> 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > index d84feb0..7d9eb2b 100644
> > --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/backlight.h>
> >  #include <linux/fb.h>
> >  #include <linux/err.h>
> > +#include <linux/slab.h>
> >
> >  #include <plat/display.h>
> >
> > --
> > 1.6.2.4
> >
> 

