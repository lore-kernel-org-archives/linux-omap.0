From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 14:46:33 -0700
Message-ID: <20120907214633.GO1303@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <201209050513.08588.marex@denx.de>
 <20120905233416.GP1303@atomide.com>
 <201209060405.08997.marex@denx.de>
 <20120906174531.GX1303@atomide.com>
 <CACRpkdYgcYAFy7bBn3XNcrkSoCpeA8yNaa9LZNd4w33Zp3Jjnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYgcYAFy7bBn3XNcrkSoCpeA8yNaa9LZNd4w33Zp3Jjnw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [120907 14:40]:
> On Thu, Sep 6, 2012 at 7:45 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> >> > The warning should be pinctrl related as the pinctrl drivers may not be
> >> > device tree based drivers.
> >>
> >> Exactly my concern. Also the warning shouldnt be present on systems where
> >> pinctrl is disabled.
> >
> > But pinctrl_get_select() returns 0 in include/linux/pinctrl/consumer.h if
> > CONFIG_PINCTRL is not selected, so no warning is produced AFAIK ;)
> 
> This is correct, nothing to worry about.
> 
> The one troublesome case is if a pinctrl driver is present but not
> being used, then you might need to call pinctrl_provide_dummies().

Thanks that's good to know.

Regards,

Tony
