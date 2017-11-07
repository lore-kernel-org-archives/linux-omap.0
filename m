From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: Battery charging, battery status on Nokia N9, N950
Date: Tue, 7 Nov 2017 21:04:19 +0100
Message-ID: <CAOf5uwnoUkZG6KUzhn2u8vdcd5_+nmUQpXwE1zjNwiakN+Mscg@mail.gmail.com>
References: <20171103210349.GA14071@amd> <20171107195020.GA19508@amd> <20171107195912.GA3274@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107195912.GA3274@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Hi Pavel

On Tue, Nov 7, 2017 at 8:59 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>>
>> > I'm fighting with battery status & battery charging on Nokia
>> > N9/N950. https://elinux.org/N950 contains enough info to get battery
>> > status (and below is first attempt at kernel implementation), but I'm
>> > not sure what needs to be done to charge the battery (or at least
>> > power phone from USB).
>>
>> Nemo recovery system (2824336 Jul 25  2016 zImage-moslo) seems to
>> either charge phone from USB or at power it from USB.
>>
>> But 4.13 does not; it seems there are two separate issue.
>>
>> First, something needs to be done to enable system power from the
>> USB. I'm not sure what that one would be :-(. Then, it should be
>> possible to ask bq24153 to charge the battery.
>
> If someone has schematics or pointer to them.. for N9 or N950, that
> would be useful :-).
>

You can dump pinctrl and configuration and check if some gpio are
used.  From reference schematic of this charger you have OTG and
CD. Those pins can be just used to enable/disable and boost charging.
You should dig a bit in sysfs to figure it out ;)

Michael


> Thanks,
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
