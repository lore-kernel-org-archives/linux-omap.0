From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 08/11] ARM: OMAP4+: Adding the
 temperature sensor register set bit fields
Date: Mon, 28 May 2012 14:17:26 +0300
Message-ID: <20120528111726.GD3923@besouro>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-9-git-send-email-eduardo.valentin@ti.com>
	<4FBFA196.2030503@ti.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FBFA196.2030503@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: amit.kucheria@linaro.org, kbaidarov@dev.rtsoft.ru, kishon@ti.com, balbi@ti.com, Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 05:13:26PM +0200, Cousson Benoit wrote:
> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
> >OMAP4460 specific temperature sensor register bit fields are added.
> >Existing OMAP4 entries are renamed to OMAP4430.
> >
> >Signed-off-by: Keerthy<j-keerthy@ti.com>
> >Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
> >---
> >  arch/arm/mach-omap2/include/mach/control.h |  116 ++++++++++++++++++++++++++++
> 
> Now that we do have a dedicated driver for the bandgap, I guess it
> will be better to put these defines inside the driver directly.

Agreed

> 
> Benoit
> 
> >  1 files changed, 116 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-omap2/include/mach/control.h
> >index cf42764..171b504 100644
> >--- a/arch/arm/mach-omap2/include/mach/control.h
> >+++ b/arch/arm/mach-omap2/include/mach/control.h
> >@@ -230,6 +230,122 @@
> >  /* OMAP44xx control McBSP padconf */
> >  #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP	0x061c
> >
> >+/* TEMP_SENSOR OMAP4430 */
> >+#define OMAP4430_BGAP_TEMPSOFF_SHIFT			12
> >+#define OMAP4430_BGAP_TEMPSOFF_MASK			(1<<  12)
> >+#define OMAP4430_BGAP_TSHUT_SHIFT				11
> >+#define OMAP4430_BGAP_TSHUT_MASK				(1<<  11)
> >+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_SHIFT		10
> >+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_MASK		(1<<  10)
> >+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_SHIFT		9
> >+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK			(1<<  9)
> >+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		8
> >+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1<<  8)
> >+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
> >+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0xff<<  0)
> >+
> >+/* TEMP_SENSOR OMAP4460 */
> >+#define OMAP4460_BGAP_TEMPSOFF_SHIFT			13
> >+#define OMAP4460_BGAP_TEMPSOFF_MASK			(1<<  13)
> >+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_SHIFT		11
> >+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK		(1<<  11)
> >+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
> >+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK		(1<<  10)
> >+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
> >+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff<<  0)
> >+
> >+/* BANDGAP_CTRL */
> >+#define OMAP4460_SINGLE_MODE_SHIFT			31
> >+#define OMAP4460_SINGLE_MODE_MASK			(1<<  31)
> >+#define OMAP4460_MASK_HOT_SHIFT				1
> >+#define OMAP4460_MASK_HOT_MASK				(1<<  1)
> >+#define OMAP4460_MASK_COLD_SHIFT			0
> >+#define OMAP4460_MASK_COLD_MASK				(1<<  0)
> >+
> >+/* BANDGAP_COUNTER */
> >+#define OMAP4460_COUNTER_SHIFT				0
> >+#define OMAP4460_COUNTER_MASK				(0xffffff<<  0)
> >+
> >+/* BANDGAP_THRESHOLD */
> >+#define OMAP4460_T_HOT_SHIFT				16
> >+#define OMAP4460_T_HOT_MASK				(0x3ff<<  16)
> >+#define OMAP4460_T_COLD_SHIFT				0
> >+#define OMAP4460_T_COLD_MASK				(0x3ff<<  0)
> >+
> >+/* TSHUT_THRESHOLD */
> >+#define OMAP4460_TSHUT_HOT_SHIFT			16
> >+#define OMAP4460_TSHUT_HOT_MASK				(0x3ff<<  16)
> >+#define OMAP4460_TSHUT_COLD_SHIFT			0
> >+#define OMAP4460_TSHUT_COLD_MASK			(0x3ff<<  0)
> >+
> >+/* BANDGAP_STATUS */
> >+#define OMAP4460_CLEAN_STOP_SHIFT			3
> >+#define OMAP4460_CLEAN_STOP_MASK			(1<<  3)
> >+#define OMAP4460_BGAP_ALERT_SHIFT			2
> >+#define OMAP4460_BGAP_ALERT_MASK			(1<<  2)
> >+#define OMAP4460_HOT_FLAG_SHIFT				1
> >+#define OMAP4460_HOT_FLAG_MASK				(1<<  1)
> >+#define OMAP4460_COLD_FLAG_SHIFT			0
> >+#define OMAP4460_COLD_FLAG_MASK				(1<<  0)
> >+
> >+/* TEMP_SENSOR OMAP5430 */
> >+#define OMAP5430_BGAP_TEMP_SENSOR_SOC_SHIFT		12
> >+#define OMAP5430_BGAP_TEMP_SENSOR_SOC_MASK		(1<<  12)
> >+#define OMAP5430_BGAP_TEMPSOFF_SHIFT			11
> >+#define OMAP5430_BGAP_TEMPSOFF_MASK			(1<<  11)
> >+#define OMAP5430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
> >+#define OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1<<  10)
> >+#define OMAP5430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
> >+#define OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff<<  0)
> >+
> >+/* BANDGAP_CTRL */
> >+#define OMAP5430_MASK_HOT_CORE_SHIFT			5
> >+#define OMAP5430_MASK_HOT_CORE_MASK			(1<<  5)
> >+#define OMAP5430_MASK_COLD_CORE_SHIFT			4
> >+#define OMAP5430_MASK_COLD_CORE_MASK			(1<<  4)
> >+#define OMAP5430_MASK_HOT_MM_SHIFT			3
> >+#define OMAP5430_MASK_HOT_MM_MASK			(1<<  3)
> >+#define OMAP5430_MASK_COLD_MM_SHIFT			2
> >+#define OMAP5430_MASK_COLD_MM_MASK			(1<<  2)
> >+#define OMAP5430_MASK_HOT_MPU_SHIFT			1
> >+#define OMAP5430_MASK_HOT_MPU_MASK			(1<<  1)
> >+#define OMAP5430_MASK_COLD_MPU_SHIFT			0
> >+#define OMAP5430_MASK_COLD_MPU_MASK			(1<<  0)
> >+
> >+/* BANDGAP_COUNTER */
> >+#define OMAP5430_REPEAT_MODE_SHIFT			31
> >+#define OMAP5430_REPEAT_MODE_MASK			(1<<  31)
> >+#define OMAP5430_COUNTER_SHIFT				0
> >+#define OMAP5430_COUNTER_MASK				(0xffffff<<  0)
> >+
> >+/* BANDGAP_THRESHOLD */
> >+#define OMAP5430_T_HOT_SHIFT				16
> >+#define OMAP5430_T_HOT_MASK				(0x3ff<<  16)
> >+#define OMAP5430_T_COLD_SHIFT				0
> >+#define OMAP5430_T_COLD_MASK				(0x3ff<<  0)
> >+
> >+/* TSHUT_THRESHOLD */
> >+#define OMAP5430_TSHUT_HOT_SHIFT			16
> >+#define OMAP5430_TSHUT_HOT_MASK				(0x3ff<<  16)
> >+#define OMAP5430_TSHUT_COLD_SHIFT			0
> >+#define OMAP5430_TSHUT_COLD_MASK			(0x3ff<<  0)
> >+
> >+/* BANDGAP_STATUS */
> >+#define OMAP5430_BGAP_ALERT_SHIFT			31
> >+#define OMAP5430_BGAP_ALERT_MASK			(1<<  31)
> >+#define OMAP5430_HOT_CORE_FLAG_SHIFT			5
> >+#define OMAP5430_HOT_CORE_FLAG_MASK			(1<<  5)
> >+#define OMAP5430_COLD_CORE_FLAG_SHIFT			4
> >+#define OMAP5430_COLD_CORE_FLAG_MASK			(1<<  4)
> >+#define OMAP5430_HOT_MM_FLAG_SHIFT			3
> >+#define OMAP5430_HOT_MM_FLAG_MASK			(1<<  3)
> >+#define OMAP5430_COLD_MM_FLAG_SHIFT			2
> >+#define OMAP5430_COLD_MM_FLAG_MASK			(1<<  2)
> >+#define OMAP5430_HOT_MPU_FLAG_SHIFT			1
> >+#define OMAP5430_HOT_MPU_FLAG_MASK			(1<<  1)
> >+#define OMAP5430_COLD_MPU_FLAG_SHIFT			0
> >+#define OMAP5430_COLD_MPU_FLAG_MASK			(1<<  0)
> >+
> >  /* AM35XX only CONTROL_GENERAL register offsets */
> >  #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
> >  #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
> 
