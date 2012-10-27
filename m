From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Sat, 27 Oct 2012 16:28:07 +0530
Message-ID: <508BBE3F.307@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <20121026200137.GC29548@arwen.pp.htv.fi> <508B0310.60807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab2J0K6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 06:58:15 -0400
In-Reply-To: <508B0310.60807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

On Saturday 27 October 2012 03:09 AM, Jon Hunter wrote:
>
> On 10/26/2012 03:01 PM, Felipe Balbi wrote:
>> Hi,
>>
>> On Fri, Oct 26, 2012 at 03:19:13PM +0200, Tim Niemeyer wrote:
>>> Adds support for configuring the omap-gpio driver use autosuspend f=
or
>>> runtime power management. This can reduce the latency in using it b=
y
>>> not suspending the device immediately on idle. If another access ta=
kes
>>> place before the autosuspend timeout (2 secs), the call to resume t=
he
>>> device can return immediately saving some save/ restore cycles.
>>>
>>> This removes also the bank->mod_usage counter, because this is alre=
ady
>>> handled in pm_runtime.
>>>
>>> I use a gpio to monitor a spi transfer which occurs every 250=B5s. =
The
>>> suspend overhead is to high, so almost every second transfer is los=
t.
>>> This patch fixes that.
>>>
>>> Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
>>> ---
>>>   drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++---------=
------------
>>>   1 files changed, 43 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 94cbc84..708d5a9 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -31,6 +31,7 @@
>>>   #include <asm/mach/irq.h>
>>>
>>>   #define OFF_MODE	1
>>> +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
>>
>> something just hit me... If you keep timeout at 2000 ms and you hook
>> this up to an IRQ line, it's very unlikely GPIO will ever sleep.
>>
>> Why did you choose 2000 ms ? Arbitrary value ?
>
> It does seem quite large. I wonder if the default timeout should be
> something much smaller and then users can set the timeout needed for
> their specific application via the sysfs.
>
> By the way, it appears that I keep getting unsubscribed from linux-om=
ap
> mailing list and I only saw this because you copied me. Thanks Felipe=
!
> Can you bounce the thread to me?
>
I didn't get this email either though am getting other LOML emails.
Please bounce the thread.

Am curious to see the implementation, since GPIO IP as such doesn't hav=
e
any state machine of any sort.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
