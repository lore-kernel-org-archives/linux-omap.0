From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] LED: OMAP PWM: Use work queue for brightness
Date: Tue, 30 Oct 2007 12:00:51 +0200
Message-ID: <31e679430710300300g51d65e89g6a9fdf2aeccb65ca@mail.gmail.com>
References: <11937370523112-git-send-email-daniel.stone@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11937370523112-git-send-email-daniel.stone@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Stone <daniel.stone@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/30/07, Daniel Stone <daniel.stone@nokia.com> wrote:
> It isn't safe to schedule from a LED brightness_set handler, so use a work queue.
>
> Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
> ---
>  drivers/leds/leds-omap-pwm.c |   22 ++++++++++++++++++++--
>  1 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/leds/leds-omap-pwm.c b/drivers/leds/leds-omap-pwm.c
> index 6b195d6..c5d7ff0 100644
> --- a/drivers/leds/leds-omap-pwm.c
> +++ b/drivers/leds/leds-omap-pwm.c
> @@ -16,17 +16,20 @@
>  #include <linux/platform_device.h>
>  #include <linux/leds.h>
>  #include <linux/ctype.h>
> +#include <linux/sched.h>
>  #include <asm/delay.h>
>  #include <asm/arch/board.h>
>  #include <asm/arch/dmtimer.h>
>
>  struct omap_pwm_led {
>         struct led_classdev cdev;
> +       struct work_struct work;
>         struct omap_pwm_led_platform_data *pdata;
>         struct omap_dm_timer *intensity_timer;
>         struct omap_dm_timer *blink_timer;
>         int powered;
>         unsigned int on_period, off_period;
> +       enum led_brightness brightness;
>  };
>
>  static inline struct omap_pwm_led *pdev_to_omap_pwm_led(struct platform_device *pdev)
> @@ -39,6 +42,11 @@ static inline struct omap_pwm_led *cdev_to_omap_pwm_led(struct led_classdev *led
>         return container_of(led_cdev, struct omap_pwm_led, cdev);
>  }
>
> +static inline struct omap_pwm_led *work_to_omap_pwm_led(struct work_struct *work)
> +{
> +       return container_of(work, struct omap_pwm_led, work);
> +}
> +
>  static void omap_pwm_led_set_blink(struct omap_pwm_led *led)
>  {
>         if (!led->powered)
> @@ -134,9 +142,17 @@ static void omap_pwm_led_set(struct led_classdev *led_cdev,
>  {
>         struct omap_pwm_led *led = cdev_to_omap_pwm_led(led_cdev);
>
> -       if (value != LED_OFF) {
> +       led->brightness = value;
> +       schedule_work(&led->work);
> +}
> +
> +static void omap_pwm_led_work(struct work_struct *work)
> +{
> +       struct omap_pwm_led *led = work_to_omap_pwm_led(work);
> +
> +       if (led->brightness != LED_OFF) {
>                 omap_pwm_led_power_on(led);
> -               omap_pwm_led_set_pwm_cycle(led, value);
> +               omap_pwm_led_set_pwm_cycle(led, led->brightness);
>         } else {
>                 omap_pwm_led_power_off(led);
>         }
> @@ -228,6 +244,8 @@ static int omap_pwm_led_probe(struct platform_device *pdev)
>         led->cdev.default_trigger = NULL;
>         led->cdev.name = pdata->name;
>         led->pdata = pdata;
> +       led->brightness = 0;

led->brightness = LED_OFF;
would look better.

besides the patch looks ok to me.

> +       INIT_WORK(&led->work, omap_pwm_led_work);
>
>         dev_info(&pdev->dev, "OMAP PWM LED (%s) at GP timer %d/%d\n",
>                  pdata->name, pdata->intensity_timer, pdata->blink_timer);
> --
> 1.4.4.2
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
