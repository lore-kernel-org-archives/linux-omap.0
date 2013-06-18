From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap4-panda: Fix DVI EDID reads
Date: Tue, 18 Jun 2013 16:29:32 +0300
Message-ID: <51C060BC.8010300@ti.com>
References: <1371553891-29364-1-git-send-email-rogerq@ti.com>
 <1371553891-29364-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371553891-29364-3-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/18/2013 02:11 PM, Roger Quadros wrote:
> On Panda the +5V supply for DVI EDID is supplied by the
> same regulator that poweres the USB Hub. Currently, the
> DSS/DVI subsystem doesn't know how to manage this regulator
> and so DVI EDID reads will fail if USB Hub is not enabled.
> 
> As a temporary fix we keep this regulator permanently enabled
> on boot. This fixes the DVI EDID read problem.
> 
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 7a21e8e..40df79e 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -80,6 +80,11 @@
>  		gpio = <&gpio1 1 0>;	/* gpio_1 */
>  		startup-delay-us = <70000>;
>  		enable-active-high;
> +		/*
> +		 * FIXME: Remove boot-on when DSS can handle this regulator
> +		 * for DVI EDID.
> +		 */
> +		regulator-boot-on;

As pointed out by Tomi, the correct usage here is "regulator-always-on".

The reason I use "regulator-boot-on" is because the regulator framework doesn't 
turn on the regulator. (maybe a bug in the regulator framework?)

"regulator-boot-on" is not sufficient as it doesn't prevent drivers from turning it
off. e.g. loading and unloading the USB host driver will turn of the regulator.
So it must be used along with "regulator-always-on"

I'll fix this in v2.

cheers,
-roger
