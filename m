From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Thu, 2 Dec 2010 10:35:57 +0530
Message-ID: <68d1d4807ed2c28d3b339571601a2a7f@mail.gmail.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>	<1291061993-4740-5-git-send-email-nm@ti.com>
	<AANLkTim9dQ2Vw06_QSDVm1S92TkkS-cRHh+HNAp_qk-W@mail.gmail.com>
	<4CF507CF.30909@ti.com> <AANLkTi=_w=Rg1Xaj0W0zPbJjMoRaruEAdNux1k8NWz8d@mail.gmail.com>
 <4CF65E03.103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34479 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab0LBFF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 00:05:59 -0500
Received: by mail-qy0-f175.google.com with SMTP id 8so3462077qyk.20
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 21:05:59 -0800 (PST)
In-Reply-To: <4CF65E03.103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, TAO HU <tghk48@motorola.com>
Cc: TAO HU <taohu@motorola.com>, linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Wednesday, December 01, 2010 8:09 PM
> To: TAO HU
> Cc: TAO HU; linux-omap; Jean; Tony; Kevin; Vishwa
> Subject: Re: [PATCH 4/5 v2] OMAP3630: PM: Disable L2 cache while
> invalidating L2 cache
>
> TAO HU had written, on 12/01/2010 02:56 AM, the following:
> > Do we need to implement the same thing in bootloader?
> > I.e. Do we need to disable L2 prior invalidating L2 for  OMAP3630 1st
> boot up?
> Though out of context for this email list (linux kernel :)), I believe
> it wont hurt to do this as a standard procedure.

You should always invalidate the cache before enabling it. Now if
at the 1st boot-up if the ROM code / boot-loader is doing this,
you don't have do it.

At least from kernel point of it's responsibility of
boot-loaders/boot-straps to keep the caches invalidated. That's why
the generic kernel don't invalidate them before enabling them.

RMK has documeneted this. Read " 2. Loader Checks"
http://www.arm.linux.org.uk/developer/noboot-checklist/



Regards,
Santosh
