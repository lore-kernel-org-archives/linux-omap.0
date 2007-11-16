From: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Subject: OSK5912 GPIO
Date: Fri, 16 Nov 2007 11:59:42 +0000 (GMT)
Message-ID: <680885.35310.qm@web7613.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
  =20
  I AM WORKING ON OMAP5912 OSK.

I am writing a keyboard based gpio program to write a value '1' to the fr=
ee gpio pin when a key was pressed.

For that I modified the gpio-switch.c program. I am using the up arrow
key which is mapped to gpio7. By pressing this key I am able to write=20
a value '1' to the gpio pin 23.

At the shell prompt I am able to see a logic '1' value at gpio pin 23 wit=
h the following message

value of pin # 23 =3D 1
up (GPIO 7) is now disconnected


But through  the Cathode Ray Oscilloscope  I am unable to observe the GPI=
O pin 23 value as =911=92. There is no change in the Oscilloscope.

Here is my gpio-switch code


#define OMAP_GPIO_SW_POLL_DELAY    10

#define LED_GPIO 23

const struct omap_gpio_switch_config omap_left_switch =3D {
    .name =3D "left",
    .type =3D OMAP_GPIO_SWITCH_TYPE_CONNECTION,
    .gpio =3D 6,
    .flags =3D OMAP_GPIO_SWITCH_FLAG_INVERTED,
    .key_code =3D KEY_LEFT
};

const struct omap_gpio_switch_config omap_enter_switch =3D {
    .name =3D "enter",
    .type =3D OMAP_GPIO_SWITCH_TYPE_CONNECTION,
    .gpio =3D 12,
    .flags =3D OMAP_GPIO_SWITCH_FLAG_INVERTED,
    .key_code =3D KEY_ENTER
};

const struct omap_gpio_switch_config omap_up_switch =3D {
    .name =3D "up",
    .type =3D OMAP_GPIO_SWITCH_TYPE_CONNECTION,
    .gpio =3D 7,
    .flags =3D OMAP_GPIO_SWITCH_FLAG_INVERTED,
    .key_code =3D KEY_UP
};

const struct omap_gpio_switch_config omap_down_switch =3D {
    .name =3D "down",
    .type =3D OMAP_GPIO_SWITCH_TYPE_CONNECTION,
    .gpio =3D 15,
    .flags =3D OMAP_GPIO_SWITCH_FLAG_INVERTED,
    .key_code =3D KEY_DOWN
};

const struct omap_gpio_switch_config *omap_switches[] =3D {
    &omap_left_switch,
    &omap_enter_switch,
    &omap_up_switch,
    &omap_down_switch,
    NULL              /* Guard */   =20
};

static void gpio_sw_handler(void *data)
{
    struct gpio_switch *sw =3D data;
    int state =3D gpio_sw_get_state(sw);

    if (sw->state =3D=3D state)
          return;

    if (sw->type =3D=3D OMAP_GPIO_SWITCH_TYPE_CONNECTION)
          kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
                    &dev_attr_connection_switch.attr);
    else
          kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,
                    &dev_attr_cover_switch.attr);
    sw->state =3D state;
    input_report_key(&omap_sw_kp_dev, sw->key_code, state);
   =20
    /*** [START]: code for writing some value to GPIO 17 ***/

    if(sw->key_code=3D=3DKEY_UP)
    {
          if(led_glow(sw))
              printk(KERN_ERR "led_glow:failed ");
    }   =20
   =20
    /*** [END]: code for writing some value to GPIO 17 ***/         =20

static int led_glow(struct gpio_switch *ctrlsw)
{
    /* requesting for LED_GPIO */
    if(omap_request_gpio(LED_GPIO)<0)
          return -1;
   =20
    /* setting LED_GPIO as output pin */
    omap_set_gpio_direction(LED_GPIO,0);

    /* writing to LED_GPIO the state of KEY_UP */
    omap_set_gpio_dataout(LED_GPIO,ctrlsw->state);

    /* printing the value of led_gpio pin */
    printk("value of pin # %d =3D %d\n",LED_GPIO,omap_get_gpio_datain(LED=
_GPIO));

    return 0;
   =20

}


please suggest where I had gone wrong.

With Regards
  Azharuddin, India

      =20
---------------------------------
 5, 50, 500, 5000 - Store N number of mails in your inbox. Click here.
