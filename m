From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Thu, 26 Feb 2015 05:01:50 +0100
Message-ID: <CAALWOA8k44uQvQK18qvGRgOYDY3n5xKow4t94c+FyH8u79_BBw@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
 <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
 <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
 <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
 <CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com> <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42306 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbbBZECM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 23:02:12 -0500
Received: by wghl2 with SMTP id l2so7579186wgh.9
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 20:02:10 -0800 (PST)
In-Reply-To: <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 26 February 2015 at 02:09, Grazvydas Ignotas <notasas@gmail.com> wrote:
> And hey, it worked too with your code modified to use
> USB Blaster in it's bitbang mode over libftdi. This setup also works
> with openocd, but somewhat unreliably (only occasionally gets through
> init, often gets register values it doesn't like).

I've never had much luck with OpenOCD either... it doesn't handle
ICEPick very well, nor DAP for that matter: e.g. you can't connect to
DAP without also connecting to a processor, and it can't deal with
WAIT responses so you need to configure it to worst-case timings
(nearly impossible to estimate) or hope AP responses never get delayed
due to interconnect congestion or clock speed changes.

> Anyway I'm attaching my code too

Ah, if this works then apparently the omap3 control module doesn't
check privilege.

BTW, is this comment in hw-omap3.h true?

> 0x23'002100, // assert cortex-a8 DBGEN

My impression was that bit 13 of DAP's tap control register either
does nothing or at most enables the DAPCTL registers to be written,
but that setting bit 13 of the DAP_PC_FER register would still be
needed to assert DBGEN.

Also,

> // address of cortex-a8 debug regs on debug APB
> constexpr u32 a8_debug = 0x54011'000;

If bit 31 isn't set, then these writes should (afaik) be equivalent to
just performing them directly through the interconnect instead of
using JTAG.

I should maybe have mentioned that without TDO, my example doesn't
actually verify debug authentication status. It does perform a test
that debug APB writes are working by using the debug communications
channel, but I don't think this requires DBGEN to be asserted.
