From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] ARM: OMAP: Add support for USB on OMAP34XX
Date: Tue, 11 Dec 2007 08:02:31 -0800
Message-ID: <20071211160231.5DDC511270A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <010C7BAE6783F34D9AC336EE5A01A08804FE7090@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804FE7090@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: gadiyar@ti.com, ext-felipe.lima@nokia.com
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > > > > +#if defined(CONFIG_USB_MUSB_HDRC) || defined(CONFIG_USB_MUSB_HDRC_MODULE)
> > > >
> > > > What about #ifdef CONFIG_USB_MUSB_SOC
> > > >
> > >
> > > How is this relevant? Could you please elaborate?
> >
> > #if defined(*) || defined(*_MODULE) looks a bit awkward.
> > CONFIG_USB_MUSB_SOC is a boolean macro and is true in 2430 and 34XX.
> >
> > Anybody has any comments on this ??
>
> I might end up doing this in other places as well.
> Specifically, when adding EHCI, I might have something along the lines of
>
> #if defined (CONFIG_USB_EHCI_HCD) || defined (CONFIG_USB_EHCI_HCD_MODULE)
>
> Besides, it seems to be common usage anywhere you have something that can
> be built as a module.

It's common usage only when it's the best solution available.

When there's a single boolean symbol available (as in this
case), the simple #ifdef seems clearly better....


> > > > > +extern void __init sdp3430_usb_init(void);
> > > >
> > > > This extern will look better in
> > > > include/asm-arm/arch-omap/board-3430sdp.h
> > >
> > > Yes. But there are other .c files in arch/arm/mach-omap2
> > > that declare externs.
> > > Specifically, board-2430sdp.c also does it this way. I
> > > thought it would be a good idea to retain the same structure.
> > >
> > > I can move it to the .h file if needed. What do you think?
> >
> > Don't know about the others, but I'd prefer seeing this
> > prototype in the header file.
>
> Ok. No problem moving it to the .h file. Anyone else thinks this way?

Yes.  Don't perpetuate bad idioms.  I'm fairly convinced this
one happens out of laziness ... I know that's been the reason
I've done it on occasion, just to avoid a larger rebuild.

Prototypes should be in header files so that there is only one
copy, so that when the signature changes it's easier to catch
all the code that relies on the old version.


> Also what about the other externs in board*.c files?

They're all bugs that should be fixed at a convenient time.
Sooner is better, so fewer folk are tempted to repeat these goofs.

- Dave
