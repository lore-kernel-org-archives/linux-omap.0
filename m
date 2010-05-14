From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 00/15] omap: mailbox: reorganize init
Date: Fri, 14 May 2010 12:12:53 +0300 (EEST)
Message-ID: <20100514.121253.116379760.Hiroshi.DOYU@nokia.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65053 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0ENJNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 05:13:36 -0400
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/15] omap: mailbox: reorganize init
Date: Thu, 13 May 2010 19:47:21 +0200

> Hi,
> 
> The main purpose of this patch series is to be able to compile mach platform
> data as built-in. Otherwise, client modules such as bridgedriver will load the
> platform code, but not the mach code when mailbox is built as a module.
> 
> Unfortunately, there's no easy way to do that since plat and mach code are
> deepely interrelated. So the first patches try to separate the mailbox
> registering through a defined omap_mbox_platform_data.
> 
> Also, it's worth noting that mailboxes are not a one-to-one mapping to
> resources; that is, some resources belong to multiple mboxes. So it's best to
> think of mailboxes as fake devices. That is why custom platform_data is required.
> 
> Finally, a bunch of cleaning up is done in the very first patches, specially for
> OMAP1.

Can you rebase them against the following?

  git://gitorious.org/~doyu/lk/mainline.git v2.6.34-rc7.mailbox

The above includes the unmerged patches for omap mailbox, and it seems
that yours can be applied to neither v2.6.34-rc7 or omap/master now.
