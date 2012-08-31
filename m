From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/5] leds: leds-gpio: adopt pinctrl support
Date: Fri, 31 Aug 2012 17:54:18 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2329D@DBDE01.ent.ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-5-git-send-email-anilkumar@ti.com>
 <20120831160402.GN1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120831160402.GN1303-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thanks for the review,

On Fri, Aug 31, 2012 at 21:34:04, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> [120831 02:30]:
> > Adopt pinctrl support to leds-gpio driver, based on the device
> > pointer (leds-gpio) pinctrl driver configure SoC pins to GPIO
> > mode.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/leds/leds-gpio.c |   31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> > index c032b21..d98dfb9 100644
> > --- a/drivers/leds/leds-gpio.c
> > +++ b/drivers/leds/leds-gpio.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/module.h>
> > +#include <linux/pinctrl/consumer.h>
> >  
> >  struct gpio_led_data {
> >  	struct led_classdev cdev;
> > @@ -236,14 +237,23 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
> >  {
> >  	struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
> >  	struct gpio_leds_priv *priv;
> > -	int i, ret = 0;
> > +	struct pinctrl *pinctrl;
> > +	int i = 0;
> > +	int ret = 0;
> > +
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl)) {
> > +		return PTR_ERR(pinctrl);
> > +	}
> 
> I think you need to just print out a warning here as most systems don't
> have the pinctrl implemented. And some people just do static pinmuxing
> in the bootloader.
> 

Yes, that is better approach I will fix this in my next version.
I will separate out this patch from the series because these changes are
leds-gpio driver specific which are different from DT data (pinctrl and
d_can).

Thanks
AnilKumar
