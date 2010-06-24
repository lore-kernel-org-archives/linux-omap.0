From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 24 Jun 2010 01:19:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006240116450.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-12-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15E5B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59153 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab0FXHT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 03:19:56 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15E5B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 24 Jun 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
> > Walmsley
> > Sent: Thursday, June 24, 2010 11:57 AM

> > > +struct device *omap_get_mpu_device(void)
> > > +{
> > > +	mpu_dev = per_cpu(mpu_dev, smp_processor_id());
> > 
> > Looks like this will trash the per-CPU mpu_dev on SMP.  You'll need to
> > rename one of these two mpu_devs.
> > 
> > Also, won't the use of smp_processor_id() mean that this will just return
> > the struct device * for the MPU that is running this code?  So on a
> > two-CPU system, it would be either CPU 0 or 1, randomly.  I guess one
> > solution would be to pass in the processor ID to omap_get_mpu_device().
> >
> MPUSS and both CPU's are clocked from same clock source, so above assumption
> still work on OMAP4.

If the point is to only return an omap_device corresponding to the MPU 
subsystem, then all the per_cpu() stuff is unnecessary and can be dropped, 
and the function should be so named (e.g., omap_get_mpuss_device()).


- Paul
