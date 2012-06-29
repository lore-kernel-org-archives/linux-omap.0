From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
Date: Fri, 29 Jun 2012 15:18:32 +0200
Message-ID: <20120629151832.0cb26bea@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
	<1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
	<20120629144002.3b4a31ee@endymion.delvare>
	<20120629145718.697b6955@endymion.delvare>
	<4FEDA9A8.1050504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FEDA9A8.1050504-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jun 2012 18:42:08 +0530, Shubhrajyoti wrote:
> On Friday 29 June 2012 06:27 PM, Jean Delvare wrote:
> > drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initi=
alization for =E2=80=98msg[1].actual=E2=80=99) [enabled by default]
> >
> > This needs to be all fixed (converted to C99-style struct
> > initialization) before your patch is considered for inclusion. And
> > there may be more that my config did not spot.
> Yes,agree.
>=20
> The idea of this patch was if the idea is agreed upon then.
> then fixing all the callers could be worked on.

This is worth fixing anyway, C99-style initialization is always good to
move to.

> However do you agree with this approach?

Well you've seen the caveats I mentioned, this will be no easy ride. If
you are willing to take the risk, spend the time documenting the
change, and help people if there are issues, then I'm OK. At least as
long as someone else doesn't come saying it's a very bad idea ;)

--=20
Jean Delvare
