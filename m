From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Wed, 2 Dec 2009 23:29:10 +0200
Message-ID: <6ed0b2680912021329g372bd0a4vb5b4a80244960f95@mail.gmail.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
	 <20091202173321.GA23738@nokia.com>
	 <6ed0b2680912021234x6b5e6058p6d50d5cd20ecf019@mail.gmail.com>
	 <20091202204946.GB25682@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755674AbZLBV3H@vger.kernel.org>
In-Reply-To: <20091202204946.GB25682@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 2, 2009 at 10:49 PM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> Hi,
>
> On Wed, Dec 02, 2009 at 09:34:00PM +0100, ext Grazvydas Ignotas wrote=
:
>>>>
>>>> +#define BCI_DELAY =A0 =A0 =A0 =A0 =A0 =A0 =A0100
>>>
>>> 100ms ??? that's too quick for battery monitoring. Imagine that you=
'll
>>> have
>>> 10 i2c transfers per-second forever with this one. Don't you think =
you're
>>> waking up omap for nothing ??
>>
>> The work item doesn't queue itself, so this is only used once after
>> every interrupt. The delay itself is needed because charge state
>> machine needs some time to switch states and is not yet in expected
>> state at the time VBUS/AC detect interrupt kicks.
>
> ok got it... not so bad then ;-)
>
>>>> +static struct twl4030_bci_device_info twl4030_bci =3D {
>>>
>>> this should be allocated on probe() time.
>>
>> I need to access it from twl4030charger_usb_en().. Could only leave
>> delayed_work global and allocate everything else in probe() if you
>> prefer that.
>
> well, you could keep only a global static pointer and after allocatin=
g that
> in probe, make the global static pointer, point to it... Anyways, I t=
hink
> twl4030charger_usb_en() should change its prototype to something like
>
> twl4030charger_usb_en(struct twl4030_bci *bci, int enable);

This function is called by twl4030-usb, where will it get this bci poin=
ter from?

> you could leave userland to decide whether to start charging, special=
ly in
> usb charging case where we still need to know if we where enumerated =
with
> 100mA or 500mA configuration.

=46rom what I saw in other drivers they are setup to start charging
automatically as soon as they see VBUS. Maybe Anton can give more
details here.

> How are you differing between those currently?

Not handled at all at the moment (uses BCI defaults).

>>> I don't like the way you did this. I would expect twl4030-usb to ki=
ck the
>>> charger detection based on the VBUS irq. You have to consider the
>>> possibility of boards which won't use BCI module and will have some
>>> bq24xxx
>>> chip dealing with that like RX51. So instead of implementing this h=
ere
>>> and
>>> forcing people to have this driver enabled on e.g. RX51, you should
>>> implement the charger_enable_usb() logic in twl4030-usb itself. /me
>>> thinks
>>
>> I don't think charging is twl4030-usb's business, also notifying
>> power_supply core about charge state changes that I do here.
>
> I was talking about the charger detection.

The USB_PRES interrupt belongs to twl4030-usb, so it gets it's
detection as before and does not need this driver, where is the
problem? This driver only registers CHG_PRES, which is AC charger
detect interrupt.

> The start of charge you could leave to userland to handle, no ?

Maybe, I wonder if there is standard way to do that.
Anton?

>
>> What about just returning early from twl4030charger_usb_en() if this
>> driver is not started? TWL4030-core requires twl4030_bci_platform_da=
ta
>> to be present to even register this driver, so it won't start on RX5=
1.
>> RX51 can also choose not to compile this driver in, then
>> twl4030charger_usb_en() call won't even be done fom twl4030-usb.
>
> still we need to detect the charger...
>
>>> how about using request_threaded_irq() ?? then you avoid having tha=
t
>>> workqueue.
>>
>> I need to do some delayed processing after VBUS/AC detect interrupts
>> kick, delayed_work looked perfect for this. Also note that I can't g=
et
>> USB_PRES interrupt (taken by twl4030-usb), only a callback from
>> twl4030-usb.
>
> or you let userland to handle a bit more of this logic (??)

Still need to autostart AC charging, who would plug AC adapter and
want to fiddle with the GUI to start charging instead it having it go
automatically? Agree about USB userspace switch though..
