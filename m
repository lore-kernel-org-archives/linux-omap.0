From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] power_supply: Introduce generic psy charging driver
Date: Wed, 12 Mar 2014 15:37:17 +0100
Message-ID: <CACRpkda_9UG70G-b3eGTccr22WC4eoAbj0g2QgX0DRSYVgvrxA@mail.gmail.com>
References: <1392875640-29230-1-git-send-email-jenny.tc@intel.com>
	<1392875640-29230-3-git-send-email-jenny.tc@intel.com>
	<CACRpkdaU44iinj2iDNdYm62J+4jQbg+XJ=Zq4GmJryPeu7GfTQ@mail.gmail.com>
	<20140228100114.GA13189@amd.pavel.ucw.cz>
	<CACRpkdaZ2moqGWx2BpfEeKoW6doXg67TkJKY+mbg4hrFHDr16Q@mail.gmail.com>
	<20140307201039.GB27645@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49428 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaCLOhR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 10:37:17 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so10213330oag.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2014 07:37:17 -0700 (PDT)
In-Reply-To: <20140307201039.GB27645@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jenny TC <jenny.tc@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, =?windows-1251?B?yOLg6evuIMTo7Ojy8O7i?= <freemangordon@abv.bg>Lin

On Fri, Mar 7, 2014 at 9:10 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2014-03-07 11:04:59, Linus Walleij wrote:
>> On Fri, Feb 28, 2014 at 6:01 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Thu 2014-02-27 21:08:01, Linus Walleij wrote:
>> >> On Thu, Feb 20, 2014 at 6:53 AM, Jenny TC <jenny.tc@intel.com> wr=
ote:
>> >>
>> >> > +++ b/include/linux/power/power_supply_charger.h
>> >>
>> >> > +#define MAX_CUR_VOLT_SAMPLES 3
>> >> > +#define DEF_CUR_VOLT_SAMPLE_JIFF (30*HZ)
>> >>
>> >> Why are things defined in Jiffies like this insead of seconds, mi=
lliseconds
>> >> etc? This will vary with the current operating frequency of the s=
ystem,
>> >> why should physical measurements do that?
>> >
>> > It is actually ok. The define is relative to jiffies, and that's w=
hat
>> > interface expects.
>>
>> So consider the option that the interface is wrong.
>>
>> Stating something like a sample period in system-specific jiffies
>> instead of period time T is just weird. What control systems
>> guy would understand this?
>
> 30*HZ means 30 seconds in the kernel... what is hard to understand
> about it?

Well I might be picky, but since it is a charging algorithm dealing wit=
h
amp=E8res, volts, constant-current/constant-voltage, watchdogs and
timeouts, all stated in SI units, it would be nice if all such constant=
s
were specified in simple units instead of kernel-specific terms.

One reason is that this kind of code actually needs review from
non-programmers, people like chemists and physicists.

I know it may be far fetched so no strong preference for sure.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
