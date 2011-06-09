From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Clock & PM breakage in 3.0-rc2
Date: Thu, 9 Jun 2011 09:10:29 +0300
Message-ID: <20110609091029.7051ef33.jhnikula@gmail.com>
References: <20110608173143.0b03ebac.jhnikula@gmail.com>
	<87zklsi374.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45874 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1FIGKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 02:10:32 -0400
Received: by ewy4 with SMTP id 4so426057ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 23:10:31 -0700 (PDT)
In-Reply-To: <87zklsi374.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 08 Jun 2011 11:32:47 -0700
Kevin Hilman <khilman@ti.com> wrote:

> > I traced breakage to commit 638080c ("OMAP2+ / PM: move runtime
> > PM implementation to use device power domains").
> >
> > Reventing that and and 2064af9 ("PM: Revert "driver core: platform_bus:
> > allow runtime override of dev_pm_ops") makes both mcbsp clocks and
> > retention idle working again.
> >
> > Unfortunately I'm not able to see quickly what would be the right fix.
> 
> This should be fixed in my for_3.0/pm-fixes branch (pull req. sent to
> Tony earlier this week.)
> 
> Specifically, the "OMAP: PM: omap_device: fix device power domain callbacks"
> patch should fix your problem
> 
> Can you test again with merging that branch from:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> 
Great! That patch fixes the mcbsp clock problem and I suppose retention
too (I don't have a multimeter with me now to verify but retention
counters in /sys/kernel/debug/pm_debug/count are increasing now).

-- 
Jarkko
