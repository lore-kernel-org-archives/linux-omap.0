From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Thu, 19 Feb 2015 04:16:07 +0200
Message-ID: <CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
	<20150216175826.GT2531@atomide.com>
	<CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
	<CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
	<CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34801 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbBSCQJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2015 21:16:09 -0500
Received: by labhs14 with SMTP id hs14so5075524lab.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2015 18:16:07 -0800 (PST)
In-Reply-To: <CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On Wed, Feb 18, 2015 at 5:00 AM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
>
> 030-040 are the core debug control regs... in fact, judging by their
> values and the fact you mentioned bit 13 controls DBGEN, these regs
> look very much like the ICEPick-D core debug control regs, which
> themselves are simplified versions of debug TAP control registers (fo=
r
> which you can find the layout in the dm3730 TRM's debug chapter).
>
> 050 and 054 are unknown, but 058 reads 0x20000000 which suggests it
> may have an ownership claim command register there. Try writing
> 0x40000000 to it, if that succeeds and it reads back 0x70000000 then
> you're successfully claimed ownership which hopefully means you can
> then write to other regs too, although they may not take effect unles=
s
> you enable the module by writing 0x80000000 to the ownership claim
> command register, after which it should read back 0xb0000000. Of
> course it's also possible it only covers registers 050 and 054,
> whatever they may be... (or it might be something else altogether)

It turns out 050, 054 and 058 (but only them) are actually documented
in dm3730 manual and are part of Emulation Pin Manager. 058 works as
you (and the manual) describe, however claiming and enabling EPM
registers still doesn't enable writing to 030 :(

>
> RXEN =3D=3D INPUTENABLE
>
> At least on the am335x, disabling it causes the processor to perceive
> the input as being low regardless of its actual level. Since the line
> itself doesn't have to change level, this can be toggled pretty fast
> probably. Using this to simulate an input does require the actual lin=
e
> level to be high obviously.

OK thanks for all the info. I've tested a spare floating pin by muxing
it as a GPIO on my dm3730 and it works as you describe, nice.
Hopefully this also applies to jtag pins there.

>> I could try the bitbang method if you think it can work, although my
>> board (openpandora) has a 10K pulldown resistor on nTRST that I'm no=
t
>> sure OMAP's internal pullup would win over.
>
> It won't, you'll need to externally drive it up, e.g. by connecting i=
t
> to the Vref pin that's also on the jtag connector.
>
>> Is there any way to check if anything works from the CPU?
>> Maybe I could modify my board, I could connect some spare GPIO pads =
to
>> jtag pads, but I don't know if it's even worth trying.
>
> If the ownership claim register doesn't work it may be worth a try, i=
f
> you're comfortable doing that. Connecting them to GPIOs will
> definitely work, though just driving the inputs high and toggling
> INPUTENABLE via padconf *may* also work and be simpler.

Ok, sounds like I need to find and get rid of that 10k resistor, or
connect the pad to 1.8V. It's just a shame that there doesn't seem to
be a way to do it purely in software so that other pandora users could
have hardware watchpoints.

If you could share the programming sequence it would be great.

Thanks again,
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
