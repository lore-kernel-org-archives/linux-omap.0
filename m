From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Tue, 18 Nov 2014 19:35:45 +0100
Message-ID: <20141118183545.GA16999@amd>
References: <20141116075928.GA9763@amd>
 <20141117101553.GA21151@amd>
 <20141117145545.GC7046@atomide.com>
 <201411171601.32311@pali>
 <20141117150617.GD7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141117150617.GD7046-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon 2014-11-17 07:06:17, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141117 07:03]:
> > On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> > >=20
> > > There's nothing stopping us from initializing the camera code
> > > from pdata-quirks.c for now to keep it working. Certainly the
> > > binding should be added to the driver, but that removes a
> > > dependency to the legacy booting mode if things are otherwise
> > > working.
> >=20
> > Tony, legacy board code for n900 is not in mainline tree. And=20
> > that omap3 camera subsystem for n900 is broken since 3.5=20
> > kernel... (both Front and Back camera on n900 show only green=20
> > picture).
>=20
> I'm still seeing the legacy board code for n900 in mainline tree :)
> It's deprecated, but still there.
>=20
> Are you maybe talking about some other piece of platform_data that's
> no longer in the mainline kernel?
>=20
> No idea what might be wrong with the camera though.

Camera support for main and secondary cameras was never mainline, AFAIC=
T.

Merging it will not be easy, as it lacks DT support... and was broken
for long time.

Anyway, flash is kind of important for me, since it makes phone useful
as backup light; and it is simple piece of hw, so I intend to keep it
useful.

       	       	   	    	      	      	  		     Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
