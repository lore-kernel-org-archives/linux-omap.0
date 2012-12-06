From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Thu, 6 Dec 2012 09:16:42 +0530
Message-ID: <CAJe_ZhcUV7mYaNSEw1kLe8-Ym6RcVEab-1-ZZMT20xsWAb=szQ@mail.gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
	<1354460467-28006-2-git-send-email-tom.leiming@gmail.com>
	<50BB7BA9.4090902@linaro.org>
	<CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
	<50BF7B30.9050904@ti.com>
	<CACVXFVOiu5+M3A14Q-U2FiHYrBjAswp4Jv+Aybs_kV9DiWNHZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CACVXFVOiu5+M3A14Q-U2FiHYrBjAswp4Jv+Aybs_kV9DiWNHZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Andy Green <andy.green@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 6 December 2012 06:57, Ming Lei <tom.leiming@gmail.com> wrote:
> On Thu, Dec 6, 2012 at 12:49 AM, Roger Quadros <rogerq@ti.com> wrote:
>> On 12/03/2012 05:00 AM, Ming Lei wrote:
>>> On Mon, Dec 3, 2012 at 12:02 AM, Andy Green <andy.green@linaro.org> wrote:
>>>> On 02/12/12 23:01, the mail apparently from Ming Lei included:
>>>>
>>>>> Power controller is an abstract on simple power on/off switch.
>>>>>
>>>>> One power controller can bind to more than one device, which
>>>>> provides power logically, for example, we can think one usb port
>>>>> in hub provides power to the usb device attached to the port, even
>>>>> though the power is supplied actually by other ways, eg. the usb
>>>>> hub is a self-power device. From hardware view, more than one
>>>>> device can share one power domain, and power controller can power
>>>>> on if one of these devices need to provide power, and power off if
>>>>> all these devices don't need to provide power.
>>>>
>>>>
>>>> What stops us using struct regulator here?  If you have child regulators
>>>> supplied by a parent supply, isn't that the right semantic already without
>>>> introducing a whole new thing?  Apologies if I missed the point.
>>>
>>> There are two purposes:
>>>
>>> One is to hide the implementation details of the power controller because
>>> the user doesn't care how it is implemented, maybe clock, regulator, gpio
>>> and other platform dependent stuffs involved, so the patch simplify the usage
>>> from the view of users.
>>>
>>
>> Which user are you talking about?
>
> Here it is the usb port device.
>
> At least, there are many boards which have hardwired and self-powered usb
> devices, so in theory they can benefits from the power controller.  Maybe
> only regulator and clock can't be covered completely for other boards.
>
> The patch can make usb port deal with the 'power controller' only, and make it
> avoid to deal with regulators/clocks/... directly.
>
I am curious too, except for clocks and voltage supplies (regulators),
what other external resources does a chip need ?
