From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 0/7] Nokia N9xx bluetooth driver
Date: Tue, 16 Aug 2016 09:10:54 +0200
Message-ID: <A9EA833E-DDDE-46FB-917C-30CF00A70A6C@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, =?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

> This series (based von 4.8-rc1) adds support for bluetooth on the Nokia
> N9xx devices. It has been tested on the Nokia N950, where it works
> correctly. On Nokia N900 it currently fails during negotiation
> (probably related to slightly incorrect serial settings/timings).
> The N900's bcm2048 correctly answeres to alive check even before
> negotiation (on N950 it does not work before negotiation), but replies
> with an Hardware error event to the negotiation packet.
> 
> Apart from N900 support there are still two "features" missing in the
> driver:
> 
> 1. To save energy the bluetooth module can be put into sleep mode via a
>   GPIO. This gpio should be enabled before sending data via UART and
>   disabled once the transmission is done. I currently just keep the
>   GPIO always enabled.
> 2. It would be nice to have a bluetooth device exposed by the kernel
>   automatically without having to setup the tty disector first for
>   proper configurationless out of the box support. I could not find
>   a nice way to do this from the kernel, though.

currently using the HCI line discipline is the only way to attach a Bluetooth device to a serial line / UART.

However I have been advocating for a serial bus or UART bus for a long time now. It is needed especially for Bluetooth devices which have no business in being exposed as TTYs in the first place.

This is true for the ACPI and DT world actually. Some UARTs should not be exposed as TTY and just be stuck on a bus that can be enumerated and matched by a driver that knows how to handle it.

This goes along with the weird fetish to expose certain Bluetooth GPIOs as RFKILL switches. They are not that either since they just power the UART. They have nothing to do with a radio RFKILL switch. We fixed the Intel and Broadcom ones to be mapped into the driver. Having a proper bus would make this one also a lot easier.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
