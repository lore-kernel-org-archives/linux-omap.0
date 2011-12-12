From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called
 from invalid context
Date: Mon, 12 Dec 2011 15:08:26 -0800
Message-ID: <20111212230825.GJ32251@atomide.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
 <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
 <20111209213447.GB31337@atomide.com>
 <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22963 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137Ab1LLXIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 18:08:31 -0500
Content-Disposition: inline
In-Reply-To: <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ramirez Luna, Omar <omar.ramirez@ti.com> [111209 13:38]:
> On Fri, Dec 9, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> >> + =C2=A0 =C2=A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER=
_SRC_32_KHZ);
> ...
> >> =C2=A0EXPORT_SYMBOL_GPL(omap_dm_timer_request);
> >
> > This does not seem right.. It seems that you're hardcoding the sour=
ce
> > clock to 32 KiHz clock while other sources are available too?
>=20
> Agree, but... (below)
>=20
> >> + =C2=A0 =C2=A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER=
_SRC_32_KHZ);
> ...
> > And here too?
>=20
> Agree but that is the default behavior set by dm timer framework:
>=20
> @@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct
> omap_dm_timer *timer)
>  int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
> ...
> -       ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ=
);
> ...
>=20
> All clocks requested are set to 32 KHz first, even with the current
> approach, there exists another API to set a new source.
>=20
> To be honest I don't know why the clocks are set to 32 KHz first,
> maybe the default call path for users should be:

You need a functional clock for the timer registers to work
I believe.

> omap_dm_timer_request

Yes this would make sense. The omap_timer_list should be protected
by a mutex. There should not be a need for spinlock there as
omap_dm_timer_request should be only called during init. If that's
not the case, the the driver using it is broken.

> omap_dm_timer_set_source (new explicit call)
> omap_dm_timer_start

Once the timer has been requested, there should not be a need
for locking as there should be only one timer user using the
timer specific registers.
=20
> And remove setting the source to 32 KHz by default in omap_dm_timer_r=
equest.

That you may need to be able to do anything with the timer :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
