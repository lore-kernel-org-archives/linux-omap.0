From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [RFC] Patch for proper Cortex-A8 cache configuration output
Date: Thu, 07 Aug 2008 18:37:46 +0200
Message-ID: <489B24DA.4020008@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:46221 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYHGQhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 12:37:51 -0400
Received: by mu-out-0910.google.com with SMTP id w8so798524mue.1
        for <linux-omap@vger.kernel.org>; Thu, 07 Aug 2008 09:37:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Recent ARM kernel doesn't detect and output Cortex-A8 cache 
configuration correctly. Result is something like this in kernel's 
boot messages:

-- cut --
...
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=00c5387f
...
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
...
-- cut --

Catalin sent a patch for this to linux-arm-kernel list:

http://lists.arm.linux.org.uk/lurker/message/20080704.150532.983f01ca.en.html

Result:

-- cut --
...
CPU0: L1 I VIPT cache. Caches unified at level 2, coherent at level 3
CPU0: Level 1 cache is separate instruction and data
CPU0: I cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
       supports RA
CPU0: D cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
       supports RA WB WT
CPU0: Level 2 cache is unified
CPU0: unified cache: 262144 bytes, associativity 8, 64 byte lines, 512 
sets,
       supports WA RA WB WT
...
-- cut --

Some people really like this and this patch is used in some private 
trees, e.g. for BeagleBoard.

Unfortunately, RMK doesn't like the patch. He prefers to completely 
remove 'broken' configuration output completely.

What's about applying this patch locally to OMAP git until upstream 
ARM kernel has a fix/remove solution for this?

Many thanks

Dirk

