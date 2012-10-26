From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 16:39:28 -0500
Message-ID: <508B0310.60807@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <20121026200137.GC29548@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56161 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab2JZVjb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 17:39:31 -0400
In-Reply-To: <20121026200137.GC29548@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tim Niemeyer <tim.niemeyer@corscience.de>, Linux OMAP List <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>


On 10/26/2012 03:01 PM, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Oct 26, 2012 at 03:19:13PM +0200, Tim Niemeyer wrote:
>> Adds support for configuring the omap-gpio driver use autosuspend fo=
r
>> runtime power management. This can reduce the latency in using it by
>> not suspending the device immediately on idle. If another access tak=
es
>> place before the autosuspend timeout (2 secs), the call to resume th=
e
>> device can return immediately saving some save/ restore cycles.
>>
>> This removes also the bank->mod_usage counter, because this is alrea=
dy
>> handled in pm_runtime.
>>
>> I use a gpio to monitor a spi transfer which occurs every 250=B5s. T=
he
>> suspend overhead is to high, so almost every second transfer is lost=
=2E
>> This patch fixes that.
>>
>> Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
>> ---
>>  drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++-----------=
----------
>>  1 files changed, 43 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..708d5a9 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -31,6 +31,7 @@
>>  #include <asm/mach/irq.h>
>> =20
>>  #define OFF_MODE	1
>> +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
>=20
> something just hit me... If you keep timeout at 2000 ms and you hook
> this up to an IRQ line, it's very unlikely GPIO will ever sleep.
>=20
> Why did you choose 2000 ms ? Arbitrary value ?

It does seem quite large. I wonder if the default timeout should be
something much smaller and then users can set the timeout needed for
their specific application via the sysfs.

By the way, it appears that I keep getting unsubscribed from linux-omap
mailing list and I only saw this because you copied me. Thanks Felipe!
Can you bounce the thread to me?

Also if anyone knows why I could be getting unsubscribed let me know.
May be my emails have a bad signal to noise ratio :-(

Cheers
Jon



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
