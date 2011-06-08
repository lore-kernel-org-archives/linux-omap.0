From: Kevin Hilman <khilman@ti.com>
Subject: Re: Clock & PM breakage in 3.0-rc2
Date: Wed, 08 Jun 2011 11:32:47 -0700
Message-ID: <87zklsi374.fsf@ti.com>
References: <20110608173143.0b03ebac.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35686 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885Ab1FHScv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 14:32:51 -0400
Received: by mail-pw0-f44.google.com with SMTP id 5so372481pwi.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 11:32:49 -0700 (PDT)
In-Reply-To: <20110608173143.0b03ebac.jhnikula@gmail.com> (Jarkko Nikula's
	message of "Wed, 8 Jun 2011 17:31:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

Jarkko Nikula <jhnikula@gmail.com> writes:

> While debugging another issue I noticed that McBSP2 clock on Nokia N900
> doesn't get disabled in 3.0-rc2 after calling
> pm_runtime_put_sync(mcbsp->dev) and the fclk usecount remains active if
> the pm_runtime_get_sync(mcbsp->dev) was ever called activating it.
>
> I believe this affects other drivers too as the system is not able to
> enter into retention idle even if the mcbsp clocks are off.
>
> I traced breakage to commit 638080c ("OMAP2+ / PM: move runtime
> PM implementation to use device power domains").
>
> Reventing that and and 2064af9 ("PM: Revert "driver core: platform_bus:
> allow runtime override of dev_pm_ops") makes both mcbsp clocks and
> retention idle working again.
>
> Unfortunately I'm not able to see quickly what would be the right fix.

This should be fixed in my for_3.0/pm-fixes branch (pull req. sent to
Tony earlier this week.)

Specifically, the "OMAP: PM: omap_device: fix device power domain callbacks"
patch should fix your problem

Can you test again with merging that branch from:

    git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin
