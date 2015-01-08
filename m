From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 00/21] irqchip: gic: killing gic_arch_extn and co,
 slowly
Date: Wed, 7 Jan 2015 21:31:42 -0600
Message-ID: <20150108033141.GA24237@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> As for the patches, they are on top of 3.19-rc3.
Applied the 21 patches and gave a quick dry run on various boards
BASE = v3.19-rc3 + 1 uImage+dtb patch for 
IRQ = v3.19-rc3 + irq series

NOTE: I am yet to dig in deeper to figure out which platform may have
valid regressions etc. will do that tomorrow. meanwhile, some raw test
results below:
+++v3.19-rc3 - BOOT TEST+++
boot
 1:                     am335x-evm: BOOT: PASS: http://slexy.org/raw/s2IOPX99Ty
 2:                      am335x-sk: BOOT: FAIL: http://slexy.org/raw/s2dzt0lTF7
 3:                     am3517-evm: BOOT: PASS: http://slexy.org/raw/s23yAMKuRx
 4:                      am37x-evm: BOOT: PASS: http://slexy.org/raw/s20vsYwsYQ
 5:                      am437x-sk: BOOT: PASS: http://slexy.org/raw/s2QgujFs6l
 6:                    am43xx-epos: BOOT: PASS: http://slexy.org/raw/s2QHVg9XcB
 7:                   am43xx-gpevm: BOOT: PASS: http://slexy.org/raw/s2Ep5DEQuk
 8:    BeagleBoard-X15(am57xx-evm): BOOT: PASS: http://slexy.org/raw/s20STBNTs9
 9:                 BeagleBoard-XM: BOOT: PASS: http://slexy.org/raw/s2UhG6u7yM
10:            beagleboard-vanilla: BOOT: PASS: http://slexy.org/raw/s2QB7ECFKw
11:               beaglebone-black: BOOT: PASS: http://slexy.org/raw/s20iAe7yTa
12:                     beaglebone: BOOT: PASS: http://slexy.org/raw/s20Uui1gkn
13:                     craneboard: BOOT: PASS: http://slexy.org/raw/s21DcY6gn4
14:                     dra72x-evm: BOOT: PASS: http://slexy.org/raw/s2qj7IvmaV
15:                     dra7xx-evm: BOOT: PASS: http://slexy.org/raw/s20lLxN8bR
16:         OMAP3430-Labrador(LDP): BOOT: PASS: http://slexy.org/raw/s20GmT9ASX
17:                           n900: BOOT: FAIL: http://slexy.org/raw/s2riSEzfea
18:                      omap5-evm: BOOT: PASS: http://slexy.org/raw/s21adCD3Js
19:                  pandaboard-es: BOOT: PASS: http://slexy.org/raw/s21Am3vEzM
20:             pandaboard-vanilla: BOOT: PASS: http://slexy.org/raw/s2XLmW2ONB
21:                        sdp2430: BOOT: PASS: http://slexy.org/raw/s21ehzlzyv
22:                        sdp3430: BOOT: PASS: http://slexy.org/raw/s24gh1VUnl
23:                        sdp4430: BOOT: PASS: http://slexy.org/raw/s2HfgkFfOx
TOTAL = 23 boards, Booted Boards = 21, No Boot boards = 2
+++ IRQ - BOOT TEST+++
boot
 1:                     am335x-evm: BOOT: PASS: http://slexy.org/raw/s21411sejg
 2:                      am335x-sk: BOOT: PASS: http://slexy.org/raw/s209N4Tu4E
 3:                     am3517-evm: BOOT: PASS: http://slexy.org/raw/s2Shbhciy8
 4:                      am37x-evm: BOOT: PASS: http://slexy.org/raw/s20wfqH0Wo
 5:                      am437x-sk: BOOT: PASS: http://slexy.org/raw/s21uAXcB12
 6:                    am43xx-epos: BOOT: PASS: http://slexy.org/raw/s26MGCZz0i
 7:                   am43xx-gpevm: BOOT: PASS: http://slexy.org/raw/s2c8IGmWfB
 8:    BeagleBoard-X15(am57xx-evm): BOOT: FAIL: http://slexy.org/raw/s2u1yV4hHK
 9:                 BeagleBoard-XM: BOOT: PASS: http://slexy.org/raw/s20zzOBKWJ
