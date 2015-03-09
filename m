From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 14:20:16 -0700
Message-ID: <20150309212016.GI5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com>
 <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <binmlist@gmail.com>
Cc: balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <binmlist@gmail.com> [150309 14:17]:
> On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
> >> Hi,
> >>
> >> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> > Add a minimal driver for dm816x USB. Otherwise we can just use
> >> > the existing musb_am335x and musb_dsps on dm816x.
> >>
> >> dm816x has the almost identical usbss as that in am335x, we should be
> >> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
> >
> > Tony's using the same musb glue layers, this is just a phy driver,
> > right ?
> 
> Can the current am335x phy driver be adopted too? I remember it is
> under drivers/usb/phy/.

Yes this is just the phy, other than that things work the same.

I believe this is different from the am335x phy, and more similar to
what we have in old drivers/usb/musb/davinci.c. Chances are dm814x
is same as am335x phy.

But yeah, we really should do a proper phy driver for am335x too
along the same lines. Might even be be able to combine those drivers
with just different compatible values to set the quirks and the
enable/disable functions.

Regards,

Tony
