From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Sun, 1 Mar 2015 02:52:44 +0100
Message-ID: <CAALWOA8naXSr018yNBR24pMuLup7Ye6+J-dDn9dpDU2gi0uKTA@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
 <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
 <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
 <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
 <CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com>
 <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
 <CAALWOA8k44uQvQK18qvGRgOYDY3n5xKow4t94c+FyH8u79_BBw@mail.gmail.com> <CANOLnOMSbAM1bnAPFQt4Pk-rzZMS=q8Uu62F_x=hxBCLqCu2rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:36272 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbCABxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2015 20:53:07 -0500
Received: by wevk48 with SMTP id k48so27021206wev.3
        for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2015 17:53:05 -0800 (PST)
In-Reply-To: <CANOLnOMSbAM1bnAPFQt4Pk-rzZMS=q8Uu62F_x=hxBCLqCu2rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 1 March 2015 at 01:03, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Thu, Feb 26, 2015 at 5:14 AM, Matthijs van Duin wrote:
>> If you want guaranteed reliability, modify tck_pulse() to insert
>> aforementioned barrier + an actual delay at all three points where I
>> put comments about them.  usleep(50) or so should do the job.
>
> Adding just the barrier works reliably for me, even at 1GHz.

Yeah I just realized that usleep is a bit larger than I intended... by
a factor 1000. Whoops :) In fact even 50 ns would be excessive but I
wanted to be on the safe side.  It doesn't surprise me that sending
(and waiting for) a ping all the way to the L4WK suffices in practice.

>> Ah, if this works then apparently the omap3 control module doesn't
>> check privilege.
>
> Yeah, even OMAP5 doesn't do it for me.

Hmm, based on a quick browse of TRMs, this restriction indeed seems specific to
centaurus, subarctic, and aegis. Curious.


>> If bit 31 isn't set, then these writes should (afaik) be equivalent to
>> just performing them directly through the interconnect instead of
>> using JTAG.
>
> I don't know about that... To enable DBGEN, I just do:
> ap_write( 0x5401d030, 0x00002000 );
> and it works. Using 0xd401d030 seems to work too.

That's... unexpected.

Normally on a CoreSight debug APB, bit 31 identifies requests as
coming from the debugger. It would normally set it, but can clear it
to simulate application (= non-debug) access.

An example of this difference is that application code typically needs
to unlock access to a CoreSight debug peripheral before it can write
to them, while debuggers are exempt. This is reflected in the
LOCKSTATUS register:
00001fb4: 00000003   // lock present and engaged
80001fb4: 00000000   // no lock present

TI SoCs don't really have a debug APB as such, instead the APB-AP
routing on e.g. centaurus and subarctic is:
if( ( addr & 0x7ff'ff'000 ) == 0x000'40'000 ) {
        target = dap_cs_rom;
        addr &= 0xfff;
} else {
        target = l4emu;
        debug = addr >> 31;  // OCP MReqDebug signal
        addr &= 0x3f'fff;
}
with MReqDebug mapped back to bit 31 for APB targets.

Maybe the omap3 ignores bit 31, or it might be a quirk of DAPCTL to
check the initiator id rather than MReqDebug.

(Note BTW that using the L3 address happens to work in this case
because the higher bits are ignored. It might however cause an
unsuspecting reader to not realize that the APB-AP has a very
different address space and targets outside the L4EMU are not
reachable through it.)

> Thanks again,

You're welcome!
