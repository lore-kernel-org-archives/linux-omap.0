From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Sun, 23 Dec 2012 21:50:52 -0300
Message-ID: <CALF0-+VHp+V=d114r_OT8baht_hSi9apmdYrJ3eVQRtEzjDZAw@mail.gmail.com>
References: <1356307280-8323-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1356307280-8323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:63762 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2LXAux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 19:50:53 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so8322052iea.26
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 16:50:52 -0800 (PST)
In-Reply-To: <1356307280-8323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, martinez.javier@gmail.com, zonque@gmail.com, grant.likely@secretlab.ca, eballetbo@gmail.com, matthias.bgg@googlemail.com, jon-hunter@ti.com, b-cousson@ti.com, Ezequiel Garcia <ezequiel@free-electrons.com>

On Sun, Dec 23, 2012 at 9:01 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> This patch adds device tree bindings for OMAP OneNAND devices.
> Tested on an OMAP3 3430 IGEPv2 board.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   44 ++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.c                         |   44 ++++++++++++++++++++
>  2 files changed, 88 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> new file mode 100644
> index 0000000..4108f18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -0,0 +1,44 @@
> +Device tree bindings for GPMC connected OneNANDs
> +
> +GPMC connected OneNAND (found on OMAP boards) are represented as child nodes of
> +the GPMC controller with a name of "onenand".
> +
> +All timing relevant properties as well as generic gpmc child properties are
> +explained in a separate documents - please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +Required properties:
> +
> + - reg:                        The CS line the peripheral is connected to
> +
> +Optional properties:
> +
> + - dma-channel:                DMA Channel index
> +
> +For inline partiton table parsing (optional):
> +
> + - #address-cells: should be set to 1
> + - #size-cells: should be set to 1
> +
> +Example for an OMAP3430 board:
> +
> +       gpmc: gpmc@6e000000 {
> +               compatible = "ti,omap3430-gpmc";
> +               ti,hwmods = "gpmc";
> +               reg = <0x6e000000 0x1000000>;
> +               interrupts = <20>;
> +               gpmc,num-cs = <8>;
> +               gpmc,num-waitpins = <4>;
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +

Before anyone complains, this is wrong:

> +               onenand@0 {
> +                       reg = <0>;
> +

It should be "reg = <0 0 0>" of course.

Also, IMHO, I don't like the node to be matched by his name.
Shouldn't we add a "compatible" tag instead?

That way we could describe the device like

flash@xxx {
    compatible = "nand";
}

or

flash@xxx {
    compatible = "onenand";
}

Does this make sense?

Regards,

    Ezequiel
