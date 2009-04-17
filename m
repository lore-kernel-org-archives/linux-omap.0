From: Kalle Valo <kalle.valo@iki.fi>
Subject: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Fri, 17 Apr 2009 23:44:16 +0300
Message-ID: <873ac7ko2n.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:57283 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbZDQUvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 16:51:13 -0400
Received: by bwz7 with SMTP id 7so326609bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 13:51:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm trying to compile n800 kernel with latest linux-omap tree. First I
got strange build error:

arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_wait':
arch/arm/kernel/sys_oabi-compat.c:289: error: implicit declaration of function 'kmalloc'
arch/arm/kernel/sys_oabi-compat.c:289: warning: assignment makes pointer from integer without a cast
arch/arm/kernel/sys_oabi-compat.c:302: error: implicit declaration of function 'kfree'
arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_semtimedop':
arch/arm/kernel/sys_oabi-compat.c:325: warning: assignment makes pointer from integer without a cast

Adding include <linux/slab.h> made it go away but then I got this:

In file included from arch/arm/mach-omap2/clock24xx.c:46:
arch/arm/mach-omap2/clock24xx.h:1801: error: 'secure_32k_ck' undeclared here (not in a function)

Any hints?

The latest commit I have is:

commit 8e58316ba38aa6ffd53e2ada59142ad40cf47744
Merge: 1232332 0932667
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Apr 15 11:22:24 2009 -0700

    Merge branch 'omap-pool'

-- 
Kalle Valo
