From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
Date: Fri, 2 Nov 2012 16:49:36 +0530
Message-ID: <CAM=Q2cuUobzP97Fk1X5EGL1BbRxcpDbaqUa=jv4k4JN8NZLCJA@mail.gmail.com>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
	<1351852785-16961-3-git-send-email-shubhrajyoti@ti.com>
	<20121102110713.GC19493@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121102110713.GC19493-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 2, 2012 at 4:37 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Fri, Nov 02, 2012 at 04:09:45PM +0530, Shubhrajyoti D wrote:
>> The errata i207 is enabled for 2430 and 3xxx. Use the revision check
>> to enable the erratum instead.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> very good. I haven't read the errata but from a code standpoint, it
> looks good:
>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>

Also I post to this the flag may be deleted.


From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Date: Fri, 2 Nov 2012 16:34:08 +0530
Subject: [PATCH] ARM: i2c: omap: Remove the i207 errata flag

The commit [i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207]
uses the revision id instead of the flag. So the flag can be safely removed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++------
 drivers/i2c/busses/i2c-omap.c              |    3 +--
 include/linux/i2c-omap.h                   |    1 -
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c455e41..b79ccf6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -76,8 +76,7 @@ static struct omap_hwmod_class i2c_class = {

 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2 |
 			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f67b7ee..943222c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 /* I2C1 */
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-			  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags		= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 			  OMAP_I2C_FLAG_BUS_SHIFT_2,
 };

@@ -818,8 +817,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 /* I2C2 */
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };

@@ -845,8 +843,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 /* I2C3 */
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dd97c14..87970fa 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1029,8 +1029,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index df804ba..5c88187 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -21,7 +21,6 @@
 #define OMAP_I2C_FLAG_SIMPLE_CLOCK		BIT(1)
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
 #define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE	BIT(3)
-#define OMAP_I2C_FLAG_APPLY_ERRATA_I207	BIT(4)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
 /* how the CPU address bus must be translated for I2C unit access */
-- 
1.7.5.4
