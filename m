From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Thu, 26 Sep 2013 18:09:28 +0100
Message-ID: <20130926170927.GI2411@e106331-lin.cambridge.arm.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
 <CAL_Jsq+XxQ_9ik_P8EPPNSzXiCz6yd-VJLRU668t3jvD-jhyOw@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA16B0D@DBDE04.ent.ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA16CEE@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56417 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896Ab3IZRJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 13:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA16CEE@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Olof Johansson <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Sep 26, 2013 at 11:54:39AM +0100, Gupta, Pekon wrote:
> 
> > > From: Rob Herring [mailto:robherring2@gmail.com]
> > > > From: Pekon Gupta [mailto:pekon@ti.com]
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > > index df338cb..958e5d5 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > > +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> > > > @@ -21,11 +21,8 @@ Optional properties:
> > > >                                 is wired that way. If not specified, a bus
> > > >                                 width of 8 is assumed.
> > > >
> > > > - - ti,nand-ecc-opt:            A string setting the ECC layout to use. One of:
> > > > -
> > > > -               "sw"            Software method (default)
> > > > -               "hw"            Hardware method
> > > > -               "hw-romcode"    gpmc hamming mode method & romcode
> > layout
> > > > + - ti,nand-ecc-scheme:         A string setting the ECC layout to use. One of:
> > > > +               "ham1"          1-bit Hamming ecc code
> > >
> > > As has been pointed out, this breaks compatibility which should be
> > > avoided unless you know the state of use of this binding. I fail to
> > > see the advantage of using scheme over opt. You could simply add ham1
> > > here and maintain compatibility. Instead of removing sw, hw, etc. you
> > > can simply deprecate them or decide that the kernel doesn't support
> > > those options.
> > >
> > Renaming 'ti,nand-ecc-opt' to 'ti,nand-ecc-scheme' was as per earlier
> > comments from Olof. So either way is fine with me. Should I revert
> > it back to 'ti,nand-ecc-opt' ?

I think that if the binding is already in use then we shouldn't break
it, unless you're _definitely_ the only user.

> > 
> > Also, "sw", "hw_romcode" have been deprecated, they are no longer
> > supported in driver. So shouldn't they be removed from the documentation
> > ?

Deprecated properties should be marked as deprecated, but continue to be
documented. That at least prevents the names being repurposed in an
incompatible way, and explains to anyone who looks at the document that
the proeprty is deprecated rather than simply undocumented.

> > 
> > > However, since you are willing to break compatibility, then you should
> > > the generic NAND binding and use nand-ecc-mode adding the values you
> > > need.
> > >
> > > Documentation/devicetree/bindings/mtd/nand.txt:
> > > * MTD generic binding
> > >
> > > - nand-ecc-mode : String, operation mode of the NAND ecc mode.
> > >   Supported values are: "none", "soft", "hw", "hw_syndrome",
> > > "hw_oob_first",
> > >   "soft_bch".
> > 
> > Yes I can use generic 'nand-ecc-mode', But the binding values like
> > "soft", "hw", "soft_bch" are too generic to describe the hardware.
> > - BCH ECC scheme can itself be of multiple types, bch4/bch8/bch16
> >   so "soft_bch" is ambiguous.

It does indeed seem like the generic properties are not generic enough,
at least from my quick look other them. However, I am not familiar with
NAND, so I may have misunderstood.

> > - Similarly "soft" and "hw" do not determine the algorithm used
> >    like Hamming or BCH.
> > 
> > (a) Should I update the generic binding values (if no one else is using) ? like
> > 	sw -> ham1_sw
> > 	hw -> ham1_hw
> > 	soft_bch-> soft_bch4, soft_bch8

What do the current property names actually correspond to logically? If
we did this and there are existing users, the old DTs need to continue
functioning.

> > OR
> > (b) Should I add newer ones to it (like "ham1", "bch4", "bch8", "bch16") ?
> >       keeping the old ones intact. And how should I handle un-supported
> >      values, (Is pr_err during kernel probe enough ?).

I think something like this, but with the names from (a) would be
preferrable.

> > 
> > [...]
> > 
> > > > - - elm_id:     Specifies elm device node. This is required to support BCH
> > > > -               error correction using ELM module.
> > > > + - ti,elm-id:  Specifies pHandle of the ELM devicetree node.
> > > > +               ELM is an on-chip hardware engine on TI SoC which is used for
> > > > +               locating ECC errors for BCHx algorithms. SoC devices which have
> > > > +               ELM hardware engines should specify this device node in .dtsi
> > > > +               Using ELM for ECC error correction frees some CPU cycles.
> > >
> > > While yes, this is better name and documentation, I don't know that
> > > breaking compatibility is justified.
> > >
> > As this is TI specific binding, so manufacturer's name should have been
> > included.  But as this was missed while adding this binding, so this should
> > be fixed now. (Olof also recommended the same).

We could update the binding to prefer ti,elm-id, and deprecate elm_id
while maintaining support in the kernel.

Thanks,
Mark.

> > 
> > AFAIK, For TI's NAND OMAP driver, currently there are not many
> > end-users are using these bindings from mainline DT kernel.
> > So this patch series mainly aims to cleanup NAND driver so that migrate
> > to latest DT based kernel from board-file one is easy.
> > So changes should be acceptable from end-user's point, its only matter
> > of which path to take.
> > Request you to please help me finalize this before I resend next patch
> > series addressing other comments from Brian.
> > 
> 
> + Mark Rutland <mark.rutland@arm.com>
> + Pawel Moll <pawel.moll@arm.com>
> + Ian Campbell <ijc+devicetree@hellion.org.uk>
> + Stephen Warren <swarren@wwwdotorg.org>
> 
> CC other DT maintainers, who were missed in this branch of mail-chain.
> 
> with regards, pekon
> 
