From: "Premi, Sanjeev" <premi@ti.com>
Subject: Problem with git-fetch
Date: Tue, 29 Sep 2009 20:33:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB4073@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42091 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZI2PDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 11:03:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8TF33E4021961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 10:03:06 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8TF334D005927
	for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 20:33:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I did a git-pull today, but I am seeing inconsistency on the patches
being pulled on master.

When I browse the linux-omap tree in my browser, the history for
"arch/arm/plat-omap/include/mach/cpu.h at the URL shows as:

2009-08-19 	Felipe Balbi   arch: arm: omap: terminate ifndef
2009-08-18 	Tony Lindgren  OMAP: Fix incorrect 730 vs 850 detection
2009-08-10 	Tony Lindgren  OMAP: Fix testing of cpu defines for mach-omap1
...
URL : http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=history;f=arch/arm/plat-omap/include/mach/cpu.h;h=11e73d9e8928458adc5656add696d835cf330d7a;hb=d3505405a4b2d1659566db1b69ba2b554771efc6

But when I did git-pull, the history is:

#
# git-branch
* master
#
# git log --pretty=format:"%h : %s" arch/arm/plat-omap/include/mach/cpu.h
cd922049 : OMAP: Fix testing of cpu defines for mach-omap1
8e25ad9 : OMAP2/3: Add omap_type() for determining GP/EMU/HS
...

The top 2 commits are not visible!

Both the commits seem to be "present". I can view them via git-log.

Thinking it be be a problem with my local repo (though not sure what?);
I did a fresh clone of the repo:

# git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

But, 2 hours later, it is still the same result!!

# git-branch
* master
#
# git log --pretty=format:"%h : %s"
d350540 : Fix compile for omap3evm because of ehci branch mismerge
dbf3f0a : Merge branch 'omap7xx-fortony-rc1' of git://robotfuzz.com/linwizard-ke
6acfd68 : OMAP850: Fix zImage booting
6efe82e : OMAP850: PM: Add an ARCH_OMAP850 check
0a19200 : OMAP7XX: Clocks: Add ck_ref and armxor
#
#
# git log --pretty=format:"%h : %s" arch/arm/plat-omap/include/mach/cpu.h
cd922049 : OMAP: Fix testing of cpu defines for mach-omap1
8e25ad9 : OMAP2/3: Add omap_type() for determining GP/EMU/HS
...

Did anyone see this issue? OR can someone confirm that I am not alone?

Best regards,
Sanjeev
