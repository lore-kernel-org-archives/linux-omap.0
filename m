From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Tue, 2 Dec 2008 11:09:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904F156@dbde02.ent.ti.com>
References: <200811281154.06274.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200811281154.06274.david-b@pacbell.net>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi David,

Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Saturday, November 29, 2008 1:24 AM
> To: Hiremath, Vaibhav
> Cc: video4linux-list@redhat.com; davinci-linux-open-source-
> bounces@linux.davincidsp.com; linux-omap@vger.kernel.org; Jadav,
> Brijesh R; Shah, Hardik; Hadli, Manjunath; R, Sivaraj; Karicheri,
> Muralidharan
> Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
>=20
> On Friday 28 November 2008, David Brownell wrote:
> > On Friday 28 November 2008, Hiremath, Vaibhav wrote:
> > > Will have to now think how to differentiate between these
> > > two chips and handle this sequence.
> >
> > That's really easy, the "id" parameter to probe() tells you:
> >
> > 	if (strcmp(id->name, "tvp5146") =3D=3D 0)
> > 		/* original '46 part ... */;
> > 	else if (strmcp(id->name, "tvp5146m2") =3D=3D 0)
> > 		/* new '46m2 version ... */
> > 	... etc
>=20
> ... although it's even easier to use id->driver_data to
> hold, for example, a bitmask telling various attributes
> of that particular device.  Examples here:
>=20
> 	- does it have the extra '46 registers?
> 	- does it use the original '46 init sequence?
> 	- or the new m2 one?
> 	- or the original '47 init sequence?
> 	- or the new m1 version?
> 	- ...
>=20
> Another common use of driver_data is to hold a pointer
> to a struct holding chip-specific data that doesn't fit
> into a simple bitmask.
>=20
[Hiremath, Vaibhav] I am trying to use/save complete init sequence in=20
id->driver_data -

static const struct i2c_device_id tvp514x_id[] =3D {
	{"tvp5146", (unsigned int)&tvp5146_init},
	{"tvp5146m2", (unsigned int)&tvp514xm_init},
	{"tvp5147", (unsigned int)&tvp5147_init},
	{"tvp5147m1", (unsigned int)&tvp514xm_init},
	{},
};

NOTE: Please note that init sequence for 46, 47 are different.

But I came to know that, client structure doesn't have any parameter whic=
h will provide me the index under this id table. The only differentiating=
 parameter we have is "name" (decoder->client->driver->name).

I can use "id->driver_data" only in my probe function without any index.=20

So left with only following options -

1)=20
 	if (strcmp(id->name, "tvp5146") =3D=3D 0)
 		/* original 46 init seq */;
	else if (strcmp(id->name, "tvp5147") =3D=3D 0)=20
		/* original 47 init seq */
 	else if ((strmcp(id->name, "tvp5146m2") =3D=3D 0) ||=20
			(strmcp(id->name, "tvp5147m1") =3D=3D 0))
		/* New 46/47 init seq */

2)

Driver specific structure must contain either of
	- Index of i2c_device_id table, use this to get the driver_data. (This a=
lso requires string compare to get the index.)
	- Pointer to init_reg_seq, which is pointer to array of structure for tv=
p514x_regs. This is little bit ugly, since will have to export tvp514x_re=
gs structure.
	- Or have pointer to i2c_device_id itself. (Implemented and tested)


I prefer to use second option, instead of comparing the name string in s_=
power every time. And it will be very easy to add even more chips providi=
ng generic solution; we need to just add entry to i2c_device_id with expe=
cted init sequence and you are done.

Any suggestions or inputs appreciated???

> - Dave


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
