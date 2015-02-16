From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Mon, 16 Feb 2015 21:09:01 +0100
Message-ID: <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63004 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbBPUJX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2015 15:09:23 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so28427044wid.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2015 12:09:22 -0800 (PST)
In-Reply-To: <20150216175826.GT2531@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 15 February 2015 at 22:30, Grazvydas Ignotas <notasas@gmail.com> wrote:
> "The DBGEM signal on the Cortex-A8 is driven by setting bit 13 at
> address 0x5401 D030 in the DAP-APB address space."

The register is apparently, for some reason, called DAP_PC_FER
according to some notes of mine (I have no idea anymore where I got
these from) listing a few DAPCTL registers:

//      dap_pc_fer      APB     0xd401d030      ;DAP_PC for Cortex-A8
//      dap_pc_ime      APB     0xd401d034      ;DAP_PC for IME
//      dap_pc_ilf      APB     0xd401d038      ;DAP_PC for ILF
//      dap_pc_vlc      APB     0xd401d03c      ;DAP_PC for VLC
//      dap_pc_core     APB     0xd401d040      ;DAP_PC for Core


> However regardless of how hard I try the writes to that register seem
> to be ignored.

Just checking... it's possible of course that DAPCTL tries to be
coresight-compatible and has a lock_access register at 0x5401dfb0 to
which you need to write 0xc5acces5. To be safe you can first check
whether 0x5401dfb4 (lock_status) reads 3 before doing so (and it
should then become 1). Debuggers generally don't need to worry about
it since access via APB-AP (with bit 31 / MReqDebug set) bypasses such
locks.

A dump of all non-zero registers in DAPCTL (the 4KB block at
0x5401d000) might be interesting.

> It seems others had this problem too, and TI is as helpful as ever:
> http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/30011/104527

(The reply post is weird though, since you don't need DBGEN for
performance counters, but I'm not gonna bump a thread from 2009)

> 0x5401D030 is referenced by some OpenOCD scripts, so I guess it's
> writeable over jtag, but not by the CPU(s).

If a write is done to that address as-is (via either AHB-AP or
APB-AP), rather than an APB-AP write with bit 31 set, then I think you
should be able to write it from the processor too.  If so, it means
access is unlocked by some previous step such as my main worry, bit 13
(DEBUGENABLE) of ICEPick debug tap 3 control.

You can try writing it from the cortex-a8 while a debugger is
connected (if using CCS you can connect to DAP without connecting to
the Cortex-A8, in which case it shouldn't get confused if you mess
with DBGEN. OpenOCD doesn't support this afaik so it'll probably get
confused... well so be it)

If you have an FTDI-based debugger (preferably an XDS100v2) I can
provide a little test tool to directly manipulate ICEPick registers to
futher test this theory. (Alternatively, driving nTRST high and
bit-banging TMS and TDI can do the job too, the sequence isn't very
long I think)

> It's quite a mysterious otherwise undocumented register

Debug and crypto are two areas where the (otherwise usually quite
good) public documentation of TI SoCs is unfortunately sorely lacking.
This is a shame, since both are useful in nearly all application
domains. My guess is that these two subjects are secretive since info
about them (shouldn't but) might help people copy netflix films off
their smartphone or whatever. Perhaps now that omapgeddon has come to
pass they might open up on these topics, but that may just be wishful
thinking.

Fortunately info about these subsystems leaks out of TI all over the
place, but scraping bits and pieces from many sources together and
filling in the blanks with empirical science takes more time than one
ought to have to spend on it.



On 16 February 2015 at 18:58, Tony Lindgren <tony@atomide.com> wrote:
> The perf counter on omap3 used to work, but is buggy at least on
> 3430 because it eventually stops producing interrupts because of
> some bug in the Cortex-A8 version being used.

Of course the workaround of polling the counters at least once per
2^31 clock cycles to detect when they wrap (or in general keep local
64-bit copies up-to-date) is not really a huge burden.


>> 0x5401D030 is referenced by some OpenOCD scripts, so I guess it's
>> writeable over jtag, but not by the CPU(s). It's quite a mysterious
>> otherwise undocumented register, I've noticed it's bit21 is some
>> status bit related to Cortex-A8's low power states.
>
> Have you checked the Cortex-A8 documentation for the debugger?
> It seems that's where they should be documented.

DAPCTL is a TI-specific debug peripheral, it's not from ARM or related
to the Cortex-A8 specifically.
