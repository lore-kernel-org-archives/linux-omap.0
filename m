From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] usb: phy: twl4030-usb: Fix lost interrupts after ID pin
 goes down
Date: Fri, 22 Aug 2014 16:18:40 +0300
Message-ID: <CANOLnOM_5VXDAstbQN45wRyYq9k26PWM0z9uZ+C2VmhOqzCuEw@mail.gmail.com>
References: <20140821164803.GB10066@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140821164803.GB10066@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Aug 21, 2014 at 7:48 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Commit 249751f22380 ("usb: phy: twl4030-usb: poll for ID disconnect")
> added twl4030_id_workaround_work() to deal with lost interrupts
> after ID pin goes down. However, this currently only works for the
> insertion. The PHY interrupts are not working after disconnecting
> an USB-A device from the board, and the deeper idle states for
> omap are blocked as the USB controller stays busy.
>
> The issue can be solved by calling delayed work from twl4030_usb_irq(=
)
> when ID pin is down and the PHY is not asleep like we already do
> in twl4030_id_workaround_work().

The way it is supposed to work is that after plugging in the cable
twl4030_phy_power_on() sees ID_GROUND and kicks off id_workaround_work
every second. When cable is unplugged, twl4030_id_workaround_work()
sees changes in STS_HW_CONDITIONS register and triggers events.
Doesn't that work for you, why do you need to trigger it from
twl4030_usb_irq() too?

> But as both twl4030_usb_irq() and twl4030_id_workaround_work()
> already do pretty much the same thing, let's call twl4030_usb_irq()
> from twl4030_id_workaround_work() instead of adding some more
> duplicate code.

The difference is the sysfs_notify() call, so now every time
id_workaround_work triggers (around once per second while the cable is
plugged) userspace will now get useless uevent. Haven't actually
checked if it really happens though, so I might be wrong.


--=20
Gra=C5=BEvydas
