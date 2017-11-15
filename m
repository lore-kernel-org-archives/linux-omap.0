From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Wed, 15 Nov 2017 21:12:26 +0100
Message-ID: <CAK8P3a2DT+uOUWYFiYoc_=qFx1oS5xMgWmHde+8tm+BmAENaeg@mail.gmail.com>
References: <cover.1510759152.git.hns@goldelico.com> <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns@goldelico.com>
 <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
 <AFD95D2E-2EBB-4EBF-9B3B-E68ED98E5437@goldelico.com> <CAK8P3a1Ah35mmbw0qN=zp8TMN9HVgdtTSkkSCCayC-5b6Q960A@mail.gmail.com>
 <AFF4418B-740D-4FFE-A3A6-A92E73F0B901@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AFF4418B-740D-4FFE-A3A6-A92E73F0B901-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 8:55 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>> Am 15.11.2017 um 18:03 schrieb Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>> On Wed, Nov 15, 2017 at 5:27 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>>>> Am 15.11.2017 um 16:54 schrieb Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>>> On Wed, Nov 15, 2017 at 4:19 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>>>>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>>>
>>> There is one more goal. Some people are dreaming about a generic GPS interface.
>>> Then, the driver wouldn't have to register a /dev/GPS tty any more but a
>>> gps_interface and mangle serial data as requested by that API. This will become
>>> a simple upgrade.
>>>
>>> So you can consider creating a new tty as sort of temporary solution. Like we
>>> had for years for UART HCI based bluetooth devices using a user-space daemon.
>>
>> It shouldn't be hard to split out the tty_driver portion of your file from the
>> part that registers the port, basically getting two files that each handle
>> half of the work, and the second one would be generic from the start.
>
> Hm. Sounds like a big hack to me instead of using existing API (serdev and tty_port)
> and making the best out of it.
>
> But I may have misunderstood what you mean by splitting out parts of
> a tty (which one?) and why I need two files?
>
> The structure of the driver is:
>
> UART --> serdev magic ---> this device driver ---> register something to present data to user space ---> user space read()
>
> Data should flow following this arrows.
> And power control happens this way:
>
> UART --> serdev magic ---> this device driver <--- register something to present data to user space <--- user space open()
> GPIO <----------------------------+
>
> So we need one serdev port to communicate with the device and something to present serial data to user-space (where gpsd runs).

My suggestion was directed at replacing the big hack (adding one
driver per port, and a different driver for each type of GPS hardware)
with a smaller hack, using one driver to manage the ttyGPS name
space for any implementation. That same driver could later even be
expanded to offer additional ioctl interfaces, e.g. for reading the
current position or time.

Let's ignore that point for the moment though and finish the
discussion below, I think it will become clearer what I meant here
when the split between init() and probe() function is resolved.

>>>>> +       /* initialize the tty driver */
>>>>> +       data->tty_drv->owner = THIS_MODULE;
>>>>> +       data->tty_drv->driver_name = "w2sg0004";
>>>>> +       data->tty_drv->name = "ttyGPS";
>>>>> +       data->tty_drv->major = 0;
>>>>> +       data->tty_drv->minor_start = 0;
>>>>> +       data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>>>>> +       data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>>>>> +       data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>>>>> +       data->tty_drv->init_termios = tty_std_termios;
>>>>> +       data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>>>>> +                                             HUPCL | CLOCAL;
>>>>> +       /*
>>>>> +        * optional:
>>>>> +        * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>>>>> +                                       115200, 115200);
>>>>> +        * w2sg_tty_termios(&data->tty_drv->init_termios);
>>>>> +        */
>>>>> +       tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>>>>
>>>> While I'm still not sure about why we want nested tty port, it
>>>> seems that we should have only one tty_driver that gets initialized
>>>> at module load time, rather than one driver structure per port.
>>>
>>> If we have several such chips connected to different serdev UARTs
>>> we need different /dev/GPS to separate them in user-space.
>>
>> I understand that you need multiple devices, but I don't see
>> what having multiple drivers that all share the same name
>> "w2sg0004" helps. I would have expected that to fail in
>> tty_register_driver() when you get to the second driver,
>> but looking at the code, it doesn't actually try to make the name
>> unique
>
> Yes, that is missing because I copied that from other drivers
> and have no full understanding what is needed to make it really
> work with multiple /dev/ttyGPS0 tty ports.
>
> Therefore each probe (for each device connected to a different uart
> of the SoC) should create a different /dev/ttyGPSn. Like you can have
> multiple and independent i2c clients of the same type and driver.

Right, that's what I mean. But each of those devices should
use the same driver, just like each omap tty port uses the same
'serial_omap_reg' (which includes a tty driver).

>> proc_tty_register_driver() will fail to create the second
>> procfs file, but we ignore that failure.
>>
>> Why not call tty_register_driver() in the init function rather than probe()?
>
> We have no dedicated init function. Should we have one?
>
> And if I understand correctly it would prohibit to fix the driver for the
> multiple gps-devices situation. Or makes more work if the device is to be
> registered as a future GPS interface.
>
> So if the ->driver_name or ->name should have a dynamic sequence number,
> please help me to get it correct.

There should only be one driver structure, as in any other tty driver
implementation. You have an init function inside of the
module_serdev_device_driver() macro. When you open-code that,
you can register the tty driver there before registering the serdev driver,
see serial_omap_init() for a similar example using uart_driver and
platform_driver.

>>> The UART tty would be e.g. /dev/ttyO2 (on OMAP3) if no driver is
>>> installed. And the new one that is registered is /dev/GPS0. So the
>>> tty subsystem doesn't (or shouldn't) know they are related. They
>>> are only related/connected inside this driver. So I assume that
>>> some locking or reentrancy happens in tty_port_register_device().
>>
>> I meant the serdev->dev pointer that you pass into
>> tty_port_register_device() seems to be the same one that
>> got passed into the first tty_port_register_device() in the
>> parent uart_port.
>
> Ah, interesting!
>
> Well, I copied that from other drivers registering a tty without
> understanding all side-effects of everything.
>
> Documentations of tty_port_register_device() says:
> @device: parent if exists, otherwise NULL
>
> Do we really need a "parent" here? Could we safely pass NULL?

There should be a parent, to make it show up in the right place in sysfs.

Ideally the parent should point to a device representing the original
uart port. It probably is that right now, so I'd leave it like that if it
works without getting you into a double probe.

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
