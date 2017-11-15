From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Wed, 15 Nov 2017 20:55:39 +0100
Message-ID: <AFF4418B-740D-4FFE-A3A6-A92E73F0B901@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns@goldelico.com>
 <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
 <AFD95D2E-2EBB-4EBF-9B3B-E68ED98E5437@goldelico.com>
 <CAK8P3a1Ah35mmbw0qN=zp8TMN9HVgdtTSkkSCCayC-5b6Q960A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1Ah35mmbw0qN=zp8TMN9HVgdtTSkkSCCayC-5b6Q960A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, letux-kernel@openphoenux.org, Jonathan Cameron <jic23@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

> Am 15.11.2017 um 18:03 schrieb Arnd Bergmann <arnd@arndb.de>:
> 
> On Wed, Nov 15, 2017 at 5:27 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Am 15.11.2017 um 16:54 schrieb Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 15, 2017 at 4:19 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>> 
>> There is one more goal. Some people are dreaming about a generic GPS interface.
>> Then, the driver wouldn't have to register a /dev/GPS tty any more but a
>> gps_interface and mangle serial data as requested by that API. This will become
>> a simple upgrade.
>> 
>> So you can consider creating a new tty as sort of temporary solution. Like we
>> had for years for UART HCI based bluetooth devices using a user-space daemon.
> 
> It shouldn't be hard to split out the tty_driver portion of your file from the
> part that registers the port, basically getting two files that each handle
> half of the work, and the second one would be generic from the start.

Hm. Sounds like a big hack to me instead of using existing API (serdev and tty_port)
and making the best out of it.

But I may have misunderstood what you mean by splitting out parts of
a tty (which one?) and why I need two files?

The structure of the driver is:

UART --> serdev magic ---> this device driver ---> register something to present data to user space ---> user space read()

Data should flow following this arrows.
And power control happens this way:

UART --> serdev magic ---> this device driver <--- register something to present data to user space <--- user space open()
GPIO <----------------------------+

So we need one serdev port to communicate with the device and something to present serial data to user-space (where gpsd runs).

> 
>>>> +       /* initialize the tty driver */
>>>> +       data->tty_drv->owner = THIS_MODULE;
>>>> +       data->tty_drv->driver_name = "w2sg0004";
>>>> +       data->tty_drv->name = "ttyGPS";
>>>> +       data->tty_drv->major = 0;
>>>> +       data->tty_drv->minor_start = 0;
>>>> +       data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>>>> +       data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>>>> +       data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>>>> +       data->tty_drv->init_termios = tty_std_termios;
>>>> +       data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>>>> +                                             HUPCL | CLOCAL;
>>>> +       /*
>>>> +        * optional:
>>>> +        * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>>>> +                                       115200, 115200);
>>>> +        * w2sg_tty_termios(&data->tty_drv->init_termios);
>>>> +        */
>>>> +       tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>>> 
>>> While I'm still not sure about why we want nested tty port, it
>>> seems that we should have only one tty_driver that gets initialized
>>> at module load time, rather than one driver structure per port.
>> 
>> If we have several such chips connected to different serdev UARTs
>> we need different /dev/GPS to separate them in user-space.
> 
> I understand that you need multiple devices, but I don't see
> what having multiple drivers that all share the same name
> "w2sg0004" helps. I would have expected that to fail in
> tty_register_driver() when you get to the second driver,
> but looking at the code, it doesn't actually try to make the name
> unique

Yes, that is missing because I copied that from other drivers
and have no full understanding what is needed to make it really
work with multiple /dev/ttyGPS0 tty ports.

Therefore each probe (for each device connected to a different uart
of the SoC) should create a different /dev/ttyGPSn. Like you can have
multiple and independent i2c clients of the same type and driver.

> proc_tty_register_driver() will fail to create the second
> procfs file, but we ignore that failure.
> 
> Why not call tty_register_driver() in the init function rather than probe()?

We have no dedicated init function. Should we have one?

And if I understand correctly it would prohibit to fix the driver for the
multiple gps-devices situation. Or makes more work if the device is to be
registered as a future GPS interface.

So if the ->driver_name or ->name should have a dynamic sequence number,
please help me to get it correct.

