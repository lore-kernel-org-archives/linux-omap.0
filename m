From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed
 under DEBUG_FS
Date: Wed, 23 Dec 2009 22:04:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277589@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
 <1261483154.2108.86.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756416AbZLWQew convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 11:34:52 -0500
In-Reply-To: <1261483154.2108.86.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, December 22, 2009 5:29 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-fbdev-
> devel@lists.sourceforge.net; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks
> enclosed under DEBUG_FS
> 
> Hi,
> 
> On Thu, 2009-12-17 at 16:18 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Which warning does this fix? I don't get any compiler warnings.
> 
[Hiremath, Vaibhav] Below is the log - 


  CC      drivers/video/omap2/dss/core.o
drivers/video/omap2/dss/core.c:129: warning: 'core_dump_clocks' defined but not used
  CC      drivers/video/omap2/dss/dss.o


> Can you change the name of the patch to a more standard one?
> 
[Hiremath, Vaibhav] Ok, will do that and resubmit. I believe only prefix "OMAP" should do.

Thanks,
Vaibhav

>  Tomi
> 
> > ---
> >  drivers/video/omap2/dss/core.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/dss/core.c
> b/drivers/video/omap2/dss/core.c
> > index 29497a0..2fabaf2 100644
> > --- a/drivers/video/omap2/dss/core.c
> > +++ b/drivers/video/omap2/dss/core.c
> > @@ -124,6 +124,7 @@ static void restore_all_ctx(void)
> >  	dss_clk_disable_all_no_ctx();
> >  }
> >
> > +#if defined(CONFIG_DEBUG_FS) &&
> defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
> >  /* CLOCKS */
> >  static void core_dump_clocks(struct seq_file *s)
> >  {
> > @@ -149,6 +150,7 @@ static void core_dump_clocks(struct seq_file
> *s)
> >  				clocks[i]->usecount);
> >  	}
> >  }
> > +#endif /* defined(CONFIG_DEBUG_FS) &&
> defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
> >
> >  static int dss_get_clock(struct clk **clock, const char
> *clk_name)
> >  {
> 

