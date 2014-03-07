From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] power_supply: Introduce generic psy charging driver
Date: Fri, 7 Mar 2014 21:09:50 +0100
Message-ID: <20140307200949.GA27645@amd.pavel.ucw.cz>
References: <1392875640-29230-1-git-send-email-jenny.tc@intel.com>
 <1392875640-29230-3-git-send-email-jenny.tc@intel.com>
 <CACRpkdaU44iinj2iDNdYm62J+4jQbg+XJ=Zq4GmJryPeu7GfTQ@mail.gmail.com>
 <20140228042753.GC27921@jenny-desktop>
 <CACRpkdbuCC=-aYmyeaGW0GfkhRU8SEc=1+2f6k3tA7TygiZRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbuCC=-aYmyeaGW0GfkhRU8SEc=1+2f6k3tA7TygiZRJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jenny Tc <jenny.tc@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordo>
List-Id: linux-omap@vger.kernel.org

Hi!

> >> > +++ b/include/linux/power/power_supply_charger.h
> >>
> >> > +#define MAX_CUR_VOLT_SAMPLES 3
> >> > +#define DEF_CUR_VOLT_SAMPLE_JIFF (30*HZ)
> >>
> >> Why are things defined in Jiffies like this insead of seconds, milliseconds
> >> etc? This will vary with the current operating frequency of the system,
> >> why should physical measurements do that?
> >
> > Is it fine if I use msecs_to_jiffies(30000)?
> 
> Keep the
> #define DEF_CUR_VOLT_SAMPLE_PERIOD 30000
> 
> Then use msecs_to_jiffies(DEF_CUR_VOLT_SAMPLE_PERIOD)
> in the call site.

Actually, I do not think this is good suggestion. 30*HZ -- is pretty
clearly 30 seconds. 30000 may be 30sec or 30msec ... hard to tell.

If the constant is used in just one place, maybe you don't need the
define?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
