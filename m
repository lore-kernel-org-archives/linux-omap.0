From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 1 Oct 2012 07:03:47 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Don Aisheng

On Tue, Sep 11, 2012 at 01:10:12, Linus Walleij wrote:
> On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> wrote:
> 
> > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > device pointer, pinctrl driver configure SoC pins to GPIO
> > mode according to definitions provided in .dts file.
> >
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> 
> So looking back at this after Stephen posed a real good
> question, when you say "configure SoC pins to GPIO
> mode", does that mean anything else than to mux them into
> GPIO mode?
>

pinctrl-single.c driver sets mux mode as well as pin configuration
like pull-up/pull-down, input/output and slew rate.

> In that case, have you considered augmenting
> pinctrl-single.c to implement .gpio_request_enable()
> .gpio_disable_free() and maybe also .gpio_set_direction()
> in its struct pinmux_ops pinmux backend?
> 
> If not, why?

Recently, I have gone through the details on implementing
gpio_request_enable in pinctrl-single driver. To add this
functionality we have to add gpio_range's to pinctrl driver.

AM335x EVM supports total 128 GPIO pins (4 banks) and these
are randomly distributed across AM33XX SoC pins.

These are the concerns/questions I have:-
1. I haven't added yet but it will come to more than 30-40
pinctrl_gpio_range entries
2. If the silicon package is changed then these will change.
3. If the GPIO driver is common for multiple SoCs then these
entries will be more & more over SoC specific and driver has
to change every time the gpio_range changes. 

   I have gone through the "Don Aisheng" patch series, which
adds "pinctrl_dt_add_gpio_ranges" support but not accepted
yet. With this patch series we can overcome the driver changes.

4. The current pinctrl driver has support for these APIs
pinctrl_request_gpio(), pinctrl_free_gpio(),
pinctrl_gpio_direction_input/output()
no API for slew rate control, pulled down/up control
how can we handle this?
5. pinctrl-single driver has to modify to provide separate handles
for pinmux and pinconfig. And we need separate pin configuration
bit masks and values/flags to take care of pull-up/down, slew rate,
receiver in/out and mux mode control.
6. This is for my understanding, on which node do we have to add
pinctrl data i.e., pin mux-mode data. In leds-gpio node (mostly not)
and if it is in gpio node then how can we pass pinmux data with
the existing API pinctrl_request_gpio(gpio);? Here we are passing
only gpio number.

Few more driver patches are pending along with this (leds-gpio DT
data additions according to this patch, similarly other drivers
like matrix keypad and volume keys)

Thanks
AnilKumar
