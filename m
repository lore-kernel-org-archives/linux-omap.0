From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 16 Mar 2015 19:19:19 -0700
Message-ID: <20150317021919.GA31346@atomide.com>
References: <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com>
 <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com>
 <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
 <20150313193058.GN5264@atomide.com>
 <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
 <20150316164951.GR5264@atomide.com>
 <CAALWOA-oynZi-L=iUrvVCAFQ0bXLSwdqpNV5qKakCdUU0M7rHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA-oynZi-L=iUrvVCAFQ0bXLSwdqpNV5qKakCdUU0M7rHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Bin Liu <binmlist@gmail.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150316 14:17]:
> *gets increasingly confused*

:)
 
> The datasheet (sprs614e) only contains register addresses, and they
> seem to match the TRM's USB chapter.  The only disagreement I can spot
> is related to USB_CTRL register(s) in the control module (offsets
> 0x620 and 0x628) where
> * the TRM claims both exist in the control module chapter (1.16.1.3),
> one for each both
> * the TRM's USB chapter claims only one exists, and its layout
> (24.9.8.2) doesn't resemble the former one

Yes the second entry is the closest thing to a documentation
here it seems.

> * the datasheet agrees only one exists (but gives no layout)
> * reality seems to disagree with both: I booted up our evm816x,
> plugged in a mouse to confirm USB is functional, and attached JTAG:
> both registers read as zero (contradicting both layouts) and appear to
> ignore writes.

Yes so it seem here too, this is dm816x rev c, what do you have?

Anyways, I'll add a note that at least rev c does not seems to do
anything with USB_CTRL but that we follow what the TI tree is doing
in case some other revisions of the hardware use it.
 
> There doesn't seem to be any disagreement in the docs about the
> USBPHY_CTRL regs (offsets 0x624 and 0x62c in control module) as far as
> I can tell, and the documented reset values also match what I see via
> JTAG.

Yes agreed.

> > But dm814x [..] seems to be wired up like am335x.
> 
> This I mentioned: the only difference is related to GPIO mode (which
> on the dm814x yields exactly that: GPIO, while the am335x uses it to
> hook up UARTs).
> 
> > Yes I checked am3517 trm, and that too mentions Synopsys once
> 
> Only in its ECHI/OCHI host controller, not the OTG one...

Oh OK I missed that part.
 
> Anyhow, I didn't expect this small observation to end up becoming a
> device archeology expedition, sorry about that ;-)

Well thanks for spotting the weirdness :) 
 
> >> BTW, da850? Is that yet another instance of Primus? (i.e.
> >> omap-L1xx/c674x/am1xxx with odd final digit, also da830/da828)
> >
> > Yes it's the arm926 based series, l-138 is da850 I believe.
> 
> Ah, but there are two such series: Freon and Primus. Just to be
> different, their part numbers are both allocated from the omap-L1xx
> (arm+dsp) / tms320c674x (dsp only) / am1xxx (arm only) ranges, but
> distinguished by Freon having even final digit while Primus has odd
> final digit. Of course this doesn't hold for the da8xx parts, that
> would be too consistent.

I can't keep up with these part numbers..
 
> But you're right, da850 indeed seems to be a Freon rather than a
> Primus based on some more googling (apparently da850 has SATA --
> Primus doesn't).

OK

Regards,

Tony
