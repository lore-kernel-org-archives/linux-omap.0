From: Tim Bird <tim.bird@am.sony.com>
Subject: Re: Do defconfigs work for 2.6.32-rc5 mainline kernels?
Date: Mon, 2 Nov 2009 10:21:20 -0800
Message-ID: <4AEF2320.8040100@am.sony.com>
References: <4AEB5CD8.8060603@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:56095 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbZKBSV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 13:21:56 -0500
In-Reply-To: <4AEB5CD8.8060603@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-omap@vger.kernel.org

Bill Gatliff wrote:
> I'm trying to build a kernel for beagleboard, using the defconfig found
> in 2.6.32-rc5 and the 2.6.32-rc5 source code.
> 
> Said kernel hangs after the uncompressor, I'm just trying to figure out
> if this is a known issue or not.  The defconfig in the linux-omap tree
> does seem to work with the linux-omap source code, FWIW...

Short story:
I found that the omap OSK defconfig is broken in mainline also.

Long story:
I found that the defconfig in the mainline 2.6.32-rc1 kernel
didn't work on an OMAP OSK board.  Thinking there was some
problem in the code itself, I bisected from a known working
config on 2.6.29 all the way back up to 2.6.32-rc1.  When
I was done I was at the current code base, but with a .config
that had about 650 differences.

I haven't had time to go back and find the individual config
option that changed to break things.  I would need some kind
of "config bisect" to find this efficiently.

I didn't think to try the OSK defconfig in the omap tree.
(Silly me, might have saved me some grief. :-)

Is there a maintainer for individual defconfig files?
In other words, if I repair the OSK defconfig, who do
I send it to?

 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Corporation of America
=============================

