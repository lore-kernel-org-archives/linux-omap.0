From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Mon, 19 Nov 2012 21:52:37 +0100
Message-ID: <87zk2djox6.fsf@dell.be.48ers.dk>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
	<1353338956-19420-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50841 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab2KSUwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 15:52:42 -0500
Received: by mail-wi0-f172.google.com with SMTP id hm9so321555wib.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 12:52:41 -0800 (PST)
In-Reply-To: <1353338956-19420-4-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Mon, 19 Nov 2012 23:29:16 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

>>>>> "D" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 D> This patch adds basic DT bindings for OMAP GPMC.
 D> The actual peripherals are instanciated from child nodes within the GPMC

s/instanciated/instantiated/

 D> node, and the only type of device that is currently supported is NAND.

 D> Code was added to parse the generic GPMC timing parameters and some
 D> documentation with examples on how to use them.

 D> Successfully tested on an AM33xx board.

 D> Signed-off-by: Daniel Mack <zonque@gmail.com>
 D> ---
 D>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  84 ++++++++++
 D>  arch/arm/mach-omap2/gpmc.c                         | 170 +++++++++++++++++++++
 D>  2 files changed, 254 insertions(+)
 D>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

 D> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
 D> new file mode 100644
 D> index 0000000..20aa5b9
 D> --- /dev/null
 D> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
 D> @@ -0,0 +1,84 @@
 D> +Device tree bindings for GPMC connected NANDs
 D> +
 D> +GPMC connected NAND (found on OMAP boards) are represented as child nodes of
 D> +the GPMC controller with a name of "nand".
 D> +
 D> +All timing relevant properties as well as generic gpmc child properties are
 D> +explained in a separate documents - please refer to
 D> +Documentation/devicetree/bindings/bus/ti-gpmc.txt

Which this patch seems to be missing?


 D> +
 D> +For NAND specific properties such as ECC modes or bus width, please refer to
 D> +Documentation/devicetree/bindings/mtd/nand.txt
 D> +
 D> +
 D> +Required properties:
 D> +
 D> + - reg:		The CS line the peripheral is connected to
 D> +
 D> +Optional properties:
 D> +
 D> + - nand-bus-width: 		Set this numeric value to 16 if the hardware
 D> +				is wired that way. If not specified, a bus
 D> +				width of 8 is assumed.
 D> + - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
 D> +
 D> +	Layouts for 1-bit ecc: stored at end of spare area:
 D> +
 D> +		"software"	Software method (default)
 D> +		"hw"		Hardware method (let gpmc do the error detection)

Nit: why are you spelling out 'software' when everything else is shortened?

 D> +
 D> +	Layouts for 1-bit ecc: stored at beginning of spare area as romcode:
 D> +
 D> +		"hw-romcode"	gpmc method & romcode layout
 D> +		"bch4"		4-bit BCH ecc code
 D> +		"bch8"		8-bit BCH ecc code
 D> +

These are not 1-bit - Well, romcode might be depending on SoC. Looking at
omap2.c it seems to be an alias for hw, so that isn't really helpful on
E.G. am33xx where you should select bch8 to have something compatible
with the romcode.


 D> + - ti,nand-ecc-use-elm:		Property without value to specify that the
 D> +				hardware error correction mode should be used.

It's called the error location module. Like you pointed out yourself,
this property isn't really nice. I haven't looked at the elm bindings in
detail, but couldn't the nand driver automatically use the elm if the
device tree provides a node for it? Perhaps the elm should be a subnode
of the nand one?

-- 
Bye, Peter Korsgaard
