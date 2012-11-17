From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: tfp410 and i2c_bus_num
Date: Sat, 17 Nov 2012 07:41:36 +0200
Message-ID: <50A72390.3050509@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com> <20121116135155.GE18527@arwen.pp.htv.fi> <50A64D35.9050109@ti.com> <20121116151959.GA19411@arwen.pp.htv.fi> <50A65E40.9040208@ti.com> <20121116182146.GC20496@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5728B4561905890BE168921E"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121116182146.GC20496-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--------------enig5728B4561905890BE168921E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 20:21, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Nov 16, 2012 at 05:39:44PM +0200, Tomi Valkeinen wrote:
>>>>> To be fair, the whole i2c_bus_num looks like a big hackery introduc=
ed by
>>>>> the way panel drivers are written for OMAP DSS.
>>>>>
>>>>> TFP410 is an I2C client, not an OMAPDSS client. After a quick look =
at
>>>>> the driver, there's is no such thing as a DSS bus, so looks like yo=
u
>>>>> should have an I2C driver for TFP410 and the whole DSS stuff should=
 be
>>>>> just a list of clients, but not a struct bus at all.
>>>>>
>>>>> The fact that you have to pass the I2C bus number down to the panel=

>>>>> driver is already a big indication of how wrong this is, IMHO.
>>>>
>>>> Without going deeper in the dss device model problems, I would agree=

>>>> with you if this was about i2c panel, but this is not quite like tha=
t.
>>>>
>>>> A panel controlled via i2c would be an i2c device. But TFP410 is not=

>>>> controlled via i2c. It's not really controlled at all except via
>>>> power-down gpio. TFP410 doesn't need the i2c to be functional at all=
=2E
>>>
>>> then why does it need the i2c adapter ? What is this power-down gpio =
?
>>> Should that be hidden under gpiolib instead ?
>>
>> For the i2c, see below. Power-down GPIO is used to power down and up t=
he
>> tfp410 chip.
>=20
> that much I guessed ;-) Should it be hidden under gpiolib ?

I have to say I have no idea what you mean... Hidden how?

>>>> The i2c lines do not even touch TFP410 chip, so to be precise, the i=
2c
>>>> lines should not be TFP410's concern. The i2c lines come from the
>>>> monitor and go to OMAP's i2c pins. But TFP410 driver is a convenient=

>>>> place to manage them.
>>>
>>> fair enough... but who's actually using those i2c lines ? OMAP is the=

>>> I2C master, who's the slave ? It's something in the monitor, I assume=
=2E..
>>>
>>> IIUC, this I2C bus goes over the HDMI wire ?
>>
>> Yes, the i2c goes over HDMI wire. OMAP is the master, monitor is the
>> slave. You can see some more info from
>> http://en.wikipedia.org/wiki/Display_Data_Channel under DDC2 section.
>>
>> It is used to read the EDID
>> (http://en.wikipedia.org/wiki/Extended_display_identification_data)
>> information from the monitor, which tells things like supported video
>> timings etc.
>>
>> As for why the tfp410 driver handles the i2c... We don't have a better=

>> place. There's no driver for the monitor. Although in the future with
>=20
> than that's wrong :-) If TFP410 isn't really using I2C it shouldn't nee=
d
> the whole i2c_bus_num logic. I'm far from fully understanding dss
> architecture but it looks like what you want is a generic 'i2c-edid.c'
> which just reads the edid structure during probe and caches the values
> and exposes them via sysfs ?!? (perhaps you also need a kernel API to
> read those values... I don't know; but that's also doable).

Well, it's not that simple. TFP410 manages hot plug detection of the
HDMI cable (although not implemented currently), so the we'd need to
convey that information to the i2c-edid somehow. Which, of course, is
doable, but increases complexity.

Another thing is that even if in this case the i2c and EDID reading are
separate from the actual video path, that may not be the case for other
display solutions. We could have a DSI panel which reports its
resolution via DSI bus, or we could have an external DSI-to-HDMI chip,
which reads the EDID via i2c from the monitor, but reports them back to
the SoC via DSI bus.

So we need a generic way to get the resolution information, and it makes
sense to have this in the components of the video path, not in a
separate driver which is not part of the video path as such.

And while the above issues could perhaps be solved, all we do is read
one or two 128 byte datablocks from the i2c device. I'm not sure if the
extra complexity is worth it. At least it's not on the top of my todo
list as long as the current solution works =3D).

> If you have a generic i2c-edid.c simple driver, I guess X could be
> changes to read those values from sysfs and take actions based on those=
=2E

We handle the EDID inside the kernel, although I'm not sure if drm also
exposes the EDID to userspace.

> Looks like even drm_edid.c should change, btw.

Yes, DRM handles it in somewhat similar way.

 Tomi



--------------enig5728B4561905890BE168921E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpyOVAAoJEPo9qoy8lh71qscP/3AFbTZ0SFWJZuEnZ/jXQm1X
skMp2rYaZhPkM/HirKjh/eUkQqOtNIFYW7QWiFY2DDWnBN/cwnMKY6P9UvciRgGY
nCNPQ4byZ5v7fg0ASUIg83SvgWqp+W1hEggNnrv0TjVdBPqgjv/mpbFbzlwRiRvF
TywPUN70G4jE+GZlyyJ3MRtGPdAd5FQbEXtXxyKB+NhapznX8XxOWiSNYseKcahQ
akmdYN3JYzpC3cRpifadn9PdiMaEcsS6F2+vD8AfsQu8v2JQDB70BtBQiWEQ2XJ4
NMDPmxx2J92ReHz3U8sqeyXWWrAkJshlXS8nVnhcyVD3AHQU7lK+GaKDqhT70n80
sAnxIjTMEl1oWbumCzDa7GVqw1Mm327+sg0mOdQSg/VlIUm4T+SSTc2h+kchfoBO
5JceEoDVX8h2FGmhQh/UIAJJ0zbgCngvdkWoSk/5m9GiySdAesXG6D2Q0RhuzUMR
+fY91Vfg8H414jlzOICZMV6O57ypLToRBSCAdjblqvL8QT61rX0cY9SjOV/LHP3Y
3uMPmerTWWI2zpKfU6Uf79Kv7obqMZnMDpRAlr4CTsc3GpFoLgDyc/I2+p7QqjB3
kdsbB47W9kP1z3pI5kGgUGdoRo2517nRkTiD+43VjeZ9SPRvxU40dqo+YnP8Yl4C
yUsjdiB87scYJ09CPXKr
=y+Gd
-----END PGP SIGNATURE-----

--------------enig5728B4561905890BE168921E--
