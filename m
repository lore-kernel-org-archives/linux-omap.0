From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Mon, 8 Jun 2009 15:49:21 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2F73A252@dlee03.ent.ti.com>
References: <1244121977-24927-1-git-send-email-ameya.palande@nokia.com>
	<27F9C60D11D683428E133F85D2BB4A53040F3FCD75@dlee03.ent.ti.com>
 <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbZFHUtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 16:49:31 -0400
In-Reply-To: <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>

Hi Doyu-san,

Regarding

> http://marc.info/?l=linux-omap&m=124201773423892&w=2
> I think that the first one should be merged into d.o-z.org now, but
> for the second one about 128 byte alignment. let me know your
> thought/plan on it.

-- I think you sent this patch as a probable fix for the slab corruption that was observed in Bridge driver, but then we found that slab corruption was due to some other issue in Bridge driver and not due to the cache alignment.

Irrespective of above point, I think it is good to enforce the cache alignment check, but I think the check should be in Proc Map function and to start with the check should be under a flag so as not to affect some MM applications that use padding to get over the alignment issue.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Monday, June 08, 2009 6:34 AM
> To: Ramirez Luna, Omar
> Cc: ameya.palande@nokia.com; linux-omap@vger.kernel.org;
> felipe.contreras@gmail.com
> Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
> 
> From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
> Subject: RE: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
> Date: Mon, 8 Jun 2009 08:49:03 +0200
> 
> > >From: Ameya Palande [mailto:ameya.palande@nokia.com]
> > >Subject: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
> > >
> > >From: Ameya Palande <ameya.palande@nokia.com>
> > >
> > >Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > >---
> > > drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
> > > drivers/dsp/bridge/rmgr/drv_interface.h |    2 +-
> > > 2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
> b/drivers/dsp/bridge/rmgr/drv_interface.c
> > >index c3d8a02..f41e153 100644
> > >--- a/drivers/dsp/bridge/rmgr/drv_interface.c
> > >+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> > >@@ -665,7 +665,7 @@ static int bridge_release(struct inode *ip, struct
> file *filp)
> > > }
> > >
> > > /* This function provides IO interface to the bridge driver. */
> > >-static int bridge_ioctl(struct file *filp, unsigned int code,
> > >+static long bridge_ioctl(struct file *filp, unsigned int code,
> > > 		unsigned long args)
> > > {
> > > 	int status;
> > >diff --git a/drivers/dsp/bridge/rmgr/drv_interface.h
> b/drivers/dsp/bridge/rmgr/drv_interface.h
> > >index 3e77ed0..dc49210 100644
> > >--- a/drivers/dsp/bridge/rmgr/drv_interface.h
> > >+++ b/drivers/dsp/bridge/rmgr/drv_interface.h
> > >@@ -34,7 +34,7 @@ static int __init bridge_init(void);	/* Initialize
> bridge */
> > > static void __exit bridge_exit(void);	/* Opposite of initialize */
> > > static int bridge_open(struct inode *, struct file *);	/* Open */
> > > static int bridge_release(struct inode *, struct file *);	/*
> Release */
> > >-static int bridge_ioctl(struct file *, unsigned int,
> > >+static long bridge_ioctl(struct file *, unsigned int,
> > > 			unsigned long);
> > > static int bridge_mmap(struct file *filp, struct vm_area_struct *vma);
> > > #endif				/* ifndef _DRV_INTERFACE_H_ */
> > >--
> > >1.6.2.4
> > >
> >
> > Pushed to bridge tree on dev.omapzoom.org
> 
> Thanks. Also there still seems to remain 2 patches:
> 
> 	http://marc.info/?l=linux-omap&m=124201773423895&w=2
> 	http://marc.info/?l=linux-omap&m=124201773423892&w=2
> 
> I think that the first one should be merged into d.o-z.org now, but
> for the second one about 128 byte alignment. let me know your
> thought/plan on it.
> 
> >
> > - omar
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

