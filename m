From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Wed, 18 Feb 2015 01:37:55 +0200
Message-ID: <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
	<20150216175826.GT2531@atomide.com>
	<CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133ae122f97dd050f5131b6
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:40201 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbBQXh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2015 18:37:57 -0500
Received: by lbdu10 with SMTP id u10so7603133lbd.7
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2015 15:37:55 -0800 (PST)
In-Reply-To: <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

--001a1133ae122f97dd050f5131b6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2015 at 8:43 PM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
>
> This really sucks since without it you can't use debug monitor
> functionality such as hardware breakpoints and watchpoints, or have an
> aux core (e.g. a cortex-m3) perform halting debug on the main core.
> I've actually considered asking for a hardware patch on our board to
> allow it to self-jtag via gpio just to enable that stupid bit
> (basically everything else is memory-mapped).

I absolutely agree.

> (As a random note, on the am335x the JTAG pins have pinconf registers,
> in that case it may suffice to externally pull/drive all pins up and
> then toggle the RXEN bit in software, given that even the (warm) reset
> pin responds to such manipulation.)

DM3730 (equivalent to OMAP3630) that I'm using also has pinconf
registers on all JTAG pins, and there are external pullups on my
board. So I guess you mean performing I/O by quickly
enabling/disabling the pulldowns? Would that satisfy any timing
requirements? I doubt pinmux register access would be fast from the
CPU (OMAP3 is known not to be a good GPIO bitbanger even).

And what is RXEN bit? I can't find it referenced anywhere (and I'll
admit I don't have experience with hardware debuggers).

On Mon, Feb 16, 2015 at 10:09 PM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
> On 15 February 2015 at 22:30, Grazvydas Ignotas <notasas@gmail.com> wrote=
:
>> "The DBGEM signal on the Cortex-A8 is driven by setting bit 13 at
>> address 0x5401 D030 in the DAP-APB address space."
>
> The register is apparently, for some reason, called DAP_PC_FER
> according to some notes of mine (I have no idea anymore where I got
> these from) listing a few DAPCTL registers:
>
> //      dap_pc_fer      APB     0xd401d030      ;DAP_PC for Cortex-A8
> //      dap_pc_ime      APB     0xd401d034      ;DAP_PC for IME
> //      dap_pc_ilf      APB     0xd401d038      ;DAP_PC for ILF
> //      dap_pc_vlc      APB     0xd401d03c      ;DAP_PC for VLC
> //      dap_pc_core     APB     0xd401d040      ;DAP_PC for Core

Interesting.

>> However regardless of how hard I try the writes to that register seem
>> to be ignored.
>
> Just checking... it's possible of course that DAPCTL tries to be
> coresight-compatible and has a lock_access register at 0x5401dfb0 to
> which you need to write 0xc5acces5. To be safe you can first check
> whether 0x5401dfb4 (lock_status) reads 3 before doing so (and it
> should then become 1).

It doesn't seem to be, trying to access these registers (tried reading
and writing) results in data abort..

> Debuggers generally don't need to worry about
> it since access via APB-AP (with bit 31 / MReqDebug set) bypasses such
> locks.
>
> A dump of all non-zero registers in DAPCTL (the 4KB block at
> 0x5401d000) might be interesting.

Attached, fault means external data abort (or at least that's what
Linux kernel calls it).
Note that it was done with Linux kernel running, with chip low power
states enabled and everything.

>> It seems others had this problem too, and TI is as helpful as ever:
>> http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/30011=
/104527
>
> (The reply post is weird though, since you don't need DBGEN for
> performance counters, but I'm not gonna bump a thread from 2009)

Yes, the performance counters are working fine already.

>> 0x5401D030 is referenced by some OpenOCD scripts, so I guess it's
>> writeable over jtag, but not by the CPU(s).
>
> If a write is done to that address as-is (via either AHB-AP or
> APB-AP), rather than an APB-AP write with bit 31 set, then I think you
> should be able to write it from the processor too.  If so, it means
> access is unlocked by some previous step such as my main worry, bit 13
> (DEBUGENABLE) of ICEPick debug tap 3 control.
>
> You can try writing it from the cortex-a8 while a debugger is
> connected (if using CCS you can connect to DAP without connecting to
> the Cortex-A8, in which case it shouldn't get confused if you mess
> with DBGEN. OpenOCD doesn't support this afaik so it'll probably get
> confused... well so be it)
>
> If you have an FTDI-based debugger (preferably an XDS100v2) I can
> provide a little test tool to directly manipulate ICEPick registers to
> futher test this theory. (Alternatively, driving nTRST high and
> bit-banging TMS and TDI can do the job too, the sequence isn't very
> long I think)

Unfortunately I don't have any hardware debuggers.
I could try the bitbang method if you think it can work, although my
board (openpandora) has a 10K pulldown resistor on nTRST that I'm not
sure OMAP's internal pullup would win over. Is there any way to check
if anytihng works from the CPU?
Maybe I could modify my board, I could connect some spare GPIO pads to
jtag pads, but I don't know if it's even worth trying.


Gra=C5=BEvydas

--001a1133ae122f97dd050f5131b6
Content-Type: text/plain; charset=US-ASCII; name="dm3730_5401d000.txt"
Content-Disposition: attachment; filename="dm3730_5401d000.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i69wwzvj0

NTQwMWQwMDAgMDAwMDAwMTAKNTQwMWQwMDQgZmF1bHQKNTQwMWQwMDggZmF1bHQKNTQwMWQwMGMg
ZmF1bHQKNTQwMWQwMTAgMDAwMDAwMDAKNTQwMWQwMTQgZmF1bHQKLi4uCjU0MDFkMDJjIGZhdWx0
CjU0MDFkMDMwIDAwMjAwMDI2CjU0MDFkMDM0IDAwMjIwMDAyCjU0MDFkMDM4IDAwMjIwMDAyCjU0
MDFkMDNjIDAwMjIwMDAyCjU0MDFkMDQwIDAwMjAwMDI0CjU0MDFkMDQ0IGZhdWx0CjU0MDFkMDQ4
IGZhdWx0CjU0MDFkMDRjIGZhdWx0CjU0MDFkMDUwIDAwMDAwMDAwCjU0MDFkMDU0IDAwMDAwMDAw
CjU0MDFkMDU4IDIwMDAwMDAwCjU0MDFkMDVjIGZhdWx0Ci4uLgo1NDAxZGZjYyBmYXVsdAo1NDAx
ZGZkMCAwMDAwMDAwMAo1NDAxZGZkNCAwMDAwMDAwMAo1NDAxZGZkOCAwMDAwMDAwMAo1NDAxZGZk
YyAwMDAwMDAwMAo1NDAxZGZlMCAwMDAwMDA0Mwo1NDAxZGZlNCAwMDAwMDA3Mwo1NDAxZGZlOCAw
MDAwMDAwOQo1NDAxZGZlYyAwMDAwMDAwMAo1NDAxZGZmMCAwMDAwMDAwZAo1NDAxZGZmNCAwMDAw
MDBmMAo1NDAxZGZmOCAwMDAwMDAwNQo1NDAxZGZmYyAwMDAwMDBiMQo=
--001a1133ae122f97dd050f5131b6--
