From: Tony Lindgren <tony@atomide.com>
Subject: Re: Updated status of the removal of plat headers
Date: Wed, 17 Oct 2012 15:02:03 -0700
Message-ID: <20121017220203.GZ15569@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <507F2875.2050406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:29111 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751736Ab2JQWCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 18:02:07 -0400
Content-Disposition: inline
In-Reply-To: <507F2875.2050406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.luna@linaro.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Jon Hunter <jon-hunter@ti.com> [121017 14:53]:
> Hi Tony,
> 
> On 10/16/2012 06:00 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's a quick status update on the removal of remaining
> > #include <plat/*.h> files. Most files are now fixed up, and
> > we only have the following remaining:
> > 
> > cpu.h		wrapper only left, will be removed as soon as drivers are fixed
> > 
> > dmtimer.h	Jon is fixing this
> 
> I have patches ready for this. However, as you know I have a few timer
> series cooking at the moment and just sent out the latest timer DT
> series today [1][2].
> 
> I have also updated my timer fixes series [3] too, however, I was not
> going to send out until the DT stuff is sorted. At the moment I have
> included the dmtimer header patches with the fixes series as there are
> some dependencies but this series has now grown into a 20+ patch series.
> So if it is easier to manage, I could split this into a fixes series and
> a clean-up series. Or if you only want the header stuff now, I could
> send this and send the fixes and clean-up later.

When they are ready, two separate pull requests against v3.7-rc1 for fixes
and cleanup would be perfect.

Thanks,

Tony
 
> [1] http://marc.info/?l=linux-omap&m=135049690119218&w=2
> [2] http://marc.info/?l=linux-omap&m=135049882020029&w=2
> [3] http://marc.info/?l=linux-arm-kernel&m=134687192121865&w=2
