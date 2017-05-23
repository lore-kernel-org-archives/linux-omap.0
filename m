From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module
 and w2cbw003 wifi/bluetooth
Date: Tue, 23 May 2017 07:28:18 -0500
Message-ID: <CAL_JsqJamBBggr9AOQtQWtZOG+FevK1XEU_D=nYL6=hyvjviVw@mail.gmail.com>
References: <cover.1495363443.git.hns@goldelico.com> <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com>
 <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On Tue, May 23, 2017 at 12:43 AM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> Hi Rob,
>
>> Am 23.05.2017 um 04:26 schrieb Rob Herring <robh+dt@kernel.org>:
>>
>> On Sun, May 21, 2017 at 5:44 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Since our proposed API was not acceptable and the new serdev API has arrived in 4.11 kernels,
>>> we finally took the challenge to update the w2sg and w2cbw drivers to use the serdev API.
>>>
>>> The approach is to write a "man in the middle" driver which is on one side a serdev client
>>> which directly controls the UART where the device is connected to and on the other side
>>> presents a new tty port so that user-space software can talk to the chips as if they would
>>> directly talk to the UART of the SoC (e.g. ttyO1). This is similar to connecting to a remote
>>> serial device e.g. through USB (ttyACM) or Bluetooth UART profiles.
>>>
>>> For example gpsd or hciattach expect a /dev/tty they can control (flow control, baud rate
>>> etc.).
>>
>> I understand from the prior discussion why you want to pass the data
>> thru for gps, but why do you need to do that for BT?
>
> Because we otherwise can't turn on power when /dev/ttyBT0 is opened and turn off when it
> is closed. I.e. it should not be powered unless someone does a hciattach /dev/ttyBT0. And it
> should be turned off by a killall hciattach.

Still, you can do power control within BT HCI drivers. You wouldn't be
limited to just open/close, but can handle suspend/resume as well.

> Basically we would like to have a power control automatic like it exists for many other devices.
>
> Since the BT chip is described as a serdev by DT, we see no other means than to pass data
> through the serdev driver.

We could have a blacklist if we need to have serdev not create a
device and create a tty device instead.

> We had looked into the line discipline approach but it makes a lot of problems. The first one
> is that registering a new system-wide ldesc number is required. Next we do not see how to make
> a serdev driver (as it seems to be required by the DT) to register a different ldesc.
>
>>
>>> Here is the result of our first hack which is working as a demo on GTA04 devices (and the
>>> w2cbw driver can also be used to control a GTA04 variant with WL1837).
>>>
>>> Since it is just a demo hack, the code is not yet cleaned up, nor does it completely pass
>>> check-patch, nor follows 100% the coding styles. And certainly has some bugs.
>>>
>>> The most significant issue is that calling tty_port_register_device() inside of the
>>> serdev probe() function makes the serdev probe() function to be entered a second
>>> time. This does not lead to big problems since we currently have minor = 0
>>> and this makes the second call assume the device is not available.
>>>
>>> But we have no idea why this happens and how it can be prevented.
>>
>> Johan's fixes may help there, but it is intended to be temporary to
>> have a separate API for registering tty ports with or without serdev.
>
> Ah, would that mean something like a tty_port_register_device_without_serdev()?

Yes, but other way around. The old function doesn't register with
serdev and there's a new function that will.

> Do you have a reference to his fixes?

They are in Greg's tty-linus branch if not Linus' tree now.

Rob
