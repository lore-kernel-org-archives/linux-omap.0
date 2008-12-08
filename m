From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] TPS6235x driver added into the power regulator framework
Date: Mon, 8 Dec 2008 05:33:45 -0800
Message-ID: <200812080533.46042.david-b@pacbell.net>
References: <1228730882-22328-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:36131 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751977AbYLHNds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 08:33:48 -0500
In-Reply-To: <1228730882-22328-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@sirena.org.uk>

On Monday 08 December 2008, Manikandan Pillai wrote:
> +++ b/drivers/regulator/tps6235x-regulator.c
> @@ -0,0 +1,557 @@
> +/*
> + * tps6235x-regulator.c -- support regulators in tps6235x family chi=
ps
> + *
> + * Copyright (C) 2008 David Brownell
> + * Author : Manikandan Pillai<mani.pillai@ti.com>
> + *

No, not copyright by me.  I didn't write this.  Take my
name off of your code.


Note that your patch [2/2] should have been merged with the
relevant parts of this patch ... which, as Mark noted,
is all over the map and needs to partitioned according
to structure.

A patch supporting *JUST* the regulator will seemingly
touch drivers/regulator/{Kconfig,Makefile} and create
a new drivers/regulator/tps6235x-regulator.c file; that
would be a good first patch for your set.

I suggest your Kconfig not mention the PR785 card; there
are surely plenty of other products using these chips and
there's no way you can (or should!) mention them all.  If
you're tempted to have pr785-specific logic in the
generic regulator code, think again:  that's a sign you
are not actually writing generic, reusable code.  And
for something as *SIMPLE* as the $SUBJECT family of
regulators, there's no reason to write anything except
fully reusable code which implements the regulator API.

(With one key exception.  Floor/ceiling support for
dynamic voltage switching is not part of that API.
I suggest you treat the regulator calls as applying
to the ceiling, with "floor" support as an extension.)


> +struct tps_6235x_info {
> +=A0=A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
state;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
tps_i2c_addr;
> +=A0=A0=A0=A0=A0=A0=A0struct i2c_client=A0=A0=A0=A0=A0=A0=A0*client;
> +=A0=A0=A0=A0=A0=A0=A0struct device=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*=
i2c_dev;
> +=A0=A0=A0=A0=A0=A0=A0/* platform data holder */
> +=A0=A0=A0=A0=A0=A0=A0void=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0*pdata;
> +};
> +
> +static struct tps_6235x_info =A0 =A0tps_6235x_infodata[2];

I'm not following this. =20

 - The tps_info should be accessed by i2c_get_clientdata(),
   and initialized by i2c_set_clientdata().  It's instance
   specific data, and that's how to manage such data.

 - tps_i2c_addr is completely un-needed; client->addr is
   the same thing.

 - ditto i2c_dev; &client->dev is the same thing.

 - and pdata is client->dev.platform_data.

Plus there's no reason to limit the system to two of
these regulators ... get rid of that global.


And you should remove all the pr785-specific code
from the regulator driver.  That includes the vdd1
and vdd2 consumers -- none of that belongs as part
of a generic regulator driver.  Needing to have those
board-specific constraints should have been a Sign...


> +
> +static
> +int tps_6235x_probe(struct i2c_client *client, const struct i2c_devi=
ce_id
> *id) +{
> +=A0=A0=A0=A0=A0=A0=A0struct =A0tps_6235x_info =A0 =A0 =A0 =A0 =A0*in=
fo;
> +=A0=A0=A0=A0=A0=A0=A0struct =A0regulator_dev =A0 =A0 =A0 =A0 =A0 *rd=
ev =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0unsigned char reg_val;
> +
> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "tps_6235x_probe:i2c_addr =3D =
%x\n", (int)client->addr);

That's a debug message.  Use dev_dbg(); and plan to remove that
one before this merges.


> +=20
> +=A0=A0=A0=A0=A0=A0=A0info =3D &tps_6235x_infodata[id->driver_data];
> +=A0=A0=A0=A0=A0=A0=A0/* Device probed is TPS62352 CORE pwr chip if d=
river_data =A0=3D 0
> +=A0=A0=A0=A0=A0=A0=A0Device probed is TPS62353 MPU pwr chip if drive=
r_data =3D 1 =A0 */

It would be a lot easier to just have initted driver_data to
point to the "info" you wanted.

But you're also mis-understanding some things here.

The id->driver_data should be *generic* data ... as in,
if you had three '52 chips (maybe on different busses),
they'd all have the same driver_data, stuff holding true
for every instance of one of those chips.  Regulator
ops vectors; maybe some tables they use, which help
interpret register bitfields.  Read-only goodies.

If you want instance-specific data, there are two
flavors of that.  One is from client->dev.platform_data,
full of board-specific state you treat as read-only.

The other is stuff that you collect over time; an
example might be statistics.  Call this "mutable state".
The convention is that probe() will kzalloc() a
struct holding "mutable state", then stuff that
with goodies.  Like maybe the i2c_client, so it's
always available; stuff from id->driver_data, so
chip parameters don't get forgotten; and whatever
else you need.

You're turning the generic/"type description"
data into per-instance mutable state, and then
limiting this to two instances total!

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
