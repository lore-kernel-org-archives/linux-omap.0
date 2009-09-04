From: Peter Barada <peterb@logicpd.com>
Subject: RE: [RFC][PATCH] omapfb: Reorder Register_framebuffer call
Date: Fri, 04 Sep 2009 09:34:28 -0400
Message-ID: <1252071268.2507.1.camel@blitz>
References: <A24693684029E5489D1D202277BE89444BA0DB52@dlee02.ent.ti.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A0071B9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:43923 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753083AbZIDN3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Sep 2009 09:29:25 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071B9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2009-09-04 at 12:14 +0530, Gadiyar, Anand wrote:
> > From: Sergio Aguirre <saaguirre@ti.com>
> > 
> > This fixes the issue in which mm_lock mutex was attempted to be
> > used without initializing previously.
> > 
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> 
> Tested-by: Anand Gadiyar <gadiyar@ti.com>
> 
> This patch on top of current linux-omap kernel allows me to
> boot with the default SDP defconfig on a 3430 SDP.

Tested-by: Peter Barada <peterb@logicpd.com>

This patch on top of current linux-omap kernel allows me to boot with
the LCD enabled on LogicPD's OMAP boards.

> > ---
> >  drivers/video/omap/omapfb_main.c |   20 +++++++++++---------
> >  1 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> > index 125e605..60f9482 100644
> > --- a/drivers/video/omap/omapfb_main.c
> > +++ b/drivers/video/omap/omapfb_main.c
> > @@ -1503,12 +1503,21 @@ static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info)
> >  	var->rotate	  = def_rotate;
> >  	var->bits_per_pixel = fbdev->panel->bpp;
> >  
> > +	r = register_framebuffer(info);
> > +	if (r != 0) {
> > +		dev_err(fbdev->dev,
> > +			"registering framebuffer failed\n");
> > +		return r;
> > +	}
> > +
> >  	set_fb_var(info, var);
> >  	set_fb_fix(info);
> >  
> >  	r = fb_alloc_cmap(&info->cmap, 16, 0);
> > -	if (r != 0)
> > +	if (r != 0) {
> >  		dev_err(fbdev->dev, "unable to allocate color map memory\n");
> > +		unregister_framebuffer(info);
> > +	}
> >  
> >  	return r;
> >  }
> > @@ -1773,15 +1782,8 @@ static int omapfb_do_probe(struct platform_device *pdev,
> >  	init_state++;
> >  
> >  	vram = 0;
> > -	for (i = 0; i < fbdev->mem_desc.region_cnt; i++) {
> > -		r = register_framebuffer(fbdev->fb_info[i]);
> > -		if (r != 0) {
> > -			dev_err(fbdev->dev,
> > -				"registering framebuffer %d failed\n", i);
> > -			goto cleanup;
> > -		}
> > +	for (i = 0; i < fbdev->mem_desc.region_cnt; i++)
> >  		vram += fbdev->mem_desc.region[i].size;
> > -	}
> >  
> >  	fbdev->state = OMAPFB_ACTIVE;
> >  
> > -- 
> > 1.6.3.2
> > 
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
