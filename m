From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/13] ARM: gpio: davinci: convert drivers to use
	asm/gpio.h rather than mach/gpio.h
Date: Tue, 9 Aug 2011 20:45:53 +0100
Message-ID: <20110809194553.GA14281@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk> <E1QqhKP-0003aK-9R@rmk-PC.arm.linux.org.uk> <4E4122B6.2070706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E4122B6.2070706@ru.mvista.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 09, 2011 at 04:06:14PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> On 09-08-2011 12:06, Russell King - ARM Linux wrote:
>
>    CCing linux-usb and Felipe...
>
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> ---
>>   drivers/usb/musb/davinci.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>
>> diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
>> index 8bdf25a..f9a3f62 100644
>> --- a/drivers/usb/musb/davinci.c
>> +++ b/drivers/usb/musb/davinci.c
>> @@ -35,7 +35,7 @@
>>
>>   #include<mach/hardware.h>
>>   #include<mach/memory.h>
>> -#include<mach/gpio.h>
>> +#include<asm/gpio.h>
>
>    Shouldn't this now be moved to the below #include group?

When doing this kind of work with sed -i, that doesn't happen.  There's
too much of this crap (and I've been telling people about this for at
least a year) that I don't think there's that luxury anymore.

If maintainers would have paid more attention, then most of these changes
would not be necessary.  My view is that if maintainers do care about this
stuff _they_ should have been the ones to pick up on it long ago.  In
other words, they've lost the right to complain about petty crap like
the ordering of includes through their own inaction on this point.
