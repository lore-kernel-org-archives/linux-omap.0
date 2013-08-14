From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCH v4 2/4] ARM: dts: add AM33XX vdd core opp50 suspend for
 Beaglebone.
Date: Wed, 14 Aug 2013 14:29:52 +0530
Message-ID: <520B4708.3040108@ti.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376432412-8509-3-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376432412-8509-3-git-send-email-Russ.Dill@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, devicetree@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8/14/2013 3:50 AM, Russ Dill wrote:
> Changes since v1:
> * Rebased onto new am335x PM branch
> 
> This adds a sleep and wake sequence to set the VDD core voltage to the
> OPP50 level, 0.950V. This saves power during suspend. The sequences are
> specific to the Beaglebone layout and PMIC, the TPS65217. The sequences
> are written out by the Cortex-M3.
> 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 444b4ed..3f6528d 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -127,10 +127,33 @@
>  			status = "okay";
>  			clock-frequency = <400000>;
>  
> +			/* Set OPP50 (0.95V) for VDD core */
> +			sleep_sequence = /bits/ 8 <

For user readability, can you mention the PMIC used here as a comment?

> +				0x02 0x24 0x0b 0x6d /* Password unlock 1 */
> +				0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
> +				0x02 0x24 0x0b 0x6d /* Password unlock 2 */
> +				0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
> +				0x02 0x24 0x0b 0x6c /* Password unlock 1 */
> +				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
> +				0x02 0x24 0x0b 0x6c /* Password unlock 2 */
> +				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
> +			>;
> +
> +			/* Set OPP100 (1.10V) for VDD core */
> +			wake_sequence = /bits/ 8 <
> +				0x02 0x24 0x0b 0x6d /* Password unlock 1 */
> +				0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
> +				0x02 0x24 0x0b 0x6d /* Password unlock 2 */
> +				0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
> +				0x02 0x24 0x0b 0x6c /* Password unlock 1 */
> +				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
> +				0x02 0x24 0x0b 0x6c /* Password unlock 2 */
> +				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
> +			>;
> +
>  			tps: tps@24 {
>  				reg = <0x24>;
>  			};
> -
>  		};
>  	};
>  
> 