> 
>>>> +       /* register the tty driver */
>>>> +       err = tty_register_driver(data->tty_drv);
>>>> +       if (err) {
>>>> +               pr_err("%s - tty_register_driver failed(%d)\n",
>>>> +                       __func__, err);
>>>> +               put_tty_driver(data->tty_drv);
>>>> +               goto err_rfkill;
>>>> +       }
>>>> +
>>>> +       tty_port_init(&data->port);
>>>> +       data->port.ops = &w2sg_port_ops;
>>>> +
>>>> +/*
>>>> + * FIXME: this appears to reenter this probe() function a second time
>>>> + * which only fails because the gpio is already assigned
>>>> + */
>>>> +
>>>> +       data->dev = tty_port_register_device(&data->port,
>>>> +                       data->tty_drv, minor, &serdev->dev);
>>> 
>>> This seems to be a result of having nested tty ports, and both
>>> ports point to the same device.
>> 
>> The UART tty would be e.g. /dev/ttyO2 (on OMAP3) if no driver is
>> installed. And the new one that is registered is /dev/GPS0. So the
>> tty subsystem doesn't (or shouldn't) know they are related. They
>> are only related/connected inside this driver. So I assume that
>> some locking or reentrancy happens in tty_port_register_device().
> 
> I meant the serdev->dev pointer that you pass into
> tty_port_register_device() seems to be the same one that
> got passed into the first tty_port_register_device() in the
> parent uart_port.

Ah, interesting!

Well, I copied that from other drivers registering a tty without
understanding all side-effects of everything.

Documentations of tty_port_register_device() says:
@device: parent if exists, otherwise NULL

Do we really need a "parent" here? Could we safely pass NULL?

> 
> I just checked the current mainline code, and it doesn't seem
> to actually call serdev_tty_port_register() from
> tty_port_register_device(), so maybe the comment was
> based on an older version of the serdev framework?

Maybe. We rewrote the driver in parallel to v4.11-rc where this
was observed. Then we only rebased it to now v4.14 but didn't
verify this detail.

I did now test the driver with debugging enabled (after removing
the pdata stuff) on top of v4.14.

But I could not find a trace of this issue (there was a
double w2sg_probe() right after tty_port_register_device):

dmesg|fgrep w2sg
[    8.039184] w2sg_probe()
[    8.039184] w2sg serdev_device_set_drvdata
[    8.039398] w2sg_probe() lna_regulator = dc944c80
[    8.039398] w2sg devm_gpio_request
[    8.039703] w2sg rfkill_alloc
[    8.039733] w2sg register rfkill
[    8.039886] w2sg alloc_tty_driver
[    8.039916] w2sg tty_register_driver
[    8.039916] w2sg call tty_port_init
[    8.039916] w2sg call tty_port_register_device
[    8.040130] w2sg_rfkill_set_block: blocked: 0
[    8.040161] w2sg_set_lna_power: off
[    8.040222] w2sg tty_port_register_device -> ddeda800
[    8.040222] w2sg port.tty =   (null)
[    8.040222] w2sg probed
[    8.040222] w2sg DEBUGGING MODE enabled
[    8.040222] w2sg power gpio ON
[    8.252227] w2sg power gpio OFF
[    8.876617] w2sg_set_power to state=0 (requested=0)
[    9.127410] w2sg00x4 has sent 124 characters data although it should be off!
[    9.127471] w2sg_set_lna_power: off
[    9.127471] w2sg: power gpio ON
[    9.142700] w2sg: power gpio OFF
[    9.162689] w2sg: idle
[  239.280212] w2sg_tty_install() tty = ddfa3a00
[  239.284759] w2sg_tty_install() data = dc858810
[  239.290344] w2sg_tty_open() data = dc858810 open_count = ++0
[  239.296264] w2sg_set_power to state=1 (requested=0)
[  239.301940] w2sg00x4 scheduled for 1
[  239.305725] w2sg_set_lna_power: on
[  239.310913] w2sg: power gpio ON
[  239.327362] w2sg: power gpio OFF
[  239.347351] w2sg: idle
[  239.385162] w2sg00x4: push 1 chars to tty port
[  239.390228] w2sg00x4: push 4 chars to tty port
[  239.395141] w2sg00x4: push 5 chars to tty port
[  239.401184] w2sg00x4: push 5 chars to tty port
[  239.406097] w2sg00x4: push 4 chars to tty port
[  239.412994] w2sg00x4: push 6 chars to tty port
[  239.418731] w2sg00x4: push 5 chars to tty port
[  240.241821] w2sg_tty_close()
[  240.244873] w2sg_set_power to state=0 (requested=1)
[  240.251281] w2sg00x4 scheduled for 0
[  240.255065] w2sg_set_lna_power: off
[  240.261322] w2sg: power gpio ON
[  240.277435] w2sg: power gpio OFF
[  240.297424] w2sg: idle

So it is probed only once. Maybe we did note a bug in early
serdev that already has been fixed?

Hence we are discussing a problem that already has disappeared.

> 
> It seems like something that should be fixed, so maybe
> put a WARN_ON() at the beginning of the probe
> function to see where we come from.

Well, I'd say this notice can be removed as well.

So I'll post a v4 asap.

BR,
Nikolaus
