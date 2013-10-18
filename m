From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 18 Oct 2013 08:35:42 -0700
Message-ID: <20131018153541.GJ15154@atomide.com>
References: <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
 <20131011154352.GO29913@atomide.com>
 <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
 <20131011160146.GR29913@atomide.com>
 <5260E606.2030903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5260E606.2030903@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Balaji T K <balajitk@ti.com> [131018 00:41]:
> 
> Any conclusion on using regmap for omap control module non-mux registers ?

I don't think anybody has even started looking into a SCM driver
yet considering there are tons of other issues to sort out.

If you're thinking about implementing the MMC PBIAS driver, I would
just implement it as a standalone driver. It seems that the PBIAS
interface to the MMC driver can be just regulator framework.

Then when we have the SCM driver available, this driver can be
updated to coordinate things with the core SCM driver.

Regards,

Tony
