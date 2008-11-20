From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [ANNOUNCE] new PM branch: pm-20081119
Date: Thu, 20 Nov 2008 21:30:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C83E@dbde02.ent.ti.com>
References: <87d4grdxqh.fsf@deeprootsystems.com>
 <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44945 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755789AbYKTQAw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 11:00:52 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Peter Reid <ppeter.reid@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


<snip>--<snip>
> 
> 2) Also:
> # echo mem > /sys/power/state
> <6>PM: Syncing filesystems ...
> PM: Syncing filesystems ...
> done.
> done.
> Freezing user space processes ... Freezing user space 
> processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
> done.
> Freezing remaining freezable tasks ... Freezing remaining 
> freezable tasks ... (elapsed 0.00 seconds) (elapsed 0.00 
> seconds) done.
> done.
> 
> Suspending console(s) (use no_console_suspend to debug) 
> Suspending console(s) (use no_console_suspend to debug) 
> <3>omapfb omapfb: timeout waiting for FRAME DONE

I see a bus error generated.
Haven't been able to nail the reason so far :(

Last symbol I could trace was pm_power_off

> 
> However, I the "resume" doesn't happen.
> Trying to debug further.
> 

<snip>--<snip>