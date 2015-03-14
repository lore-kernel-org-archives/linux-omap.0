From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Sat, 14 Mar 2015 22:04:24 +0100
Message-ID: <CAALWOA_FM71OsvCfPuz4DHwGDEpfxcSB4L+YdoCsJuZkukK2iw@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com> <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com> <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com> <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
 <20150309214129.GK5264@atomide.com> <CAALWOA-sdLzUP8_6BKvsDQeAqxCw5-n410u3=W3D5yaCLYChbQ@mail.gmail.com>
 <20150313193058.GN5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150313193058.GN5264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 13 March 2015 at 20:30, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Hmm OK have to check that. It could also be that dm816x documentation
> is copy-paste from da850 or am3517 and the PHY got changed in the
> hardware as the registers don't match the documentation. Only the
> dm816x errata has right documentation for the USB PHY.

Hmm? While I see plenty of usb errata (mostly DMA bugs), I don't see
anything about registers being different.

I do see something curious: advisory 70, the only PHY-related erratum
I see, is also present in the DM814x errata and even in AM335x r1.0.
This strongly suggests the PHYs must at least be closely related...

The dm816x TRM makes three separate mentions of the synopsys usb phy
though, while I found no other TRMs that mention it, so if it's a
copy-paste error (which certainly would not be exceptional) I don't
know where from.

I suppose it's still possible TI acquired a sufficiently permissive
license for the synopsys phy to fork it and call it a "TI PHY" as they
do in the AM335x docs. (No mention of its origin is made in the DM814x
docs.)

BTW, da850? Is that yet another instance of Primus? (i.e.
omap-L1xx/c674x/am1xxx with odd final digit, also da830/da828)

Matthijs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
