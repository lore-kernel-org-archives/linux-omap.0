From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
 L2 cache
Date: Mon, 20 Dec 2010 17:44:45 +0530
Message-ID: <eb91f91221d31f1c74366590a4fb0900@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-6-git-send-email-nm@ti.com>
 <9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com> <4D0F41BB.2070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60389 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755491Ab0LTMOq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 07:14:46 -0500
Received: by yia28 with SMTP id 28so404085yia.15
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 04:14:45 -0800 (PST)
In-Reply-To: <4D0F41BB.2070606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Monday, December 20, 2010 5:15 PM
> To: Santosh Shilimkar
> Cc: linux-omap; linux-arm; Jean Pihet; Kevin; Tony
> Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while
> invalidating L2 cache
>
> Santosh Shilimkar wrote, on 12/20/2010 01:13 AM:
> [..]
> >> This is be done according to ARM documentation. Currently this is
> >> identified
> >> as being needed on OMAP3630 as the disable/enable is done from
"public
> >> side"
> >> while, on OMAP3430, this is done in the "secure side".
> > Can you point me to ARM doc which says " for L2 invalidation, the
> > controller
> > needs to be disabled" ?
> please see section 8.3 of the Cortex-A8 TRM
>
Yes. Have seen it and it doesn't say at least what your patch
description is saying.
