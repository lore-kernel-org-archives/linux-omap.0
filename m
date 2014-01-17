From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 14:02:02 -0600
Message-ID: <52D98C3A.8020501@ti.com>
References: <20140110161352.GG6665@saruman.home>	<20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com>	<20140114203613.GA604@saruman.home>	<20140115020421.GA24195@saruman.home>	<20140115031632.4167.2698@quantum> <20140115035011.4167.96678@quantum>	<20140115171323.GA22739@atomide.com>	<20140115192340.4167.87685@quantum>	<20140115193547.GF7993@atomide.com>	<20140116213954.4167.37071@quantum> <87r486mrh5.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaAQUC3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 15:02:29 -0500
In-Reply-To: <87r486mrh5.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

On 01/17/2014 11:46 AM, Kevin Hilman wrote:
> Mike Turquette <mturquette@linaro.org> writes:
> 
> [...]
> 
>> I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
>> Tero's series. This includes the AM3517 bits now. I've pushed this
>> branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
>> final sanity test before I merge this into clk-next?
> 
> I merged clk-next-omap into next-20140117 and build/boot tested
> omap2plus_defconfig, multi_v7_defconfig and
> multi_v7_defconfig+CONFIG_LPAE=y and all passed a basic boot test for
> omap5uevm.
> 
> I'll add OMAP5 to the automated boot testing starting with the next
> linux-next.


Here are my logs for the similar configuration(with few patches for
legacy boot):

next-db23a6c + next-20140117 (omap2plus_defconfig)
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20pGXG1jF
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2ViUqyxYc
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s29qMTk2mS
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20aZ0oDHS
 5:       beag:  Boot PASS: http://slexy.org/raw/s2DAKDwqRm
 6:       bone:  Boot PASS: http://slexy.org/raw/s215UVEmq2
 7:      crane: No Image built - Missing platform support?: (pending
merge from Benoit)
 8:       dra7:  Boot PASS: http://slexy.org/raw/s2CbtBGGxE
 9:        ldp:  Boot FAIL: http://slexy.org/raw/s20MOKNvPG
(been seeing this behavior on and off for some days now.. not really a
regression due to this series - need to debug this - could be setup
issues).
10:      panda:  Boot PASS: http://slexy.org/raw/s20RHdfXjS
11:    sdp2430:  Boot PASS: http://slexy.org/raw/s21fR9cQap
12:    sdp3430:  Boot PASS: http://slexy.org/raw/s209eZfYlQ
13:    sdp4430:  Boot PASS: http://slexy.org/raw/s21jemvEcd
14:       uevm:  Boot PASS: http://slexy.org/raw/s20OumuRI8
TOTAL = 14 boards, Booted Boards = 12, No Boot boards = 2

clk-next-db23a6c + next-20140117 (multi_v7_defconfig)
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21kek3KDX
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20b6Ypnpr
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s200aHOMA1
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2QwHWtLbB
 5:       beag:  Boot PASS: http://slexy.org/raw/s2120qe2nJ
 6:       bone:  Boot PASS: http://slexy.org/raw/s21SnQH1AY
 7:      crane: No Image built - Missing platform support?:
 8:       dra7:  Boot FAIL: http://slexy.org/raw/s20HxBFzIr
missing DRA7 in multi_v7
 9:        ldp:  Boot PASS: http://slexy.org/raw/s21vjb9GeV
10:      panda:  Boot FAIL: http://slexy.org/raw/s2WahEfqVw
kevin already reported this for CPU_IDLE enable
11:    sdp2430:  Boot FAIL: http://slexy.org/raw/s2ADmtqRhq
* multi_v7 does not boot v6 based boards
12:    sdp3430:  Boot PASS: http://slexy.org/raw/s2qM9hxrfi
13:    sdp4430:  Boot PASS: http://slexy.org/raw/s2ubbIBRA7
14:       uevm:  Boot PASS: http://slexy.org/raw/s2Y9xESvfH
TOTAL = 14 boards, Booted Boards = 10, No Boot boards = 4

clk-next-db23a6c + next-20140117 (multi_v7_defconfig + CONFIG_LPAE=y)
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s26sCQ0zqh
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20BDyQWdB
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21OPwGNo1
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20tpjF0ri
 5:       beag:  Boot PASS: http://slexy.org/raw/s2jzkyRVaS
 6:       bone:  Boot PASS: http://slexy.org/raw/s20XodcZtZ
 7:      crane: No Image built - Missing platform support?:
 8:       dra7:  Boot FAIL: http://slexy.org/raw/s21cv8ni1H
missing DRA7 in multi_v7
 9:        ldp:  Boot PASS: http://slexy.org/raw/s22x4lqV3F
10:      panda:  Boot FAIL: http://slexy.org/raw/s200ETyoTB
kevin already reported this for CPU_IDLE enable
11:    sdp2430:  Boot FAIL: http://slexy.org/raw/s2lw3baFwx
* multi_v7 does not boot v6 based boards
12:    sdp3430:  Boot PASS: http://slexy.org/raw/s21i0TdsYs
13:    sdp4430:  Boot PASS: http://slexy.org/raw/s2DaYv6GVp
14:       uevm:  Boot PASS: http://slexy.org/raw/s2Q5IdWfMQ
TOTAL = 14 boards, Booted Boards = 10, No Boot boards = 4


-- 
Regards,
Nishanth Menon
