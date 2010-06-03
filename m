From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/4] OMAP3: PM: Smartreflex clean up patches against PM tree
Date: Thu, 03 Jun 2010 16:28:25 -0700
Message-ID: <87zkzbitly.fsf@deeprootsystems.com>
References: <1275151614-16634-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:58157 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab0FCX23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:28:29 -0400
Received: by pzk15 with SMTP id 15so488561pzk.15
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:28:28 -0700 (PDT)
In-Reply-To: <1275151614-16634-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 22\:16\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch series does clean up of Kevin Hilman's PM tree
> so that the earlier Smartreflex series against lo-master can
> be applied seamlessly. This patch sereis also does some
> smartreflex related code changes in the cpuidle and dvfs
> code which exists only in the pm tree and not on lo-master.
>
> This patch series has been tested in conjunction with the
> the Smartreflex series posted against the lo-master on
> OMAP3430 SDP, OMAP3630SDP and ZOOM3 using omap3_pm_defconfig.

This series should no longer be necessary as your latest SR series is
part of the PM branch (as pm-sr branch.)

> Thara Gopinath (4):
>   OMAP3: PM: Cleaning up of smartreflex code.
>   OMAP3: PM: Disabling Smartreflex across both frequency and voltage
>     scaling during DVFS.

This one I've added to the pm-srf branch.

>   OMAP3: PM: Removing voltage related code from the generic pm code.
>   OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm
>     defconfig

And I've updatd omap3_pm_defconfig with this one.

Thanks,

Kevin
