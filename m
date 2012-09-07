From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 14:30:59 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
 <20120907110251.GA7968@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120907110251.GA7968@glitch>
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
To: Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 07, 2012 at 16:32:51, Domenico Andreoli wrote:
> On Fri, Sep 07, 2012 at 09:10:50AM +0000, AnilKumar, Chimata wrote:
> > Hi Domenico,
> 
> Hi,
> 
> > On Fri, Sep 07, 2012 at 14:18:39, Domenico Andreoli wrote:
> > > On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> wrote:
> > > > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > > > device pointer, pinctrl driver configure SoC pins to GPIO
> > > > mode according to definitions provided in .dts file.
> > > 
> > > Shouldn't be the interaction with the pinctrl layer left to gpiolib?
> > > 
> > 
> > No, these gpio's are configured specifically for user leds.
> 
> So there are some special pad configs to make the leds work which are not
> only muxing and direction setting? Because I expect these to be managed
> privately between gpiolib and pinctrl but now I'm not sure any more,
> I'll look the code.

How can gpio driver knows that leds-gpio driver require
these 4 pins?

> 
> > So, leds-gpio driver should have this call, because these gpio
> > pins are used by leds-gpio driver.
> > 
> > +       am33xx_pinmux: pinmux@44e10800 {
> > +               userled_pins: pinmux_userled_pins {
> > +                       pinctrl-single,pins = <
> > +                               0x54 0x7       
> > +                               0x58 0x17       
> > +                               0x5c 0x7        
> > +                               0x60 0x17       
> > +                       >;
> > +               };
> > +       };
> > +
> > 
> > [...]
> > 
> > +               leds {
> > +                       compatible = "gpio-leds";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&userled_pins>;
> >                                       ^^^^^^^^^^^^
> 
> I'm surprised to not see any gpio controller (ala irq) involved.

GPIO controller data will be in GPIO node, should not be here.

> 
> > Lets take gpio-keypad driver, in that case we have to configure
> > pins as INPUT mode (generic gpio driver might not know what
> > the end usecase is) and this leds case we configure as OUTPUT
> > mode.
> 
> gpio direction is modeled by gpiolib so, if no other out-of-gpiolib
> capabilities are required for that led gpio, there is no need to directly
> use pinctrl.
> 

Here leds-gpio driver requirement is to set mux configuration of
those 4 pins to GPIO mode (mode 7) as well direction OUTPUT/INPUT.

Set mux mode to 7 (GPIO usage) should be from led driver, because
this driver have the requirement.

Thanks
AnilKumar
