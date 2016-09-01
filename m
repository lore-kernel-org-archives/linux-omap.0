From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
Date: Thu, 1 Sep 2016 09:09:33 -0500
Message-ID: <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>
List-Id: linux-omap@vger.kernel.org

On 09/01/2016 08:51 AM, Tomi Valkeinen wrote:
> LS_OE GPIO was changed from gpio6_28 to gpio2_30 for the Rev B1 board,
> and the current .dts file has the old GPIO.
>
> Rev B1 is the earliest board supported, so we can just change the .dts.
>
> This fixes "omapdss error: HDMI I2C Master Error" which causes failure
> to read EDID from the monitor.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index c4d04c5293b9..07603d9e2da7 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -120,7 +120,7 @@
>  		pinctrl-0 = <&tpd12s015_pins>;
>
>  		gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
> -			<&gpio6 28 GPIO_ACTIVE_HIGH>,	/* gpio6_28, LS OE */
> +			<&gpio2 30 GPIO_ACTIVE_HIGH>,	/* gpio2_30, LS OE */
>  			<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
>
>  		ports {
>

I believe we have A2s being shipped as well. we dont want to break A2s 
either -> I propose we refactor the dts to introduce revb1 X15.

-- 
Regards,
Nishanth Menon
