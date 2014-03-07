From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] power_supply: Introduce PSE compliant algorithm
Date: Fri, 7 Mar 2014 11:34:14 +0800
Message-ID: <CACRpkdanZ2NiwAkd2nTXQ1=bqqmatbGXxK8t9TGSYfjG8cvJZQ@mail.gmail.com>
References: <1391490780-6141-1-git-send-email-jenny.tc@intel.com>
	<1391490780-6141-4-git-send-email-jenny.tc@intel.com>
	<CACRpkdbppewuSSJu=Y=1T7oOCxz_ynhNspyPT=S894KoUB6H6g@mail.gmail.com>
	<20140228030727.GB27921@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:51073 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaCGDeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Mar 2014 22:34:15 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so3625986obc.10
        for <linux-omap@vger.kernel.org>; Thu, 06 Mar 2014 19:34:15 -0800 (PST)
In-Reply-To: <20140228030727.GB27921@jenny-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jenny Tc <jenny.tc@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, =?windows-1251?B?yOLg6evuIMTo7Ojy8O7i?= <freemangordon@abv.bg>, Linux-

On Fri, Feb 28, 2014 at 11:07 AM, Jenny Tc <jenny.tc@intel.com> wrote:
> On Thu, Feb 27, 2014 at 09:18:57PM +0100, Linus Walleij wrote:
>> On Tue, Feb 4, 2014 at 6:12 AM, Jenny TC <jenny.tc@intel.com> wrote:
>>
>> > +static inline bool __is_battery_full
>> > +       (long volt, long cur, long iterm, unsigned long cv)
>>
>> Overall I wonder if you've run checkpatch on these patches, but why
>> are you naming this one function with a double __underscore?
>> Just is_battery_full_check() or something would work fine I guess?
>
> Just to convey that is_battery_full is a local function and not generic. You
> can find similar usage in power_supply_core.c (__power_supply_changed_work)
> and in other drivers. Isn't it advised to have __ prefixes?

The preference is different, usually __ is for compiler things, but
while I dislike it (disturbs my perception) I can sure live with it.

>> Why are you packing these structs? If no real reason, remove it.
>> The compiler will pack what it thinks is appropriate anyway.
>
> The structure is part of the  battery charging profile which can be read directly
> from an EEPROM or from secondary storage (emmc). So it should be packed to keep
> it align with the stored format.

OK I buy that. Make sure this is noted somewhere (or maybe I missed it).

Yours,
Linus Walleij
