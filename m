From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Recent OMAP git broken on Beagle
Date: Sat, 10 May 2008 08:49:06 +0200
Message-ID: <48254562.7000006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:1982 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYEJGtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 02:49:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1075549fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2008 23:49:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: beagleboard@googlegroups.com


I tried latest OMAP git (2.6.26-rc1-omap1, git from today, HEAD == 
42fa072e237427675752bb9da05bf406bff19719, "OMAP3 EVM: enable ethernet 
support")  on OMAP3 based BeagleBoard and it immediately stops after 
output of Kernel command line (with CONFIG_DEBUG_LL enabled):

...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: console=ttyS2,115200n8 ...

No later output or crash, nothing.

On an older 2.6.25-omap1 kernel next output is

...
Kernel command line: console=ttyS2,115200n8 ...
Clocking rate (Crystal/DPLL/ARM core): 26.0/266/381 MHz
GPMC revision 5.0
...

Assuming that it might be related to recent clock or powerdomain 
changes [1] I switched back to HEAD == "Fix remaining sparse warnings 
in arch/arm/mach-omap2" (git-checkout 
cdda2a9adbc5421f4857e0313afc6c189f422e25) and system now boots again.

Any idea?

Many thanks

Dirk

[1] http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary
