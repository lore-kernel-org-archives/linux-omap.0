From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 8/8] ARM: dts: am43-pre-silicon support
Date: Tue, 19 Feb 2013 16:05:22 +0530
Message-ID: <5123556A.9050109@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <e344f74da47579c11db68d9f6efe25259ed7f25d.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e344f74da47579c11db68d9f6efe25259ed7f25d.1361186097.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, devicetree-discuss@lists.ozlabs.org, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <marc.zyngier@arm.com>, Syed Mohammed Khasim <khasim@ti.com>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
> AM43 SoC is in pre-silicon stage, meanwhile it has been modelled in
> a pre-silicon platform. To validate and boot Linux in pre-silicon
> platform that emulates an AM43 SoC, add DT build support.
>
> As bootloader is not used, bootargs is passed through DT.
>
> Note: This would be replaced by an original board support.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>   arch/arm/boot/dts/Makefile             |  3 ++-
>   arch/arm/boot/dts/am43-pre-silicon.dts | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/am43-pre-silicon.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 94d88b9..b434344 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -124,7 +124,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>   	omap5-evm.dtb \
>   	am335x-evm.dtb \
>   	am335x-evmsk.dtb \
> -	am335x-bone.dtb
> +	am335x-bone.dtb \
> +	am43-pre-silicon.dtb
>   dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
>   dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>   dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
> diff --git a/arch/arm/boot/dts/am43-pre-silicon.dts b/arch/arm/boot/dts/am43-pre-silicon.dts
> new file mode 100644
> index 0000000..b9c6297
> --- /dev/null
> +++ b/arch/arm/boot/dts/am43-pre-silicon.dts

Well the pre-silicon platform and the SOC are very
close and at least the support you are adding here is
exactly same. So lets just use am437x.dtb or something
like that.

Regards,
Santosh
