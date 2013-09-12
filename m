From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/4] ARM: am335x-bone-common: switch mmc1 to 4-bit mode
Date: Thu, 12 Sep 2013 11:19:11 -0500
Message-ID: <5231E97F.1060005@ti.com>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
 <1379000532-27376-4-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379000532-27376-4-git-send-email-koen@dominion.thruhere.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

nitpick minor comment:
$subject: ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode

On 09/12/2013 10:42 AM, Koen Kooi wrote:
> The micro-SD slot hooks up all four data pins so lets' use them.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index cfec441..80407ff 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -290,6 +290,7 @@
>  
>  &mmc1 {
>  	status = "okay";
> +	bus-width = <0x4>;
>  	vmmc-supply = <&ldo3_reg>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
> 


-- 
Regards,
Nishanth Menon
