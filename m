From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Wed, 15 Jan 2014 09:59:25 -0600
Message-ID: <52D6B05D.6000302@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com> <20140109231513.GA11648@saruman.home> <52CFC2F1.706@ti.com> <20140110161352.GG6665@saruman.home> <52D02037.3090705@ti.com> <20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com> <20140114203613.GA604@saruman.home> <20140115020421.GA24195@saruman.home> <20140115031632.4167.2698@quantum> <20140115035011.4167.96678@quantum> <52D68FFA.8000806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41743 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbaAOP7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jan 2014 10:59:51 -0500
In-Reply-To: <52D68FFA.8000806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/15/2014 07:41 AM, Tero Kristo wrote:
> On 01/15/2014 05:50 AM, Mike Turquette wrote:
>> Quoting Mike Turquette (2014-01-14 19:16:32)
>>> Quoting Felipe Balbi (2014-01-14 18:04:21)
>>>> Hi,
>>>>
>>>> On Tue, Jan 14, 2014 at 02:36:13PM -0600, Felipe Balbi wrote:
>>>>>> Felipe, care to run your randconfig magic for this?
>>>>>
>>>>> This branch builds just fine so far, I still have omap5 multiplaform and
>>>>> uniplatform builds, but since that was working before i'm assuming it
>>>>> won't break.
>>>>
>>>> No build failures in any of my 18 seeds (5 randconfigs of each), I'd
>>>> attach logs, but it's a 2.8MiB tarball, if anyone cares enough, I can
>>>> send it.
>>>>
>>>> FWIW:
>>>>
>>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>>
>>> Felipe,
>>>
>>> That's great to hear. Thanks for testing.
>>>
>>> Tero & Tony,
>>>
>>> These 40 patches apply very cleanly on top of clk-next with 2
>>> exceptions:
>>>
>>> 1) I did not apply "[PATCH 30/42] ARM: dts: AM35xx: use DT clock data"
>>> because I do not have arch/arm/boot/dts/am3517.dtsi in clk-next (based
>>> on 3.13-rc1).
>>>
>>> 2) Minor merge conflict in arch/arm/boot/dts/omap3.dtsi which I think I
>>> resolved correctly but would like verification.
>>>
>>> I'd prefer to simply merge these patches into clk-next, which is the
>>> most straightforward route. Any ideas on how to handle the missing
>>> AM35xx dtsi data? It can always go as a separate fix after this stuff
>>> gets merged which, ironically, is how that file was created in the first
>>> place.
>>
>> I've pushed my branch. Tero can you take a look and let me know if you
>> see any problems?
>>
>> git://git.linaro.org/people/mike.turquette/linux.git clk-next-omap
> 
> Hey Mike,
> 
> Can't see any issues there, also gave it a quick boot test with the 
> boards I have access to and seems to work fine.
> 
Here are the logs with commit 12d0a30a45e3a85463a6cb2a9e886192e3123892
( i need an additional patch for legacy platform testing).

 1: am335x-evm: http://slexy.org/raw/s215zNjZFv
 2:  am335x-sk: http://slexy.org/raw/s20uTrPG7V
 3: am3517-evm: http://slexy.org/raw/s21XPhGMCt
(we should be based on .13-rc4 to get am3517 baseline patches -> So
due to the dropped am3517 patch, we stop booting here).
 4:  am37x-evm: http://slexy.org/raw/s20W2nuCQa
 5: am43xx-epos: http://slexy.org/raw/s2I2qc961B (no boot yet)
 6:    beag-xm: http://slexy.org/raw/s210lX2EvT
 7: bone-black: http://slexy.org/raw/s2NgHa78JC (still have the
fixed-regulator bug in rc1 so, wont boot to shell at rc1)
 8: am3517-crane: http://slexy.org/raw/s2r1Bt4Hk2 (need benoit'
for-next to boot)
 9:       dra7: http://slexy.org/raw/s21UWF0yYd (same fixed regulator
issue)
10:        ldp: http://slexy.org/raw/s2oWL6qt2t (dts for this is
pending merge in Tony's next)
11:    panda-es: http://slexy.org/raw/s20NEXs51M
12:    sdp2430: http://slexy.org/raw/s21kyDYjfk (dts for this pending
in Tony's next)
13:    sdp3430: http://slexy.org/raw/s2EYHpcAW0
14:    sdp4430: http://slexy.org/raw/s2QPK7cBUP
15:       uevm: http://slexy.org/raw/s21mMF6kN3 (same regulator stuff
kicks again)


am3517-evm is concerning for 14-rc1 boot, am43xx-epos looks concerning
too(not sure if there are follow on fixes in later rcs that allow it
to boot)
- considering that both did work on tests that I did based on next[1],
only thing i am concerned in am3517 patch dropped in clk-next-omap.

- will be good to get this merged on clk-next and see what we can get
results on linux-next tag.


[1] http://marc.info/?l=devicetree&m=138930255330882&w=2

-- 
Regards,
Nishanth Menon
