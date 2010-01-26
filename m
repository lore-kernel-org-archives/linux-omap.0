From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 07:33:01 -0800
Message-ID: <201001260733.01628.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <20100126141016.GD10690@nokia.com> <20100126141935.GG10690@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100126141935.GG10690-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 January 2010, Felipe Balbi wrote:
> just remember of another problem which I couldn't solve yet:
> 
> if you boot the board with the usb cable already attached, then we miss 
> the first notification because when the notifier is called, usb 
> controller driver isn't probed yet.

That's part of why the OTG transceiver driver has methods
used by host and peripheral drivers to register themselves.

Standard init sequence there is to do nothing until both
drivers are fully initialized ... last step being to
register the drivers with the transceiver.  That way the
transceiver can know when its peer drivers are ready.

Example:  VBUS present from a host.  If the board runs
in OTG mode, as soon as both drivers are registered then
the B-Default state machine would start running ... and
that involves (see the OTG state machine!) issuing a VBBUS
event.

Same thing can be done with the power events.  As soon
as an event listener is registered, it could be fed any
events it missed.  (Just one approach; one must sort
out any other interdependencies too.  In this case, it
can make sense to consume 100mA current right away, and
then adjust the draw later if needed.)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
