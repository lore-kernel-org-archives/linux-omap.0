From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Mon, 20 Jan 2014 11:36:17 -0600
Message-ID: <52DD5E91.70203@ti.com>
References: <52D53084.1070105@ti.com>	<20140115031632.4167.2698@quantum>	<20140115035011.4167.96678@quantum>	<20140115171323.GA22739@atomide.com>	<20140115192340.4167.87685@quantum>	<20140115193547.GF7993@atomide.com>	<20140116213954.4167.37071@quantum>	<87r486mrh5.fsf@linaro.org>	<20140117175312.GH7993@atomide.com>	<52D9723A.6000700@ti.com>	<20140117205832.4167.95162@quantum>	<52D9C484.6000404@ti.com>	<CAOesGMiniMi9xG6ByL0pQE7wzpM82JB40cPvfJcSYkXPs3PrDw@mail.gmail.com>	<52D9C88C.3020508@ti.com> <CAOesGMjB-Np1hkHfAPWeCxGK20OzWBt5zumFzDp5WLKTrntUAQ@mail.gmail.com> <52D9D6C6.2000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaATRgp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 12:36:45 -0500
In-Reply-To: <52D9D6C6.2000700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/17/2014 07:20 PM, Nishanth Menon wrote:
[...]
> I am running a defconfig set check on next-20140117 and will do one
> with next-20140118 once that is ready for comparison results
> 
baseline next-20140120
modified as follows:
multi_v7_defconfig - added CONFIG_SOC_DRA7XX
omap2plus_defconfig - added CONFIG_SOC_AM43XX
few patches for legacy boot platforms added in.

next-20140120-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2vfJ5w6Na
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21IdtacuB
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2zrGqzI8r
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21RLq4EzM
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21msOh70k
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2MyM1kbTJ
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2KmkjEQU5
 8:      crane: No Image built - Missing platform support?:
* Pending merge from Benoit's tree
 9:       dra7:  Boot PASS: http://slexy.org/raw/s20GK8ZSrL
10:        ldp:  Boot FAIL: http://slexy.org/raw/s20I1vJEY6
* Known issue on my setup :( - debug pending.
11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s2SVGtHlwx
12:    sdp2430:  Boot PASS: http://slexy.org/raw/s214WyGCco
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s21fPHXoOB
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s20v0UJubl
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2jPgymund
TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2

next-20140120-multi_v7_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2DcNIdR1p
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2NWkEQIct
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21rOVU9L3
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2xRLmJ9EW
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21487l9Tw
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2198moPea
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s20wdS9zgf
 8:      crane: No Image built - Missing platform support?:
* pending merge from Benoit's tree
 9:       dra7:  Boot PASS: http://slexy.org/raw/s21Vr0foZS
10:        ldp:  Boot PASS: http://slexy.org/raw/s21PKycvVx
11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s20M5bdzFq
* kevin already reported this for CPU_IDLE enable
12:    sdp2430:  v6 platform - wont boot
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2pmLQItJb
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21FYwSVZz
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21O7xuAJp
TOTAL = 15 boards, Booted Boards = 12, No Boot boards = 3

next-20140120-multi_v7_defconfig + CONFIG_ARM_LPAE=y
 1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s21YHQrdtf
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s20buoWhQw
 3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s2VfH3LYFf
 4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s20Q4s7tjA
 5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s2tMG0ABLi
 6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s20INrphLO
 7: BeagleBone-Black:  Boot FAIL: http://slexy.org/raw/s2ZKx9lyGc
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot PASS: http://slexy.org/raw/s21EV3vV4E
10:        ldp:  Boot FAIL: http://slexy.org/raw/s21aQ1vXWH
11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s20JMBxQUc
12:    sdp2430:  v6 platform - wont boot
13:    sdp3430:  Boot FAIL: http://slexy.org/raw/s20Itj0uX4
14:    sdp4430:  Boot FAIL: http://slexy.org/raw/s2BEPG9pjN
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20bOKUZev
TOTAL = 15 boards, Booted Boards = 2, No Boot boards = 13


in comparison  with previous next tag:
multi_v7_defconfig - added CONFIG_SOC_DRA7XX
omap2plus_defconfig - added CONFIG_SOC_AM43XX
few patches for legacy boot platforms added in.

next-20140117-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2x6c41m1Q
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s24IkMtLwV
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20ahoA1JR
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2hzZbe5fq
 5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s20875oeoW
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s20luzJWbj
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2Z1YQqX1A
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s2137kLALM
10:        ldp:  Boot FAIL: http://slexy.org/raw/s21S66NNnp
11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s20XyDcifE
12:    sdp2430:  Boot PASS: http://slexy.org/raw/s234d7bWzB
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s250xvaBxy
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2g3As3XlA
15: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s21hOhWY4E
TOTAL = 15 boards, Booted Boards = 10, No Boot boards = 5

next-20140117-multi_v7_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2M6DZp8D2
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21WdeG7QL
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2PanhpCqK
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20nI7GNQS
 5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s2FFQpMN21
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2hy4PnWL6
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s21tx10epo
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s20itoFBdS
10:        ldp:  Boot PASS: http://slexy.org/raw/s213Un5KQW
11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s20B5kDMwg
12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s21ZvpGpmK
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20Ne0P2oX
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s215lq0bvl
15: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2cUSAGe5h
TOTAL = 15 boards, Booted Boards = 9, No Boot boards = 6

next-20140117-multi_v7_defconfig + CONFIG_ARM_LPAE=y
 1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s208rBie8T
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2176U7Dph
 3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s216noNiRN
 4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s21iF5KAJz
 5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s2lTTWBTzz
 6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s20rHgs9kq
 7: BeagleBone-Black:  Boot FAIL: http://slexy.org/raw/s2yp7IWdE1
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s2GgOR9BzT
10:        ldp:  Boot FAIL: http://slexy.org/raw/s2u2OKWLpI
11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s2t3PluNV5
12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s2biJ1CVJf
13:    sdp3430:  Boot FAIL: http://slexy.org/raw/s2K3G0fji6
14:    sdp4430:  Boot FAIL: http://slexy.org/raw/s2162mQFOS
15: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2WbE4HU6Q
TOTAL = 15 boards, Booted Boards = 0, No Boot boards = 15


-- 
Regards,
Nishanth Menon
