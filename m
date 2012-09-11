From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Tue, 11 Sep 2012 06:35:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36316 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab2IKGf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 02:35:28 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Rajendra,

A CCF testing branch has been built here.  The base is v3.6-rc5, plus the 
most recent version of the Common Clock Framework preparation patches that 
you posted to the list, "[PATCH v4 0/3] Prepare for OMAP2+ movement to 
Common Clk", but updated to take RMK's feedback into account.  Then the 
'clk-next-omap-3.6-rc3' branch from your repo at 
'git://github.com/rrnayak/linux.git' was added.  Then some patches to drop 
the old arch/arm/mach-omap2/clock*_data.c files were added.

This branch was then run through checkpatch.pl, and all of the parenthesis
alignment warnings have been fixed.  I don't know what to do about these 
crazy DECLARE_CLK_* macros; they have so many arguments that they are 
basically impossible to read.  Mike and I discussed converting them 
into C99 structure initializers with named fields, but am not sure if it's 
a readability advantage; it's probably going to be "write-only data" 
either way.  I've reflowed many of them to save diffstat but there are 
quite a few more to go.

The branch was then built with a set of testing Kconfigs.  Here's what was 
found: (these are still being investigated)

- The OMAP4-only testconfig and rmk's OMAP4430-SDP Kconfigs failed:
  "undefined reference to `omap2_clkt_iclk_allow_idle'":

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/omap4_testconfig/
  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/rmk_omap4430_sdp_oldconfig/

- RMK's OMAP3430-LDP Kconfig failed with a whole set of warnings:

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/build/rmk_omap3430_ldp_oldconfig/


The kernel built with omap2plus_defconfig was then booted on several 
OMAP2+ boards.  Here's what was found:

- The kernel wouldn't boot on either the 3517EVM nor CM-T3517 boards.
  This turned out to be due to some missing AM35XX clkdev aliases, the 
  lack of which cause the CCF code to panic.  The patch that adds the 
  OMAP3 data has been updated to fix that bug and an HSOTGUSB clkdev
  alias bug that was found by visual inspection.

- The 3730 Beagle XM issued a warning and stack trace upon boot.  
  Debugging with Mike, this turned out to be due to a bug in the
  modified omap2_init_clksel_parent() function: it returned a register
  bitfield rather than an array index.  The patch that modifies this
  function was then updated to fix the bug.

- The 2420 N800 seems to have some kind of MMC-related problem
  that prevents it from booting.  Still looking into this:

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/2420n800/2420n800_log.txt


Then the branch was PM-tested to determine whether it can suspend and 
serial-resume properly, and whether dynamic idle works.  These tests 
didn't go so well:

- 3530ES3 Beagleboard here was able to enter retention-idle
  suspend, and leave it with serial wakeup, but the CORE powerdomain never 
  entered a low-power state.  Dynamic retention-idle with serial wakeup
  never resumed, and the test stopped there:

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3530es3beagle/3530es3beagle_log.txt

- 37xx EVM and 3730 Beagle XM fared better; they made it through the whole 
  test program, but the CORE powerdomain also never entered a low-power
  state:

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/37xxevm/37xxevm_log.txt
  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3730beaglexm/3730beaglexm_log.txt

- 4430ES2 Panda never made past the first retention-idle suspend:

  http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/4430es2panda/4430es2panda_log.txt


Could you please take a look and see if you can identify why the patches 
aren't passing the tests?  I can't send these upstream until they pass the 
PM tests.

This testing branch can be found at the branch named 
"common_clk_testing_devel_3.7" of git://git.pwsan.com/linux-2.6

The testbed reports from this branch can be found here:
  
   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/

And the baseline test reports from v3.6-rc5 can be found here:

   http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/



- Paul
