From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: dra72-evm-tps65917: Add voltage supplies to
 usb_phy, mmc, dss
Date: Wed, 14 Dec 2016 13:00:50 +0200
Message-ID: <2bb73170-dbb5-01a3-5b3a-4d5d9414e3a9@ti.com>
References: <20161214085703.506-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161214085703.506-1-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Carlos Hernandez <ceh@ti.com>, Tero Kristo <t-kristo@ti.com>, robh+dt@kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Lokesh,

On 14/12/16 10:57, Lokesh Vutla wrote:
> Commit 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
> added a separate dtsi for dra72-evm-tps65917 moving all the voltage supplies
> to this file. But it missed adding voltage supplies to usb_phy, mmc,
> dss and deleted from dra72-evm-common.dtsi. Adding the voltage supply
> phandles to these nodes in dra72-evm-tps65917.dtsi
> 
> Fixes: 5d080aa30681 ("ARM: dts: dra72: Add separate dtsi for tps65917")
> Reported-by: Carlos Hernandez <ceh@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Logs:
> - DRA72-evm revC: http://pastebin.ubuntu.com/23627665/ 
> - DRA72-evm revB: http://pastebin.ubuntu.com/23627658/
>  arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> index ee6dac44edf1..e6df676886c0 100644
> --- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> +++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
> @@ -132,3 +132,19 @@
>  		ti,palmas-long-press-seconds = <6>;
>  	};
>  };
> +
> +&usb2_phy1 {
> +	phy-supply = <&ldo4_reg>;
> +};
> +
> +&usb2_phy2 {
> +	phy-supply = <&ldo4_reg>;
> +};
> +
> +&dss {
> +	vdda_video-supply = <&ldo5_reg>;
> +};
> +
> +&mmc1 {
> +	vmmc_aux-supply = <&ldo1_reg>;
> +};
> 

Are you sure that all future users of dra72-evm-tps65917.dtsi will use this same configuration?
If not I'd rather put this in the board dts files.

cheers,
-roger
