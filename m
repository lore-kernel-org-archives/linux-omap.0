From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Wed, 18 Feb 2015 04:00:36 +0100
Message-ID: <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35445 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbBRDA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2015 22:00:58 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so38021123wib.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2015 19:00:57 -0800 (PST)
In-Reply-To: <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 18 February 2015 at 00:37, Grazvydas Ignotas wrote:
> On Mon, Feb 16, 2015 at 8:43 PM, Matthijs van Duin wrote:
>> A dump of all non-zero registers in DAPCTL (the 4KB block at
>> 0x5401d000) might be interesting.
>
> Attached

OK, nice.  I like peripherals which fault accesses to non-existent (or
at least non-readable) regs, makes it easier to make an inventory of
what's there :-)   So, we have some standard ID regs at the end:
CID = b1 05 f0 0d -- PrimeCell or system peripheral (i.e. not coresight)
PID = 00 00 09 73 43 -- vendor 0x097 (TI), part 0x343, rev 0x00
and indeed no other coresight management regs. The partcode 0x343
might be a reference to the omap3430. Regs at 000 and 010 presumably
revision and sysconfig.

030-040 are the core debug control regs... in fact, judging by their
values and the fact you mentioned bit 13 controls DBGEN, these regs
look very much like the ICEPick-D core debug control regs, which
themselves are simplified versions of debug TAP control registers (for
which you can find the layout in the dm3730 TRM's debug chapter).

050 and 054 are unknown, but 058 reads 0x20000000 which suggests it
may have an ownership claim command register there. Try writing
0x40000000 to it, if that succeeds and it reads back 0x70000000 then
you're successfully claimed ownership which hopefully means you can
then write to other regs too, although they may not take effect unless
you enable the module by writing 0x80000000 to the ownership claim
command register, after which it should read back 0xb0000000. Of
course it's also possible it only covers registers 050 and 054,
whatever they may be... (or it might be something else altogether)

If this doesn't work either, then bitbanging JTAG is plan B...


>> (As a random note, on the am335x the JTAG pins have pinconf registers,
>> in that case it may suffice to externally pull/drive all pins up and
>> then toggle the RXEN bit in software, given that even the (warm) reset
>> pin responds to such manipulation.)
>
> DM3730 (equivalent to OMAP3630) that I'm using also has pinconf
> registers on all JTAG pins, and there are external pullups on my
> board. So I guess you mean performing I/O by quickly
> enabling/disabling the pulldowns? Would that satisfy any timing
> requirements? I doubt pinmux register access would be fast from the
> CPU (OMAP3 is known not to be a good GPIO bitbanger even).
>
> And what is RXEN bit? I can't find it referenced anywhere (and I'll
> admit I don't have experience with hardware debuggers).

RXEN == INPUTENABLE

At least on the am335x, disabling it causes the processor to perceive
the input as being low regardless of its actual level. Since the line
itself doesn't have to change level, this can be toggled pretty fast
probably. Using this to simulate an input does require the actual line
level to be high obviously.

Using the pull up/down to toggle an IO can definitely also work, but
only if the pin is really floating since the internal pulls are really
weak afaik. They're not gonna win from that 10k resistor. And
obviously you then need to toggle it slow enough to allow the pull
resistor to do its job.

JTAG has no lower limit on clock speed, or any other timing
constraints other than minimum setup/hold/cycle times, so bitbanging
it using slow GPIO is no problem if you don't care about performance
but only need to set some debug enable bit.


> I could try the bitbang method if you think it can work, although my
> board (openpandora) has a 10K pulldown resistor on nTRST that I'm not
> sure OMAP's internal pullup would win over.

It won't, you'll need to externally drive it up, e.g. by connecting it
to the Vref pin that's also on the jtag connector.

> Is there any way to check if anything works from the CPU?
> Maybe I could modify my board, I could connect some spare GPIO pads to
> jtag pads, but I don't know if it's even worth trying.

If the ownership claim register doesn't work it may be worth a try, if
you're comfortable doing that. Connecting them to GPIOs will
definitely work, though just driving the inputs high and toggling
INPUTENABLE via padconf *may* also work and be simpler.

Pin summary:
nTRST - cpu input, must be high for JTAG to work
TCK - cpu input, clock, idle low
TMS - cpu input, command, captured on rising TCK edge
TDI - cpu input, data, captured on rising TCK edge during data xfer
TDO - cpu output, useful to capture so you're not working blind
RTCK - cpu output, optional to capture: it should follow TCK if all is well

It's essentially SPI mode 0, but with two MOSI signals (TMS and TDI)
and one MISO (TDO). RTCK is an acknowledge of TCK, and mostly relevant
when connecting to older (pre-Cortex) ARM cores since they
resynchronize TCK to their core clock (so if their clock can change,
e.g. due to power management, you need to watch RTCK to ensure you're
not going too fast).

See also http://e2e.ti.com/support/arm/sitara_arm/f/791/p/385704/1377250#1377250
for some diagrams and explanation (pictures always help).
