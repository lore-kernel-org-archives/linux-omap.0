From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 0/7] Nokia N9xx bluetooth driver
Date: Tue, 16 Aug 2016 15:22:45 -0500
Message-ID: <CAL_JsqJ9FG0KeyDTbwvMwq+bcoVTMusGrcTT52e3jdfmX2j19w@mail.gmail.com>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <A9EA833E-DDDE-46FB-917C-30CF00A70A6C@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A9EA833E-DDDE-46FB-917C-30CF00A70A6C-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 16, 2016 at 2:10 AM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wrote:
> Hi Sebastian,
>
>> This series (based von 4.8-rc1) adds support for bluetooth on the Nokia
>> N9xx devices. It has been tested on the Nokia N950, where it works
>> correctly. On Nokia N900 it currently fails during negotiation
>> (probably related to slightly incorrect serial settings/timings).
>> The N900's bcm2048 correctly answeres to alive check even before
>> negotiation (on N950 it does not work before negotiation), but replies
>> with an Hardware error event to the negotiation packet.
>>
>> Apart from N900 support there are still two "features" missing in the
>> driver:
>>
>> 1. To save energy the bluetooth module can be put into sleep mode via a
>>   GPIO. This gpio should be enabled before sending data via UART and
>>   disabled once the transmission is done. I currently just keep the
>>   GPIO always enabled.
>> 2. It would be nice to have a bluetooth device exposed by the kernel
>>   automatically without having to setup the tty disector first for
>>   proper configurationless out of the box support. I could not find
>>   a nice way to do this from the kernel, though.
>
> currently using the HCI line discipline is the only way to attach a Bluetooth device to a serial line / UART.
>
> However I have been advocating for a serial bus or UART bus for a long time now. It is needed especially for Bluetooth devices which have no business in being exposed as TTYs in the first place.
>
> This is true for the ACPI and DT world actually. Some UARTs should not be exposed as TTY and just be stuck on a bus that can be enumerated and matched by a driver that knows how to handle it.

To add to this, my initial thought has been to split off uart_port ops
for use by the uart bus/subsystem so we can reuse all the uart
drivers. Then driver ports can be registered either with the tty layer
or the uart bus (or perhaps registered with both and claimed by one
later). This is somewhat already done with the serio subsys (see
drivers/tty/serial/sunsu.c). I thought extending serio might be an
option, but it's data handling is pretty limited.

The transmit side seems pretty straightforward. The receive side is a
bit more complex as the buffering is all in the tty layer. It doesn't
seem so straightforward to share the tty buffer handling code. Perhaps
at least initially, a more simple buffering scheme can be used given
the packet oriented nature of the device protocols.

Rob
