From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 17 Mar 2015 11:01:42 +0100
Message-ID: <20150317100142.GA3759@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <9A1B178A-2751-4864-94B5-FCDCDA2E3875@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9A1B178A-2751-4864-94B5-FCDCDA2E3875@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Tue 2015-03-17 10:07:12, Dr. H. Nikolaus Schaller wrote:
> 
> Am 17.03.2015 um 09:47 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> > Hi!
> > 
> >>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >>>> new file mode 100644
> >>>> index 0000000..bb3580c
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >>>> @@ -0,0 +1,43 @@
> >>>> +twl4030_madc_battery
> >>>> +
> >>>> +Required properties:
> >>>> + - compatible : "ti,twl4030-madc-battery"
> >>>> + - capacity-uah : battery capacity in uAh
> >>> 
> >>> Could we make it capacity-uAh ?
> >> This name was suggested by Mark Rutland [1] and naming convention
> >> should be all lowercase. There exists already bindings
> >> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.
> > 
> > Messing up SI units due to "convention" is _stupid_. Don't do it.
> > 
> >>> to introduce coefficients for temperature and discharge rate?
> >> What do you mean? Nothing like that is used in current driver why do
> >> we need to add it?
> > 
> > Well, conversion between Li-ion's voltage and state of charge at 0
> > current is well known:
> > 
> >    def percent(m, v):
> >    	u = 0.0387-(1.4523*(3.7835-v))
> >        if u < 0:
> >            return 0
> >          return (0.1966+math.sqrt(u))*100
> 
> I forgot to ask: does the kernel have a sqrt() function?

This could be good enough.

https://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/fix-sqrt.patch

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
