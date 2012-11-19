From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: tfp410 and i2c_bus_num
Date: Mon, 19 Nov 2012 13:09:42 +0200
Message-ID: <50AA1376.6060801@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com> <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com> <20121116151959.GA19411@arwen.pp.htv.fi> <50A65E40.9040208@ti.com> <20121116182146.GC20496@arwen.pp.htv.fi> <50A72390.3050509@ti.com> <20121118113437.GB30462@arwen.pp.htv.fi> <50A9D3DD.6040807@ti.com> <20121119092744.GB4211@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0271B90883DDDDC8F71623E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121119092744.GB4211-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--------------enigA0271B90883DDDDC8F71623E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-19 11:27, Felipe Balbi wrote:

>> If we had a separate, independent i2c-edid driver, we'd have to someho=
w
>> link the i2c-edid driver and tfp410 (or whatever driver would handle t=
he
>> video link in that particular case) so that the i2c-edid driver would
>> know about hotplug events. We would also need to link the drivers so
>> that the edid can be associated with the video pipeline the tfp410 chi=
p
>> is part of, and to the particular slot in the pipeline where the tfp41=
0 is.
>=20
> that should all be doable, just look at how v4l2 handles pipelining the=

> video data (all in userland though) and you'll see it's definitely
> possible.

Afaik, v4l2 handles only the pipeline for video. This i2c-edid would not
be part of the video pipeline, so I don't see a connection to v4l2.

And I'm not saying it's not possible, or that the current way is good or
correct. I'm saying it's not easy, and definitely more complex than the
current tfp410 implementation. The amount of code related to this
feature would multiply.

If we had 10 different tfp410 like drivers, then obviously there'd be
more pressing reason to clean this up. But currently we have only one
place where this code is used.

>> I haven't tried writing such a driver, but it sounds much more complex=

>> to me than doing one or two i2c reads in the tfp410 driver.
>=20
> until you have e.g. tfp999, tfp534, tfp678 (hypothetical device numbers=
,
> they probably don't exist) which are all SW incompatible and you have t=
o
> duplicate i2c reads in all of them. Whereas if you had a dedicated
> i2c-edid.c driver, you would only have to tell them where to get EDID
> structure from.
>=20
> Also, if you have systems with different panel interfaces, they will us=
e
> the same i2c-edid.c and just instantiate that class multiple times.

Yep. Althought the same could be done with a common edid library,
without an i2c-edid driver.

>>>> So we need a generic way to get the resolution information, and it m=
akes
>>>> sense to have this in the components of the video path, not in a
>>>> separate driver which is not part of the video path as such.
>>>
>>> But the I2C bus isn't part of the video path anyway. It's a completel=
y
>>> separate path which is dedicated to reading EDID. If you need a gener=
ic
>>
>> While reading EDID is totally separate from the video data itself, it =
is
>> not separate from the hotplug status of the cable. And the EDID needs =
to
>> be associated with the video path in question, of course.
>=20
> yes, but that can't be done in another way right ? Try something like
> having a EDID provider and an EDID consumer. The provider will be
> i2c-edid.c or dvi-edid.c and the consumer will a generic layer which
> tfp410 would use to request certain attributes from the EDID structure.=


TFP410 doesn't need the EDID for anything, it just provides it as raw
data. Parsing the EDID is done in other layers. But as you said, instead
of tfp410 fetching the EDID and providing it, tfp410 could get the EDID
from the i2c-edid driver and pass it forward.

> I think that would look a lot nicer as the underlying implementation fo=
r
> requesting EDID would be completely encapsulated from its users.

If with "users" you mean, for example, tfp410, then true. But tfp410
doesn't use EDID for anything, it just provides it. For the actual users
of the EDID data reading the EDID is encapsulated already.

>> No, reading edid is done via generic read_edid call. TFP410 uses i2c t=
o
>> read edid, but it could do it in any way it wants.
>=20
> it's not very well designed, then, if tfp410 still needs to fetch the
> i2c adapter. It still has to know about the underlying bus for reading
> EDID.

Well, yes. TFP410 is a RGB to DVI chip. It knows that the underlying bus
is DVI, and that there are i2c lines to read the EDID. There are no
other option what the busses could be. So I don't see any problem with
knowing the underlying bus.

>>> In fact current implementation is far worse than having an extra
>>> i2c-edid.c driver because it doesn't encapsulate EDID implementation
>>> from tfp410.
>>>
>>> Then moment you need to read EDID via DSI, you will likely have to pa=
ss
>>> a DSI handle to e.g. TFP410 so it can read EDID via DSI.
>>
>> TFP410 is a parallel RGB to DVI chip. It's not related to DSI. The DSI=

>> case would be with some other chip.
>=20
> it doesn't change what I said, however. Another chip will need to be
> passed in a DVI handle.

I'm sorry, but I don't understand what you're saying above...

If we have a DSI-2-DVI chip, then reading the EDID would be done by
sending a DSI command to the chip, which would return the EDID data.
Which would be passed forward when someone requests it. There would not
be anything in common with tfp410 and i2c implementation.

>> We could have a library with the code that does the one or two i2c
>> reads. And while I think it'd be good, we're talking about one or two
>> i2c reads. It wouldn't be a huge improvement.
>=20
> fair enough... it looks like this is going nowhere, so best we come bac=
k
> to this later. No reason to block your patch.

Well, the patch is a fix for stable kernels, so even if we had a great
idea how to rewrite the dss device handling, it wouldn't affect this
patch =3D).

 Tomi



--------------enigA0271B90883DDDDC8F71623E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqhN2AAoJEPo9qoy8lh71CTwP/1kl59iUlqNCfi0HEcH/Vt0G
WlR+wkZpyDmS1HBY/8R82vnHHCy0fY31LHz6F/6Tl3AFgC78dkIdyi5/PW9OhYFq
XFdVYpeuY3pySf+zISOiABtYrK+E1MFwFpTQwO08lberyAaJFSLWpxcmc1B53hAV
zL4xoSwX5dKIL+DZSeI81+jhDOr9tDaQrC+U4WklFtI4/D7CM4WSmdHE1PaehZan
UbFyau0C1CfLfy/zVmDQ9gdHiqxp8UcNew6s4XA1BPIt1dsYlfUB4LglRtmIXSEh
py7kRYRWZCprV2lOWGrlrxnoiw5YyUkBnETAHFxj+WW1w7wCBbdwFgEuZi8dRxxs
UqUu6HN8tvTx6wza+ZqUvrsPk5nipad4mY9FPVw+J89le9RO4KM3OR3xsCN3+NZT
8sB0sJmrtVM4UucEyH/fcVpEQdsO6Te8L2TEkFGH/FagAJGylF9eWVWEpgtPUL2U
/Q4gJ03S1+oqD0VcWxB0w96WnLJQVOw2ikKvaBwKZNvI6ZBhRUk4lPdmagkvjl5a
FzaW0GQu5Ww4UMFblDhHO9TLV5E2zUfXXYiPHtRr2H9wO8wvtzpgrwXo1ieJWWpQ
DgxwOfuO6c1ejoWDHK5MaHUkyoJst72IOybz2jIa/KEpFPodPRh14qNDgAD98Ve9
x4wvqZpm055zIdHFhW0I
=IZTz
-----END PGP SIGNATURE-----

--------------enigA0271B90883DDDDC8F71623E--
