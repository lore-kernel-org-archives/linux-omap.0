From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] LED: OMAP PWM: Use work queue for brightness
Date: Wed, 14 Nov 2007 18:07:10 -0800
Message-ID: <20071115020710.GE6005@atomide.com>
References: <11937370523112-git-send-email-daniel.stone@nokia.com>
	<31e679430710300300g51d65e89g6a9fdf2aeccb65ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <31e679430710300300g51d65e89g6a9fdf2aeccb65ca@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipebalbi@users.sourceforge.net> [071030 03:01]:
> Hi,
> 
> On 10/30/07, Daniel Stone <daniel.stone@nokia.com> wrote:
> > It isn't safe to schedule from a LED brightness_set handler, so use a work queue.
> >
> > Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
> > ---
> >  drivers/leds/leds-omap-pwm.c |   22 ++++++++++++++++++++--
> >  1 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/leds/leds-omap-pwm.c b/drivers/leds/leds-omap-pwm.c
> > index 6b195d6..c5d7ff0 100644
> > --- a/drivers/leds/leds-omap-pwm.c
> > +++ b/drivers/leds/leds-omap-pwm.c

<snip>


> > @@ -134,9 +142,17 @@ static void omap_pwm_led_set(struct led_classdev *led_cdev,
> >  {
> >         struct omap_pwm_led *led = cdev_to_omap_pwm_led(led_cdev);
> >
> > -       if (value != LED_OFF) {
> > +       led->brightness = value;
> > +       schedule_work(&led->work);
> > +}
> > +
> > +static void omap_pwm_led_work(struct work_struct *work)
> > +{
> > +       struct omap_pwm_led *led = work_to_omap_pwm_led(work);
> > +
> > +       if (led->brightness != LED_OFF) {
> >                 omap_pwm_led_power_on(led);
> > -               omap_pwm_led_set_pwm_cycle(led, value);
> > +               omap_pwm_led_set_pwm_cycle(led, led->brightness);
> >         } else {
> >                 omap_pwm_led_power_off(led);
> >         }
> > @@ -228,6 +244,8 @@ static int omap_pwm_led_probe(struct platform_device *pdev)
> >         led->cdev.default_trigger = NULL;
> >         led->cdev.name = pdata->name;
> >         led->pdata = pdata;
> > +       led->brightness = 0;
> 
> led->brightness = LED_OFF;
> would look better.
> 
> besides the patch looks ok to me.

Pushing with Felipe's suggestion for LED_OFF.

Tony
