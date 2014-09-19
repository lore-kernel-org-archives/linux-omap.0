From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/5] Beaglebone-Black HDMI audio
Date: Fri, 19 Sep 2014 16:24:20 +0300
Message-ID: <541C2E84.9060006@ti.com>
References: <cover.1410898073.git.jsarha@ti.com>
 <CAPM=9txRReSdcB5j+0dKmrDNM94zANu-q7ZfWHtP2iA54Dieig@mail.gmail.com>
 <54193D7E.5050900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7416446137520787534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <54193D7E.5050900@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Dave Airlie <airlied@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, Dave Airlie <airlied@linux.ie>, t-kristo@ti.com, dri-devel <dri-devel@lists.freedesktop.org>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com
List-Id: linux-omap@vger.kernel.org

--===============7416446137520787534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KNLpG4kqI9rFoA38eW3lleQRFXbSKJe9u"

--KNLpG4kqI9rFoA38eW3lleQRFXbSKJe9u
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/09/14 10:51, Jyri Sarha wrote:
> On 09/17/2014 04:06 AM, Dave Airlie wrote:
>> On 17 September 2014 06:40, Jyri Sarha <jsarha@ti.com> wrote:
>>> Changes since v2:
>>> - Change compatible property from "ti,gpio-clock" to
>>> "ti,gpio-gate-clock"
>>> - Some minor cleanups
>>>
>>> The code has a functional dependency to:
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg109264.html=

>>>
>>> Without the above patch the audio card does not probe.
>>>
>>> The code has been rebased on top of Linux 3.17-rc5. The patches
>>> bellow, the above dependency, and couple of commits to add BBB HDMI
>>> audio
>>> support to omap2plus_defconfig can be pulled from:
>>>
>>> https://github.com/jsarha/linux.git linux-master-bbb-hdmi-audio
>>
>> How do you intend to get this merge, sending patchsets like this witho=
ut
>> indication to maintainers on a merge strategy is kinda messy.
>>
>> I'm not sure how maintained tilcdc is.
>>
>=20
> Well, it is used but AFAIK the people who have been working with it the=

> most have left TI. I think eventually someone at TI needs to take it
> over, but I do not know anything about that.
>=20
> I was hoping that because the change to tilcdc is quite minimal it coul=
d
> go in via you. I am sure I could get a reviewed-by and tested-by from
> from Darren how has bit more experience with tilcdc and maybe from Tomi=

> too if that helps. (Adding Tomi to cc).
>=20
> The "drm/tilcdc: Add I2S HDMI audio config for tda998x"-patch itself
> just adds the audio configuration to pda998x pdata and fills the swap,
> and mirr parameters with default values (they are usually coming in har=
d
> coded at the beginning of tda998x_create()).

I think Dave's point was that the series touches three different
subsystems, and you didn't give any thoughts about how this could be merg=
ed.

Must this be merged in one piece, because xxx depends on yyy etc? Can
these all be merged separately, via respective trees? If in one piece,
you could ask acks from Mr x and Mr y, for the parts they maintain. Etc.
And of course, it'd be good to include all the maintainers (At least
Mike was missing).

I think the clock patch could be handled totally separate, as it's in no
way related to HDMI. The video and audio part may be handled together,
if they have dependencies.

 Tomi



--KNLpG4kqI9rFoA38eW3lleQRFXbSKJe9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHC6EAAoJEPo9qoy8lh71w0wP/Awe6N8ffxgzBGDjbDbWvLQo
59KNFIxG4iWXByVj7+4MTZkk1V/Ddcw80t4cQrSRN6dfuPDfEUQFRAOf5u9kW6ES
M5oR0wPd6hc7KPM/BSnVMQRJ0dVw1lmkh5Ul/Mtzu6PWWWkya9f1doB/KemFY0SW
ejrH6BxU62J/BUjikcKoBTpZ1pgNMkXuERG3+EDe04bdK+mYSML1W6++lAq2a1S5
tPH2VVcu6WIun2655vZSaBpHVJXSTMjjikpIB91rex2+s19zbqE8B2hNb4EP3uor
zqZpMswH51z6Bc8lkJN5gs8uaq78IhzyvasgPwMIldtNYccuuApYHoJCnfNcLGqs
vrhWaerfvvqU8yRz475XGwM0JFwvVPq5rapfofrgjgMM/EGqTzTJD4iQ0gF4FmSf
/sPkRPJEjPzK4kZURZVTHfArJoXTW2H6V0AtffDWnYAXLkxwDSDtlwQl+d/GdFsE
R99eIM3jcI7quR6eNDrT13WD/cR2u37hdZLNGe42LT2G9ZldtZEn6cEkAxwttVWN
hZTtAcNsbZHqshEdvgQfVWTf/6fwY+5CbHIic8DMEQ5YL8PXkRpiW/IzAy1jwJuZ
xk9S2UlK+dbGfTBnUNYE4sIPTdggPJymqwRpbJ6NdKNTTXdV3sejL8X6aaeZA9qH
MMQfOQMLkA5dEr6RMx3M
=HQjY
-----END PGP SIGNATURE-----

--KNLpG4kqI9rFoA38eW3lleQRFXbSKJe9u--

--===============7416446137520787534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7416446137520787534==--
