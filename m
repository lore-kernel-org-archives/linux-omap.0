From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram controller
Date: Mon, 19 Dec 2011 08:56:01 -0800
Message-ID: <CAOesGMi79_4EH58rErxkBNevEUeCf56pSfEG2A4ejD4b4pNf-A@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
	<1324303533-17458-3-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46915 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1LSQ4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:56:03 -0500
Received: by wgbds13 with SMTP id ds13so7572401wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 08:56:01 -0800 (PST)
In-Reply-To: <1324303533-17458-3-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi,

=46ewer comments here. :) But see below.

On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V <aneesh@ti.com> wrote:


> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.tx=
t
> @@ -0,0 +1,64 @@
> +* EMIF family of TI SDRAM controllers
> +
> +EMIF - External Memory Interface - is an SDRAM controller used in
> +TI SoCs. EMIF supports, based on the IP revision, one or more of
> +DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
> +of the EMIF IP and memory parts attached to it.
> +
> +Required properties:
> +- compatible =A0 : One or more of "ti,emif-ddr2", "ti,emif-ddr3", an=
d
> + =A0"ti,emif-lpddr2"
> +
> + =A0"ti,emif-ddr2" should be listed of the EMIF controller on this S=
oC
> + =A0supports DDR2 memories
> +
> + =A0"ti,emif-ddr3" should be listed of the EMIF controller on this S=
oC
> + =A0supports DDR3 memories
> +
> + =A0"ti,emif-lpddr2" should be listed of the EMIF controller on this=
 SoC
> + =A0supports LPDDR2 memories
> +
> +- ti,hwmods =A0 =A0: For TI hwmods processing and omap device creati=
on
> + =A0the value shall be "emif<n>" where <n> is the number of the EMIF
> + =A0instance with base 1.
> +
> +- phy-type =A0 =A0 : string indicating the phy type. Should be one o=
f the
> + =A0following:
> +
> + =A0"phy-type-omap4" =A0: PHY used in OMAP4 family of SoCs
> +
> + =A0"phy-type-dm81xx" : PHY used in DM81XX family of SoCs
> +
> +- ddr-handle =A0 : phandle to a "ddr" node representing the memory p=
art
> + =A0attached to this EMIF instance.

Just specify said ddr node as a child of this node instead of give it
a handle. What other bus would the ddr node sit on, if not the memory
controller bus?



-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
