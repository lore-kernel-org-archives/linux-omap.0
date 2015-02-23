From: "Devshatwar, Nikhil" <nikhil.nd-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] dtc: parser: Add label while overriding nodes
Date: Mon, 23 Feb 2015 06:01:26 +0000
Message-ID: <E60A9E1B4132A24DB80BD56ABC9268473504C6B1@DBDE04.ent.ti.com>
References: <1424378462-22105-1-git-send-email-nikhil.nd@ti.com>
 <20150223014813.GB4536@voom.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150223014813.GB4536-1s0os16eZneny3qCrzbmXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: "jdl-CYoMK+44s/E@public.gmane.org" <jdl-CYoMK+44s/E@public.gmane.org>, "devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: David Gibson [mailto:david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org]
> Sent: Monday, February 23, 2015 7:18 AM
> To: Devshatwar, Nikhil
> Cc: jdl-CYoMK+44s/E@public.gmane.org; devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v2] dtc: parser: Add label while overriding nodes
> 
> On Fri, Feb 20, 2015 at 02:11:02AM +0530, Nikhil Devshatwar wrote:
> > This patch changes the dtc grammar to allow following syntax
> >
> > i2cexp: &i2c2 {
> >     ...
> > };
> >
> > Current device tree compiler allows to define multiple labels when
> > defining the device node the first time. Typically device nodes are
> > defined in DTSI files. Now these nodes can be overwritten for
> updating
> > some of the properties. Typically, device nodes are overridden in DTS
> files.
> >
> > When working with adapter boards, most of the time adapter board can
> > fit to multiple base boards. But depending on which base board it is
> > connected to, the devices on the adapter board would be children of
> different devices.
> >
> > e.g. On dra7-evm.dts, i2c2 is exported for expansion connector
> whereas
> > on dra72-evm.dts, i2c5 is exported for expansion connector.
> > This causes a problem when writing a generic device tree file for the
> > adapter board. Because, you cannot know whether all the devices on
> > adapter board are present on i2c or i2c5.
> >
> > The problem can be solved by adding a common label (e.g. i2cexp) in
> > both of the DTS files when overriding the device nodes for i2c2 or
> i2c5.
> > This way, generic adapter board file would override the i2cexp. And
> > depending on which base board you use the adapter board, all the
> > devices are automatically added for correct device nodes.
> >
> > Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
> 
> Applied, thanks.
> 
OK, thanks, that's first upstream contribution!

> I did tweak the testcase to use dtbs_unordered_equal instead of going
> through the set of tree1 tests.
> 
> The fact that you can only apply a single label by this method is a bit
> of a wart, but it's something we can fix later.  I had a look at it and
> (as I suspect you already discovered) it's surprisingly complicated to
> do so.
Yes, but for now even one label can suffice the needs of the problem

> 
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_
> _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
--
To unsubscribe from this list: send the line "unsubscribe devicetree-compiler" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
