From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Mon, 28 Jan 2013 11:53:39 +0000
Message-ID: <20130128115339.GD7754@e106331-lin.cambridge.arm.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130125155633.GC16795@e106331-lin.cambridge.arm.com>
 <CALF0-+X2qsF5OETerRSVsJbjkC-JdVXsZhyw1sxQYR+PWX6LHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45936 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3A1Lxp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 06:53:45 -0500
In-Reply-To: <CALF0-+X2qsF5OETerRSVsJbjkC-JdVXsZhyw1sxQYR+PWX6LHA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "zonque@gmail.com" <zonque@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "jon-hunter@ti.com" <jon-hunter@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>

On Fri, Jan 25, 2013 at 06:11:28PM +0000, Ezequiel Garcia wrote:
> Hi Mark,
> 
> First of all: thanks for reviewing.
> 
> On Fri, Jan 25, 2013 at 12:56 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > I have a couple more comments after looking though this a bit more thoroughly.
> >
> > On Fri, Jan 25, 2013 at 12:23:11PM +0000, Ezequiel Garcia wrote:
> >> This patch adds device tree bindings for OMAP OneNAND devices.
> >> Tested on an OMAP3 3430 IGEPv2 board.
> >>
> >> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >> ---
> >> Changes from v2:
> >>  * Remove unneeded of_node_put() as reported by Mark Rutland
> >>
> >> Changes from v1:
> >>  * Fix typo in Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >>
> >>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   43 +++++++++++++++++++
> >>  arch/arm/mach-omap2/gpmc.c                         |   45 ++++++++++++++++++++
> >>  2 files changed, 88 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >> new file mode 100644
> >> index 0000000..deec9da
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >> @@ -0,0 +1,43 @@
> >> +Device tree bindings for GPMC connected OneNANDs
> >> +
> >> +GPMC connected OneNAND (found on OMAP boards) are represented as child nodes of
> >> +the GPMC controller with a name of "onenand".
> >> +
> >> +All timing relevant properties as well as generic gpmc child properties are
> >> +explained in a separate documents - please refer to
> >> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >
> > Which tree can I find this in?
> >
> 
> GPMC binding was posted by Daniel Mack a while ago.
> Tony has recently pushed it to his master branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

Aha. Thanks, it's far easier to understand with the gpmc doc!

> 
> >> +
> >> +Required properties:
> >> +
> >> + - reg:                      The CS line the peripheral is connected to
> >> +
> >> +Optional properties:
> >> +
> >> + - dma-channel:              DMA Channel index
> >> +
> >> +For inline partiton table parsing (optional):
> >> +
> >> + - #address-cells: should be set to 1
> >> + - #size-cells: should be set to 1
> >> +
> >> +Example for an OMAP3430 board:
> >> +
> >> +     gpmc: gpmc@6e000000 {
> >> +             compatible = "ti,omap3430-gpmc";
> >> +             ti,hwmods = "gpmc";
> >> +             reg = <0x6e000000 0x1000000>;
> >> +             interrupts = <20>;
> >> +             gpmc,num-cs = <8>;
> >> +             gpmc,num-waitpins = <4>;
> >> +             #address-cells = <2>;
> >> +             #size-cells = <1>;
> >> +
> >> +             onenand@0 {
> >> +                     reg = <0 0 0>; /* CS0, offset 0 */
> >> +
> >> +                     #address-cells = <1>;
> >> +                     #size-cells = <1>;
> >> +
> >> +                     /* partitions go here */
> >> +             };
> >> +     };
> >> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> >> index c6255f7..0636d0a 100644
> >> --- a/arch/arm/mach-omap2/gpmc.c
> >> +++ b/arch/arm/mach-omap2/gpmc.c
> >> @@ -39,6 +39,7 @@
> >>  #include "omap_device.h"
> >>  #include "gpmc.h"
> >>  #include "gpmc-nand.h"
> >> +#include "gpmc-onenand.h"
> >>
> >>  #define      DEVICE_NAME             "omap-gpmc"
> >>
> >> @@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
> >>  }
> >>  #endif
> >>
> >> +#ifdef CONFIG_MTD_ONENAND
> >> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
> >> +                              struct device_node *child)
> >> +{
> >> +     u32 val;
> >> +     struct omap_onenand_platform_data *gpmc_onenand_data;
> >> +
> >> +     if (of_property_read_u32(child, "reg", &val) < 0) {
> >> +             dev_err(&pdev->dev, "%s has no 'reg' property\n",
> >> +                     child->full_name);
> >> +             return -ENODEV;
> >> +     }
> >
> > I don't understand the format of the reg property, but it seems odd that you
> > only need to read one cell from it. Are the remaining address cell and size
> > cell used anywhere?
> >
> 
> Okey, I'll give a shot and try to explain this myself:
> 
> As you can see by Daniel's first patch [1]
> the reg property originally contained the chip select only, and
> after some discussion in that same thread, and in this one [2]
> It was decided to use a reg property that would also describe
> the base address and size of the gpmc sub-device,
> and use ranges for the address translation.
> This was reflected in Daniel's changelog when he submitted
> the v2 patch series [3].
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg202169.html
> [2] http://web.archiveorange.com/archive/v/vEQ2yFI0tmpQJdigvAog
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129426.html

So if I've understood correctly, the first address cell is the CS, and the
second the offset within this (as the comment in the onenand@0 node hints)?

If so, the code now makes sense to me :)

I was having difficulty seeing where the base address of the child got
translated via ranges, but I see in [3] that this doesn't currently happen.
That answers my question about the remaining cells.

Might it be worth sanity checking the runtime calculated address with the one
translated from dt? That way we can print a warning if the two don't match,
which would help to discover broken dts (or invalid runtime calculation if
future hardware breaks it somewhow).

Thanks,
Mark.


