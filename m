From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Thu, 26 Sep 2013 10:27:28 -0700
Message-ID: <20130926172728.GJ23337@ld-irv-0074.broadcom.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
 <CAL_Jsq+XxQ_9ik_P8EPPNSzXiCz6yd-VJLRU668t3jvD-jhyOw@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA16B0D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA16B0D-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

[I see Mark made some of the same comments while I was typing this
email]

On Thu, Sep 26, 2013 at 06:08:42AM +0000, Gupta, Pekon wrote:
> > From: Rob Herring [mailto:robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > > From: Pekon Gupta [mailto:pekon-l0cyMroinI0@public.gmane.org]
> > > diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > index df338cb..958e5d5 100644
> > > --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > @@ -21,11 +21,8 @@ Optional properties:
> > >                                 is wired that way. If not specified, a bus
> > >                                 width of 8 is assumed.
> > >
> > > - - ti,nand-ecc-opt:            A string setting the ECC layout to use. One of:
> > > -
> > > -               "sw"            Software method (default)
> > > -               "hw"            Hardware method
> > > -               "hw-romcode"    gpmc hamming mode method & romcode layout
> > > + - ti,nand-ecc-scheme:         A string setting the ECC layout to use. One of:
> > > +               "ham1"          1-bit Hamming ecc code
> > 
> > As has been pointed out, this breaks compatibility which should be
> > avoided unless you know the state of use of this binding. I fail to
> > see the advantage of using scheme over opt. You could simply add ham1
> > here and maintain compatibility. Instead of removing sw, hw, etc. you
> > can simply deprecate them or decide that the kernel doesn't support
> > those options.
> > 
> Renaming 'ti,nand-ecc-opt' to 'ti,nand-ecc-scheme' was as per earlier 
> comments from Olof. So either way is fine with me. Should I revert
> it back to 'ti,nand-ecc-opt' ?
> 
> Also, "sw", "hw_romcode" have been deprecated, they are no longer
> supported in driver. So shouldn't they be removed from the documentation ?

I think leaving them in the documentation but marking them as
"deprecated" makes sense.

> > However, since you are willing to break compatibility, then you should
> > the generic NAND binding and use nand-ecc-mode adding the values you
> > need.
> > 
> > Documentation/devicetree/bindings/mtd/nand.txt:
> > * MTD generic binding
> > 
> > - nand-ecc-mode : String, operation mode of the NAND ecc mode.
> >   Supported values are: "none", "soft", "hw", "hw_syndrome",
> > "hw_oob_first",
> >   "soft_bch".
> 
> Yes I can use generic 'nand-ecc-mode', But the binding values like
> "soft", "hw", "soft_bch" are too generic to describe the hardware.
> - BCH ECC scheme can itself be of multiple types, bch4/bch8/bch16
>   so "soft_bch" is ambiguous.
> - Similarly "soft" and "hw" do not determine the algorithm used
>    like Hamming or BCH.
> 
> (a) Should I update the generic binding values (if no one else is using) ? like 
> 	sw -> ham1_sw
> 	hw -> ham1_hw
> 	soft_bch-> soft_bch4, soft_bch8
> OR 
> (b) Should I add newer ones to it (like "ham1", "bch4", "bch8", "bch16") ?
>       keeping the old ones intact. And how should I handle un-supported
>      values, (Is pr_err during kernel probe enough ?).

The existing nand-ecc-mode binding is a bit peculiar and hard to
maintain generically for all NAND, IMO. ECC is often very specific to
each driver/controller. What's to say that a given software BCH4 library
(such as the one found in Linux) will match a given controller's HW BCH4
layout and encoding format? Perhaps Pekon's OMAP NAND driver can
straighten things out such that HW and SW ECC are interchangeable for a
given BCH mode, but we can't guarantee all drivers/controllers make this
possible.

So, what's the advantage of using this generic binding (nand-ecc-mode)
for all NAND hardware instead of defining distinct hardware-specific
bindings for different sets of hardware? The former seems like we will
clutter up the nand-ecc-mode namespace such that any one set of
hardware/software will only support a small subset of the potential
options. And it doesn't seem to win us a lot.

What's more, this single binding doesn't seem flexible enough for the
hardware I deal with. I have a NAND controller whose ECC HW can be
programmed to one of dozens of different ECC modes, parameterized by
strength (i.e., BCH-x, where x varies) and ECC step/sector size (i.e.,
each ECC block covers 512B or 1024B of data).

So I'm not convinced that extending this nand-ecc-mode property is
correct at all. But if we do want to, perhaps we'd need to introduce
additional orthogonal properties to specify strength and step size,
rather than listing all combinations as separate values for
nand-ecc-mode.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
