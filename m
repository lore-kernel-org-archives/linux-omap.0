From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
	only and OTG roles.
Date: Mon, 31 May 2010 12:44:05 +0300
Message-ID: <AANLkTin-Ud-BdQ3lcydqZx7Tb1YoBq05XCONeYqxWhZm@mail.gmail.com>
References: <AANLkTim7r5zq-G8iF1fxHQ9ohqfoOiuUkkMXfRYxkBQu@mail.gmail.com>
	<987022.25256.qm@web180303.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <987022.25256.qm-g47maUHHHF/6X00i2u5GFvu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 28, 2010 at 9:32 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> w=
rote:
> --- On Fri, 5/28/10, Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> > By the way ... the #ifdeffery should indeed vanish
>> from all board
>> > configs except the Davinci DM6446 EVM. =A0That board is
>> kind of quirky
>> > in terms of USB support, and needs jumpering to get
>> host or peripheral mode (and can't do OTG).
>
>
>> For Overo this patch actually makes quite a bit of sense
>> (and I have
>> been using something similar for quite some time).
>>
>> The Overo COM itself has no USB connector -- the customer
>> can choose
>> or create a daughter card with the type of USB connector
>> appropriate> to their application,
>
> So that would be another exception ... because it doesn't
> have a fixed USB connector (and thus does not convey to
> users any specific details about what modes it supports).

Another issue is that OTG depends on PM, so if I build PM-less kernel
(PM is still more or less in development on OMAPs), Kconfig will only
allow host or peripheral for musb, which doesn't match OTG selection
in the board file, and the driver fails.

If a board is configured as host and driver is set to only support
peripheral it is perfectly fine for the driver not to allow that. But
why is the driver refusing OTG board setting if it's compiled to only
support host/peripheral? If I apply [1], it works perfectly fine for
me. What's wrong with degrading OTG to host/peripheral, did you really
mean to NAK [1], David? Why can't I compile musb in a
periperal/host-only mode if I have OTG connector?

I have to patch around this every time :(

[1] http://marc.info/?l=3Dlinux-usb&m=3D127367875600618&w=3D2

>
> - Dave
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
