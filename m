From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Mon, 16 Mar 2015 22:20:51 +0100
Message-ID: <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
	<1423088075-10025-4-git-send-email-marek@goldelico.com>
	<20150316210532.GA11441@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150316210532.GA11441@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 16, 2015 at 10:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2015-02-04 23:14:32, Marek Belisko wrote:
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>>  .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>> new file mode 100644
>> index 0000000..bb3580c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>> @@ -0,0 +1,43 @@
>> +twl4030_madc_battery
>> +
>> +Required properties:
>> + - compatible : "ti,twl4030-madc-battery"
>> + - capacity-uah : battery capacity in uAh
>
> Could we make it capacity-uAh ?
This name was suggested by Mark Rutland [1] and naming convention
should be all lowercase. There exists already bindings
without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.
>
>> + - volt-to-capacity-charging-map : list of voltage(mV):level(%) values
>> +     for charging calibration (see example)
>> + - volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
>> +     for discharging calibration (see example)
>
> Would "mV-to-capacity..." be more accurate? Also, would it make sense
Again maybe mv but it can be added also later.
> to introduce coefficients for temperature and discharge rate?
What do you mean? Nothing like that is used in current driver why do
we need to add it?
>
> Thanks,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

[1] - http://lists.openwall.net/linux-kernel/2014/10/09/104

BR,

marek


-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
