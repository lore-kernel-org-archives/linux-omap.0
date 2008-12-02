From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Mon, 1 Dec 2008 22:38:53 -0800
Message-ID: <200812012238.54240.david-b@pacbell.net>
References: <19F8576C6E063C45BE387C64729E739403E904F156@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:46037 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750986AbYLBGi5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 01:38:57 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E904F156@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>

On Monday 01 December 2008, Hiremath, Vaibhav wrote:
> >=20
> > Another common use of driver_data is to hold a pointer
> > to a struct holding chip-specific data that doesn't fit
> > into a simple bitmask.
> >=20
> [Hiremath, Vaibhav] I am trying to use/save complete init sequence in=
=20
> id->driver_data -
>=20
> static const struct i2c_device_id tvp514x_id[] =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5146", (unsigned int)&tvp5146_init},

Well, kernel_ulong_t ...

> =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5146m2", (unsigned int)&tvp514xm_init},
> =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5147", (unsigned int)&tvp5147_init},
> =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5147m1", (unsigned int)&tvp514xm_init},
> =A0=A0=A0=A0=A0=A0=A0=A0{},
> };
>=20
> NOTE: Please note that init sequence for 46, 47 are different.
>=20
> But I came to know that, client structure doesn't have any parameter
> which will provide me the index under this id table. The only
> differentiating parameter we have is "name" (decoder->client->driver-=
>name). =20

Right; why would you need an index, if you've got the pointer you
were going to use to look it up anyway?

	struct tvp_init {
		enum tvp_id	id;		/* tvp5146, tvp5146m2, etc */
		short		*entries;	/* ((addr << 8) | value, etc */
		unsigned	n_entries;
	};

	struct tvp_init tvp515xm_init =3D { ... };
	... etc

=20
> I can use "id->driver_data" only in my probe function without any ind=
ex.=20
>=20
> So left with only following options -
>=20
> 1)=20
> =A0=A0=A0=A0=A0=A0=A0=A0if (strcmp(id->name, "tvp5146") =3D=3D 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* original 46 init s=
eq */;
> =A0=A0=A0=A0=A0=A0=A0=A0else if (strcmp(id->name, "tvp5147") =3D=3D 0=
)=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* original 47 init s=
eq */
> =A0=A0=A0=A0=A0=A0=A0=A0else if ((strmcp(id->name, "tvp5146m2") =3D=3D=
 0) ||=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0(strmcp(id->name, "tvp5147m1") =3D=3D 0))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* New 46/47 init seq=
 */

Avoid that; it's already been done before you, if you pass the
right info in driver_data.

=20
> 2)
>=20
> Driver specific structure must contain either of

By "driver specific structure" do you mean what the
board init code stores in i2c_client.dev.platform_data?

I'm assuming that's what you mean ... but of course, a
second driver-specific structure is what you'd normally
store in probe() and retrieve with i2c_get_clientdata().


> =A0=A0=A0=A0=A0=A0=A0=A0- Index of i2c_device_id table, use this to g=
et the driver_data.
>   =A0=A0=A0=A0=A0=A0=A0=A0(This also requires string compare to get t=
he index.)=20

No, you're given the i2c_device_id entry as a probe() parameter.
Just dereference id to get driver_data; no stable index numbers
needed.  Store it away along through i2c_get_clientdata() if
you need it later.


> =A0=A0=A0=A0=A0=A0=A0=A0- Pointer to init_reg_seq, which is pointer t=
o array of structure
>   =A0=A0=A0=A0=A0=A0=A0=A0for tvp514x_regs. This is little bit ugly, =
since will have to=20
>   =A0=A0=A0=A0=A0=A0=A0=A0export tvp514x_regs structure.

The platform_data should not hold such stuff; it's not board-specific.
I'd expect platform_data to hold regulator_init_data as needed to
instantiate the regulator; and maybe other stuff needed on this board
too.  Floor and ceiling parameters, maybe, unless they change at runtim=
e.

The init sequence wouldn't matter at all for i2c_get_clientdata(),
since it should only kick in during probe().


> =A0=A0=A0=A0=A0=A0=A0=A0- Or have pointer to i2c_device_id itself. (I=
mplemented and tested)

Hmm, now I'm not sure what you mean.  Were you talking about
the i2c_get_clientdata() stuff instead?
=20

> I prefer to use second option, instead of comparing the name string i=
n
> s_power every time. And it will be very easy to add even more chips
> providing generic solution; we need to just add entry to i2c_device_i=
d
> with expected init sequence and you are done.  =20

If I interpret your words correctly, I agree.  The whole point of
the id table is to let probe just use the "id" directly to get at
descriptors with chip-specific data.

- Dave
=20

> Any suggestions or inputs appreciated???


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
