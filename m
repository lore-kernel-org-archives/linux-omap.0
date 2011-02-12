From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap3: cpuidle: Add description field to each C-state.
Date: Sat, 12 Feb 2011 13:12:21 +0530
Message-ID: <dc999244fd7ec6b23f71a17847d4e03d@mail.gmail.com>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com><1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
 <20110211190723.b93bcb60.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:44607 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab1BLHmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 02:42:25 -0500
Received: by wyb28 with SMTP id 28so3180590wyb.39
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 23:42:23 -0800 (PST)
In-Reply-To: <20110211190723.b93bcb60.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Friday, February 11, 2011 10:37 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] omap3: cpuidle: Add description field to each
> C-state.
>
> On Fri, 11 Feb 2011 20:42:12 +0530
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>
> > Add a description field to each idle C-state. This helps to give
> > better data with PowerTop and one don't have to refer to the code
> > to link what Cx means from system point of view while analysing
> > PowerTop data.
> >
> > No functional change.
> >
> Out of curiosity what powertop version is required to get these
> handy descriptions visible?
>
It should work with most of the power Top version. I have a
older 1.13 version.

> As I see these in /sys/devices/system/cpu/cpu0/cpuidle/stateX/desc
> it's fair to give my tested by
>
> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
Thanks !!
