From: Neeraj Kumar Reddy Dantu <dantuguf14105@gmail.com>
Subject: Re: [PATCH v2] Add DT support for Octavo Systems OSD3358-SM-RED based
 on TI AM335x
Date: Tue, 10 Jul 2018 15:54:19 -0500
Message-ID: <CADO55X_wCd1o9Tfze08fJixsUuA2y7EDDQ3hRwy2bR1nktgx1A@mail.gmail.com>
References: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
 <20180709114304.GE6920@n2100.armlinux.org.uk>
 <CADO55X8_tbz-O8AuHwqCGnV0g2oDiGHzAug6g3PFqRth5U2H=w@mail.gmail.com>
 <20180710082624.GA16036@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180710082624.GA16036@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> As maintainer of the TDA998x driver, I know what the TDA998x is
> capable of, I already have the datasheets, and I know the binding
> document.

> What I'm asking about is about the specifics of your board's
> implementation and why you've written what you have in your DT
> file.  You haven't answered my specific questions either.
I am sorry I was unclear. My apologies.

Here is the wiring between LCD controller and the framer:

LCD[11:15] ====> VPA[3:7]
LCD[5:10]   ====> VPB[2:7]
LCD[0:4]     ====> VPC[3:7]
Here is the schematic:
https://octavosystems.com/docs/osd3358-sm-red-schematics-pdf/
And yes, the colors will come out wrong for the 24 bit for the
configuration set. See "blue-and-red-wiring" in tilcdc bindings:
https://www.kernel.org/doc/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
AM335x errata providing wiring info for 24 bit mode:
http://www.ti.com/lit/er/sprz360i/sprz360i.pdf

We used the same interface design as the BeagleBone Black:
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/am335x-boneblack-common.dtsi

Hope this is helpful.

Thanks,
Neeraj

On Tue, Jul 10, 2018 at 3:26 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jul 09, 2018 at 02:45:17PM -0500, Neeraj Kumar Reddy Dantu wrote:
> >  > This should not be "tda19988" as the node name - DT requires generic
> > > names, like "hdmi-encoder".
> >
> > Thanks.Will fix in v3
> >
> > > Can you set 24-bit RGB mode with the above configuration - presumably
> > > the colours will come out wrong?
> > > Exactly what is the wiring between the lcdc and tda998x?
> >
> > You can set mapping for lcd interface between pins with video-ports. See
> > TDA19988 datasheet, Table 4:
> > https://media.digikey.com/pdf/Data%20Sheets/NXP%20PDFs/TDA19988_DS_21_july_2011.pdf
> > .
> > The property is optional and not used in the board. DT bindings:
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/display/bridge/tda998x.txt
> >
> > This board uses 15 pin RGB565 interface.
>
> As maintainer of the TDA998x driver, I know what the TDA998x is
> capable of, I already have the datasheets, and I know the binding
> document.
>
> What I'm asking about is about the specifics of your board's
> implementation and why you've written what you have in your DT
> file.  You haven't answered my specific questions either.
>
> >
> > Regards,
> > Neeraj
> >
> > On Mon, Jul 9, 2018 at 6:43 AM Russell King - ARM Linux <
> > linux@armlinux.org.uk> wrote:
> >
> > > On Fri, Jul 06, 2018 at 08:00:51PM +0000, Neeraj Dantu wrote:
> > > > +&lcdc {
> > > > +     status = "okay";
> > > > +
> > > > +     /* If you want to get 24 bit RGB and 16 BGR mode instead of
> > > > +      * current 16 bit RGB and 24 BGR modes, set the propety
> > > > +      * below to "crossed" and uncomment the video-ports -property
> > > > +      * in tda19988 node.
> > > > +      */
> > > > +     blue-and-red-wiring = "straight";
> > > ...
> > > > +&i2c0 {
> > > > +     tda19988: tda19988 {
> > >
> > > This should not be "tda19988" as the node name - DT requires generic
> > > names, like "hdmi-encoder".
> > >
> > > ...
> > > > +             /* Convert 24bit BGR to RGB, e.g. cross red and blue
> > > wiring */
> > > > +             /* video-ports = <0x234501>; */
> > >
> > > Please explain more what's going on here.
> > >
> > > Can you set 24-bit RGB mode with the above configuration - presumably
> > > the colours will come out wrong?
> > >
> > > Exactly what is the wiring between the lcdc and tda998x?
> > >
> > > --
> > > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > > FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps
> > > up
> > > According to speedtest.net: 13Mbps down 490kbps up
> > >
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up
