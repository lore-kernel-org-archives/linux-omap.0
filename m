From: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Sun, 15 Feb 2015 23:09:10 +0800
Message-ID: <CAJ1gpc2FKe06gWMoMHXriO52_AnKdDSa1G46mvrzAFTEQUY99w@mail.gmail.com>
References: <54DCAF88.4010607@intel.com>
	<Pine.LNX.4.44L0.1502121013390.1209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1502121013390.1209-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Alan:

thanks for comment it,
and sorry that a little bit late for replying,

2015-02-12 23:18 GMT+08:00 Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>:
> On Thu, 12 Feb 2015, Mathias Nyman wrote:
>
>> On 25.01.2015 10:13, Sneeker Yeh wrote:
>> > This issue is defined by a three-way race at disconnect, between
>> > 1) Class driver interrupt endpoint resheduling attempts if the ISR gave an ep
>> >    error event due to device detach (it would try 3 times)
>> > 2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
>> >    asynchronously
>> > 3) The hardware IP was configured in silicon with
>> >    - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1
>> >    - Synopsys IP version is < 3.00a
>> > The IP will auto-suspend itself on device detach with some phy-specific interval
>> > after CSC is cleared by 2)
>> >
>> > If 2) and 3) complete before 1), the interrupts it expects will not be generated
>> > by the autosuspended IP, leading to a deadlock. Even later disconnection
>> > procedure would detect that corresponding urb is still in-progress and issue a
>> > ep stop command, auto-suspended IP still won't respond to that command.
>
> If the Synopsys IP provides a way to do it, it would be better to turn
> off the autosuspend feature entirely.  Doesn't autosuspend violate the
> xHCI specification?

it's an IP parameter that can't be turn off via any register ><.

I guess Synopsis can insisted that xHCI specification doesn't
explicitly state that hardware designer shouldn't do auto-suspend when
device is attached, especially that definition of the auto-suspend is
their own specific low power state.
IIRC, this is point of view from Synopsis.

I wonder maybe they just didn't have a good assumption when
implementing auto-suspend, e.g. they shouldn't take PORTCSC clearing
as a commitment that software has done all the device detach task, so
that IP can go into suspend. it seems more reasonable to take
slot-disabling as a commitment to a start of auto-suspend.

anyway the "errata" would be disclosed recently, and Synopsis plan to
fix it in their new silicon version IP.
Old version IP has to live happily with some patch that can workaround
this monster i think.

Much appreciate,
Sneeker

>
>> So did I understand correctly that the class driver submits a new urb which
>> is enqueued by xhci_urb_enqueue() before the hub thread notices the device is disconnected.
>> Then hub thread clears CSC bit, controller suspends and the new urb is never given back?
>>
>> Doesn't the CSC bit and PORT_CONNECT bit show the device is disconnected when we enter
>> xhci_enqueue_urb(), even it the hub thread doesn't know this yet?
>
> What if the device disconnects _after_ the new URB is enqueued?
>
>> Would it make sense to check those bits in xhci_enqueue_urb, and just return error
>> in the xhci_urb_enqueue() if device is not connected? Then there wouldn't be a need for any quirk
>> at all.
>
> That wouldn't help URBs that were already enqueued when the disconnect
> occurred.
>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
