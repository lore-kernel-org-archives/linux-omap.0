From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Mon, 3 Dec 2012 11:00:44 +0800
Message-ID: <CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
	<1354460467-28006-2-git-send-email-tom.leiming@gmail.com>
	<50BB7BA9.4090902@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49992 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab2LCDAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Dec 2012 22:00:46 -0500
In-Reply-To: <50BB7BA9.4090902@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>

On Mon, Dec 3, 2012 at 12:02 AM, Andy Green <andy.green@linaro.org> wrote:
> On 02/12/12 23:01, the mail apparently from Ming Lei included:
>
>> Power controller is an abstract on simple power on/off switch.
>>
>> One power controller can bind to more than one device, which
>> provides power logically, for example, we can think one usb port
>> in hub provides power to the usb device attached to the port, even
>> though the power is supplied actually by other ways, eg. the usb
>> hub is a self-power device. From hardware view, more than one
>> device can share one power domain, and power controller can power
>> on if one of these devices need to provide power, and power off if
>> all these devices don't need to provide power.
>
>
> What stops us using struct regulator here?  If you have child regulators
> supplied by a parent supply, isn't that the right semantic already without
> introducing a whole new thing?  Apologies if I missed the point.

There are two purposes:

One is to hide the implementation details of the power controller because
the user doesn't care how it is implemented, maybe clock, regulator, gpio
and other platform dependent stuffs involved, so the patch simplify the usage
from the view of users.

Another is that several users may share one power controller, and the
introduced power controller can help users to use it.

Also the power controller is stored as device resource, not any new
stuff added into 'struct device', and all users of the power controller
needn't write code to operate device resource things too.

Thanks,
-- 
Ming Lei
