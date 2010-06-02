From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Ads7846 breaks suspend-to-ram on 3430SDP
Date: Wed, 2 Jun 2010 13:32:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323207744@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D778@dbde02.ent.ti.com>
 <20100602072400.GD3713@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41726 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab0FBICJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 04:02:09 -0400
In-Reply-To: <20100602072400.GD3713@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry Torokhov wrote:
> Hi Anand,
> 
> On Fri, May 14, 2010 at 02:26:40PM +0530, Gadiyar, Anand wrote:
> > Looks like the ads7846 driver breaks suspend-to-ram at least on
> > the OMAP 3430SDP. On a kernel built with the omap3_defconfig, with
> > no_console_suspend, I see the log below.
> > 
> > Will investigate some time next week, unless someone already has a fix.
> > 
> 
> Could you please try 2.6.35-rc1 - I expect Kevin's fix to handle
> regulatore registering failure will take care of this oops.
> 

Thanks for the tip. I don't see the crash with 2.6.35-rc1.

But I still cannot get the console back after a suspend. I don't think
this is related to the ads7846 driver any more.


- Anand

# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: suspend of devices complete after 108.439 msecs
PM: late suspend of devices complete after 0.274 msecs
Class driver suspend failed for cpu0
PM: early resume of devices complete after 0.122 msecs
