From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() with sysfs_streq()
 in overlay_manager_store()
Date: Wed, 28 Jul 2010 22:33:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A025@dbde02.ent.ti.com>
References: <'> <1280298118-4295-1-git-send-email-archit@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F08@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EAB90@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50310 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0G1RDj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 13:03:39 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703060EAB90@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Taneja, Archit 
> Sent: Wednesday, July 28, 2010 8:06 PM
> To: Premi, Sanjeev; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() 
> with sysfs_streq() in overlay_manager_store()
> 
>  
> 
> > -----Original Message-----
> > From: Premi, Sanjeev 
> > Sent: Wednesday, July 28, 2010 7:28 PM
> > To: Taneja, Archit; tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() 
> > with sysfs_streq() in overlay_manager_store()
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> > Taneja, Archit
> > > Sent: Wednesday, July 28, 2010 11:52 AM
> > > To: tomi.valkeinen@nokia.com
> > > Cc: linux-omap@vger.kernel.org; Taneja, Archit
> > > Subject: [PATCH resend] OMAP: DSS2: Replace strncmp() with
> > > sysfs_streq() in overlay_manager_store()
> > > 
> > > In the function overlay_manager_store, the length of the 
> > string buf is 
> > > used to comapre the 2 strings, there is a possibility of false 
> > > positive match if buf is a prefix string of another manager.
> > > 
> > > The use of sysfs_streq() fixes this.
> > > 
> > > Signed-off-by: Archit Taneja <archit@ti.com>
> > > ---
> > >  drivers/video/omap2/dss/overlay.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/video/omap2/dss/overlay.c
> > > b/drivers/video/omap2/dss/overlay.c
> > > index 8233658..244dca8
> > > --- a/drivers/video/omap2/dss/overlay.c
> > > +++ b/drivers/video/omap2/dss/overlay.c
> > > @@ -65,7 +65,7 @@ static ssize_t overlay_manager_store(struct 
> > > omap_overlay *ovl, const char *buf,
> > >  		for (i = 0; i <
> > > omap_dss_get_num_overlay_managers(); ++i) {
> > >  			mgr = omap_dss_get_overlay_manager(i);
> > >  
> > > -			if (strncmp(buf, mgr->name, len) == 0)
> > > +			if (sysfs_streq(buf, mgr->name))
> > 
> > [sp] sysfs_streq() ignores trailing newlines during comparison. So,
> >      the possibility mentioned in the description still stays.
> 
> The aim is to compare one string which is a sysfs input and the other
> which is in the kernel. 
> 
> > 
> >      I am not familiar with overall context; but wouldn't srtcmp()
> >      be the right choice? unless, of course, either of strings
> >      being compared are not null terminated.
> 
> The sysfs input will have a newline and null at the end whereas the
> other string will only have null, strcmp will fail when we 
> want the two
> strings to match.
> 
> Eg. Sysfs input "lcd\n\0"
> Kernel string "lcd\0"
> 
> strcmp will fail here

[sp] If the patch is intending to fix this condition, then it isn't
     evident from the description. You should consider updating the
     description.

> 
> > 
> > >  				break;
> > >  
> > >  			mgr = NULL;
> > > --
> > > 1.5.4.7
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" 
> > > in the body of a message to majordomo@vger.kernel.org More 
> > majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 