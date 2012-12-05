From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Wed, 5 Dec 2012 18:49:52 +0200
Message-ID: <50BF7B30.9050904@ti.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-2-git-send-email-tom.leiming@gmail.com> <50BB7BA9.4090902@linaro.org> <CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39524 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab2LEQup (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 11:50:45 -0500
In-Reply-To: <CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Andy Green <andy.green@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On 12/03/2012 05:00 AM, Ming Lei wrote:
> On Mon, Dec 3, 2012 at 12:02 AM, Andy Green <andy.green@linaro.org> wrote:
>> On 02/12/12 23:01, the mail apparently from Ming Lei included:
>>
>>> Power controller is an abstract on simple power on/off switch.
>>>
>>> One power controller can bind to more than one device, which
>>> provides power logically, for example, we can think one usb port
>>> in hub provides power to the usb device attached to the port, even
>>> though the power is supplied actually by other ways, eg. the usb
>>> hub is a self-power device. From hardware view, more than one
>>> device can share one power domain, and power controller can power
>>> on if one of these devices need to provide power, and power off if
>>> all these devices don't need to provide power.
>>
>>
>> What stops us using struct regulator here?  If you have child regulators
>> supplied by a parent supply, isn't that the right semantic already without
>> introducing a whole new thing?  Apologies if I missed the point.
> 
> There are two purposes:
> 
> One is to hide the implementation details of the power controller because
> the user doesn't care how it is implemented, maybe clock, regulator, gpio
> and other platform dependent stuffs involved, so the patch simplify the usage
> from the view of users.
> 

Which user are you talking about?

AFAIK for Panda we only need a regulator and a clock for each root port.
IMHO we should just use the existing regulator and clock frameworks.

> Another is that several users may share one power controller, and the
> introduced power controller can help users to use it.
> 

True. e.g. the same regulator could be used to power 3 root hub ports in
a ganged setup. But the regulator framework is sufficient to deal with
that. Each port will call regulator_get() and regulator_enable() and the
physical regulator won't be disabled till all of them have called
regulator_disable().

regards,
-roger
