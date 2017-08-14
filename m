From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Date: Mon, 14 Aug 2017 07:42:47 +0100
Message-ID: <20170814064247.qvggx4ito4vgjqvs@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <rtc-linux+bncBDA7X7F2WUEBB3EMYXGAKGQE3NHXMMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170813133700.tv4ka7anvbzcplr7@ninjato>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.>
List-Id: linux-omap@vger.kernel.org

On Sun, 13 Aug 2017, Wolfram Sang wrote:

> On Thu, Jul 06, 2017 at 08:03:52AM +0100, Lee Jones wrote:
> > On Thu, 06 Jul 2017, Thierry Reding wrote:
> >=20
> > > On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > > > include/linux/i2c is not for client devices. Move the header file t=
o a
> > > > more appropriate location.
> > > >=20
> > > > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > > > ---
> > > >  arch/arm/mach-omap2/common.h            | 2 +-
> > > >  arch/arm/mach-omap2/omap_twl.c          | 2 +-
> > > >  drivers/gpio/gpio-twl4030.c             | 2 +-
> > > >  drivers/iio/adc/twl4030-madc.c          | 2 +-
> > > >  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
> > > >  drivers/input/keyboard/twl4030_keypad.c | 2 +-
> > > >  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
> > > >  drivers/input/misc/twl4030-vibra.c      | 2 +-
> > > >  drivers/mfd/twl-core.c                  | 6 +++---
> > > >  drivers/mfd/twl4030-audio.c             | 2 +-
> > > >  drivers/mfd/twl4030-irq.c               | 2 +-
> > > >  drivers/mfd/twl4030-power.c             | 2 +-
> > > >  drivers/mfd/twl6030-irq.c               | 2 +-
> > > >  drivers/phy/phy-twl4030-usb.c           | 2 +-
> > > >  drivers/power/supply/twl4030_charger.c  | 2 +-
> > > >  drivers/pwm/pwm-twl-led.c               | 2 +-
> > > >  drivers/pwm/pwm-twl.c                   | 2 +-
> > > >  drivers/regulator/twl-regulator.c       | 2 +-
> > > >  drivers/regulator/twl6030-regulator.c   | 2 +-
> > > >  drivers/rtc/rtc-twl.c                   | 2 +-
> > > >  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
> > > >  drivers/video/backlight/pandora_bl.c    | 2 +-
> > > >  drivers/watchdog/twl4030_wdt.c          | 2 +-
> > > >  include/linux/{i2c =3D> mfd}/twl.h        | 0
> > > >  sound/soc/codecs/twl4030.c              | 2 +-
> > > >  25 files changed, 26 insertions(+), 26 deletions(-)
> > > >  rename include/linux/{i2c =3D> mfd}/twl.h (100%)
> > >=20
> > > I didn't see this get applied yet, so just in case anyone was waiting
> > > for me (this is trivial, so I don't think there's a need):
> >=20
> > You're not the last. :)
>=20
> Given the triviality of the change for non-MFD subsystems, can we apply
> this for 4.14?

I can't apply anything without Acks for *all* of the subsystems above.

As you well know, it is the submitters responsibility to obtain them.

My suggestion would be to collect the Acks you've received up until
this point and identify which SS's are still lacking in change log
section of a RESEND.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
