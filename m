From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Fri, 28 Feb 2014 09:59:45 -0600
Message-ID: <5310B271.5040708@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbaB1QAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 11:00:10 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 02/28/2014 03:22 AM, Tero Kristo wrote:
> Hi,
> 
> This set concludes the omap2+ clock DT conversion work by creating the
> DT clock data for omap2 SoC also.
> 
> I am also currently doing related work to cleanup CM/PRM codebase in
> preparation to move it into drivers/, this set is basically going to
> be a pre-requisite for that. I'll hopefully post something related
> to that early next week.
> 
> This set has been boot tested on OMAP2430 only (thanks Nishanth, I don't
> have access to OMAP2 hardware myself), so any testing feedback on
> 2420 board(s) would be appreciated.
> 
> Working tree:
> 
> Tree: https://github.com/t-kristo/linux-pm.git
> Branch: 3.14-rc4-omap2-dt-clks

I do see checkpatch warnings in the series:
http://slexy.org/view/s20mzhlJ93

Series boot tested with:
3.14-rc4-omap2-dt-clks  fc73a96 ARM: OMAP2: clock: use DT clock boot
if available
from the tree mentioned above.

Things look good other than the checkpatch violation noticed in
report, so other than that,

Tested-by: Nishanth Menon <nm@ti.com>

omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2jdV3XMCC
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s210nZI8Hx
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21MG8kg6u
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20coVhzLt
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21XKjjwyk
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s27PCmlDq7
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2HX1Q3iPb
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot PASS: http://slexy.org/raw/s21ofDfpD2
10:        ldp:  Boot FAIL: http://slexy.org/raw/s2SbrpyX2p
^^ legacy behavior
11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s21n4iMUKd
12:    sdp2430:  Boot PASS: http://slexy.org/raw/s2CJ5hYl72
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20axZ1nyb
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21wt3C5F3
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s208PhmCpm
TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2



-- 
Regards,
Nishanth Menon
