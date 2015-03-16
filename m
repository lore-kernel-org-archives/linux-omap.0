From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
Date: Mon, 16 Mar 2015 14:25:09 -0700
Message-ID: <20150316212508.GI12397@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <201503162158.50587@pali>
 <20150316210143.GF12397@atomide.com>
 <201503162215.06436@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201503162215.06436@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Luciano Coelho <luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150316 14:15]:
> On Monday 16 March 2015 22:01:43 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150316 13:59]:
> > > On Monday 16 March 2015 16:29:39 Tony Lindgren wrote:
> > > > I believe the last pending issues is the support for
> > > > ATAG_REVISION in device tree mode as posted by Pali.
> > >=20
> > > No. In DT boot there is missing /proc/atags file (readable
> > > by userspace processes).
> >=20
> > Oh OK thanks for the update.
> >=20
> > > And also broken AES/SHA/MD5 support. Fix for crypto DT stuff
> > > I already sent.
> >=20
> > But this is not a regression in mainline with legacy boot vs
> > device tree based booting, right? Sounds like it never worked
> > in the mainline or am thinking of some other set of patches?
> >=20
> > Regards,
> >=20
> > Tony
>=20
> In legacy board code are DMA channels defined. In DT files not.=20
> So I think this is regression. Omap secure devices are broken in=20
> both legacy & DT code, but non secure could work with legacy=20
> code. But all devices booted with DT are broken.

OK I'll apply the DMA channels into omap-for-v4.0/fixes in
that case.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
