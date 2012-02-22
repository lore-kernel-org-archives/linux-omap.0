From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 22 Feb 2012 10:29:43 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
 <4F452484.5080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6378 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab2BVS3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:29:53 -0500
In-Reply-To: <4F452484.5080503@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "khilman@ti.com" <khilman@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Rob Herring wrote at Wednesday, February 22, 2012 10:23 AM:
> On 02/22/2012 08:31 AM, Cousson, Benoit wrote:
> > On 2/22/2012 3:23 PM, Rob Herring wrote:
> >> On 02/15/2012 10:04 AM, Benoit Cousson wrote:
> >>> Adapt the GPIO driver to retrieve information from a DT file.
> >>>
> >>> Allocate the irq_base dynamically and rename bank->virtual_irq_start
> >>> to bank->irq_base.
> >>> Change irq_base type to int instead of u16 to match irq_alloc_descs
> >>> output.
> >>>
> >>> Add documentation for GPIO properties specific to OMAP.
> >>>
> >>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> >>
> >> One comment below, but otherwise:
> >>
> >> Acked-by: Rob Herring<rob.herring@calxeda.com>
> >>
> >>> ---
> >>>   .../devicetree/bindings/gpio/gpio-omap.txt         |   30 +++++
> >>>   drivers/gpio/gpio-omap.c                           |  121
> >>> ++++++++++++++++++--
> >>>   2 files changed, 142 insertions(+), 9 deletions(-)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/gpio/gpio-omap.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> >>> b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> >>> new file mode 100644
> >>> index 0000000..c1b3100
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> >>> @@ -0,0 +1,30 @@
> >>> +OMAP GPIO controller bindings
> >>> +
> >>> +Required properties:
> >>> +- compatible:
> >>> +  - "ti,omap2-gpio" for OMAP2 controllers
> >>> +  - "ti,omap3-gpio" for OMAP3 controllers
> >>> +  - "ti,omap4-gpio" for OMAP4 controllers
> >>> +- #gpio-cells : Should be two.
> >>> +  - first cell is the pin number
> >>> +  - second cell is used to specify optional parameters (unused)
> >>> +- gpio-controller : Marks the device node as a GPIO controller.
> >>> +- #interrupt-cells : Should be one
> >>
> >> There's no level/edge settings for gpios?
> >
> > That's a good question, because I was wondering as well :-)
> >
> > I did no see how it was done in other GPIO implementation.
> 
> There's not really a good example that I've found. Many gpio nodes don't
> even have "interrupt-controller" set.
> 
> So if you have an irq_set_type function for gpio's, then you should have
> 2 cells.

Tegra's GPIO IRQ binding (gpio_nvidia.txt in linux-next at least) says:

- #interrupt-cells : Should be 2.
  The first cell is the GPIO number.
  The second cell is used to specify flags:
    bits[3:0] trigger type and level flags:
      1 = low-to-high edge triggered.
      2 = high-to-low edge triggered.
      4 = active high level-sensitive.
      8 = active low level-sensitive.
      Valid combinations are 1, 2, 3, 4, 8.

Presumably, that's what you meant.

-- 
nvpublic

