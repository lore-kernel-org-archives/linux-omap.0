From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 24 Jun 2010 12:57:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15E92@dbde02.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
 <1277336563-24988-12-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15E5B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1006240116450.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202Ab0FXH2E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 03:28:04 -0400
In-Reply-To: <alpine.DEB.2.00.1006240116450.1550@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, June 24, 2010 12:50 PM
> To: Shilimkar, Santosh
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
> 
> On Thu, 24 Jun 2010, Shilimkar, Santosh wrote:
> 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Paul
> > > Walmsley
> > > Sent: Thursday, June 24, 2010 11:57 AM
> 
> > > > +struct device *omap_get_mpu_device(void)
> > > > +{
> > > > +	mpu_dev = per_cpu(mpu_dev, smp_processor_id());
> > >
> > > Looks like this will trash the per-CPU mpu_dev on SMP.  You'll need to
> > > rename one of these two mpu_devs.
> > >
> > > Also, won't the use of smp_processor_id() mean that this will just return
> > > the struct device * for the MPU that is running this code?  So on a
> > > two-CPU system, it would be either CPU 0 or 1, randomly.  I guess one
> > > solution would be to pass in the processor ID to omap_get_mpu_device().
> > >
> > MPUSS and both CPU's are clocked from same clock source, so above assumption
> > still work on OMAP4.
> 
> If the point is to only return an omap_device corresponding to the MPU
> subsystem, then all the per_cpu() stuff is unnecessary and can be dropped,
> and the function should be so named (e.g., omap_get_mpuss_device()).
> 
Indeed !!
Even otherwise the patch is not really initializing per-cpu device because
init(omap_hwmod_for_each_by_class("mpu", _init_omap_device, &mpu_dev);)
is called only on one CPU.

Regards,
Santosh
