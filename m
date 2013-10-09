From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 00/36] ARM: OMAP: DT clock conversion
Date: Wed, 9 Oct 2013 18:30:31 +0300
Message-ID: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41761 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab3JIPc3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:32:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi all,

Version 8 has basically just some cosmetic changes + 2 functional ones.

Functional changes:
- patch #1: added support for am3-dpll-j-type-clock
- patch #20: added support for is_enabled op to APLL
- patch #34: fixed a typo in dpll_core_ck compatible string

Cosmetic fixes:
- new DT XXX_clk_init function names changed to XXX_dt_clk_init, this
  makes it easier to split the patch set into 3 separately manageable
  hunks

Despite these changes, I retained the Acked-by and Tested-by tags by
Tony / Nishanth from version 7, as these do not impact functionality of
the set. Feel free to yell now if you think this is wrong.

I also did a quick testing round with the patches:
- omap3-beagle: boot + suspend/resume : OK
- am335x-bone: boot : OK
- omap5-uevm: boot : OK
- dra7-evm: boot : OK
- omap4-panda-es: boot + suspend/resume : OK

Separate branches for the maintainers also available here:

https://github.com/t-kristo/linux-pm.git

Branch with DTS only data: 3.12-rc3-dt-clks-for-benoit
- based on top of 3.12-rc3 with Benoit's latest for_3.13 merged in

Branch with clock driver patches: 3.12-rc3-dt-clks-for-mike
- based on top of 3.12-rc3
- does not compile due to lack of 1 dependency patch (for getting DT clock
  parent count) which Mike has queued to his own branch though I believe

Branch with all the stuff for mach-omap2: 3.12-rc3-dt-clks-for-tony
- based on top of 3.12-rc3
- merged both above branches to this
- merged also a few temporary hacks to get some of my boards to work,
  these have been discussed elsewhere but can act as a reference

-Tero

