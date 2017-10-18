From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Wed, 18 Oct 2017 14:48:04 +0200
Message-ID: <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============7034608160724446857=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171018122804.GA14376@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, Marek Belisko <marek.belisko@open-nandra.com>, khilman@kernel.org, tony@atomide.com, Marek Belisko <marek.belisko@gmail.com>, linux-pm@vger.kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, robh+dt@kernel.org, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============7034608160724446857==
Content-Type: multipart/signed; boundary="Apple-Mail=_1CB45714-597B-4906-9C37-C989356D3E1C"; protocol="application/pgp-signature"; micalg=pgp-sha256


--Apple-Mail=_1CB45714-597B-4906-9C37-C989356D3E1C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> Hi!
>=20
>>> Without patch description: See Last Question in
>>>=20
>>> Documentation/power/power_supply_class.txt
>>=20
>> ...should be done in libbattery, yet to be written. :-).
>>=20
>> Do you have specific guidance what you'd like to see in libbattery?

IMHO there was no answer from maintainers. Or I have not received it.

>=20
> So I started something, it is at.
>=20
> https://github.com/pavelmachek/libbattery
>=20
> My battery on n900 is currently uncalibrated (and charging), still it
> gets some kind of estimation:
>=20
> Battery -1 %
> Seconds -1
> State 1
> Voltage 3.88 V
> Battery 63 %
>=20
> Of course, there's a lot more work to be done.

Nice start but not a solution to our problem.

Our problem is that people simply expect that for example =
https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
displays the battery percentage.

With using generic-adc-battery driver and Marek's patch in kernel, this =
can easily be provided.

With exactly 0 bits of change in user space. Please note that you can't =
always tell users "upgrade to the latest user space".

So I have three questions:
a) why do you use float/double instead of fixed point for such simple =
and imprecise calculations?
b) what does it provide as additional information over some lines of =
code in generic-adc-battery driver?
c) how do yo make sure that this libbattery is included in all the =
battery monitors that are already in use and
is backported for example to the old plugin I mentioned above?

BR and thanks,
Nikolaus



--Apple-Mail=_1CB45714-597B-4906-9C37-C989356D3E1C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZ502FAAoJEIl79TGLgAm6jnUQAKOKbQeeuqZTcg+uq9LZhivH
hp1HIn6ZSk/2e7BGErKXqxceEx8bzbnVS4U+DQxIjINqiVKAFiRRWlAFmndnYWlJ
qcCeGE71GgzObJTJq047UGbB1Kbf5K1QgfevpIJV2ht9fjHMhVDZsjBqWjcCkJP5
klRKsfLI3sXcRXhsLvDl7skI0GsThRazCfh0wBj6jvRqK2SIFdqyKt3HAgzxpwAz
1BlQElo80dFheiNZi4d8Eik9uj7XEdPJfg69tbT461QJglMMcemqpT8xcKoLUdnP
013mejIHhuOh+wJuXCC/uKxgTMZRg3KqS36tHDWJJANEb6kVMoGcODyLkdUj3c8s
re2deK+RjU3bZLB9IbLtU+2hgTBWzWB9g253ATo+kwdCc0xfUE1VKHKm7YRM5lJG
fFu9ez5etp7kNapnEDjCeN6d7VLka/S/2GuwB5iQdjIswOr9U2jramhQqrPNaerz
VFLZMVrdt6ydTnKwICqHh22ebV8xYso0zeqSkgqbxeQeyFTaf24RzNOjHXoLH7Tl
fWmMmnWOAM6/yogL7TmbDK57b1UvFZXbmoKWYbDoG1NDveAn0TrRA+ZXgMddp6/q
A63xD3XHzu2vYsJn8Ienq/oqIEKWYWdWWco+4UimzTxZZAMLJJs9CJdtFj4wg0aq
k0RgShwMfQhF3VH4A/oH
=RqPb
-----END PGP SIGNATURE-----

--Apple-Mail=_1CB45714-597B-4906-9C37-C989356D3E1C--


--===============7034608160724446857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7034608160724446857==--
