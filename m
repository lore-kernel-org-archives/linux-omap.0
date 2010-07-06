From: "Que, Simon" <sque@ti.com>
Subject: RE: [RFC v.3] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 6 Jul 2010 14:03:02 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1956@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35493 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab0GFTDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 15:03:06 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Thanks Santosh, I have responded to your feedback.

> > +#include <plat/hwspinlock.h>
> > +
> No need of new  line here.
> > +#include <plat/omap_device.h>
> > +#include <plat/omap_hwmod.h>

Alright I will fix that.

> > +/* Initialization function */
> > +int __init hwspinlocks_init(void)
> Since it's only init, can this go to "arch/arm/mach-omap2/omap4-commin.c" ?

No, since it uses local #defines, we would prefer to put it in its own file.

> > +       if (retval == HWSPINLOCK_BUSY)
> > +               pm_runtime_put(&handle->pdev->dev);
> What resource is getting release with above ??

That was a mistake actually.  It should not be called because the device will be locked by the time that code is reached.


Simon
