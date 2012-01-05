From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x devices
 the same
Date: Thu, 5 Jan 2012 10:48:48 +0100
Message-ID: <CAORVsuXRG=8BesXvfynO_TdUbvZdVTsTcrfC6LNsPdsi54+gpw@mail.gmail.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<1325726206-11199-4-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52068 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2AEJst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 04:48:49 -0500
Received: by vcbfk14 with SMTP id fk14so248113vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Jan 2012 01:48:48 -0800 (PST)
In-Reply-To: <1325726206-11199-4-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Kevin,

On Thu, Jan 5, 2012 at 2:16 AM, Kevin Hilman <khilman@ti.com> wrote:
> The init for 3505/3517 specific clocks depends on the ordering of
> cpu_is checks, is error prone and confusing (there are 2 separate
> checks for cpu_is_omap3505()).
>
> Remove the 3505-specific checking since CK_3505 flag is not used, and
> treat all AM35x clocks the same.
Since the only remaining check is for omap3517 and from this comment
it should be better to use a generic check, e.g. cpu_is_omap35xx().

>
> This means that the SGX clock (the only AM35x clkdev not currently
> flagged for 3505) will now be registered on 3505, but that is
> harmless. =A0That can be cleaned up when the clkdev nodes are removed=
 in
> favor of them being registered by hwmod.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock3xxx_data.c | =A0 14 +-------------
> =A01 files changed, 1 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-oma=
p2/clock3xxx_data.c
> index e09e506..26fb4d9 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3505,21 +3505,9 @@ int __init omap3xxx_clk_init(void)
> =A0 =A0 =A0 =A0struct omap_clk *c;
> =A0 =A0 =A0 =A0u32 cpu_clkflg =3D 0;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* 3505 must be tested before 3517, since 3517 return=
s true
> - =A0 =A0 =A0 =A0* for both AM3517 chips and AM3517 family chips, whi=
ch
> - =A0 =A0 =A0 =A0* includes 3505. =A0Unfortunately there's no obvious=
 family
> - =A0 =A0 =A0 =A0* test for 3517/3505 :-(
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (cpu_is_omap3505()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_mask =3D RATE_IN_34XX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_clkflg =3D CK_3505;
> - =A0 =A0 =A0 } else if (cpu_is_omap3517()) {
> + =A0 =A0 =A0 if (cpu_is_omap3517()) {
This is rather confusing if it applies to other omap35xx variants.
cpu_is_omap35xx() is better.

What do you think?

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
