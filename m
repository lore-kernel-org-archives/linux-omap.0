From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Wed, 18 Oct 2017 17:52:22 +0200
Message-ID: <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com> <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com> <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd> <20171018122804.GA14376@amd> <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com> <20171018132204.GD4394@atomide.com> <20171018135656.GA26432@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A4B5DA5C-8477-4FCE-A557-7FADC67EBDF8"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20171018135656.GA26432@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_A4B5DA5C-8477-4FCE-A557-7FADC67EBDF8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 18.10.2017 um 15:56 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> On Wed 2017-10-18 06:22:04, Tony Lindgren wrote:
>> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
>>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>>>>=20
>>>> So I started something, it is at.
>>>>=20
>>>> https://github.com/pavelmachek/libbattery
>>>>=20
>>>> My battery on n900 is currently uncalibrated (and charging), still =
it
>>>> gets some kind of estimation:
>>>>=20
>>>> Battery -1 %
>>>> Seconds -1
>>>> State 1
>>>> Voltage 3.88 V
>>>> Battery 63 %
>>>>=20
>>>> Of course, there's a lot more work to be done.
>>>=20
>>> Nice start but not a solution to our problem.
>>>=20
>>> Our problem is that people simply expect that for example =
https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
>>> displays the battery percentage.
>>=20
>> I think we could make things compatible with various battery apps by
>> having libbattery write back the capacity percentage and time =
remaining
>> to the kernel driver via sysfs or a dev entry. Then the kernel =
interface
>> can just display the data to whatever apps.
>=20
> Hmm. This could be as simple as providing symlink from
> /sys/class/power/userland-battery to some place writable by
> userspace...

Well, please implement arbitrary symlinks in /sysfs...

root@letux:~# ln -sf /tmp/somewhere /sys/class/power_supply/fake-battery
ln: failed to create symbolic link =
'/sys/class/power_supply/fake-battery': Operation not permitted
root@letux:~#

And you need to run a daemon so that the data is available
somewhere.

BR and thanks,
Nikolaus


--Apple-Mail=_A4B5DA5C-8477-4FCE-A557-7FADC67EBDF8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZ53i3AAoJEIl79TGLgAm660EP/RB88iFzYYzdzPb93p+ArOIH
hQo4jaHu7+buSW8GwMoxkvgRjnpV4snSMB3RrQqTTrRXsIgzG5TWYNdsJUu9yBMu
/CdaAGmg52mUhkUW+CF4ARAuxHgVUCIC8ogNvfbNff5TRr/eOW3ePQDLqNYOfQx+
DjGLXZGllThRpTVCfIakkGW1ub+Nq++CVmOix1xDbPaT6hr4LvYhvndJ8/HkYL4Q
g7F4Gt5pwUTWlcUJp+CQdkSR0KqLjPKueLap1SnRkyUhWQBHsZP6yphp3L+lUJ3/
IN6o6W0AdfyqyRNYlQLYLb8e/x0h1EkYq/BPyt3SRlVyWAnLX0D/Xyy6WF3A+WUw
rs30CKklz3jDaifihCn1PepVcXANx1ZKzcJeCemLncDn4D825xERZqZyLsSM+Vob
6wtMU7Fde1nqx+jp3iHAehsG68UTHpgEUjMD7LhR+OciEzrRaSxOEvqXQKT8RVQE
xwTOY6z9xy59ikvcuymOFu57bOAv9NJiky/+7Vfi7giDbrhZ2wcku9pbxglqLsUA
uHhqKzAPVBbCY280/Af/7Th3FzQV46PSjN9sg4dIHhY585KMTerhpHEYk2LbBo5W
HRHuWzGFH3NRb6TaMm2TdS7u7B2b+xiejo76ET1crjtkUFU+1UKI6wl93QVqeqx2
520zcolW4LPsnuLdK/zy
=C7eu
-----END PGP SIGNATURE-----

--Apple-Mail=_A4B5DA5C-8477-4FCE-A557-7FADC67EBDF8--
