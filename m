From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix section mismatch warning.
Date: Wed, 19 Nov 2008 16:26:02 -0800
Message-ID: <200811191626.02717.david-b@pacbell.net>
References: <1227102749-19536-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:43479 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752033AbYKTA0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 19:26:06 -0500
In-Reply-To: <1227102749-19536-1-git-send-email-premi@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

I know that Beagle and Overo get the same warnings, so this
isn't really a sufficient fix...


On Wednesday 19 November 2008, Sanjeev Premi wrote:
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -130,7 +130,7 @@ static struct twl4030_madc_platform_data omap3evm=
_madc_data =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0.irq_line=A0=A0=A0=A0=A0=A0=A0=3D 1,
> =A0};
> =A0
> -static struct twl4030_platform_data omap3evm_twldata =3D {
> +static struct twl4030_platform_data __initdata omap3evm_twldata =3D =
{

=2E.. and that's incorrect in any case, since that data is used
by probe() code that's doesn't sit in an init section.

I have the following in my patchset, currently disabled since
it conflicts with other patches.  And in any case, Beagle can't
reboot with these "generic" scripts for some TBD reason.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
---
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/board-overo.c             |    2 +-
 arch/arm/mach-omap2/twl4030-generic-scripts.c |    3 +++
 arch/arm/mach-omap2/twl4030-generic-scripts.h |    5 +++++
 5 files changed, 11 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -188,7 +188,7 @@ static struct twl4030_platform_data beag
 	/* platform_data for children goes here */
 	.usb		=3D &beagle_usb_data,
 	.gpio		=3D &beagle_gpio_data,
-	.power		=3D &generic3430_t2scripts_data,
+	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
 };
=20
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] =3D {
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -140,7 +140,7 @@ static struct twl4030_platform_data omap
 	.keypad		=3D &omap3evm_kp_data,
 	.madc		=3D &omap3evm_madc_data,
 	.usb		=3D &omap3evm_usb_data,
-	.power		=3D &generic3430_t2scripts_data,
+	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
 	.gpio		=3D &omap3evm_gpio_data,
 };
=20
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -162,7 +162,7 @@ static struct twl4030_platform_data over
 	.irq_end	=3D TWL4030_IRQ_END,
 	.gpio		=3D &overo_gpio_data,
 	.usb		=3D &overo_usb_data,
-	.power		=3D &generic3430_t2scripts_data,
+	.power		=3D GENERIC3430_T2SCRIPTS_DATA,
 };
=20
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] =3D {
--- a/arch/arm/mach-omap2/twl4030-generic-scripts.c
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
  */
=20
+#ifdef CONFIG_TWL4030_POWER
+
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -76,3 +78,4 @@ struct twl4030_power_data generic3430_t2
 };
=20
=20
+#endif /* CONFIG_TWL4030_POWER */
--- a/arch/arm/mach-omap2/twl4030-generic-scripts.h
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.h
@@ -3,6 +3,11 @@
=20
 #include <linux/i2c/twl4030.h>
=20
+#ifdef CONFIG_TWL4030_POWER
 extern struct twl4030_power_data generic3430_t2scripts_data;
+#define GENERIC3430_T2SCRIPTS_DATA &generic3430_t2scripts_data
+#else
+#define GENERIC3430_T2SCRIPTS_DATA NULL
+#endif /* CONFIG_TWL4030_POWER */
=20
 #endif

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
