From: Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Sun, 9 Sep 2012 01:44:35 +0200
Message-ID: <20120908234435.GA13519@glitch>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
 <20120907110251.GA7968@glitch>
 <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
 <20120907160025.GB14330@glitch>
 <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 07, 2012 at 11:57:59PM +0200, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 6:00 PM, Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Fri, Sep 07, 2012 at 02:30:59PM +0000, AnilKumar, Chimata wrote:
> 
> >> How can gpio driver knows that leds-gpio driver require
> >> these 4 pins?
> >
> > because leds-gpio requests each gpio (specified in the DT against a specific
> > gpio controller) before assuming it is available?  gpiolib then asks to
> > pinctrl if those pins are available for gpio and possibly reserve them
> > (configuring the mux, if necessary) for the device.
> 
> So this is not an either-or situation but a both-and case.
>
...
> 
> If all you need to to is to multiplex the pins into GPIO mode,
> then the gpio_get() call on this driver *can* call through to
> pinctrl_request_gpio() which will in turn fall through to the
> above pinmux driver calls (.gpio_request_enable, etc).

So if the GPIO driver doesn't coordinate with the pinctrl driver, it's
all left to the GPIO user to configure the pin before using it, right?

I can understand the concerns of Tony, whether a pin must be requested
or not before the gpio then depends on the GPIO driver implementation,
which may or may not call through the pinctrl layer, isn't it?.

> But that's as far as it goes! The GPIO abstraction cannot
> call through to e.g. set some specific biasing on the pins
> (pull up etc). Doing that would require us to reimplement
> every interface that pinctrl already has again in the
> GPIO layer, which is not a good idea.

Yes, clear. Never meant that, I thought that the pinctrl was anyway
available for stuff not modeled by the GPIO layer, as you say below.

> So the pinctrl handle can be used for such config, and it
> can also be used for multiplexing if that is desired - if not
> done by the fall through functions pinctrl_gpio_*().
> 
> You can use a combination of both too, Stephen patched
> pinctrl some time back so that a pin can be muxed for a
> certain function and used as GPIO at the same time, so
> these two are now orthogonal, it's a bit relaxed and gives some
> feeling of loss of control but was necessary for certain
> usecases. (For example we can snoop on a I2C pin using
> its corresponding GPIO registers in the U300...)
>
> There is some flexibility here, I hope it's not too confusing :-/

Thank you for clarifying :)

Regards,
Domenico
