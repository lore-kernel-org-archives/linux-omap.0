From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 19 Sep 2014 15:12:56 -0500
Message-ID: <541C8E48.6090306@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com> <20140918171650.GK14505@atomide.com> <20140918191615.GN14505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48560 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbaISUNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 16:13:21 -0400
In-Reply-To: <20140918191615.GN14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 09/18/2014 02:16 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140918 10:17]:
>> * Tero Kristo <t-kristo@ti.com> [140901 11:09]:
>>> Hi,
>>>
>>> This set contains PRCM related cleanups meant for 3.18 merge window.
>>> These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
>>> (http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
>>> set is used as basis to avoid merge issues.
>>>
>>> Purpose of this work is to eventually convert the PRCM code into a
>>> separate driver, but this is done in incremental parts as the amount
>>> of changes is substantial. Expected conclusion of this work is 3.19
>>> if everything goes fine.
>>>
>>> This part of the work mostly moves some of the SoC specific PRCM driver
>>> calls under generic version of the same, and adds SoC-ops to support
>>> these on the driver level.
>>>
>>> Working branch posted here:
>>>
>>> tree: https://github.com/t-kristo/linux-pm.git
>>> branch: for-v3.18/prcm-cleanup
>>
>> Paul, any comments on this series?
> 
> Just gave this branch a quick try, it seems to work with off-idle
> for me when merged with current linux-omap master branch. The following
> merge resolution is needed because of the recent pre es3.1 fix though.
> 
> I've pushed out this merged with all the other pending patches into
> omap-for-v3.18/tmp-merge-2014-09-18.
> 
> Nishant, care to give it a try and check your recent PM related
> changes work with it?
> 
Sure. Sorry about the delay..  needed to find some workarounds for
working with my board farm..


Tested-by: Nishanth Menon <nm@ti.com>

Based on:

omap-for-v3.18/tmp-merge-2014-09-18
0164b2d Merge branch 'omap-for-v3.18/prcm' into omap-for-v3.18/tmp-merge

Test #1: basic testing
Added
69c6133 HACK: Makefile: Build a uImage with dtb already appended
(for legacy boards)

commit 0164b2dbe83e885a53b0c9a99a508bdbfdf7ee6d BASIC boot
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2zy9OUOMM
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2t0JaiHYf
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2SRkMMQwp
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20T0sq5dp
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2AVYqDVBf
 6: am43xx-gpevm:  Boot PASS: http://slexy.org/raw/s213N14B9r
 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s21yyMkFRS
 8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s2SYJOHRwI
 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s214QDgb06
10: beaglebone:  Boot PASS: http://slexy.org/raw/s21SOLcjMD
11: craneboard:  Boot PASS: http://slexy.org/raw/s218cXoYSl
12: dra72x-evm:  Boot FAIL: http://slexy.org/raw/s21BAnAW8N
13: dra7xx-evm:  Boot PASS: http://slexy.org/raw/s21kf4G5Sh
14: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s21QIGwFOM
15:       n900:  Boot PASS: http://slexy.org/raw/s21T5xECo2
16:  omap5-evm:  Boot PASS: http://slexy.org/raw/s20qxa3iPw
17: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2Fh0hMW7n
18: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2vqUc528i
19:    sdp2430:  Boot PASS: http://slexy.org/raw/s21gAsEAeD
20:    sdp3430:  Boot PASS: http://slexy.org/raw/s2dvThSn5D
TOTAL = 20 boards, Booted Boards = 19, No Boot boards = 1


Test #2: PM test (cpufreq/cpuidle/suspend-resume where applicable)

Testing script: (http://slexy.org/view/s21SRQehwu)

Added the following patches:
59bf40d ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
(discussion still going on https://patchwork.kernel.org/patch/4764661/
- but good to know if it still continues to work with PRM changes).

69c6133 HACK: Makefile: Build a uImage with dtb already appended
(for legacy boards)

b854ca8 gpio: omap: Fix interrupt names
(https://patchwork.kernel.org/patch/4854511/)

c50fc8b pinctrl: single: AM437x: Add pinctrl compatibility
37d17bf pinctrl: single: Add DRA7 pinctrl compatibility
74121c6 pinctrl: bindings: Add OMAP pinctrl binding
(all of the above are in linux-next)

efb2486 clk: prevent erronous parsing of children during rate change
b92ac70 clk: ti: dra7-atl: Provide error check for incoming parameters
in set_rate
96e8b6b clk: ti: divider: Provide error check for incoming parameters
in set_rate
(all above picked up by mike)

92e5e74 ARM: OMAP2+ / pm_debug: add support for wakeup_timer configuration
(wakeup timer for testing purposes - remote boards)

with these:
commit 0164b2dbe83e885a53b0c9a99a508bdbfdf7ee6d + Additional patches
basic PM test
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2xRMuVHvj
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2qEHyI9Rs
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2Vptpboop
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21TKVsyet
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s20KGye4N9
 6: am43xx-gpevm:  Boot PASS: http://slexy.org/raw/s201uuCOp2
 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s21ChQP74I
 8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s20oagBAsl
 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2VT200vL0
10: beaglebone:  Boot PASS: http://slexy.org/raw/s20raoHSya
11: craneboard:  Boot PASS: http://slexy.org/raw/s2vq6MYXNZ
12: dra72x-evm:  Boot FAIL: http://slexy.org/raw/s2EPseu0Jj
13: dra7xx-evm:  Boot PASS: http://slexy.org/raw/s21JJGLkTU
14: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s20Drlvdlp
15:       n900:  Boot PASS: http://slexy.org/raw/s21aDnJ1Bi
16:  omap5-evm:  Boot PASS: http://slexy.org/raw/s20ClvPKeK
17: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2L0dt0syP
18: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2OlA9hfzy
19:    sdp2430:  Boot PASS: http://slexy.org/raw/s20Kgf04TW
20:    sdp3430:  Boot PASS: http://slexy.org/raw/s21p71QaVO
TOTAL = 20 boards, Booted Boards = 19, No Boot boards = 1



-- 
Regards,
Nishanth Menon
