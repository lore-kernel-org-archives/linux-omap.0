From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 18 Oct 2013 09:06:15 -0700
Message-ID: <20131018160615.GM15154@atomide.com>
References: <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
 <20131011154352.GO29913@atomide.com>
 <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
 <20131011160146.GR29913@atomide.com>
 <5260E606.2030903@ti.com>
 <20131018153541.GJ15154@atomide.com>
 <52615AD4.7040306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52615AD4.7040306-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> [131018 08:59]:
> On Friday 18 October 2013 09:05 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> [131018 00:41]:
> >>
> >>Any conclusion on using regmap for omap control module non-mux registers ?
> >
> >I don't think anybody has even started looking into a SCM driver
> >yet considering there are tons of other issues to sort out.
> >
> >If you're thinking about implementing the MMC PBIAS driver, I would
> >just implement it as a standalone driver. It seems that the PBIAS
> >interface to the MMC driver can be just regulator framework.
> >
> Hi Tony,
> 
> I am testing pbias regulator, Just thinking whether it should be
> using regmap api or direct readl/writel

OK either or should work. It seems that can easily be changed
later on though.
 
> >Then when we have the SCM driver available, this driver can be
> >updated to coordinate things with the core SCM driver.
> 
> Do you see regmap getting used for the SCM driver ?

Yes eventually :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
