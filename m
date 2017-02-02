From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Thu, 2 Feb 2017 06:47:12 +0100
Message-ID: <3BB78F3F-F1FE-4F4C-BFA9-EAB19845161B@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com> <20170128193558.GC38136@dtor-ws> <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com> <20170129180108.GA10743@dtor-ws> <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com> <B64DBFB0-62E8-4B4C-957F-C90C33BEF693@goldelico.com> <cc403765-9b88-1424-a77f-36e775fbd5a0@osg.samsung.com> <20170201222832.GA25554@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201222832.GA25554@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Mark Rutland <mark.rutland@arm.com>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 01.02.2017 um 23:28 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Wed, Feb 01, 2017 at 06:14:39PM -0300, Javier Martinez Canillas =
wrote:
>> Hello Nikolaus,
>>=20
>> On 02/01/2017 05:20 PM, H. Nikolaus Schaller wrote:
>>> Hi Dmitry, Javier,
>>>=20
>>>> Am 29.01.2017 um 19:25 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>>>>=20
>>>> Hi Dmitry,
>>>>=20
>>>>> Am 29.01.2017 um 19:01 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>>>>>=20
>>>>> On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller =
wrote:
>>>>>> Hi Dmitry,
>>>>>>=20
>>>>>>> Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>>>>>>>=20
>>>>>>> On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller =
wrote:
>>>>>>>> Fix module table so that the driver is loaded if compiled
>>>>>>>> as module and requested by DT.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I believe I already replied to a similar patch: we alreadyhave =
necessary
>>>>>>> aliases in this driver, we need to fix module loading to use it.
>>>>>>=20
>>>>>> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
>>>>>>=20
>>>>>>>> We really need to fix it between spi/i23c core and module utils =
instead
>>>>>>>> of keeping adding duplicate IDs all over drivers. We already =
have OF
>>>>>>>> module device table containing the same data, we should be able =
to use
>>>>>>>> it.
>>>>>>=20
>>>>>> And Javier Martinez Canillas replied (23 Nov 2016):
>>>>>>=20
>>>>>>> Agreed, unfortunately until the I2C and SPI core are changed to =
properly
>>>>>>> report OF modaliases, we will have to keep adding these =
duplicated IDs.
>>>>>>>=20
>>>>>>> And changing the I2C and SPI core isn't trivial since it could =
break a
>>>>>>> lot of drivers that rely on a platform modalias being reported =
(i.e: no
>>>>>>> OF device IDs present in the drivers even when are registered =
via DT).
>>>>>>=20
>>>>>> Therefore I didn't see a need to change it.
>>>>>=20
>>>>> I agree that changing I2C and SPI core is not trivial, however =
this is
>>>>> no reason for piling up workarounds in all drivers. Are you =
seriously
>>>>> advocating going though *every* driver and copying OF data into =
I2C/SPI
>>>>> instead of doing the right thing and fixing the root of the issue?
>>>>=20
>>>> If you prefer to have this done (and I agree it would be a tiny =
improvement),
>>>> please do it for us all. But please after merging this workaround.
>>>=20
>>> Have we been lucky to find someone who is able and willing to work =
on this?
>>>=20
>>=20
>> As said, changing the core is trivial. A RFC patch is [0].
>>=20
>> The problem is how to make sure that this change won't cause =
regressions
>> in existing drivers.
>=20
> If the concern with drivers having I2C or SPI device table, but not OF
> device table, then I think cocinnelle could be used to scan and find
> them.
>=20
>>=20
>> There was particularly tricky for the spi-nor driver, it doesn't help =
that
>> a lot of DT are using undocumented compatible strings (sometimes with =
no
>> vendor prefix). You can see the discussion here [1].
>>=20
>> In the same thread Mark Brown said that it wasn't that bad to have =
the
>> information in the OF device ID table duplicated in a SPI device =
table.
>>=20
>> Certainly isn't the best approach but IMHO is better than the module =
not
>> loading.
>=20
> You can always build the module into kernel or load it by hand if it =
is
> that important.

Well, it is the only exception on the OpenPandora that does NOT yet load
automatically from the DT.

And sure we can always find a hack or workaround in user-space for =
everything
the kernel isn't doing well.

> Module autoloading does not work anyway if you have
> several compatible strings, like
>=20
> 	compatible =3D "vendor,new-device", "vendor,generic-device";

We don't use that mechanism here since there is only one ads7846 =
installed
and it won't change.

BR,
Nikolaus
