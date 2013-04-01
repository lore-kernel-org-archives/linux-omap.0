From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Mon, 1 Apr 2013 14:18:44 +0300
Message-ID: <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
	<CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
	<alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
	<CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
	<alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
	<CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:43020 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab3DALSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 07:18:45 -0400
In-Reply-To: <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@linaro.org, balbi@ti.com

Paul,

Please, correct me if I'm wrong, you're experiencing issues on Tx, or
Rx direction? You've said that characters are echoed incorrectly, but
haven't mentioned in what direction issue appears?
For reference, I'll quote TI DM3730 Rev.R TRM:
TRM page 2953, LSR_REG
Bit #5: TX_FIFO_E
 0x0 Transmit hold register (TX FIFO) is not empty.
 0x1 Transmit hold register (TX FIFO) is empty. The transmission is
not necessarily complete.

Before my patch: there was a check for TX_FIFO_E to be 0x1 before
filling Tx FIFO
After: If THR interrupt is raised, then there is a space in FIFO and
threshold has reached it's level, no extra check is required

TRM page 2972, SCR_REG
Bit #4: TX_EMPTY_CTL_IT
 0x1 The THR interrupt is generated when TX FIFO and TX shift register
are empty.
 0x0 Normal mode for THR interrupt (see Table 19-33 for details about
UART mode interrupts)

Before: THR interrput is raised only when TX FIFO and TX shift
register are empty, for shortcut "all Tx lane empty"
After: THR interrupt is raised both when Tx lane is empty, or when
size of data in Tx lane falls below Tx threshold level

Bit #7: RX_TRIG_GRANU1
 0x0 Disables the granularity of 1 for TRIGGER RX level
 0x1 Enables the granularity of 1 for TRIGGER RX level

Before: RX FIFO Trigger Level "Defined by the concatenated value of
RX_FIFO_TRIG_DMA and
RX_FIFO_TRIG (from 1 to 63 characters with a granularity of 1 character).
Note: The combination of RX_FIFO_TRIG_DMA = 0x0 and RX_FIFO_TRIG =
0x0 (all zeros) is not supported (minimum 1 character required). All
zeros result
in unpredictable behavior."

After: RX FIFO Trigger Level "Defined by the UARTi.FCR_REG[7:6]
RX_FIFO_TRIG field (8,16, 56, or 60
characters)" (as it should be according to comments in source code)

On Mon, Apr 1, 2013 at 1:45 PM, Alexey Pelykh <alexey.pelykh@gmail.com> wrote:
> On Mon, Apr 1, 2013 at 1:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> cc Kevin, Felipe
>>
>> Hi
>>
>> On Mon, 1 Apr 2013, Alexey Pelykh wrote:
>>
>>> On Mon, Apr 1, 2013 at 12:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
>>> > On Mon, 1 Apr 2013, Alexey Pelykh wrote:
>>> >
>>> >> Actually, I've tested my patch on DM3730,
>>> >
>>> > What board, bootloader, and test steps did you use?  Can you post a dmesg?
>>>
>>> I've used LogicPD Torpedo Wireless SoM + DevKit board. Bootloader is
>>> stock from their BSP, u-boot 2011.06 + patches from LogicPD.
>>> I can provide dmesg of 3.8(inital kernel this patch was intented for)
>>> a bit later during the day, and a bit more later same patch rebased
>>> onto latest sources.
>>> Also, I should mention that LogicPD does not support 3.8, so most
>>> LogicPD-specific devices are not working.
>>
>> A dmesg from v3.9-rc5 would be ideal, but sounds like it's a non-mainline
>> kernel?
>
> It's true, mainline kernel won't run on that board out of the box, but
> patches to
> support it go only in mach-types.h and board-omap3logic.c
>
>>
>> Are you using a serial console on that board, and if so, what UART is it
>> on?
>
> Yes, it's serial console port on UART0 (console=ttyO0,115200n8)
>
>>
>>> And I'd like to point out that after patch gaps I've seen are not gone
>>> completely, ~1 packet out of 200 at 1mbaud is still corrupted, but
>>> only when PM is enabled in kernel,
>>
>> Are you seeing corruption caused by the OMAP UART's receive path, or by
>> the transmit path?
>
> Corruption is on Tx path. Without my patch (but with patch to allow 1Mbaud):
> Interrupt to refill Tx FIFO is raised only after entire FIFO is
> transmitted (that is, no data left in FIFO to be sent),
> and it takes kernel 25us to handle interrupt and refill FIFO. Issue is
> in condition when UART triggers interrupt.
> According to original sources, this interrupt is configured to be
> raised only when TX FIFO is (fully) empty, while
> ignoring Tx FIFO threshold level completely, although it's being
> (almost) properly configured and enabled.
> So, what my patch changes is basically when interrupt to refill Tx
> FIFO is raised:
>  - from "when empty" to "when threshold is reached", refs:
> OMAP_UART_SCR_TX_EMPTY flag
>    should not be set, and UART_LSR_THRE check is also invalid, since
> blocks threshold level situation.
>  - setting OMAP_UART_SCR_RX_TRIG_GRANU1_MASK will lead to incorrect
> interpretation
>    of threshold level settings (inconsistent with comments in driver
> sources itself).
>
>>
>> When you say "only when PM is enabled" do you mean by enabling CONFIG_PM,
>> or do you mean after setting an autosuspend timeout on the serial drivers,
>> or something else?
>>
>
> I mean that I've seen gap issues both with CONFIG_PM=y and CONFIG_PM=n
> After my patch I saw gap issues only several times, and _probably_
> that is due to CONFIG_PM=y,
> since I've never seen them after that with CONFIG_PM=n
>
> I should point that tests I run are completely user-space, so I've
> never tested UARTs
> using oscilloscope during kernel boot. But, no issues in serial
> console seen, as I've
> already pointed out.
>
>>> what gives me a clue that it must be something in PM also. Maybe my
>>> patch just reveals PM-specific issue. Have you tried without PM to
>>> reproduce issues you're experiencing?
>>
>> So I'm using omap2plus_defconfig, which has CONFIG_PM=y, but the issues
>> appear before serial autosuspend is enabled.
>>
>>> Indeed, TRMs appear to contain wrong information, but I believe that
>>> in this particular case, bug is somewhere around, but not in these
>>> lines.
>>> I believe if you take a look on related TRM pages, it seems quite
>>> logical that configuration of SCR (before my patch) is not quite
>>> proper:
>>>  - trigger interrupt only when it's entirely empty, not when threshold
>>> level is reached, what is incorrect, in my opinion.
>>>  - (less influencing) Granularity of counter indicates opposite to
>>> what is stated in comments
>>>
>>> These issues may have never been experienced by others, since
>>> originally I've hit them on 1mbaud speed, what is not supported by
>>> original driver at all.
>>
>> It wouldn't surprise me at all if something is wrong with the
>> original driver's FIFO setup.  The challenge at this point is to keep
>> the driver working while trying to fix what's wrong with it.
>>
>>
>> - Paul
