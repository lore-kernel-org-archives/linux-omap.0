From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Tue, 17 Mar 2015 10:07:12 +0100
Message-ID: <9A1B178A-2751-4864-94B5-FCDCDA2E3875@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com> <1423088075-10025-4-git-send-email-marek@goldelico.com> <20150316210532.GA11441@amd> <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com> <20150317084730.GA9761@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:13708 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbbCQJHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 05:07:50 -0400
In-Reply-To: <20150317084730.GA9761@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>


Am 17.03.2015 um 09:47 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> new file mode 100644
>>>> index 0000000..bb3580c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> @@ -0,0 +1,43 @@
>>>> +twl4030_madc_battery
>>>> +
>>>> +Required properties:
>>>> + - compatible : "ti,twl4030-madc-battery"
>>>> + - capacity-uah : battery capacity in uAh
>>> 
>>> Could we make it capacity-uAh ?
>> This name was suggested by Mark Rutland [1] and naming convention
>> should be all lowercase. There exists already bindings
>> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.
> 
> Messing up SI units due to "convention" is _stupid_. Don't do it.
> 
>>> to introduce coefficients for temperature and discharge rate?
>> What do you mean? Nothing like that is used in current driver why do
>> we need to add it?
> 
> Well, conversion between Li-ion's voltage and state of charge at 0
> current is well known:
> 
>    def percent(m, v):
>    	u = 0.0387-(1.4523*(3.7835-v))
>        if u < 0:
>            return 0
>          return (0.1966+math.sqrt(u))*100

I forgot to ask: does the kernel have a sqrt() function?
> 
> And there's not much to calibrate there, and it should become library
> helper function; there's no need to write it to every single dts.
> 
> The charge/discharge difference is due to internal battery resistance,
> and Ohm's law. (Then, you should not need different values for
> charging/discharging case.)
> 
> With your aproach, you'll get lower percentage when phone is under
> load vs. idle. Taking internal resistance into account would give you
> more precise readings. (Attached, old patch for zaurus shows the
> needed computation).
> 
> And if you wanted even more precise readings... internal resistance
> depends on temperature.
> 
> I guess this should go into library somewhere, because many machines
> need similar code.
> 
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> <zbattery.10.diff>

