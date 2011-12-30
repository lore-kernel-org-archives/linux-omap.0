From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 5/5] bq27x00 - don't report power-supply change so often.
Date: Fri, 30 Dec 2011 13:13:28 +0200
Message-ID: <CANOLnOM7QbF5aMb1iW0W2t6B1q1J+cROMU8SpD185DyC33w4kA@mail.gmail.com>
References: <20111230004947.11559.81184.stgit@notabene.brown>
	<20111230005849.11559.78948.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41890 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1L3LNa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Dec 2011 06:13:30 -0500
In-Reply-To: <20111230005849.11559.78948.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Anton Vorontsov <cbouatmailru@gmail.com>

CCing Lars who added this. I vaguely recall something about generating
events to make some battery monitors update but I forget the details
now, maybe it was about something else. Also CCing Anton (the
maintainer).

On Fri, Dec 30, 2011 at 2:58 AM, NeilBrown <neilb@suse.de> wrote:
> A power_supply_changed should only be reported on significant changes
> such as transition between charging and not. =C2=A0Incremental change=
s
> such as charge increasing should not be reported - that can easily
> be polled for.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
> =C2=A0drivers/power/bq27x00_battery.c | =C2=A0 15 ++++++++++++---
> =C2=A01 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_=
battery.c
> index bb16f5b..7993a17 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -57,11 +57,15 @@
> =C2=A0#define BQ27000_FLAG_CHGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(7)
> =C2=A0#define BQ27000_FLAG_FC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(5)
>
> +#define BQ27000_FLAGS_IMPORTANT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(BQ27000_FLAG_FC|BQ27000_FLAG_CHGS|BIT(31))
> +
> =C2=A0#define BQ27500_REG_SOC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2C
> =C2=A0#define BQ27500_REG_DCAP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x3C /* Design capacity */
> =C2=A0#define BQ27500_FLAG_DSC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BIT(0)
> =C2=A0#define BQ27500_FLAG_FC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(9)
>
> +#define BQ27500_FLAGS_IMPORTANT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(BQ27500_FLAG_FC|BQ27500_FLAG_DSC|BIT(31))
> +
> =C2=A0#define BQ27000_RS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 20 /* Resistor sense */
>
> =C2=A0struct bq27x00_device_info;
> @@ -259,6 +263,7 @@ static void bq27x00_update(struct bq27x00_device_=
info *di)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct bq27x00_reg_cache cache =3D {0, };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_bq27500 =3D di->chip =3D=3D BQ2750=
0;
> + =C2=A0 =C2=A0 =C2=A0 int flags_changed;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cache.flags =3D bq27x00_read(di, BQ27x00_R=
EG_FLAGS, is_bq27500);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cache.flags >=3D 0) {
> @@ -280,10 +285,14 @@ static void bq27x00_update(struct bq27x00_devic=
e_info *di)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ignore current_now which is a snapshot =
of the current battery state
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and is likely to be different even betw=
een two consecutive reads */
> - =C2=A0 =C2=A0 =C2=A0 if (memcmp(&di->cache, &cache, sizeof(cache) -=
 sizeof(int)) !=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 di->cache =3D cach=
e;
> + =C2=A0 =C2=A0 =C2=A0 flags_changed =3D di->cache.flags ^ cache.flag=
s;
> + =C2=A0 =C2=A0 =C2=A0 di->cache =3D cache;
> + =C2=A0 =C2=A0 =C2=A0 if (is_bq27500)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags_changed &=3D=
 BQ27500_FLAGS_IMPORTANT;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags_changed &=3D=
 BQ27000_FLAGS_IMPORTANT;
> + =C2=A0 =C2=A0 =C2=A0 if (flags_changed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0power_supply_c=
hanged(&di->bat);
> - =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0di->last_update =3D jiffies;
> =C2=A0}
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
