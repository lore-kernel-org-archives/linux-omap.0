From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
Date: Mon, 24 Jan 2011 09:53:49 -0800
Message-ID: <87bp36b32q.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1295879565-13144-1-git-send-email-hvaibhav@ti.com>
	<AANLkTi=pYjxQkw2a+7R_H6HBYpKyg74uEKS9oGqtN9cO@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739404BD65F506@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50248 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753354Ab1AXRxz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 12:53:55 -0500
Received: by mail-qy0-f178.google.com with SMTP id 33so4293640qyk.16
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 09:53:55 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD65F506@dbde02.ent.ti.com>
	(Vaibhav Hiremath's message of "Mon, 24 Jan 2011 20:32:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Varadarajan, Charulatha [mailto:charu@ti.com]
>> Sent: Monday, January 24, 2011 8:13 PM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org; tony@atomide.com
>> Subject: Re: [PATCH] OMAP3EVM: Add vio regulator supply required for
>> ads7846 TSC driver
>>=20
>> On Mon, Jan 24, 2011 at 20:02,  <hvaibhav@ti.com> wrote:
>> > From: Vaibhav Hiremath <hvaibhav@ti.com>
>> >
>>=20
>> Please add a patch description.
>>=20
> [Hiremath, Vaibhav] I can copy/paste subject line again here, but I t=
hought subject description is sufficient to explain purpose of patch so=
 did not mentioned anything here.

Please summarize the change in a descriptive changelog.  You can do mor=
e
than copy/paste and add a few more lines of description, e.g.

The on-board touchscreen controller on the OMAP3EVM is powered by...

The changelogs go into the *permanent* history, so changelogs should be
descriptive enough not just for those familiar with the code but for
those reading the changelogs in the future.

Thanks,

Kevin


>
>> >
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> > ---
>> > =C2=A0arch/arm/mach-omap2/board-omap3evm.c | =C2=A0 20 +++++++++++=
+++++++++
>> > =C2=A01 files changed, 20 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
>> omap2/board-omap3evm.c
>> > index a158d21..ed0311c 100644
>> > --- a/arch/arm/mach-omap2/board-omap3evm.c
>> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> > @@ -538,6 +538,25 @@ static struct regulator_init_data omap3_evm_v=
pll2 =3D
>> {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.consumer_supplies =C2=A0 =C2=A0 =C2=A0=
=3D &omap3_evm_vpll2_supply,
>> > =C2=A0};
>> >
>> > +/* ads7846 on SPI */
>> > +static struct regulator_consumer_supply omap3evm_vio_supply =3D
>> > + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("vcc", "spi1.0");
>> > +
>> > +/* VIO for ads7846 */
>> > +static struct regulator_init_data omap3evm_vio =3D {
>> > + =C2=A0 =C2=A0 =C2=A0 .constraints =3D {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_uV =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_uV =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .apply_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D true,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid_modes_ma=
sk =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | RE=
GULATOR_MODE_STANDBY,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid_ops_mask=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_CHANGE_MODE
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | RE=
GULATOR_CHANGE_STATUS,
>> > + =C2=A0 =C2=A0 =C2=A0 },
>> > + =C2=A0 =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
>> > + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D =
&omap3evm_vio_supply,
>> > +};
>> > +
>> > =C2=A0static struct twl4030_platform_data omap3evm_twldata =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_base =C2=A0 =C2=A0 =C2=A0 =3D TWL4=
030_IRQ_BASE,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_end =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 TWL4030_IRQ_END,
>> > @@ -550,6 +569,7 @@ static struct twl4030_platform_data omap3evm_t=
wldata
>> =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.codec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &omap3evm_codec_data,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.vdac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D &omap3_evm_vdac,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.vpll2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &omap3_evm_vpll2,
>> > + =C2=A0 =C2=A0 =C2=A0 .vio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D &omap3evm_vio,
>> > =C2=A0};
>> >
>> > =C2=A0static struct i2c_board_info __initdata omap3evm_i2c_boardin=
fo[] =3D {
>> > --
>> > 1.6.2.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
