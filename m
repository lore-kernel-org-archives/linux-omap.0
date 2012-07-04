From: Archit Taneja <a0393947@ti.com>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Wed, 4 Jul 2012 16:08:05 +0530
Message-ID: <4FF41D0D.20403@ti.com>
References: <WC20120618103957.6103F2@terrafix.co.uk> <87zk7h5096.fsf@ti.com>  <WC20120703083759.980337@terrafix.co.uk> <4FF2B476.6000900@ti.com>  <WC20120703091232.480345@terrafix.co.uk> <4FF2D089.8030507@ti.com> <1341383330.9066.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933477Ab2GDKjX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 06:39:23 -0400
In-Reply-To: <1341383330.9066.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org

On Wednesday 04 July 2012 11:58 AM, Tomi Valkeinen wrote:
> On Tue, 2012-07-03 at 16:29 +0530, Archit Taneja wrote:
>
>> Thanks for testing this out.
>>
>> I was going through Tomi's queue for the 3.6 merge window:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git master
>>
>> There is a commit called:
>>
>> 2b8501d777346ce1d4fe99167e9b3c0e42aae7a8
>>
>> OMAPDSS: Use PM notifiers for system suspend
>>
>> The commit message mentions the issue you see, and seems to resolve it.
>> Could you give this a try?
>>
>> Tomi is out on vacation, and I don't know why this wasn't intended for
>> the 3.5-rcs, maybe there are still some discussion going on about this?
>
> I just missed it due to the pre-vacation hassle, I was so focused on
> getting the stuff ready for next merge window.
>
> With a quick glance to my master branch, the "OMAPDSS: Use PM notifiers
> for system suspend" looks like it could go for 3.5-rc, and also
> "OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n".
>
> Archit, can you check that both apply fine to mainline, and send them to
> Florian for 3.5-rc. And make clear they are for him, so that he doesn't
> think I'll handle them =).

Sure, will do.

Archit
