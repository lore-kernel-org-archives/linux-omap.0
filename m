From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
Date: Wed, 11 Jul 2018 00:17:05 +0100
Message-ID: <20180710231705.GG6920@n2100.armlinux.org.uk>
References: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
 <20180709114304.GE6920@n2100.armlinux.org.uk>
 <CADO55X8_tbz-O8AuHwqCGnV0g2oDiGHzAug6g3PFqRth5U2H=w@mail.gmail.com>
 <20180710082624.GA16036@n2100.armlinux.org.uk>
 <CADO55X_wCd1o9Tfze08fJixsUuA2y7EDDQ3hRwy2bR1nktgx1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADO55X_wCd1o9Tfze08fJixsUuA2y7EDDQ3hRwy2bR1nktgx1A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neeraj Kumar Reddy Dantu <dantuguf14105@gmail.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 10, 2018 at 03:54:19PM -0500, Neeraj Kumar Reddy Dantu wrote:
> > As maintainer of the TDA998x driver, I know what the TDA998x is
> > capable of, I already have the datasheets, and I know the binding
> > document.
> 
> > What I'm asking about is about the specifics of your board's
> > implementation and why you've written what you have in your DT
> > file.  You haven't answered my specific questions either.
> I am sorry I was unclear. My apologies.
> 
> Here is the wiring between LCD controller and the framer:
> 
> LCD[11:15] ====> VPA[3:7]
> LCD[5:10]   ====> VPB[2:7]
> LCD[0:4]     ====> VPC[3:7]
> Here is the schematic:
> https://octavosystems.com/docs/osd3358-sm-red-schematics-pdf/
> And yes, the colors will come out wrong for the 24 bit for the
> configuration set. See "blue-and-red-wiring" in tilcdc bindings:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> AM335x errata providing wiring info for 24 bit mode:
> http://www.ti.com/lit/er/sprz360i/sprz360i.pdf
> 
> We used the same interface design as the BeagleBone Black:
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/am335x-boneblack-common.dtsi
> 
> Hope this is helpful.

Thanks, that explains the situation.  It would be nice to state that
this weirdness is due to an errata in the comment about it.

However, if DRM had the ability to communicate the bus format between
the LCD controller and the encoder/bridge, then we could do a lot more
to correct this problem, such as:

- dynamically configuring the TDA998x's input to automatically remap
  the input pins.

- configure the TDA998x's colour space converter to correctly scale
  the RGB565 input for the missing LSB bits when we know that we are
  supplied with an RGB565 input signal.

The last point doesn't give you RGB888 or BGR888, but would at least
mean that white would be white and not a very light grey with a green
tinge.

It's seems odd that tilcdc supports 8bpc in the framebuffer, but the
hardware has no way to produce 8bpc on the device's outputs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
