From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Fri, 22 Jun 2012 13:30:51 +0300
Message-ID: <20120622103050.GG28472@arwen.pp.htv.fi>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
 <87fw9o32v2.fsf@ti.com>
 <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 22, 2012 at 01:00:39PM +0530, Munegowda, Keshava wrote:
> On Fri, Jun 22, 2012 at 12:32 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> > "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
> >
> >> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
> >> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> >>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> >>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
> >>> the usb hub and device detection fails in beagle XM
> >>> causeing NFS not functional. This affects the core retention too.
> >>> The same commit logic needs to be revisted adhering to hwmod and
> >>> device tree framework.
> >>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
> >>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
> >>>
> >>> This patch is validated on BeagleXM with NFS support over
> >>> usb ethernet and USB mass storage and other device detection.
> >>>
> >>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >
> > [...]
> >
> >>
> >> hi kevin
> >>
> >> here is pm count log on beagle XM with the above patch:
> >
> > What are you meaning to show by this log?
> >
> > This dump shows that neither PER or CORE are hitting retention in idle.
> > Which sounds to me like you have not enabled UART runtime suspend:
> >
> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
> >
> > My test with your patch shows that it fixes the oops during boot, and
> > doesn't hang during suspend, but that USB host is still preventing CORE
> > retention during idle (after UART runtime suspend is enabled.)
> >
> > This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
> >
> > Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention again.
> >
> > Kevin
>=20
>=20
>=20
> Hi kevin
>        It woks. only the log was wrong. I was using no_console_suspend
> in boot args.
> i removed it. now I can see the core retention hits with USB host in Beag=
le XM.
> below is the log:

the fact is that we can't really survive without that workaround. Kevin,
Paul what are the suggestions here ? We _MUST_ reparent the clock at
that specific location as a HW workaround.

--=20
balbi

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5ElZAAoJEIaOsuA1yqRE4IwP/RkjCyxy/hD8bLmvP36UWA23
t8O2PhvcHyxfxTmWmuWgnY3R4nOFXe6Gka6tdjPsK/bg+rqDc/yLh9nj8Cw18ogl
wIf5uTIGV38z+95jFb7h262ALgh+bLQD2/Asj56xAj7o+oKL8qHyonHVMmpdvIcE
iamxVvQQ/O37F8iIR29ArYE3qYXshrbls42gpjY4qGdmjvY7nCHlAuaYXBB3RCTW
CnZTu9mmHTuEVIvuc1VlXoAO8L4slBVnKYsYreZZoBIDb1cWw7u4DMwQII52+2Dk
E8SwfaohTs0ToaB5zfS3nXXkxv+UvAtg6JY8AZ9Oltuz4CP4V4Qo8aMxuuvx4COB
SXl2TcL9k4Rj23BJT9YT3nTBdykdrGh9Ozqzn1JI6TjW+8DZQERQeB3MAvSLggSq
/O4gycskoMuqLkHKW6VTrJ47/DHeKxcd7zEchsWl9JvI0X8NYuVVPD3RH6BWp1T/
wsCAajVj/3VWz4uDj/lGo3Tc+QNGhD9SqXSXBusNX7gRJfa6JMWrzBTRvpaL+njX
B8DmSI593LjgoJoumDW49VgrZhW4PgY47o7Rk4KdovfF9HB4u29k27KUa6ohbgpF
sssjhISKc5+J91Xj2QHt5dLdF0rCO8xVNSvAhtaDpEVKwp+meo3RBx91rwEYGY1Y
sU0IGTX0W+YsPEsFMQ22
=7xET
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
