From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
Date: Tue, 30 Apr 2013 10:35:42 +0530
Message-ID: <517F5126.5000509@ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, hvaibhav@ti.com, gururaja.hebbar@ti.com, zonque@gmail.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 4/29/2013 1:25 PM, Gupta, Pekon wrote:
> From: avinash philip <avinashphilip@ti.com>
> 
> NAND flash connected in am335x-evm on GPMC controller. This patch adds
> device tree node in am3355-evm with GPMC contoller timing for NAND flash
> interface, NAND partition table, ECC scheme, elm handle id.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Tested-by: Pekon Gupta <pekon@ti.com>
> 
> ---
> arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 0423298..1c2fd89 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -26,7 +26,8 @@
>  
>  	am33xx_pinmux: pinmux@44e10800 {
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
> +		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
> +			&nandflash_pins_s0>;

Why add this to the board level fallback (called pinctrl hogs, I think)?
This can be part of nand node you added below so that the pinctrl will
take effect when nand gets probed instead of all the time.

Thanks,
Sekhar

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
