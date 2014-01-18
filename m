From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 19:20:06 -0600
Message-ID: <52D9D6C6.2000700@ti.com>
References: <52D53084.1070105@ti.com>	<20140115031632.4167.2698@quantum>	<20140115035011.4167.96678@quantum>	<20140115171323.GA22739@atomide.com>	<20140115192340.4167.87685@quantum>	<20140115193547.GF7993@atomide.com>	<20140116213954.4167.37071@quantum>	<87r486mrh5.fsf@linaro.org>	<20140117175312.GH7993@atomide.com>	<52D9723A.6000700@ti.com>	<20140117205832.4167.95162@quantum>	<52D9C484.6000404@ti.com>	<CAOesGMiniMi9xG6ByL0pQE7wzpM82JB40cPvfJcSYkXPs3PrDw@mail.gmail.com>	<52D9C88C.3020508@ti.com>
 <CAOesGMjB-Np1hkHfAPWeCxGK20OzWBt5zumFzDp5WLKTrntUAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMjB-Np1hkHfAPWeCxGK20OzWBt5zumFzDp5WLKTrntUAQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 01/17/2014 06:23 PM, Olof Johansson wrote:
> On Fri, Jan 17, 2014 at 4:19 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 01/17/2014 06:12 PM, Olof Johansson wrote:
>>> On Fri, Jan 17, 2014 at 4:02 PM, Nishanth Menon <nm@ti.com> wrote:
>>>
>>>> clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_LPAE=y:
>>>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21GRhEOj4
>>>>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20zcNsD8h
>>>>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s27U9IfRKR
>>>>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2zYyeonec
>>>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21iCRjTHK
>>>>  6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s20bPGL3Sz
>>>>  7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21AhFmkCk
>>>>  8:      crane: No Image built - Missing platform support?:
>>>>  9:       dra7:  Boot FAIL: http://slexy.org/raw/s21Qh3sQRu
>>>> * DRA7 not enabled?
>>>> 10:        ldp:  Boot PASS: http://slexy.org/raw/s21fvBfBgs
>>>> 11:   panda-es:  Boot FAIL: http://slexy.org/raw/s20RsgVUZJ
>>>> * known issue (https://patchwork.kernel.org/patch/3084521/)
>>>> 12:    sdp2430:  Boot FAIL: v6 platform - wont boot with multi_v7
>>>> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20rhjjBwe
>>>> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2My0UfNPm
>>>> 15:       uevm:  Boot PASS: http://slexy.org/raw/s21aqF6eMN
>>>> TOTAL = 15 boards, Booted Boards = 11, No Boot boards = 4
>>>
>>>
>>> I have a hard time believing the above; A8/A9 boards are not bootable
>>> with CONFIG_LPAE=y...
>>
>> You are right! Drat!! I had CONFIG_LPAE=y in my script, not
>> CONFIG_ARM_LPAE=y! Grrr...
>>
>> Retest in a around 30 mins..
> 
> It's not a huge concern though; it's unlikely that LPAE makes a
> functional difference on this patch series. It's still useful to catch
> warnings, etc (most likely printk formats and the like).
> 
I suppose, as expected:
clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_ARM_LPAE=y
* .config = http://slexy.org/view/s208uSeQS8
* Build warnings: http://slexy.org/raw/s20n7YwbwN
 1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s20tF2eUZG
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2uP65lOMQ
 3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s2Lx13gsFZ
 4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s2eOLXxvsT
 5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s24coJzGvR
 6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s240WznuPd
 7: BeagleBone-Black:  Boot FAIL: http://slexy.org/raw/s20NG2UVTU
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot FAIL: http://slexy.org/raw/s21T3RpHx2
^^ might probably boot if we enable CONFIG_SOC_DRA7XX in multi_v7
(this is another A15 target)
10:        ldp:  Boot FAIL: http://slexy.org/raw/s2F4VO9hDM
11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s20HpzT1jW
12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s21snV1EvL
13:    sdp3430:  Boot FAIL: http://slexy.org/raw/s2FwkVfG5R
14:    sdp4430:  Boot FAIL: http://slexy.org/raw/s2xiWxlpTj
15:       uevm:  Boot PASS: http://slexy.org/raw/s2LWUOmfiG
TOTAL = 15 boards, Booted Boards = 1, No Boot boards = 14

I am running a defconfig set check on next-20140117 and will do one
with next-20140118 once that is ready for comparison results

-- 
Regards,
Nishanth Menon
