From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v8 6/11] OMAP1: dmtimer: conversion to platform devices
Date: Thu, 6 Jan 2011 14:58:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F4A7@dbde02.ent.ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<1294228127-11549-7-git-send-email-tarun.kanti@ti.com>
 <87r5cqvrir.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1AFJ2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 04:28:14 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p069SAlq010486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 03:28:12 -0600
In-Reply-To: <87r5cqvrir.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Kevin,
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, January 06, 2011 5:21 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v8 6/11] OMAP1: dmtimer: conversion to platform
> devices
> 
> Hi Tarun,
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > Convert OMAP1 dmtimers into a platform devices and then registers with
> > device model framework so that it can be bound to corresponding driver.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> One minor nit...
> 
> [...]
> 
> > +int __init omap1_dm_timer_init(void)
> > +{
> > +	int i;
> > +	int ret;
> > +	struct dmtimer_platform_data *pdata;
> > +	struct platform_device *pdev;
> > +
> > +	pr_debug("%s: +\n", __func__);
> 
> stray debug print?
I kept for debugging; well it can be removed.
--
Tarun
> 
> Kevin
