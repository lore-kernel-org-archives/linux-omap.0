From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 3/5] OMAP: DSS2: Add new overlay object for Video3
 pipeline
Date: Fri, 23 Jul 2010 11:08:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305EEAA15@dbde02.ent.ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED62F3D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab0GWFi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 01:38:27 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044ED62F3D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>

 Hi,

> -----Original Message-----
> From: Hiremath, Vaibhav 
> Sent: Friday, July 23, 2010 10:54 AM
> To: Taneja, Archit; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Mittal, Mukund
> Subject: RE: [PATCH 3/5] OMAP: DSS2: Add new overlay object 
> for Video3 pipeline
> 
>
 
<snap>

> >  	struct overlay_cache_data *oc;
> >  	struct manager_cache_data *mc;
> > -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> > +	const int num_ovls = MAX_DSS_OVERLAYS;
> [Hiremath, Vaibhav] You may want to clean this up, since now 
> you have global definition MAX_DSS_OVERLAYS.
> Applies to everywhere its being used.
> 
> >  	const int num_mgrs = MAX_DSS_MANAGERS;
> >  	int i;
> >  	int r;
> > @@ -1000,7 +1001,7 @@ void dss_setup_partial_planes(struct 
> > omap_dss_device *dssdev,  {
> >  	struct overlay_cache_data *oc;
> >  	struct manager_cache_data *mc;
> > -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> > +	const int num_ovls = MAX_DSS_OVERLAYS;
> [Hiremath, Vaibhav] Ditto.
> 
> >  	struct omap_overlay_manager *mgr;
> >  	int i;
> >  	u16 x, y, w, h;
> > @@ -1132,7 +1133,7 @@ void dss_start_update(struct omap_dss_device 
> > *dssdev)  {
> >  	struct manager_cache_data *mc;
> >  	struct overlay_cache_data *oc;
> > -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> > +	const int num_ovls = MAX_DSS_OVERLAYS;
> [Hiremath, Vaibhav] Ditto.
> 
> >  	const int num_mgrs = MAX_DSS_MANAGERS;
> >  	struct omap_overlay_manager *mgr;
> >  	int i;
> > @@ -1162,8 +1163,8 @@ static void dss_apply_irq_handler(void *data, 
> > u32
> > mask)
> >  {
> >  	struct manager_cache_data *mc;
> >  	struct overlay_cache_data *oc;
> > -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> > -	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
> > +	const int num_ovls = MAX_DSS_OVERLAYS;
> > +	const int num_mgrs = MAX_DSS_MANAGERS;
> >  	int i, r;
> >  	bool mgr_busy[MAX_DSS_MANAGERS];
> > 
> > diff --git a/drivers/video/omap2/dss/overlay.c
> > b/drivers/video/omap2/dss/overlay.c
> > index 29aa157..2f8f89c
> > --- a/drivers/video/omap2/dss/overlay.c
> > +++ b/drivers/video/omap2/dss/overlay.c
> > @@ -36,6 +36,8 @@
> > 
> >  #include "dss.h"
> > 
> > +#define MAX_DSS_OVERLAYS (cpu_is_omap44xx() ? 4 : 3)
> > +
> 
> [Hiremath, Vaibhav] Since this definition is being used in 
> multiple file, consider moving this to dss.h file so that we 
> have one place to see/modify in the future.
> 
> Thanks,
> Vaibhav
> 
Thanks for the comments, I will incorporate the following changes:
-remove const int num_mgrs and num_ovls variables as they are replaced
by the new globals everywhere.
-shift the MAX_DSS_OVERLAYS and MAX_DSS_MANAGERS to dss.h

Archit

