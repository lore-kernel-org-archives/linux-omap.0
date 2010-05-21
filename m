From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Fri, 21 May 2010 22:57:31 +0100
Message-ID: <20100521215730.GK11042@n2100.arm.linux.org.uk>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59806 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab0EUV5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:57:42 -0400
Content-Disposition: inline
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@nokia.com>

On Sat, May 22, 2010 at 12:44:32AM +0300, Felipe Contreras wrote:
> [no changes since the last v2, just rebased on top of the latest
> git://gitorious.org/~doyu/lk/mainline.git for-tony-mailbox]
> 
> Currently, the code is split into three places:
> 1) mach-omapX/devices.c: for platform_device_register() the resources
> 2) mach-omapX/mailbox.c: do platform_driver_register(), fetch the resources,
>    and register logical mailboxes with omap_mbox_register()
> 3) plat-omap/mailbox.c: implement omap_mbox_register() to add the mbox
>    to an internal linked list (static struct omap_mbox *mboxes)
> 
> So, obviously 1) is always built-in, but 2) can't be because of the
> dependency of omap_mbox_register(), which is in 3) and cannot be taken
> out.
> 
> Users of mailbox will load 3) due to omap_mbox_get(), but not 2),
> therefore, no mailboxes will be registered.

This doesn't make sense - why would 3 be loaded due to the dependency
which comes from 2, but not 2?

The only reason 3 would be loaded due to that dependency is if 2 were
being modprobed, which means it's going to be inserted after 3 anyway.

I don't see anything else in 3 which would trigger it to be loaded.

The "platform:omap2-mailbox" module alias of 2 should result in 2
being modprobed, causing 3 to be loaded to satisfy the dependency.
As already pointed out, this should happen as a result of udev or
(older) hotplug initialization.
