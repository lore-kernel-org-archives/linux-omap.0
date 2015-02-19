From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Thu, 19 Feb 2015 10:56:24 +0100
Message-ID: <CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
 <20150216175826.GT2531@atomide.com> <CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
 <CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
 <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com> <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:40275 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbBSJ4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 04:56:46 -0500
Received: by wesx3 with SMTP id x3so6200765wes.7
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2015 01:56:45 -0800 (PST)
In-Reply-To: <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On 19 February 2015 at 03:16, Grazvydas Ignotas <notasas@gmail.com> wrote:
> It turns out 050, 054 and 058 (but only them) are actually documented
> in dm3730 manual and are part of Emulation Pin Manager. 058 works as
> you (and the manual) describe, however claiming and enabling EPM
> registers still doesn't enable writing to 030 :(

Ah, bummer.

> OK thanks for all the info. I've tested a spare floating pin by muxing
> it as a GPIO on my dm3730 and it works as you describe, nice.
> Hopefully this also applies to jtag pins there.

At least on the am335x disabling RXEN of the TMS pin rendered JTAG
inoperable, which means it looks like the technique will at least work
there.  I'm now working on a test to see if it really works.  Once
done it shouldn't be too hard to adapt to the dm37xx: the padconf
registers are different obviously, but the bitbang sequence will be
almost the same (just a different ICEPick register), at least if
setting debug-enable on DAP's tap control register suffices. If it
turns out you really need to write to the DAPCTL registers themselves
via JTAG, that will be a bit more work...

> Ok, sounds like I need to find and get rid of that 10k resistor, or
> connect the pad to 1.8V. It's just a shame that there doesn't seem to
> be a way to do it purely in software so that other pandora users could
> have hardware watchpoints.

You can solder-blob a path from nTRST to Vref via other input pads
(which all need to be high, but they should already be pulled up
anyway), as long as you avoid GND and the outputs (TDO and RTCK).
Though I'm not sure that's a good idea considering it looks like
there's a ground plane running between the pads...

Anyhow, I'm currently testing just with nTRST connected to Vref, and
TDO to some GPIO for monitoring.


> If you could share the programming sequence it would be great.

Working on it!

When you manage to get nTRST (and the other all relevant inputs: TMS,
TDI, TCK) high, you can first try simple tests:
(all this should be done by via INPUTENABLE of the pads):
1. nTRST low, TMS and TDI high, toggle TCK a bunch of times (at least
five rising edges) and end with TCK low.
2. nTRST high, TMS low, and start toggling TCK.  If all is well,
sooner or later (possible right away), the processor's RTCK output
should start following TCK.  If this is the case, then you can pretty
much start doing the victory-dance ;-)  When you stop toggling, make
sure you end with TCK low.
3. If you also want to see TDO in action, perform the following
sequence: TMS high, one TCK pulse (high-low), TMS low again, and start
toggling TCK: after two pulses the processor should start driving TDO
and the 32-bit JTAG ID should emerge from it, after which TDO remains
high. To exit data mode and return to idle state again, give two TCK
pulses with TMS high. TDO will go high-Z again (after the first TCK
pulse already in fact).
4. The final pin to test is TDI: repeat step 3, but occasionally
change TDI in between clock pulses. JTAG uses shift registers for
everything, so after outputting the 32-bit JTAG ID it will actually
start repeating the input you provided, but with 32 cycles delay. When
you exit data mode, the JTAG ID register will discard the data you
provided.
