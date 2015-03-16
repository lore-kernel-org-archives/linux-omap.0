From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 16 Mar 2015 09:49:51 -0700
Message-ID: <20150316164951.GR5264@atomide.com>
References: <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com>
 <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com>
 <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com>
 <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
 <20150313193058.GN5264@atomide.com>
 <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Bin Liu <binmlist@gmail.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150314 14:04]:
> On 13 March 2015 at 20:30, Tony Lindgren <tony@atomide.com> wrote:
> > Hmm OK have to check that. It could also be that dm816x documentation
> > is copy-paste from da850 or am3517 and the PHY got changed in the
> > hardware as the registers don't match the documentation. Only the
> > dm816x errata has right documentation for the USB PHY.
> 
> Hmm? While I see plenty of usb errata (mostly DMA bugs), I don't see
> anything about registers being different.

Sorry it seems to be the partially updated TRM instead, it's the
sprs614e.pdf instead. That has the USBPHY_CTRL registers right.
No mention of Synopsys in sprs614e.pdf though so who knows. It
seems something got swapped compared to the TRM as the USB_CTRL
registers totally changed.

I'll just add a comments you mentioned earlier about it probably
being Synopsys phy.
 
> I do see something curious: advisory 70, the only PHY-related erratum
> I see, is also present in the DM814x errata and even in AM335x r1.0.
> This strongly suggests the PHYs must at least be closely related...

Hmm interesting. But dm814x has again different USB_CTRL registers,
seems to be wired up like am335x. Also there's no USBPHY_CTRL
registers on dm814x or am335x. Chances are that dm814x is wired up
the same way as am335x.

> The dm816x TRM makes three separate mentions of the synopsys usb phy
> though, while I found no other TRMs that mention it, so if it's a
> copy-paste error (which certainly would not be exceptional) I don't
> know where from.

Yes I checked am3517 trm, and that too mentions Synopsys once, but
has different registers. And also checked the l-138/da850 TRM, and
that does not have USB_CTRL and USBPHY_CTRL registers either.. Looks
like the copy paste errors come from tms320dm6446.pdf that has
the USB_CTRL and USBPHY_CTRL registers, but then no mention of
Synopsys.

> I suppose it's still possible TI acquired a sufficiently permissive
> license for the synopsys phy to fork it and call it a "TI PHY" as they
> do in the AM335x docs. (No mention of its origin is made in the DM814x
> docs.)
> 
> BTW, da850? Is that yet another instance of Primus? (i.e.
> omap-L1xx/c674x/am1xxx with odd final digit, also da830/da828)

Yes it's the arm926 based series, l-138 is da850 I believe.

Regards,

Tony
