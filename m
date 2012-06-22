From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Fri, 22 Jun 2012 23:36:46 +0300
Message-ID: <20120622203645.GD29290@arwen.pp.htv.fi>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
 <87fw9o32v2.fsf@ti.com>
 <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
 <20120622103050.GG28472@arwen.pp.htv.fi>
 <87ehp71liv.fsf@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ehp71liv.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 22, 2012 at 07:14:32AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>=20
> > Hi,
> >
> > On Fri, Jun 22, 2012 at 01:00:39PM +0530, Munegowda, Keshava wrote:
> >> On Fri, Jun 22, 2012 at 12:32 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> >> > "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
> >> >
> >> >> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
> >> >> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> >> >>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> >> >>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
> >> >>> the usb hub and device detection fails in beagle XM
> >> >>> causeing NFS not functional. This affects the core retention too.
> >> >>> The same commit logic needs to be revisted adhering to hwmod and
> >> >>> device tree framework.
> >> >>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
> >> >>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
> >> >>>
> >> >>> This patch is validated on BeagleXM with NFS support over
> >> >>> usb ethernet and USB mass storage and other device detection.
> >> >>>
> >> >>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >> >
> >> > [...]
> >> >
> >> >>
> >> >> hi kevin
> >> >>
> >> >> here is pm count log on beagle XM with the above patch:
> >> >
> >> > What are you meaning to show by this log?
> >> >
> >> > This dump shows that neither PER or CORE are hitting retention in id=
le.
> >> > Which sounds to me like you have not enabled UART runtime suspend:
> >> >
> >> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_dela=
y_ms
> >> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_dela=
y_ms
> >> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_dela=
y_ms
> >> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_dela=
y_ms
> >> >
> >> > My test with your patch shows that it fixes the oops during boot, and
> >> > doesn't hang during suspend, but that USB host is still preventing C=
ORE
> >> > retention during idle (after UART runtime suspend is enabled.)
> >> >
> >> > This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
> >> >
> >> > Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention ag=
ain.
> >> >
> >> > Kevin
> >>=20
> >>=20
> >>=20
> >> Hi kevin
> >>        It woks. only the log was wrong. I was using no_console_suspend
> >> in boot args.
> >> i removed it. now I can see the core retention hits with USB host in B=
eagle XM.
> >> below is the log:
> >
> > the fact is that we can't really survive without that workaround. Kevin,
>=20
> I don't know what workaround you're talking about.    Are you talking
> about the revert proposed in $SUBJECT patch?
>=20
> I don't have a problem with that revert.  The problem I have is that it
> does not fix the problem I initially reported: USB host prevents CORE
> retention in *idle*.

Keshava is reverting a fix for a HW errata. I can't accept it as it will
cause regressions. Granted, regression by regression, there's no change,
but I simply can't knowingly cause a regression to the driver just to
have PM working. We need a real fix for this issue.

--=20
balbi

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5NddAAoJEIaOsuA1yqREDxoQALWvkE3CtPmErhg/PMgfOh1E
O9+8iTYPgYVRPbF8Gd4xavzRjjBCdgZgZPgrF53wtZWoAakiADpOvD622Vdo1KhW
XSDvVNtxA7tMshdNau0bPBgRWliRSckAQOXt0Y7Gp1VtYZMiBGTDkFEv+2N3itdI
oDmYNLKP5DJzw8+Up5WHMZJoefk1MNaq2NmrCU5wNzS37/vFqb5hysGBYqv8MHFE
ltwU7E83Bkezftb4PtxK49iOpU6fGPlZubok+ggyapBCFGwlPxQeqcdGFWtyXVzO
0Jvn9l+OUudelJfKbm/Tue96iMgBKySBMJ4Ph9qfkT10LqHls4+/L9JsJjcOptjY
3wz8uhshJ0XLvIyvazM3VKTxxzZBMAJuRZJpn/8Byfeagl/iRkUO7hmdcqfgf+wh
4YFFChafwIHNItQxvm1Jp+xg+VUsWMk+hpD97CufFFVHAc3VRssv26deR0tZsT2x
IorSoU5Ef/F8TU7N6fO6K7jLpMLYWxWIxk8PgyBQ5Qg1/FVhiTwG9Ueq42gVlcKH
s1+rw2rRQxWYfdsS4sK2xrF+ZlQYx2pBr5sOcyQc9bPUAHPSe9sBl/mSuFGRRK6h
7MoD846PQnop8TK6nG3YwmLlMrjtMYI7KjBKbCIG8/+3pwHl0jU2eb6u4qyQeTur
u1jQYWuVomc1OCHdK26N
=wsH9
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
