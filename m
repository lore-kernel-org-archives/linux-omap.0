From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH v4 3/4] ARM: dts: AM33XX: Enable system power off control
 in am335x-bone
Date: Fri, 11 Jan 2013 00:08:34 -0800
Message-ID: <CA+Bv8XavP5qtp1QjGQ3uYuO6Rax7MdZ9YwoRG2fEvZb-DrvTvw@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <1355464997-19367-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355464997-19367-4-git-send-email-anilkumar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, Samuel Ortiz <sameo@linux.intel.com>, rtc-linux@googlegroups.com, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Enable system power off control for BeagleBone in am335x-bone.dts file
> under rtc node. RTC is the incharge of controlling the system power.
> This flag is used by the driver to hook up the pm_power_off system call.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good

Reviewed-by: Russ Dill <russ.dill@ti.com>
Acked-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index e7dff9d..febbe2f 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -52,6 +52,10 @@
>                         };
>
>                 };
> +
> +               rtc@44e3e000 {
> +                       ti,system-power-controller;
> +               };
>         };
>
>         leds {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