10:            beagleboard-vanilla: BOOT: PASS: http://slexy.org/raw/s2wffxWVGa
11:               beaglebone-black: BOOT: PASS: http://slexy.org/raw/s2Yshc0Vkw
12:                     beaglebone: BOOT: PASS: http://slexy.org/raw/s2Ki0ohBVf
13:                     craneboard: BOOT: PASS: http://slexy.org/raw/s2GVlDWkzP
14:                     dra72x-evm: BOOT: PASS: http://slexy.org/raw/s2dfZIVZ42
15:                     dra7xx-evm: BOOT: PASS: http://slexy.org/raw/s25UqvqVna
16:         OMAP3430-Labrador(LDP): BOOT: PASS: http://slexy.org/raw/s20plEBPRB
17:                           n900: BOOT: FAIL: http://slexy.org/raw/s20zeM6YUP
18:                      omap5-evm: BOOT: PASS: http://slexy.org/raw/s2JOb4VEGJ
19:                  pandaboard-es: BOOT: PASS: http://slexy.org/raw/s20jCqY4OV
20:             pandaboard-vanilla: BOOT: PASS: http://slexy.org/raw/s21TuquMeN
21:                        sdp2430: BOOT: PASS: http://slexy.org/raw/s20z1S6w1a
22:                        sdp3430: BOOT: PASS: http://slexy.org/raw/s20SJo6BqV
23:                        sdp4430: BOOT: PASS: http://slexy.org/raw/s204Bn9azX
TOTAL = 23 boards, Booted Boards = 21, No Boot boards = 2
+++v3.19-rc3 - POWER TEST+++
power
 1:                     am335x-evm: BOOT: PASS: err=10 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s20t02tklu
 2:                      am335x-sk: BOOT: FAIL: http://slexy.org/raw/s2HX7WisAk
 3:                     am3517-evm: BOOT: FAIL: http://slexy.org/raw/s2mdCPTUBw
 4:                      am37x-evm: BOOT: FAIL: http://slexy.org/raw/s2beWlmPMy
 5:                      am437x-sk: BOOT: PASS: crit=2 err=12 warn=25, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2Z0QTrATC
 6:                    am43xx-epos: BOOT: PASS: crit=2 err=15 warn=26, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s21VqMaKE5
 7:                   am43xx-gpevm: BOOT: PASS: crit=2 err=12 warn=25, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s28zvJSBnv
 8:    BeagleBoard-X15(am57xx-evm): BOOT: PASS: err=20 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2754wOSyR
 9:                 BeagleBoard-XM: BOOT: PASS: err=9 warn=19, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s21yJVYSQX
