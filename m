From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: AM3505/3517 support
Date: Tue, 05 Jul 2011 10:35:47 -0400
Message-ID: <4E132143.7040802@8d.com>
References: <4E121485.6060700@8d.com> <20110705111952.GG5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:39502 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab1GEOfu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jul 2011 10:35:50 -0400
In-Reply-To: <20110705111952.GG5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 05/07/11 07:19 AM, Tony Lindgren wrote:
> * Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com> [110704 12:51]:
>>
>> The am3505 is apparently so similar to the 3430 that it was treated =
as such=20
>> (omap_chip.oc was being set to CHIP_IS_OMAP3430ES3_1). There are how=
ever a
>> few differences that need to be addressed. I have therefore created =
a new
>> CHIP_IS and patched clocks, hwmod and power management related files
>> consequently. My system now boots until it complains that it is unab=
le=20
>> to mount its root filesystem.
>=20
> Can you please describe where you need CHIP_IS for am3505? It seems t=
hat
> your patches just enable the same CHIP_IS_OMAP3430 features for am350=
5 too?
Actually it's only needed for the 3505/3517 specific UART 4 which shoul=
d
not be registered on real OMAP3430's. (see struct omap_hwmod=20
am35xx_uart4_hwmod; in omap_hwmod_3xxx_data.c)

But there are also cases where OMAP3430 hwmods must not be registered
on AM35xx. For instance, omap3xxx_timer12_hwmod since timer12 does
not exist general purpose AM3505's.

> I'd rather see us improve the code so we can support am3505 properly =
without
> a need to patch all over the place..
Maybe instead of having one big array of hwmods registered for
all CPUs in omap_hwmod_3xxx_data we could have a separate
one for am35xx (and maybe, eventually others) such as:

static __initdata struct omap_hwmod *omap3xxx_hwmods[]
static __initdata struct omap_hwmod *am35xx_hwmods[]

=2E..and maybe also a 'common' array.

The init function would then register the appropriate hwmod array(s). T=
he only=20
thing I don't like is that for this to work we would have to keep setti=
ng=20
CHIP_IS_OMAP3430 even on AM35xx CPUs. But maybe we could change the beh=
aviour of
omap_hwmod_register to trust the caller and accept the hwmods without l=
ooking=20
at the omap_chip member. By doing this I think we could drop all the=20
=2Eomap_chip =3D OMAP_CHIP_INIT(...) instances.

Otherwise I think the current approach, despite the size of the initial=
 patch,
has at least the benefit of being explicit and less confusing than (ab)=
using the
CHIP_IS from a different CPU.

Best regards,
Rapha=C3=ABl Ass=C3=A9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
