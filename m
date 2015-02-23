From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Mon, 23 Feb 2015 12:52:06 +0100
Message-ID: <CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
 <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
 <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com> <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:51500 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbBWLw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2015 06:52:28 -0500
Received: by mail-wi0-f180.google.com with SMTP id h11so15952951wiw.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2015 03:52:27 -0800 (PST)
In-Reply-To: <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

At least on the am335x, the trick actually works!  I have a working
demo which configures ICEPick registers and even performs transactions
on the debug interconnect.

I've been lazy and imported a bunch of files from my baremetal
projects so I could easily mess with the hardware, rudely bypassing
the kernel.  The whole implementation is hideous in all sorts of ways,
but it gets the job done: https://github.com/dutchanddutch/jbang

The key part, how to bitbang JTAG, is reasonably isolated from all
this in src/jbang.cc and glues onto the device-specific part via
hw-subarctic.h.  You could probably also turn jbang.cc into plain C
without too much effort and discard the rest... I accept that my code
style is probably a bit of an acquired taste ;-)

For the omap3, apart from the differences in padconf details, you'll
want to change icepick_init_regs[] to just { 0x23002100 } I think and
hopefully you can then write the DAPCTL regs using ap_write().

I hope this example is of any help.

Matthijs
