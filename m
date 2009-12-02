From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Wed, 2 Dec 2009 23:32:50 +0200
Message-ID: <6ed0b2680912021332q5f00deb2id1b1b60ec7a69c41@mail.gmail.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
	 <012301ca71ed$449cb930$544ff780@am.dhcp.ti.com>
	 <20091130185813.GA32522@oksana.dev.rtsoft.ru>
	 <6ed0b2680912021238o29d7e773i9379369d7b277614@mail.gmail.com>
	 <20091202212710.GA24789@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755665AbZLBVcs@vger.kernel.org>
In-Reply-To: <20091202212710.GA24789@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Madhusudhan <madhu.cr@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 2, 2009 at 11:27 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, Dec 02, 2009 at 10:38:31PM +0200, Grazvydas Ignotas wrote:
>> On Mon, Nov 30, 2009 at 8:58 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > On Mon, Nov 30, 2009 at 12:45:20PM -0600, Madhusudhan wrote:
>> > [...]
>> >> > + =A0 case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> >> > + =A0 =A0 =A0 =A0 =A0 /* charging must be active for meaningful=
 result */
>> >> > + =A0 =A0 =A0 =A0 =A0 if (!is_charging) {
>> >>
>> >> How about putting a kern_info here?
>> >
>> > It might be better to return -EINVAL.
>>
>> That causes lots of warnings from power_supply core (driver failed t=
o
>> report XXX property), Not sure what to do here, I'd prefer to keep
>> returning 0.
>
> Lying to userspace is a bad idea.
>
> How about this patch + changing the driver to return -ENODATA?

This is fine for me, thanks.

>
> From 0fe4c834b551c4d4454d57acaf75645675d199ee Mon Sep 17 00:00:00 200=
1
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Thu, 3 Dec 2009 00:24:51 +0300
> Subject: [PATCH] power_supply_sysfs: Handle -ENODATA in a special way
>
> There are cases when some device can not report any meaningful value,
> e.g. TWL4030 charger can report voltage only when charging is
> active.
>
> In these cases drivers will return -ENODATA, and we shouldn't flood
> kernel log with error messages.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0drivers/power/power_supply_sysfs.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power=
_supply_sysfs.c
> index 0814439..c790e0c 100644
> --- a/drivers/power/power_supply_sysfs.c
> +++ b/drivers/power/power_supply_sysfs.c
> @@ -65,7 +65,10 @@ static ssize_t power_supply_show_property(struct d=
evice *dev,
> =A0 =A0 =A0 =A0ret =3D psy->get_property(psy, off, &value);
>
> =A0 =A0 =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D -ENODEV)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -ENODATA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "driver ha=
s no data for `%s' property\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr->a=
ttr.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ret !=3D -ENODEV)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "driver f=
ailed to report `%s' property\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0attr->=
attr.name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> --
> 1.6.3.3
>
>
