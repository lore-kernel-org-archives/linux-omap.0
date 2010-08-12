From: Gregory CLEMENT <gclement00@gmail.com>
Subject: Re: [PATCH 0/2] Put OMAP2 SPI CS in unactive state when return from
	suspend
Date: Thu, 12 Aug 2010 10:54:00 +0200
Message-ID: <AANLkTinPbOR2OUyfiCLkkbV6gCjxib+-mmMKNf9mzeDC@mail.gmail.com>
References: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
	<871va52ent.fsf@deeprootsystems.com>
	<AANLkTik7O1s-UAt0abyJoakSSjHGJD6CSktOD+O=BGou@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55146 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0HLIyB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 04:54:01 -0400
Received: by fxm13 with SMTP id 13so580855fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 01:54:00 -0700 (PDT)
In-Reply-To: <AANLkTik7O1s-UAt0abyJoakSSjHGJD6CSktOD+O=BGou@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>

2010/8/11 Kevin Hilman <khilman@deeprootsystems.com>
>
> Gregory CLEMENT <gclement00@gmail.com> writes:
>
> > We notice that when system wake up from OFF mode, then CS is in
> > unactive state until the first SPI transfert.
> > For our design it lead to some conflict on this I/O.
> > Unactive state for CS when there is no transfert shoudl be the corr=
ect
> > behaviour: this is the purpose of these patches.
>
> This approach handles an off-mode transition during suspend, but if
> off-mode is enabled, you can also have an off-mode transition during
> idle.
>

Well maybe I didn't use the correct words.
During the system life, I monitored the CS behaviour using a oscillosco=
pe.
I also activate debug in omap2_mcspi, so I see when driver disable the
clocks and restore context when device is not used.
Each time the CS is in the correct state. It is only when there is a
suspend with the following configuration that on resume the CS is in
wrong state( ie activated)


echo 1 > /mnt/pm_debug/enable_off_mode
echo 0 > /mnt/pm_debug/core_pwrdm/suspend
echo 1 > /mnt/pm_debug/voltage_off_while_idle


>
> Since you didn't describe what the conflicts you're seeing are, I wou=
ld
> assume that you'll have the same problems in idle as in suspend, and
> this series doesn't address the idle case.

I didn't see any problem in idle case, just when system resume from a
suspend to ram (echo mem > /sys/power/state)

>
> Kevin
>
>
>
> > Gregory CLEMENT (2):
> > =A0 spi: Add hook on suspend/resume for spi master
> > =A0 spi/omap2_mcspi: When SPI wake up from OFF mode, CS is in wrong
> > =A0 =A0 state: force it to unactive state
> >
> > =A0drivers/spi/omap2_mcspi.c | =A0 11 ++++++++++-
> > =A0drivers/spi/spi.c =A0 =A0 =A0 =A0 | =A0 15 ++++++++++++++-
> > =A0include/linux/spi/spi.h =A0 | =A0 =A04 +++-
> > =A03 files changed, 27 insertions(+), 3 deletions(-)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l

--
Gregory CLEMENT
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
