From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 10/32] ARM: dts: omap3-gta04: update gpmc NAND setup
Date: Wed, 25 Jul 2018 10:28:10 +0200
Message-ID: <20180725082810.GA8303@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <effe8969751cde3a3cd7993aa66c839493af9dd1.1532501910.git.hns@goldelico.com>
 <20180725081058.GB7467@lenoch>
 <1E7B727D-1AED-4B00-AD2C-CF9FC562E53D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1E7B727D-1AED-4B00-AD2C-CF9FC562E53D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 25, 2018 at 10:16:28AM +0200, H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 25.07.2018 um 10:10 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > On Wed, Jul 25, 2018 at 08:58:42AM +0200, H. Nikolaus Schaller wrote:
> >> to better match omap3-beagle.dts (which was the basis
> >> of designing the GTA04).
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> arch/arm/boot/dts/omap3-gta04.dtsi | 14 +++++++-------
> >> 1 file changed, 7 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> index 03fe404cbf56..9568e0c4d4bf 100644
> >> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> @@ -616,27 +616,27 @@
> >> 		interrupt-parent = <&gpmc>;
> >> 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
> >> 			     <1 IRQ_TYPE_NONE>;	/* termcount */
> >> +		ti,nand-ecc-opt = "ham1";
> >> +		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
> >> 		nand-bus-width = <16>;
> >> -		ti,nand-ecc-opt = "bch8";
> > 
> > You are using weeker ECC scheme just to be compatible with another machine?
> 
> No not another machine. The GTA04 uses the same SoC and NAND chip as the BeagleBoard,
> so you can imagine GTA04 being a BeagleBoard + a lot of other things.
> 
> The key reason is to change the ecc scheme is to be compatible with the U-Boot used.
> 
> BootROM can only handle ham1 for the MLO. And there is no nand-ecc-opt
> for each partition. So we either can't mix ECC schemes if we want to be able
> to read/write MLO as the first partition from kernel.
> 
> > So now you cannot boot already deployed filesystem...
> 
> No. We always used ham1 and bch8 wasn't working at all here. Therefore nobody
> did use upstream kernel for NAND yet...
> 
> > Also is it enough for
> > NAND chip used?
> 
> Well, the chip is recommended to use bch8 but BootROM imposes above mentioned limits.

Then common way to handle such a situation is to use 1bit hamming for MLO and BCH8 for
the rest. You will end with corrupted filesystem with ham1 which I'd consider very
unfortunate.

(I know there were endless discussions how to handle this situation. It is already
solved in U-Boot and for updating MLO from Linux I'm using writeloader tool)

	ladis

> BR,
> Nikolaus
> 
> > 
> > 	ladis
> > 
> >> +		#address-cells = <1>;
> >> +		#size-cells = <1>;
> >> 
> >> -		gpmc,sync-clk-ps = <0>;
> >> +		gpmc,device-width = <2>;
> >> 		gpmc,cs-on-ns = <0>;
> >> 		gpmc,cs-rd-off-ns = <44>;
> >> 		gpmc,cs-wr-off-ns = <44>;
> >> 		gpmc,adv-on-ns = <6>;
> >> 		gpmc,adv-rd-off-ns = <34>;
> >> 		gpmc,adv-wr-off-ns = <44>;
> >> -		gpmc,we-off-ns = <40>;
> >> 		gpmc,oe-off-ns = <54>;
> >> +		gpmc,we-off-ns = <40>;
> >> 		gpmc,access-ns = <64>;
> >> 		gpmc,rd-cycle-ns = <82>;
> >> 		gpmc,wr-cycle-ns = <82>;
> >> 		gpmc,wr-access-ns = <40>;
> >> 		gpmc,wr-data-mux-bus-ns = <0>;
> >> -		gpmc,device-width = <2>;
> >> -
> >> -		#address-cells = <1>;
> >> -		#size-cells = <1>;
> >> +		gpmc,sync-clk-ps = <0>;
> >> 
> >> 		x-loader@0 {
> >> 			label = "X-Loader";
> >> -- 
> >> 2.12.2
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
