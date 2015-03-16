From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 16 Mar 2015 22:16:49 +0100
Message-ID: <CAALWOA-oynZi-L=iUrvVCAFQ0bXLSwdqpNV5qKakCdUU0M7rHw@mail.gmail.com>
References: <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com> <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com> <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com> <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
 <20150313193058.GN5264@atomide.com> <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
 <20150316164951.GR5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316164951.GR5264@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bin Liu <binmlist@gmail.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

*gets increasingly confused*

The datasheet (sprs614e) only contains register addresses, and they
seem to match the TRM's USB chapter.  The only disagreement I can spot
is related to USB_CTRL register(s) in the control module (offsets
0x620 and 0x628) where
* the TRM claims both exist in the control module chapter (1.16.1.3),
one for each both
* the TRM's USB chapter claims only one exists, and its layout
(24.9.8.2) doesn't resemble the former one
* the datasheet agrees only one exists (but gives no layout)
* reality seems to disagree with both: I booted up our evm816x,
plugged in a mouse to confirm USB is functional, and attached JTAG:
both registers read as zero (contradicting both layouts) and appear to
ignore writes.

There doesn't seem to be any disagreement in the docs about the
USBPHY_CTRL regs (offsets 0x624 and 0x62c in control module) as far as
I can tell, and the documented reset values also match what I see via
JTAG.

> But dm814x [..] seems to be wired up like am335x.

This I mentioned: the only difference is related to GPIO mode (which
on the dm814x yields exactly that: GPIO, while the am335x uses it to
hook up UARTs).

> Yes I checked am3517 trm, and that too mentions Synopsys once

Only in its ECHI/OCHI host controller, not the OTG one...


Anyhow, I didn't expect this small observation to end up becoming a
device archeology expedition, sorry about that ;-)


>> BTW, da850? Is that yet another instance of Primus? (i.e.
>> omap-L1xx/c674x/am1xxx with odd final digit, also da830/da828)
>
> Yes it's the arm926 based series, l-138 is da850 I believe.

Ah, but there are two such series: Freon and Primus. Just to be
different, their part numbers are both allocated from the omap-L1xx
(arm+dsp) / tms320c674x (dsp only) / am1xxx (arm only) ranges, but
distinguished by Freon having even final digit while Primus has odd
final digit. Of course this doesn't hold for the da8xx parts, that
would be too consistent.

But you're right, da850 indeed seems to be a Freon rather than a
Primus based on some more googling (apparently da850 has SATA --
Primus doesn't).

Matthijs

On 16 March 2015 at 17:49, Tony Lindgren <tony@atomide.com> wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150314 14:04]:
>> On 13 March 2015 at 20:30, Tony Lindgren <tony@atomide.com> wrote:
>> > Hmm OK have to check that. It could also be that dm816x documentation
>> > is copy-paste from da850 or am3517 and the PHY got changed in the
>> > hardware as the registers don't match the documentation. Only the
>> > dm816x errata has right documentation for the USB PHY.
>>
>> Hmm? While I see plenty of usb errata (mostly DMA bugs), I don't see
>> anything about registers being different.
>
> Sorry it seems to be the partially updated TRM instead, it's the
> sprs614e.pdf instead. That has the USBPHY_CTRL registers right.
> No mention of Synopsys in sprs614e.pdf though so who knows. It
> seems something got swapped compared to the TRM as the USB_CTRL
> registers totally changed.
>
> I'll just add a comments you mentioned earlier about it probably
> being Synopsys phy.
>
>> I do see something curious: advisory 70, the only PHY-related erratum
>> I see, is also present in the DM814x errata and even in AM335x r1.0.
>> This strongly suggests the PHYs must at least be closely related...
>
> Hmm interesting. But dm814x has again different USB_CTRL registers,
> seems to be wired up like am335x. Also there's no USBPHY_CTRL
> registers on dm814x or am335x. Chances are that dm814x is wired up
> the same way as am335x.
>
>> The dm816x TRM makes three separate mentions of the synopsys usb phy
>> though, while I found no other TRMs that mention it, so if it's a
>> copy-paste error (which certainly would not be exceptional) I don't
>> know where from.
>
> Yes I checked am3517 trm, and that too mentions Synopsys once, but
> has different registers. And also checked the l-138/da850 TRM, and
> that does not have USB_CTRL and USBPHY_CTRL registers either.. Looks
> like the copy paste errors come from tms320dm6446.pdf that has
> the USB_CTRL and USBPHY_CTRL registers, but then no mention of
> Synopsys.
>
>> I suppose it's still possible TI acquired a sufficiently permissive
>> license for the synopsys phy to fork it and call it a "TI PHY" as they
>> do in the AM335x docs. (No mention of its origin is made in the DM814x
>> docs.)
>>
>> BTW, da850? Is that yet another instance of Primus? (i.e.
>> omap-L1xx/c674x/am1xxx with odd final digit, also da830/da828)
>
> Yes it's the arm926 based series, l-138 is da850 I believe.
>
> Regards,
>
> Tony
