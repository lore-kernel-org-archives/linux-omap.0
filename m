From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: omap: convert to module_platform_driver()
Date: Tue, 4 Jun 2013 14:32:59 +0300
Message-ID: <51ADD06B.3000201@ti.com>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com> <1366723151-23209-2-git-send-email-grygorii.strashko@ti.com> <87fvwylxl8.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fvwylxl8.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kevin,
On 06/03/2013 11:59 PM, Kevin Hilman wrote:
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
>
>> The OMAP I2C driver has a relation to pinctrl-single driver. As result,
>> its probe will be deferred during system boot until late init time,
>> because the pinctrl-single is initizalized as moudle/device init time.
>> This, in turn, will delay initialization of all I2C devices (like mfd,
>> I2C regulators and etc.) and cause boot delay (more over, it can broken
>> initialization of drivers which are not ready to use deferred probe
>> mechanism yet, for example DSS).
>>
>> There are no sense to keep OMAP I2C initialization on subsys init layer
>> any more, hence shift it to module/device layer where the i2c <-->
>> pinctrl-single dependency is resolved in drivers/Makefile now.
>>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Testing this patch with PATCH 1/2, the twl_rtc driver fails to correctly
> initialize on OMAP3:
>
>           twl_rtc rtc.22: hctosys: invalid date/time
>
> instead of the expected result:
>
>            twl_rtc rtc.22: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
>
> so something is still not right for the init sequence.
>
> Kevin
I think, the root cause of the problem isn't this patch - it's just yet 
another side effect
of using deferred probes :). I've taken a look on twl-rtc code and found 
possible error place
static int __init twl_rtc_init(void)
{
     if (twl_class_is_4030()) <------ here,
         rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
     else
         rtc_reg_map = (u8 *) twl6030_rtc_reg_map;

     return platform_driver_register(&twl4030rtc_driver);
}
In drivers/Makefile:
obj-$(CONFIG_RTC_LIB)        += rtc/  <------ RTC is placed before I2C
obj-y                += i2c/ media/ <----- and only here I2C bus 
instantiates TWL-core device
and configures twl_priv->twl_id

Thats why it's working on my OMAP4/twl6030 board. Could you check if 
below fix will work on OMAP3:
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 8751a52..aaa5015 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -469,6 +469,11 @@ static int twl_rtc_probe(struct platform_device *pdev)
         if (irq <= 0)
                 goto out1;

+       if (twl_class_is_4030())
+               rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
+       else
+               rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
+
         ret = twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
         if (ret < 0)
                 goto out1;
@@ -610,11 +615,6 @@ static struct platform_driver twl4030rtc_driver = {

  static int __init twl_rtc_init(void)
  {
-       if (twl_class_is_4030())
-               rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
-       else
-               rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
-
         return platform_driver_register(&twl4030rtc_driver);
  }
  module_init(twl_rtc_init);

Unfortunately, I have no OMAP3 HW and can't check it.

Regards,
-grygorii
