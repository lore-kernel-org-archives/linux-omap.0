From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Wed, 18 Oct 2017 18:48:36 +0200
Message-ID: <308D4E97-E80F-406B-95DE-2AD4D4DBCF03@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com> <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com> <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd> <20171018122804.GA14376@amd> <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com> <20171018132204.GD4394@atomide.com> <20171018135656.GA26432@amd> <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com> <20171018161312.GA31392@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_9AB16BD4-472C-4FCB-9514-2919C83A946D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018161312.GA31392@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_9AB16BD4-472C-4FCB-9514-2919C83A946D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 18.10.2017 um 18:13 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> On Wed 2017-10-18 17:52:22, H. Nikolaus Schaller wrote:
>>=20
>>> Am 18.10.2017 um 15:56 schrieb Pavel Machek <pavel@ucw.cz>:
>>>=20
>>> On Wed 2017-10-18 06:22:04, Tony Lindgren wrote:
>>>> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
>>>>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>>>>>>=20
>>>>>> So I started something, it is at.
>>>>>>=20
>>>>>> https://github.com/pavelmachek/libbattery
>>>>>>=20
>>>>>> My battery on n900 is currently uncalibrated (and charging), =
still it
>>>>>> gets some kind of estimation:
>>>>>>=20
>>>>>> Battery -1 %
>>>>>> Seconds -1
>>>>>> State 1
>>>>>> Voltage 3.88 V
>>>>>> Battery 63 %
>>>>>>=20
>>>>>> Of course, there's a lot more work to be done.
>>>>>=20
>>>>> Nice start but not a solution to our problem.
>>>>>=20
>>>>> Our problem is that people simply expect that for example =
https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
>>>>> displays the battery percentage.
>>>>=20
>>>> I think we could make things compatible with various battery apps =
by
>>>> having libbattery write back the capacity percentage and time =
remaining
>>>> to the kernel driver via sysfs or a dev entry. Then the kernel =
interface
>>>> can just display the data to whatever apps.
>>>=20
>>> Hmm. This could be as simple as providing symlink from
>>> /sys/class/power/userland-battery to some place writable by
>>> userspace...
>>=20
>> Well, please implement arbitrary symlinks in /sysfs...
>=20
> Any reason why I'd like to do that?

I don't know if you like it or not.

But it appears to be a strict necessity to make your proposal of
"as simple as providing symlink from /sys/class/power/userland-battery
to some place writable by userspace" work.

So if a different solution to provide /sys/class/power/*-battery
is possible, it should probably be preferred and nobody will ask
you to do something you don't like.

BR,
Nikolaus


--Apple-Mail=_9AB16BD4-472C-4FCB-9514-2919C83A946D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZ54XmAAoJEIl79TGLgAm6CmsP/i7goWAdOomtlLiNqcA0mVK1
k4nf9b/CVzCLiVQjrapj2YWG/Do0KHGJf82STy+h4ufp9I4nG8Ol1tlzcSUrHEnz
ulT7r6D/eiFrtB42D9JFwMVaBjqT71WN9low+ptzUTpeSWauV0IrQWjL2DYtiV/W
EM7CliGyt2HikHxfthAQJnT6KdtHj5ntv5fquzC6a16bCs8PzGvZJlFxsex2oiG4
ujmllVDIZ5L4W6YncoN1IOegmOlQps+p3HCkInt5A0x/G4QupKDFuFIBL6G1qiJD
iSiwmHQtDScUCz0Tn4Yuil/ZkMG4KtiW8UGUZNjqVi4Hbyr12gzkzb8s7efz0b4D
mJfGgci4SDLsvSx75T/ckT7qVVI56hB4CTIrO8r2EAxCh+9nTnHSqLA6gSoWS5EC
HMi8Kgs9ytLfrAiHJtdIngr37qn5ABrPpE5kNbgm9+9H8MQBvKRZwlubHF1/WwFK
mRqMiso0/SLvY989oQ5dflVOQYstRRfgDkQy0bRArv2kVD5i2ne6AHjM/JTEFAyQ
TCbnG6LRUzU+OLYh9PM3HS+m8Ag+Fh0PTkjb64iqWlWKfa7pNdnfptHKwcHIJicH
PYpkJXgETdHJfk3+YqnVf4kfbCzrEDEDuD1GKP7iMjXIf9UC67O4T3bWPbkZU0Y8
wNa/+gmynRthSHpHY4F1
=szs9
-----END PGP SIGNATURE-----

--Apple-Mail=_9AB16BD4-472C-4FCB-9514-2919C83A946D--
