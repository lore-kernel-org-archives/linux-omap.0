From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 18:02:12 -0600
Message-ID: <52D9C484.6000404@ti.com>
References: <52D53084.1070105@ti.com> <20140115031632.4167.2698@quantum>
 <20140115035011.4167.96678@quantum> <20140115171323.GA22739@atomide.com>
 <20140115192340.4167.87685@quantum> <20140115193547.GF7993@atomide.com>
 <20140116213954.4167.37071@quantum> <87r486mrh5.fsf@linaro.org>
 <20140117175312.GH7993@atomide.com> <52D9723A.6000700@ti.com>
 <20140117205832.4167.95162@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140117205832.4167.95162@quantum>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, bcousson@baylibre.com, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/17/2014 02:58 PM, Mike Turquette wrote:
> Quoting Tero Kristo (2014-01-17 10:11:06)
>> On 01/17/2014 07:53 PM, Tony Lindgren wrote:
>>> * Kevin Hilman <khilman@linaro.org> [140117 09:48]:
>>>> Mike Turquette <mturquette@linaro.org> writes:
>>>>
>>>> [...]
>>>>
>>>>> I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
>>>>> Tero's series. This includes the AM3517 bits now. I've pushed this
>>>>> branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
>>>>> final sanity test before I merge this into clk-next?
>>
>> I think you accidentally merged wrong branch to clk-next-omap with the 
>> latest refresh. This is one is missing the build-fixes now, when it 
>> earlier had those in.
>>
>> The correct branch to merge was 3.13-rc7-dt-clks-v13-build-fixes.
>>
>> This also causes the build failure below for omap1.
> 
> You are right. I broke the OMAPs. I force updated clk-next-omap (and
> clk-next) with the correct branch this time.

Build tests: omap1_defconfig:
clk-next-6a0cad9: builds fine
clk-next-6a0cad9 + next-20140117: http://slexy.org/view/s2HgtvUtAl
	disabling CONFIG_BT, builds fine

Boot tests: clk-next-6a0cad9, clk-next-6a0cad9 + next-20140117 : No
regressions seen

Detailed Boot logs:

clk-next-6a0cad9 omap2plus_defconfig:
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21idEk2IZ
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21Q4w8gWT
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21dT7y2CA
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2VFaOtuDP
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s20L0DBt1d
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s20gKsdH3A
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ZXTJswqY
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot PASS: http://slexy.org/raw/s2XZfjQz67
10:        ldp: No Image built - Missing platform support?:
11:   panda-es:  Boot PASS: http://slexy.org/raw/s2ESRQgBbc
12:    sdp2430: No Image built - Missing platform support?:
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2YsAO3ZPJ
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2MxxggHkh
15:       uevm:  Boot PASS: http://slexy.org/raw/s2wJT0B7wf
TOTAL = 15 boards, Booted Boards = 12, No Boot boards = 3

clk-next-6a0cad9 multi_v7_defconfig:
 1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s21AXBDbM9
* regulator/mmc missing here
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s21pQPhupJ
* regulator/mmc missing here
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21iM7TEiQ
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2pBD6nplU
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2X9mnCKhT
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s21CjzZtZ6
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2vCfnss8N
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s21Xn4t22A
* DRA7 not enabled?
10:        ldp: No Image built - Missing platform support?:
11:   panda-es:  Boot PASS: http://slexy.org/raw/s21ZoijL9i
12:    sdp2430: No Image built - Missing platform support?:
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s21rdIfh7S
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21HXFj9cw
15:       uevm:  Boot FAIL: http://slexy.org/raw/s21m26VdbI
* regulator/mmc missing here
TOTAL = 15 boards, Booted Boards = 8, No Boot boards = 7

clk-next-6a0cad9 multi_v7_defconfig+CONFIG_LPAE=y:
 1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s21GIuprIx
* regulator/mmc missing here
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s20Vy6K9Rg
* regulator/mmc missing here
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20jXaoTYq
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20bk4uHcb
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2gVGjYMXz
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s26D0F2N1t
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ThmugNzC
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s21HdQFchd
* DRA7 not enabled?
10:        ldp: No Image built - Missing platform support?:
11:   panda-es:  Boot PASS: http://slexy.org/raw/s2042Y9Pyb
12:    sdp2430: No Image built - Missing platform support?:
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2NCg8nLki
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s25GxRkWcj
15:       uevm:  Boot FAIL: http://slexy.org/raw/s2Q7xBYM3a
* regulator/mmc missing here
TOTAL = 15 boards, Booted Boards = 8, No Boot boards = 7


clk-next-6a0cad9 + next-20140117 omap2plus_defconfig:
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2ll3LdMN2
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2jyAF2Och
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20nPsCcUS
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2Rn7Vqh8x
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2frIhnu6Y
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s2GNee8kHF
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2G7fD4rGD
 8:      crane: No Image built - Missing platform support?: (pending
merge from Benoit)
 9:       dra7:  Boot PASS: http://slexy.org/raw/s21W2zLl5q
10:        ldp:  Boot FAIL: http://slexy.org/raw/s21518Tibq
* intermittent failures seen previously as well -> debug pending
11:   panda-es:  Boot PASS: http://slexy.org/raw/s20WddZMVp
12:    sdp2430:  Boot PASS: http://slexy.org/raw/s2cVr3BLLi
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s21h9oDSCv
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21PWBCUKn
15:       uevm:  Boot PASS: http://slexy.org/raw/s2OxDQtC9E
TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2

clk-next-6a0cad9 + next-20140117 multi_v7_defconfig:
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20MpjXQ71
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2T0vnX8s7
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2hvsW2oVi
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2Li1DqaeQ
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2MHh0c19C
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s21RnOxxUk
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2qaKF0lqp
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s203u2hQ1m
* DRA7 not enabled?
10:        ldp:  Boot PASS: http://slexy.org/raw/s2ug8MyzzE
11:   panda-es:  Boot FAIL: http://slexy.org/raw/s2NVPvwb2I
* known issue (https://patchwork.kernel.org/patch/3084521/)
12:    sdp2430:  Boot FAIL: v6 platform - wont boot with multi_v7
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s28vswaDnc
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s21wk2lqiC
15:       uevm:  Boot PASS: http://slexy.org/raw/s21soF15Dy
TOTAL = 15 boards, Booted Boards = 11, No Boot boards = 4

clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_LPAE=y:
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21GRhEOj4
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20zcNsD8h
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s27U9IfRKR
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2zYyeonec
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21iCRjTHK
 6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s20bPGL3Sz
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21AhFmkCk
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s21Qh3sQRu
* DRA7 not enabled?
10:        ldp:  Boot PASS: http://slexy.org/raw/s21fvBfBgs
11:   panda-es:  Boot FAIL: http://slexy.org/raw/s20RsgVUZJ
* known issue (https://patchwork.kernel.org/patch/3084521/)
12:    sdp2430:  Boot FAIL: v6 platform - wont boot with multi_v7
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20rhjjBwe
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2My0UfNPm
15:       uevm:  Boot PASS: http://slexy.org/raw/s21aqF6eMN
TOTAL = 15 boards, Booted Boards = 11, No Boot boards = 4



-- 
Regards,
Nishanth Menon
