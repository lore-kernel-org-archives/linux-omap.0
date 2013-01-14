From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Mon, 14 Jan 2013 10:06:02 -0800
Message-ID: <20130114180602.GV14149@atomide.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-6-git-send-email-zonque@gmail.com>
 <CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63865 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756827Ab3ANSGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 13:06:08 -0500
Content-Disposition: inline
In-Reply-To: <CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>

* Ezequiel Garcia <elezegarcia@gmail.com> [121223 13:49]:
> On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack <zonque@gmail.com> wrote:
> > +
> > +Example for an AM33xx board:
> > +
> > +       gpmc: gpmc@50000000 {
> > +               compatible = "ti,am3352-gpmc";
> > +               ti,hwmods = "gpmc";
> > +               reg = <0x50000000 0x1000000>;
> > +               interrupts = <100>;
> > +               gpmc,num-cs = <8>;
> > +               gpmc,num-waitpins = <2>;
> > +               #address-cells = <2>;
> > +               #size-cells = <1>;
> > +               ranges = <0 0 0x08000000 0x2000>;       /* CS0: NAND */
> > +
> > +               nand@0,0 {
> > +                       reg = <0 0 0>; /* CS0, offset 0 */
> 
> I'm a bit confused by this: what are the other two values in "reg"?
> I see you've only added a binding for CS.
> 
> I've extended a bit on your work and added a binding to enable OneNAND
> device on my IGEP board.
> 
> I might send some patches in case anyone wants to give it a try.

Daniel, should this be updated to just pass the CS?

Regards,

Tony
