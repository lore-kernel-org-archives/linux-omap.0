From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
Date: Sun, 18 Jan 2015 14:18:24 -0800
Message-ID: <54BC3130.4010401@roeck-us.net>
References: <20141226102933.GA28778@amd> <1419597294-21487-1-git-send-email-sre@kernel.org> <1419597294-21487-3-git-send-email-sre@kernel.org> <CANOLnON6rAQ2+jJEFDKseH2Htu6bqRkURDioGt7zp1Ze73f8Pw@mail.gmail.com> <CAGo_u6qO0ok+GBnm7SQtw6dJuwGN2OuP7CpKDEWawS3V2go4KA@mail.gmail.com> <20141229181556.GA26926@amd> <20141229190448.GA27124@roeck-us.net> <20150103091858.GA30538@amd> <20150107161944.GB9012@roeck-us.net> <20150118203346.GA29863@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49286 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbARWSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 17:18:55 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YCyBL-000SYJ-47
	for linux-omap@vger.kernel.org; Sun, 18 Jan 2015 22:18:55 +0000
In-Reply-To: <20150118203346.GA29863@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nishanth Menon <nm@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.de>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Pali Rohar <pali.rohar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/18/2015 12:33 PM, Pavel Machek wrote:

>>>> Pavel,
>>>>
>>>> can you look into the omap4 thermal driver to see if it can be used ?
>>>
>>> After some fixes... yes, it seems to be same hardware.
>>>
>> So this should be the way to go, but then we have others claim that
>> it should not be done because the OMAP3 sensors are too unreliable
>> to use for thermal decisions. Not really sure where that leaves us.
>> I am kind of opposed to have similar drivers for similar chips
>> in two different subsystems.
>>
>> Is it possible to add the patch below to the omap thermal driver
>> and not use it for thermal decisions ?
>
> Well... noone forces you to enable the driver, and I don't think it
> will do any thermal decisions on N900 as it is ... so we should be ok.
>
> Plus, it seems to work reasonably well (say +- 5 C), so situation does
> not seem to be as bad as TI claims.
>
> Nokia was actually using it in production.
>
Ok, I'll assume that omap3 support will be added to the omap thermal driver.

Thanks,
Guenter

