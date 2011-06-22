From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] Fix CPU spinlock lockups on secondary CPU bringup
Date: Wed, 22 Jun 2011 20:46:48 +0200
Message-ID: <1308768408.2268.2.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
References: <20110622105550.GQ23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110622105550.GQ23234@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Le mercredi 22 juin 2011 =C3=A0 11:55 +0100, Russell King - ARM Linux a
=C3=A9crit :
> From: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> Secondary CPU bringup typically calls calibrate_delay() during its
> initialization.  However, calibrate_delay() modifies a global variabl=
e
> (loops_per_jiffy) used for udelay() and __delay().
>=20
> A side effect of 71c696b1 (calibrate: extract fall-back calculation
> into own helper) introduced in the 2.6.39 merge window means that we
> end up with a substantial period where loops_per_jiffy is zero.  This
> causes the spinlock debugging code to malfunction:
=2E..

> =20
> +	loops_per_jiffy =3D lpj;
>  	printed =3D true;
>  }

To be 100% safe, I would use

	ACCESS_ONCE(loops_per_jiffy) =3D lpj;

But I assume no current gcc would be that stupid ;)
