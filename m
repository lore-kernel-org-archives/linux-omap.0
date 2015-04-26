From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Sun, 26 Apr 2015 21:12:16 +0200
Message-ID: <20150426191216.GZ19431@pengutronix.de>
References: <20150424190207.GU19431@pengutronix.de>
 <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150425021024.GA14963@saruman.tx.rr.com>
 <553D0450.6050403@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553D0450.6050403-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 26, 2015 at 08:29:20AM -0700, Guenter Roeck wrote:
> On 04/24/2015 07:10 PM, Felipe Balbi wrote:
> >On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-K=F6nig wrote:
> >>ti,hwmods doesn't belong into the compatible section but is a prope=
rty
> >>on it's own. Also reformat the section of required properties to ma=
tch the
> >>usual style of dt binding documents.
> >>
> >>Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >
> >looks great to me, thanks
> >
> >Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >
>=20
> Reviewed-by: and Acked-by: are mutually exclusive.
Really? Acked means you like it and Reviewed by means you looked deeper
into it. Maybe reviewing without liking isn't likely, *shrug*.

The command

	$ git rev-list linus/master | while read cmmt; do git cat-file commit =
$cmmt | awk -v cmmt=3D$cmmt '$1 ~ /(Acked|Reviewed)-by:/ { $1 =3D ""; p=
rint cmmt " " $0 }' | sort; done | uniq -d

should catch all commits that have duplicate tags. There are a few,
*shrugagain*.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
