From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 06/11] ARM: OMAP4+: Adding the
 temperature sensor register set bit fields
Date: Wed, 20 Jun 2012 03:25:58 -0700
Message-ID: <20120620102557.GB12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<4FDF11CD.2090101@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FDF11CD.2090101@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: Keerthy <j-keerthy@ti.com>, amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> OMAP4460 specific temperature sensor register bit fields are added.
> Existing OMAP4 entries are renamed to OMAP4430.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/control.h |  116 ++++++++++++++++++++++++++++
>  1 files changed, 116 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-omap2/include/mach/control.h
> index cf42764..171b504 100644
> --- a/arch/arm/mach-omap2/include/mach/control.h
> +++ b/arch/arm/mach-omap2/include/mach/control.h
> @@ -230,6 +230,122 @@
>  /* OMAP44xx control McBSP padconf */
>  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP	0x061c
>  
> +/* TEMP_SENSOR OMAP4430 */
> +#define OMAP4430_BGAP_TEMPSOFF_SHIFT			12
> +#define OMAP4430_BGAP_TEMPSOFF_MASK			(1 << 12)
> +#define OMAP4430_BGAP_TSHUT_SHIFT				11
> +#define OMAP4430_BGAP_TSHUT_MASK				(1 << 11)
> +#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_SHIFT		10
> +#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_MASK		(1 << 10)
> +#define OMAP4430_BGAP_TEMP_SENSOR_SOC_SHIFT		9
> +#define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK			(1 << 9)
> +#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		8
> +#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 8)
> +#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
> +#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0xff << 0)
> +
> +/* TEMP_SENSOR OMAP4460 */
> +#define OMAP4460_BGAP_TEMPSOFF_SHIFT			13
> +#define OMAP4460_BGAP_TEMPSOFF_MASK			(1 << 13)
> +#define OMAP4460_BGAP_TEMP_SENSOR_SOC_SHIFT		11
> +#define OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK		(1 << 11)
> +#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
> +#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 10)
> +#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
> +#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
> +
> +/* BANDGAP_CTRL */
> +#define OMAP4460_SINGLE_MODE_SHIFT			31
> +#define OMAP4460_SINGLE_MODE_MASK			(1 << 31)
> +#define OMAP4460_MASK_HOT_SHIFT				1
> +#define OMAP4460_MASK_HOT_MASK				(1 << 1)
> +#define OMAP4460_MASK_COLD_SHIFT			0
> +#define OMAP4460_MASK_COLD_MASK				(1 << 0)
> +
> +/* BANDGAP_COUNTER */
> +#define OMAP4460_COUNTER_SHIFT				0
> +#define OMAP4460_COUNTER_MASK				(0xffffff << 0)
> +
> +/* BANDGAP_THRESHOLD */
> +#define OMAP4460_T_HOT_SHIFT				16
> +#define OMAP4460_T_HOT_MASK				(0x3ff << 16)
> +#define OMAP4460_T_COLD_SHIFT				0
> +#define OMAP4460_T_COLD_MASK				(0x3ff << 0)

These should be all private to the bandgap driver. The same applies
for other driver specific registers for other drivers.

Tony
