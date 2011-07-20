From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2] OMAP4: OPP: add OMAP4460 definitions
Date: Wed, 20 Jul 2011 23:00:32 +0530
Message-ID: <cf569df6d3275b4143c3b350ff5e2bf5@mail.gmail.com>
References: <1309758042-17208-1-git-send-email-vishwanath.bs@ti.com><f1dff603251827d0e02bc74ebc871388@mail.gmail.com>
 <87wrfejo63.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43470 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752246Ab1GTRae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jul 2011 13:30:34 -0400
Received: by mail-gy0-f179.google.com with SMTP id 15so212613gyc.38
        for <linux-omap@vger.kernel.org>; Wed, 20 Jul 2011 10:30:33 -0700 (PDT)
In-Reply-To: <87wrfejo63.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, July 19, 2011 8:47 PM
> To: Vishwanath Sripathy
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Nishanth Menon
> Subject: Re: [PATCHV2] OMAP4: OPP: add OMAP4460 definitions
>
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
>
> > I see that this patch is not queued for 3.1 merge window. Any
> > issues/comments on this patch?
>
> I did not look at this patch as it came late in the development
> cycle.
>
> A quick glance now suggests it has a few minor problems.
>
> - patch was not Cc's to linux-arm-kernel
> - uses 44XX naming which is not used in l-o master
Sorry I did not get this point. What do you mean by 44XX naming?
I applied this patch against lo master and it seems to apply and compile
perfectly fine.

Vishwa
>
> Please update against current l-o tree which has the PRCM/hwmod
> updates
> from Paul/Benoit as well as the base 4460 support for v3.1.
>
> Kevin
