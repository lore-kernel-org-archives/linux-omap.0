From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 16:35:19 +0300 (EEST)
Message-ID: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32872 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbYHRNfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 09:35:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vpasam@ti.com, r-woodruff2@ti.com, felipe.contreras@gmail.com, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com, h-kanigeri2@ti.com, tony@atomide.com, soni.trilok@gmail.com

Hi all,

This is a draft proposal for the bridge TODO list just as a
starter. For the details, lots of comments could be added and
discussed here.

The basic concept is that, at first, we will make every components
a little bit more basic, small, primitive and independent(small kernel
modules), pushing out the kind of operating policies from modules to
more upper layers, and then reconstruct the system again with the
above primitive components to be more *unix-like* way. This may be the
bottom up approach, replacing every component **step by step** with
the always working system and finally we will get the new one. This
may allow us always to keep the working system and also be more
flexible to have multiple implementation(bridge, dspgateway and
something new) easily, on the top of the above basic
components. Ideally it would be nice if some of components were pushed
out in userland, but there may be the trade-off of performance.


The major points are listed below:

Small cleanups
--------------
There are still quite lots of trivial things, naming convention,
etc. In detail, please check:

- Documentation/CodingStyle
- Documentation/SubmitChecklist
- Documentation/SubmittingPatches

This can be cleaned up along with the other changes gradually.


Replace home-brewed APIs by native kernel APIs
----------------------------------------------

Most of the files under "drivers/dsp/bridge/services" and
"drivers/dsp/bridge/gen" seem just to provide the almost same
basic in-OS functionalities as Linux in-kernel APIs provided, like
"list", "ISR", "softIRQ", "Notifier", "locking", "bitmap", "clk" and
so on with some bridge specific debug tracing feature. The fundamental
kernel APIs should be covered by native Linux kernel APIs.

In-kernel APIs(ex: PRCM) should be used, instead of direct access for
registers.

I expect that this task would reduces the code size quite a lot.


Use "arch/arm/plat-omap/mmu.o" as generic mmu operations
---------------------------------------------------------
The "dspgateway" has to be modified a little, too. IVA[1,2],  C5x and
Camera can use the same algorithm with this driver.
	

Use "arch/arm/plat-omap/mailbox.o" as generic mailbox operations
-----------------------------------------------------------------
The "dspgateway" has to be modified a little, too.


Make communication "protocol" more independent
-----------------------------------------------
<TBD>
The communication which "shared memory" and "interrupt based mailbox"
provide shouldn't impose any operation policies on the above "mmu" and
"mailbox" drivers.


Push out some components into userland
---------------------------------------
At least, The "doff loader" should be pushed out because it reads
files from in-kernel. There's already sample implementation which
Trilok has done before. Need to evaluate the performance again.


Define bridge Interfaces
------------------------
<TBD>
This was already described in the following thread:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009540.html
I think that this is also tightly related to TI's roadmap, support
plan and so on.....

Probably I missed lots of things here, any comments/corrections would
be appreciated. I'd like to get the rough impression of feasibility of
the above items from TI.

If people have to think about the multi OS support, then that would be
the first to discuss. It may be beyond my imagination, though....

BTW: The latest update from omapzoom has been updated in the bridge patches:

  http://www.muru.com/linux/tidspbridge/

	Hiroshi DOYU
