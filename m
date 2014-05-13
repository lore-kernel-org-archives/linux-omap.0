From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] usb: dwc3: dwc3-omap: Disable/Enable core interrupts
 in Suspend/Resume
Date: Tue, 13 May 2014 10:50:19 -0500
Message-ID: <20140513155019.GN1151@saruman.home>
References: <1399541587-14067-1-git-send-email-george.cherian@ti.com>
 <1399541587-14067-6-git-send-email-george.cherian@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399541587-14067-6-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 08, 2014 at 03:03:07PM +0530, George Cherian wrote:
> Enabling the core interrupts in complete is too late for XHCI, and stops
> xhci from proper operation. So remove prepare and complete and disable/en=
able

isn't this a bug in xhci ? I mean the driver should make no assumption
as to when IRQs are enabled, why do we need to enable IRQs earlier when
the device is only considered "ready for use" after ->complete()
finishes executing ?

=46rom documentation we have:

107  * @complete: Undo the changes made by @prepare().  This method is exec=
uted for
108  *      all kinds of resume transitions, following one of the resume ca=
llbacks:
109  *      @resume(), @thaw(), @restore().  Also called if the state trans=
ition
110  *      fails before the driver's suspend callback: @suspend(), @freeze=
() or
111  *      @poweroff(), can be executed (e.g. if the suspend callback fail=
s for one
112  *      of the other devices that the PM core has unsuccessfully attemp=
ted to
113  *      suspend earlier).
114  *      The PM core executes subsystem-level @complete() after it has e=
xecuted
115  *      the appropriate resume callbacks for all devices.

which tells me that using ->complete() to reenable IRQs is ok here.
Specially when you consider that the role of ->prepare() is to prevent
new children from being created and, for a USB host, that means we
should prevent hub port changes.

cheers

--=20
balbi

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcj87AAoJEIaOsuA1yqREV0EP/049eKeF0BbVfzgCrlrKIr1a
4CASqPnBIRCgnjyYELg3vWYl8mIxyw4p6BvUzPrtJcyg0tWTDP72h0K2UGJYkonI
jia/ilS4rP6hRHi032+bmUmmGzfMLsu0JYdKudZsfOprZTLztvDeQ88lcuqAtqRZ
YA2OdPvCUhmRqNdAivV1IWX0BG79V4cpFJ6Z9lERw17K9zRPzRD1LokLH4qoyTrz
L7bXe6XZ9+s4xBD6RaQTPlp/u+CHDnTaBaNAUIv1VR58HLqHwEVegTA0mT6mqP6F
Rhb1LEBXpcc4pXHfi84BWGYbHGcI3RD6qN9lelFq+tNTX1/dlwJCsTwoPHAWaKP9
BmwV3S8KGRnNC7RMY8yeiOAeuIqL1BXhJjTzR3mJxbUORKzUzIpw34ZGg7mVe2pp
UAoN0C2MPivKd3p+o5z6ph1LYco4I5HiGjtFhKyhSOdb4uz6iJ4WhtEap4BMbaiu
3OtC0IMew5zmYIc9FUbyqkRd6fvsfj4D7ZqUYXweTnPIsvt5cj8XMgkurqLWUNPM
aTnNDT7C6FvkgtVHcLBIhK79Ewc7shQr2CS4s0g/yB1AXa0rqN+MxMasVMMS5iKK
6qu+CvhMWZAgG4FQtxxZtBmGMcikrqhu44MCsxYiT1TMOuURyLOmYYhBSmE6dudN
FOAD/iOn4qbOCT1RyxF9
=BMaZ
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
