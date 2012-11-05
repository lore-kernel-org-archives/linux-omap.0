From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Mon, 5 Nov 2012 11:03:58 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51225 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab2KELFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 06:05:09 -0500
In-Reply-To: <1351869956-2787-5-git-send-email-zonque@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 02, 2012 at 20:55:56, Daniel Mack wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instanciated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
[...]
> +
> +		nand@0,0 {
> +			reg = <0 0 0>; /* CS0, offset 0 */
> +			nand-bus-width = <16>;
> +			nand-ecc-mode = "none";
> +
> +			gpmc,sync-clk = <0>;
> +			gpmc,cs-on = <0>;
> +			gpmc,cs-rd-off = <36>;
> +			gpmc,cs-wr-off = <36>;
> +			gpmc,adv-on = <6>;
> +			gpmc,adv-rd-off = <24>;
> +			gpmc,adv-wr-off = <36>;
> +			gpmc,we-off = <30>;
> +			gpmc,oe-off = <48>;
> +			gpmc,access = <54>;
> +			gpmc,rd-cycle = <72>;
> +			gpmc,wr-cycle = <72>;
> +			gpmc,wr-access = <30>;
> +			gpmc,wr-data-mux-bus = <0>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +

Can you take the timings (for example) from arago tree. The timings is tested in am335x-evm
So the timings can be directly used to populate GPMC timings. Timings can found at

http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;
h=66bfbd2c5b35dc81edce0c24843c476161ab5978;hp=370630359cb8db711cf0941cd2a242e28ccfb61e

[...]
> +static int gpmc_probe_dt(struct platform_device *pdev)

Can you take care of the following section mismatch.
WARNING: vmlinux.o(.text+0x1e2d0): Section mismatch in reference
from the function gpmc_probe_dt() to the function .init.text:gpmc_nand_init().

[...]
> +
> +		val = of_get_nand_ecc_mode(child);
> +		if (val >= 0)
> +			gpmc_nand_data->ecc_opt = val;

This will fail for BCH. Index of "soft_bch" is 5 & also don't have selection
option between for BCH4 & BCH8 also.
Can you use the of_property_read_u32 (as done early) to pass the ecc selection
from dt file. This will help selection of BCH4 & BCH8 ecc options.

Thanks
Avinash
