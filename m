From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Wed, 27 Jan 2016 08:24:53 -0800
Message-ID: <20160127162452.GJ19432@atomide.com>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd>
 <20160121163857.GH19432@atomide.com>
 <20160121165408.GJ5783@n2100.arm.linux.org.uk>
 <20160127100237.GH25796@pali>
 <20160127111828.GK5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160127111828.GK5783-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [160127 03:19]:
> On Wed, Jan 27, 2016 at 11:02:37AM +0100, Pali Roh=C3=A1r wrote:
> > In my opinion this patch is not support for new hardware. It just a=
dd
> > missing DT definition for one specific board for HW which was added=
 to
> > linux kernel in v4.2-rc1 version. For me it looks like that needed =
DT
> > definition was forgotten...
>=20
> Opinions differ, but ultimately it's up to whoever is responsible for
> accepting the patch, and in the case of ARM SoC based patches, the
> arm-soc maintainers.

Yeah. Sorry for long delay as discussed. I'm applying the $subject
patch finally into omap-for-v4.6/dt today.

We still have at least two fixes left to go that both affect also
n900. But at least I can now sanely test adding new stuff with a WIP
fix for the PM runtime regression.

> The arm-soc maintainers close their trees for development changes a
> few weeks before hand (a patch of mine which was acked etc by 7th
> December never made the 4.5 merge window either, and the alleged
> reason I've been told is because arm-soc was already closed by then).

Heh I too have some pending clock framework patches from December
that I did not repost yet as the maintainers notified that they
rather not take new stuff any longer for v4.5 before the holidays.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
