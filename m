From: joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 08 Jun 2016 14:18:03 +0200
Message-ID: <17243006.AtPKaaqTIG@saturn>
References: <201601091616.04193@pali> <87h9d49exz.fsf@linux.intel.com> <71cb45ec-a269-d510-df34-eb6eaa781da8@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <71cb45ec-a269-d510-df34-eb6eaa781da8-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed 08 June 2016 15:04:02 Sergei Shtylyov wrote:
> On 6/8/2016 1:02 PM, Felipe Balbi wrote:
> >> * Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160607 05:53]:
> >>>> Tony, what do you think about that patch?
> >>>=20
> >>> Tony, PING
> >>=20
> >> Yeah I don't know, AFAIK we don't have a generic way to
> >> force MUSB to change mode without ID pin. If you have figured
> >> something generic for that which does not actually tinker with
> >> the PHY registers directly, that should be the generic
> >> musb_set_mode() that we've been wondering about for years.
> >=20
> > #define MUSB_TEST_FORCE_HOST	0x80
> >=20
> > Can someone confirm on MUSB's docs (and actual running system) that=
 this
> > does what's supposed to do?
>=20
>     The MUSB programmer's guide says the CID (sic) input is ignored w=
hen the
> Force_Host bit is set. The host mode is entered when the Session bit =
is
> set. But I don't have a MUSB hardware readily available to confirm.
>=20
> MBR, Sergei

also says:

While the FORCE_HOST bit remains set, the core will enter Host mode whe=
n the=20
Session bit is set and **remain in Host mode until the Session bit is c=
leared=20
even if a connected device is disconnected during the session.**=20
The operating speed while in this mode **is determined for the setting =
of the=20
=46ORCE_HS and FORCE_FS bits of the Testmode register** in Section 23.1=
=2E4.11.

see http://talk.maemo.org/showthread.php?p=3D685367

It's not any fully operational hostmode.

/j
--=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