10:            beagleboard-vanilla: BOOT: PASS: err=9 warn=25, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2ePKa43mj
11:               beaglebone-black: BOOT: PASS: err=8 warn=25, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2gFTc8yGz
12:                     beaglebone: BOOT: PASS: err=9 warn=20, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2c9LVVWez
13:                     craneboard: BOOT: PASS: err=20 warn=60, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s210m3vNqa
14:                     dra72x-evm: BOOT: PASS: crit=2 err=14 warn=27, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2nCfZhtlX
15:                     dra7xx-evm: BOOT: PASS: err=11 warn=31, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2Ikj5xQNE
16:         OMAP3430-Labrador(LDP): BOOT: PASS: err=7 warn=25, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2tfdy65xq
17:                           n900: BOOT: FAIL: http://slexy.org/raw/s21ByECFQh
18:                      omap5-evm: BOOT: PASS: err=15 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s21Jd8hDT3
19:                  pandaboard-es: BOOT: PASS: err=20 warn=33, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s20fKLg0PV
20:             pandaboard-vanilla: BOOT: PASS: err=20 warn=31, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s207BtiFCQ
21:                        sdp2430: BOOT: FAIL: http://slexy.org/raw/s2016uSIuh
22:                        sdp3430: BOOT: PASS: err=22 warn=28, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s205w47Ubl
23:                        sdp4430: BOOT: PASS: err=21 warn=33, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s23YNhbaUe
TOTAL = 23 boards, Booted Boards = 18, No Boot boards = 5
TOTAL CPUFREQ enabled boards = 13.  CPUFREQ functional boards = 13, CPUFREQ failed boards = 0
TOTAL CPUIdle enabled boards = 7.  CPUIdle functional boards = 3, CPUIdle failed boards = 4
+++ IRQ - POWER TEST+++
power
 1:                     am335x-evm: BOOT: PASS: err=10 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2luRdrwTo
 2:                      am335x-sk: BOOT: PASS: err=8 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s20rhziuEz
 3:                     am3517-evm: BOOT: FAIL: http://slexy.org/raw/s20yHRtY5f
 4:                      am37x-evm: BOOT: FAIL: http://slexy.org/raw/s2eh5wioQj
 5:                      am437x-sk: BOOT: PASS: crit=2 err=12 warn=25, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s213VjGWo1
 6:                    am43xx-epos: BOOT: PASS: crit=2 err=15 warn=26, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s20JCs4KKY
 7:                   am43xx-gpevm: BOOT: PASS: crit=2 err=12 warn=25, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s20RScmcvK
 8:    BeagleBoard-X15(am57xx-evm): BOOT: FAIL: http://slexy.org/raw/s2155P8obZ
 9:                 BeagleBoard-XM: BOOT: PASS: err=9 warn=19, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s2018sfpgM
10:            beagleboard-vanilla: BOOT: PASS: err=9 warn=25, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s28pJudRI4
11:               beaglebone-black: BOOT: PASS: err=8 warn=25, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2VNAfNqxl
12:                     beaglebone: BOOT: PASS: err=9 warn=20, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s20Ep0UYpp
13:                     craneboard: BOOT: PASS: err=20 warn=60, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2qyzBJXF1
14:                     dra72x-evm: BOOT: PASS: crit=2 err=14 warn=27, CPUFreq: N/A, CPUIdle: N/A: http://slexy.org/raw/s2czDXEdYH
15:                     dra7xx-evm: BOOT: PASS: err=11 warn=31, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2029U2gMt
16:         OMAP3430-Labrador(LDP): BOOT: PASS: err=7 warn=25, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s20pTYJKV4
17:                           n900: BOOT: FAIL: http://slexy.org/raw/s2kKNGkdK8
18:                      omap5-evm: BOOT: PASS: err=15 warn=24, CPUFreq: PASS, CPUIdle: N/A: http://slexy.org/raw/s2FpijcXbP
19:                  pandaboard-es: BOOT: PASS: err=20 warn=33, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s2i1S7kdqK
20:             pandaboard-vanilla: BOOT: PASS: err=20 warn=31, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s21v9TjuAr
21:                        sdp2430: BOOT: FAIL: http://slexy.org/raw/s207WeE74f
22:                        sdp3430: BOOT: PASS: err=22 warn=28, CPUFreq: PASS, CPUIdle: FAIL: http://slexy.org/raw/s21OSk7p87
23:                        sdp4430: BOOT: PASS: err=21 warn=33, CPUFreq: PASS, CPUIdle: PASS: http://slexy.org/raw/s2z01QnTgx
TOTAL = 23 boards, Booted Boards = 18, No Boot boards = 5
TOTAL CPUFREQ enabled boards = 13.  CPUFREQ functional boards = 13, CPUFREQ failed boards = 0
TOTAL CPUIdle enabled boards = 7.  CPUIdle functional boards = 3, CPUIdle failed boards = 4

-- 
Regards,
Nishanth Menon
