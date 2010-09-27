From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Mon, 27 Sep 2010 13:54:36 +0300
Message-ID: <AANLkTinh+JTwyE4E33QXdnZ8obYA8S0SU71i3kGi=wRT@mail.gmail.com>
References: <1285529740-28232-1-git-send-email-notasas@gmail.com>
	<AANLkTinkxokX9BGtxysYOr19xbZR4S8oPRYUAyneutzc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinkxokX9BGtxysYOr19xbZR4S8oPRYUAyneutzc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Murthy <arunrmurthy.83@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Madhusudhan <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 10:21 AM, Arun Murthy <arunrmurthy.83@gmail.com=
> wrote:
> On Mon, Sep 27, 2010 at 1:05 AM, Grazvydas Ignotas <notasas@gmail.com=
>
> wrote:
>> ---
>> This is v3 of BCI charger driver I first sent nearly a year ago [1].
>> I've updated it to use the new OTG notifiers for VBUS notifications,
>> however it still is not able to determine charge current to use.
>> For that reason there is now a temporary module param to enable USB
>> charging, until I can figure out how to get that info from the gadge=
t
>> stack (hopefully Felipe can help me here).
>
> On detecting USB plug, the driver is suppose to detect the type of us=
b
> device. Then if the device is a PC(standard host) the charging curren=
t is to
> be obtained from the usb stack. Hence the driver will have to wait un=
til the
> usb stack or driver notifies the current that can be drawn. The usb s=
tack or
> driver gets to know the amount of current to be drawn through the
> negotiations that happen between the host and device.

I'm aware of that, the question was how to get that from Linux USB
stack (which Felipe already responded).

<snip>

> Only AC and USB monitoring is achieved by registering with power supp=
ly
> class.
> How is battery monitored?
> An instance of battery is to be registered with power supply class in=
 order
> to monitor battery.

The problem is that BCI is only active while charging, when it is not
charging most (all?) monitoring registers freeze and no monitoring
happens (BCI registers read frozen values from last charge). So I
don't register battery as it has no useful data to report. I heard it
is possible to use MADC to perform monitoring while not charging, so
battery can be added when MADC driver is merged and corresponding code
is written for this driver.

>>
>> +
>> +static struct platform_driver twl4030_bci_driver =3D {
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D twl4030_bci_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(twl4030_bci_re=
move),
>> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "twl4030_bci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> +};
>
> dev_pm_ops can be use

nothing to do there right now, the driver relies on FSM change
interrupts from BCI to update state.
