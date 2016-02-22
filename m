From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Mon, 22 Feb 2016 09:49:06 -0600
Message-ID: <CAHCN7x+=Lq11X6eXg4gbfSzR2GkfZg6=SG3o9WeQQB_gpxv=EQ@mail.gmail.com>
References: <201601091616.04193@pali>
	<20160126143450.GG25796@pali>
	<20160126172631.GZ19432@atomide.com>
	<201602211212.49460@pali>
	<87ziutnqu1.fsf@ti.com>
	<20160222083431.GA4606@pali>
	<87oab9nn0i.fsf@ti.com>
	<20160222153613.GA12995@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160222153613.GA12995@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

=46or what it's worth, I tried running the MUSB via the twl4030 on
Linux-Next (I don't remember which snapshot), and it was broken for me
on a DM3730 (OMAP 3630), but Kernel 4.4.2 worked.  Are you using
Linux-Next or one of the stable kernels?

I can try again later this week with a newer linux-next when I have
more time to see if it's still there.  Once I realized the stable
kernel worked, I stoped since I was just testing some device tree
stuff.

adam



On Mon, Feb 22, 2016 at 9:36 AM, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Mon, Feb 22, 2016 at 10:54:21AM +0200, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> > On Monday 22 February 2016 09:31:50 Felipe Balbi wrote:
>> >> Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >>
>> >> > On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
>> >> >> * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160126 06:35]:
>> >> >> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
>> >> >> > > * joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org> [160121 11:35]:
>> >> >> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
>> >> >> > > > > Do you have some pointer
>> >> >> > > > > to the "certain resistor value on ID to GND" spec? Is =
it
>> >> >> > > > > maybe part of the carkit related parts of the USB spec=
?
>> >> >> > > >
>> >> >> > > > ""Three additional ID pin states are defined[4] at the n=
ominal
>> >> >> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=
=CE=A9, with respect
>> >> >> > > > to the ground pin. These permit the device to work with =
USB
>> >> >> > > > Accessory Charger Adapters that allows the OTG device to=
 be
>> >> >> > > > attached to both a charger and another device simultaneo=
usly.
>> >> >> > > > [6]""
>> >> >> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_pl=
ugs
>> >> >> > >
>> >> >> > > OK thanks. So it's the "accessory charger" part of the
>> >> >> > > battery charging specification 1.1.
>> >> >> >
>> >> >> > So, Tony, do you have some idea what needs to be changed and=
 how to
>> >> >> > fix peripheral mode after boot on Nokia N900?
>> >> >>
>> >> >> No, I'm waiting to hear an educated guess from Felipe on this =
one.
>> >>
>> >> about why peripheral mode doesn't work on n900 ? No idea. that's =
always
>> >> the default role of MUSB and last I checked, before stopping work=
ing on
>> >> this, BBB was working just fine.
>> >>
>> >> N900 is odd in that it has two PHYs (1701 handles data lines whil=
e
>> >> twl4030 handles power lines, IIRC), but peripheral should be work=
ing.
>> >>
>> >> The only reason for MUSB to not start would be that it's not dete=
cting
>> >> VBUS being above session valid threshold, however twl4030 should =
have an
>> >> IRQ for that.
>> >>
>> >> What happens when cable is attached ? Any IRQs anywhere firing ?
>> >>
>> >
>> > Just to note, when I call echo peripheral > mode then detecting us=
b
>> > cable starts working and usb peripheral mode also works fine (also
>> > after disconnecting and connecting usb cable again). Read my first
>> > post in this thread, there are also some logs:
>> > https://lkml.org/lkml/2016/1/9/69
>>
>> interesting... that softconnect interface looks odd. We _know_ the v=
alue
>> of softconnect from musb->softconnect. /me reads commit which added
>> it... Oh okay, that's only valid for host mode. Argh!
>
> softconnet bit is only valid for *peripheral* mode, but the bit is no=
t
> set in this case, so the host will not be able to detect the device.
>
> Pali,
>
> Is this never worked or just broken recently? If latter, possible to
> git-bisect to find out which patch causes softconnect bit not set?
>
> Regards,
> -Bin.
>
>>
>> Okay, the session bit is _NOT_ set when it should be. Note that DevC=
tl
>> reads as 0x98. Bit 0 is Session bit and that's not set. MUSB _is_ in=
 the
>> device mode (bit 7 set).
>>
>> For some reason DevCtl didn't get set. Care to add a print to
>> musb_gadget_pullup() to see when/if it's called ?
>>
>> BTW, Bin will be maintaining MUSB going forward.
>>
>> --
>> balbi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
