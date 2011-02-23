From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init()
 code
Date: Wed, 23 Feb 2011 00:18:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102230015480.22636@utopia.booyaka.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55789 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1BWHSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:18:31 -0500
In-Reply-To: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Santosh,

On Tue, 22 Feb 2011, Santosh Shilimkar wrote:

> To adhere to recent early_init changes, commit '44dc0' made
> omap_hwmod_late_init() to core_initcall to avoid ioremap() failures.
> 
> Later 'e7c7d7' removed _mpu_rt_va population omap_hwmod_late_init()
> 
> So now if we move the  omap_hwmod_late_init() to mdesc->timer->init(),
> timer1 should work with hwmod instead of any special hwmod settings.
> 
> This was proposed by Paul Walmsley <paul@pwsan.com>

thanks -- something like this series was what I had in mind to go to 
mainline:

   http://marc.info/?l=linux-omap&m=129844518908008&w=2

This series is also available at the branch "hwmod_clockevent_2.6.39" of 
git://git.pwsan.com/linux-2.6.

Ultimately, of course, it's up to Tony to decide what approach he wants to 
use...


- Paul
