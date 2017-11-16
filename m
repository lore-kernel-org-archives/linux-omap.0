From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
Date: Thu, 16 Nov 2017 14:43:52 +0100
Message-ID: <130D3B71-C0CE-4755-BF06-971681F630BC@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com> <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com> <4753a425-d050-7f2d-35ae-b387accfd99e@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4753a425-d050-7f2d-35ae-b387accfd99e-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org


> Am 16.11.2017 um 13:32 schrieb Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>:
>=20
> On 16/11/17 10:50, H. Nikolaus Schaller wrote:
>> The vendor name was "toppoly" but other panels and the vendor list
>> have defined it as "tpo". So let's fix it in driver and bindings.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>=20
>=20
>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>=20
> Doesn't this mean that the module won't load if you have old bindings?

Hm.

Well, I think it can load but doesn't automatically from DT strings =
which might
be unexpected.

> Can't we have two module aliases?

I think we can. Just a random example:
=
https://elixir.free-electrons.com/linux/latest/source/drivers/w1/slaves/w1=
_therm.c#L754

So we should keep both.

Should I submit a new version?

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
