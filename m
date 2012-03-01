From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/5] First set of omap1 related changes
Date: Thu, 1 Mar 2012 15:31:01 -0800
Message-ID: <20120301233101.GC18901@atomide.com>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
 <201202292106.40731.arnd@arndb.de>
 <20120229211331.GP18901@atomide.com>
 <3378572.m1z82NvySs@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48151 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2CAXbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 18:31:07 -0500
Content-Disposition: inline
In-Reply-To: <3378572.m1z82NvySs@acer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120301 13:56]:
> 
> Any chance for the continuation series [1] as well as two section 
> mismatch related fixes [2] [3] getting your attention? NB, that 
> continuation series needs another section mismatch fix, which I was 
> planing to submit once there was a stable base for it.
> 
> [1] http://www.spinics.net/lists/linux-omap/msg64146.html
> [2] http://www.spinics.net/lists/linux-omap/msg64441.html
> [3] http://www.spinics.net/lists/linux-omap/msg64442.html

Hmm sorry I guess I was waiting for the missing section
mismatch patch.

I've pushed ams-delta branch that's based on -rc5 merged
with what Arnd pulled yesterday as -rc1 has i2c-omap.c
a compile bug for omap1. I've applied these two patches
there as the second one depends on what got pulled:

ARM: OMAP1: ams-delta: clean up init data section assignments
ARM: OMAP1: ams-delta: fix incorrect section tags

Looks like your patch "ARM: OMAP1: ams-delta: set up regulator
over modem reset GPIO pin" causes the following error with
CONFIG_DEBUG_SECTION_MISMATCH=y:

arch/arm/mach-omap1/board-ams-delta.c:273:36: error:
modem_nreset_config causes a section type conflict

So care to update and repost that (and possibly the following
two patches) with your missing fixes?

Regards,

Tony
