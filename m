From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] arm: omap2: support port power on lan95xx devices
Date: Wed, 05 Dec 2012 15:33:42 +0800
Message-ID: <50BEF8D6.1050304@linaro.org>
References: <Pine.LNX.4.44L0.1212031154460.1309-100000@iolanthe.rowland.org> <50BD7095.5090103@linaro.org> <20121204181451.GB5039@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20121204181451.GB5039@xanatos>
Sender: linux-pm-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 05/12/12 02:14, the mail apparently from Sarah Sharp included:
> On Tue, Dec 04, 2012 at 11:40:05AM +0800, Andy Green wrote:
>> On 04/12/12 01:09, the mail apparently from Alan Stern included:
>>> On Mon, 3 Dec 2012, Andy Green wrote:
>>>
>>>> Unless someone NAKs it for sure already (if you're already sure yo=
u're
>>>> going to, please do so to avoid wasting time), I'll issue a try#2 =
of my
>>>> code later which demonstrates what I mean.  At least I guess it's =
useful
>>>> for comparative purposes.
>>>
>>> Before you go writing a whole lot more code, we should discuss the
>>> basics a bit more clearly.  There are several unsettled issues here=
:
>>
>>>       1. Should the LAN95xx stuff be associated with the ehci-omap.=
0's
>>> 	driver or with the hub port?  The port would be more flexible,
>>> 	offering the ability to turn the power off and on while the
>>> 	system is running without affecting anything else.  But the
>>> 	port code is currently in flux, which could cause this new
>>> 	addition to be delayed.
>>
>> I think associating ULPI PHY reset and SMSC power and reset with the
>> hub port power state is good.  Then, you could have the driver in a
>> device with multiple onboard USB devices, and individually control
>> whether they're eating power or not.  In the asset case, you'd
>> associate mux assets with ehci-omap.0.
>>
>> Yesterday I studied the hub port code and have a couple of patches,
>> one normalizes the hub port device to have a stub driver.
>>
>> The other then puts hub port power state signalling into runtime_pm
>> handlers in the hub port device.  Until now, actually there's no
>> code in hub.c to switch off a port.
>
> Did you take a look at the most recent patches from Tianyu to add
> support to power off a port if a device is suspended?
>
> Start of the series:
> http://marc.info/?l=3Dlinux-usb&m=3D135314427413307&w=3D2
> Patch that adds power off on device suspend:
> http://marc.info/?l=3Dlinux-usb&m=3D135314431913321&w=3D2
>
> Tianyu also added some code to the xHCI host controller driver to cal=
l
> into the ACPI methods to power off a port when the USB hub driver cle=
ars
> the port power feature.

No I didn't know about it, I will study these along with pm_domain stuf=
f=20
thanks.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
