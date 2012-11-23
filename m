From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Fri, 23 Nov 2012 08:19:11 +0800
Message-ID: <50AEC0FF.60508@linaro.org>
References: <Pine.LNX.4.44L0.1211221226360.2255-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211221226360.2255-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/23/12 01:36, the mail apparently from Alan Stern included:
> On Thu, 22 Nov 2012, Felipe Balbi wrote:

Hi -

>>> If you mean change the regulator managing code from living in
>>> omap-hsusb to ehci-hcd, it sounds like a good idea.
>>
>> I mean that drivers/usb/core/hub.c should manage it, since that's wh=
at
>> actually manages the HUB entity.
>
> This is an interesting problem.  How should we handle devices which
> live on a discoverable bus but whose power is controlled by an
> undiscoverable platform-specific regulator?
>
> Has this sort of thing come up in the past with other types of device=
s?
>
> A big part of the problem is associating the hub, which is created
> dynamically by the USB core code, with the regulator, which is known
> from platform data at boot time.  The suggestion that the regulator
> should really be associated with a port on the hub's parent is
> reasonable at first glance.  But what if we don't know which port tha=
t
> is?
>
> Once we can solve this part of the problem, I think the rest of it wi=
ll
> fall into place.
>
>> as long as Alan is ok and it comes in the same series, I'd be really=
,
>> really glad to see such a patch and would happily review it.
>
> If we can figure out a good way to set up the necessary association, =
I
> won't mind adding the appropriate calls to the USB core.  But is the
> hub driver the right place?  What if a similar power arrangement is
> used for a different kind of USB-connected chip (for example, a webca=
m
> or a fingerprint reader)?

About 18 months ago I sent out an RFC for "platform_data for=20
asynchronously probed devices", aimed at exactly this problem.  It got=20
flamed to death.

The core idea there was matching "device paths" like=20
"usb1/1-1/1-1.1/1-1.1:1.0" to bind platform data to an=20
asynchronously-probed device, where the device is on hardwired connecti=
on.

I provided an implementation that worked on both SDIO and usb buses on=20
Panda, for the WLAN module and smsc95xx chip respectively.  We have use=
d=20
this implementation to solve lack of hardware or assigned MAC addresses=
=20
for wlan0 and eth0 on Panda in Linaro tilt kernels ever since.

Most of the arguments against it were of the form, "do MAC address=20
setting in userspace" which I felt did not understand the general use=20
case outside of setting MAC addresses; such as we're talking about now=20
with binding regulators for example.  Some of the objectors did not see=
m=20
to know what "platform_data" was either, others killed it because=20
platform_data !=3D device tree.

There was one genuine objection that I did not solve, "what about if=20
people modprobe usb buses in different order", like ehci, xhci etc.  So=
=20
the "device path" would need to be qualified by the name of the driver=20
targeted as well as the bus index of that driver we targeted, but that'=
s=20
easy enough.

Anyway as a generic thing I think its ship has sailed (on a river of=20
flames), but since you bring up attaching kernel objects to=20
asynchronously probed devices: there's one way to do it for hardwired=20
platform devices.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
