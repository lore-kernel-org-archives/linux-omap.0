From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 3/4] usb: phy: twl4030: add support for reading restore on ID pin.
Date: Wed, 4 Mar 2015 07:54:41 +0100
Message-ID: <BF76BA84-5DD6-499D-8A00-E787C843BF7F@goldelico.com>
References: <20150224033730.31400.78200.stgit@notabene.brown> <20150224034037.31400.52748.stgit@notabene.brown> <20150302210431.GH13270@amd> <20150304173551.7cb93917@notabene.brown>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150304173551.7cb93917@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neilb@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Am 04.03.2015 um 07:35 schrieb NeilBrown <neilb@suse.de>:

> On Mon, 2 Mar 2015 22:04:31 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>=20
>> Hi!
>>=20
>>> The twl4030 phy can measure, with low precision, the
>>> resistance-to-ground of the ID pin.
>>>=20
>>> Add a function to read the value, and export the result
>>> via sysfs.
>>>=20
>>> If the read fails, which it does sometimes, try again in 50msec.
>>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>> drivers/phy/phy-twl4030-usb.c |   63 ++++++++++++++++++++++++++++++=
+++++++++++
>>> 1 file changed, 63 insertions(+)
>>>=20
>>> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl403=
0-usb.c
>>> index 023fe150c7a1..759950898df9 100644
>>> --- a/drivers/phy/phy-twl4030-usb.c
>>> +++ b/drivers/phy/phy-twl4030-usb.c
>>> @@ -374,6 +374,56 @@ static void twl4030_i2c_access(struct twl4030_=
usb *twl, int on)
>>> 	}
>>> }
>>>=20
>>> +enum twl4030_id_status {
>>> +	TWL4030_GROUND,
>>> +	TWL4030_102K,
>>> +	TWL4030_200K,
>>> +	TWL4030_440K,
>>> +	TWL4030_FLOATING,
>>> +	TWL4030_ID_UNKNOWN,
>>> +};
>>> +static char *twl4030_id_names[] =3D {
>>> +	"ground",
>>> +	"102k",
>>> +	"200k",
>>> +	"440k",
>>=20
>> New /sys files should be documented somewhere...?
>=20
> Preferably with the code...
>=20
>>=20
>> Does it make sense to change "440k" -> "440KOhm"?
>=20
> Interesting question.  I prefer to avoid including units in files - b=
are
> numbers is better.  But there is no number to match "floating" unless=
 I spell
> it out as "infinity", and wouldn't be helpful.
>=20
> Certainly "K" would be preferred over "k=93,

The international standard for kilo =3D 1000 is a lower case k.
While it is (non-standard) to use K for 1024:

http://en.wikipedia.org/wiki/Kilobyte

So I would keep the string constants lower case to avoid this potential=
 confusion.

> and given that I have "ground"
> and  "floating", it is more consistent to include the "Ohm"....
>=20
> These are really names, not measures of resistance.  The data sheet c=
alls
> them:
> ID_RES_FLOAT  (or sometimes ID_FLOAT)
> ID_RES_440K
> ID_RES_200K
> ID_RES_102K
> ID_GND        (or sometimes ID_RES_GND)
>=20
> So using those names is defensible.
>=20
> I think I'll change them all to upper case, but leave out the "Ohm".
> My justification is consistency with the data sheet.
>=20
>=20
>=20
>=20
>>=20
>> Plus I guess you need to update Documentation/
>=20
> I guess I'll need to give in to this eventually :-)
>=20
>>=20
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>=20
>=20
> Thanks,
> NeilBrown
> _______________________________________________
> Gta04-owner mailing list
> Gta04-owner@goldelico.com
> http://lists.goldelico.com/mailman/listinfo.cgi/gta04-owner
