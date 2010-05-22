From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 08:40:40 +0300 (EEST)
Message-ID: <20100522.084040.233704306.Hiroshi.DOYU@nokia.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51745 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0EVFk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 01:40:57 -0400
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, felipe.contreras@nokia.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 00/17] omap: mailbox: 
Date: Fri, 21 May 2010 23:44:32 +0200

> From: Felipe Contreras <felipe.contreras@nokia.com>
> 
> Hi,
> 
> The main purpose of this patch series is to be able to compile mailbox
> mach platform data as built-in.
> 
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

How are the above user of mailbox loaded at present?

I think that "bridgedriver.ko" is the user of it and it is also
a platform driver. Someone would have to load it without udev, right?

