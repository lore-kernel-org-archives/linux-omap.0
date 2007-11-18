From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: OSK5912 GPIO
Date: Sun, 18 Nov 2007 04:12:31 +0100
Message-ID: <fb249edb0711171912i298a4049j628e988a64242019@mail.gmail.com>
References: <680885.35310.qm@web7613.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <680885.35310.qm@web7613.mail.in.yahoo.com>
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
To: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 16/11/2007, Azhar Mr. <shaik.azharuddin@yahoo.co.in> wrote:
> Hi,
>
>   I AM WORKING ON OMAP5912 OSK.
>
> I am writing a keyboard based gpio program to write a value '1' to the free gpio pin when a key was pressed.
>
> For that I modified the gpio-switch.c program. I am using the up arrow
> key which is mapped to gpio7. By pressing this key I am able to write
> a value '1' to the gpio pin 23.
>
> At the shell prompt I am able to see a logic '1' value at gpio pin 23 with the following message
>
> value of pin # 23 = 1
> up (GPIO 7) is now disconnected
>
>
> But through  the Cathode Ray Oscilloscope  I am unable to observe the GPIO pin 23 value as '1'. There is no change in the Oscilloscope.
>
> Here is my gpio-switch code
>
>
> #define OMAP_GPIO_SW_POLL_DELAY    10
>
> #define LED_GPIO 23
>
> const struct omap_gpio_switch_config omap_left_switch = {
>     .name = "left",
>     .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,
>     .gpio = 6,
>     .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,
>     .key_code = KEY_LEFT
> };
>
> const struct omap_gpio_switch_config omap_enter_switch = {
>     .name = "enter",
>     .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,
>     .gpio = 12,
>     .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,
>     .key_code = KEY_ENTER
> };
>
> const struct omap_gpio_switch_config omap_up_switch = {
>     .name = "up",
>     .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,
>     .gpio = 7,
>     .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,
>     .key_code = KEY_UP
> };
>
> const struct omap_gpio_switch_config omap_down_switch = {
>     .name = "down",
>     .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,
>     .gpio = 15,
>     .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,
>     .key_code = KEY_DOWN
> };
>
> const struct omap_gpio_switch_config *omap_switches[] = {
>     &omap_left_switch,
>     &omap_enter_switch,
>     &omap_up_switch,
>     &omap_down_switch,
>     NULL              /* Guard */
> };
>
> static void gpio_sw_handler(void *data)
> {
>     struct gpio_switch *sw = data;
>     int state = gpio_sw_get_state(sw);
>
>     if (sw->state == state)
>           return;
>
>     if (sw->type == OMAP_GPIO_SWITCH_TYPE_CONNECTION)
>           kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
>                     &dev_attr_connection_switch.attr);
>     else
>           kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
>                     &dev_attr_cover_switch.attr);
>     sw->state = state;
>     input_report_key(&omap_sw_kp_dev, sw->key_code, state);
>
>     /*** [START]: code for writing some value to GPIO 17 ***/
>
>     if(sw->key_code==KEY_UP)
>     {
>           if(led_glow(sw))
>               printk(KERN_ERR "led_glow:failed ");
>     }
>
>     /*** [END]: code for writing some value to GPIO 17 ***/
>
> static int led_glow(struct gpio_switch *ctrlsw)
> {
>     /* requesting for LED_GPIO */
>     if(omap_request_gpio(LED_GPIO)<0)
>           return -1;
>
>     /* setting LED_GPIO as output pin */
>     omap_set_gpio_direction(LED_GPIO,0);
>
>     /* writing to LED_GPIO the state of KEY_UP */
>     omap_set_gpio_dataout(LED_GPIO,ctrlsw->state);
>
>     /* printing the value of led_gpio pin */
>     printk("value of pin # %d = %d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));
>
>     return 0;
>
>
> }

Generally it looks okay, but:

 - omap_request_gpio() and omap_set_gpio_direction() should only be
used once, in the initialisation, not on every key event.

 - omap_get_gpio_datain() should not be used with an output pin, only
for input pins. Otherwise the returned value may be false.

 - I don't know why the pin 23 stays low on your oscilloscope, but it
may be a multiplexing not set up on the pin. You may need to call
omap_cfg_reg() with some parameter, see if there is anything
concerning this pin in include/asm-arm/arch-omap/mux.h and in the
reference manual.

Regards
