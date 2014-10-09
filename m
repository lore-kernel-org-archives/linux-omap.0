From: Valdis.Kletnieks@vt.edu
Subject: Re: cpuidle - minimum time for sleep
Date: Thu, 09 Oct 2014 15:01:43 -0400
Message-ID: <11792.1412881303@turing-police.cc.vt.edu>
References: <CAJ2oMhJXi-wxZJFcmm3LsTQOC35tAVKwr1PihUc0CmbnNtfPVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1412881303_2528P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: Your message of "Thu, 09 Oct 2014 21:28:23 +0300."
             <CAJ2oMhJXi-wxZJFcmm3LsTQOC35tAVKwr1PihUc0CmbnNtfPVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--==_Exmh_1412881303_2528P
Content-Type: text/plain; charset=us-ascii

On Thu, 09 Oct 2014 21:28:23 +0300, Ran Shalit said:

> Does anybody know what is the minimum expected time for sleep period
> with the cpuidle ?

Both processor dependent and sleep level dependent.  There's a certain
amount of latency induced by the hardware waking up.

Look at /sys/devices/system/cpu/cpu*/cpuidle/state*/latency

--==_Exmh_1412881303_2528P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVDbblgdmEQWDXROgAQJQrw/9Gf1ytV1qtQYLulg2riYyv3un2hhmgDzt
Tdf/j72Lfzue13I8THDRlGhey3wVyc3nb1z+OC/LsDXGffKYw1Qjydayl115O1tg
64tFE6RVDA+OM0rML67IrJqpjVZOcaqOra4VbxwnyRhWp6OGl2GgeNctsS2LvSd7
+gnFe5CgTc4Al/TvkEPnx+zg+TPUZb4lVyFLFyONuUAVorr5lqL22sFNsqvDGwif
qjn23FwVLK60FXfPu+8Cfbl364EtIe0UzeojW6VEyQ8IPTV/D6fhrbW3SOTP6RW3
AQFdOAKwl4xCQ0xTK6vjbJbWqcK0o/l/ZuAdFsaQ7wlglGXL1U0Jtbzqo09YVHbN
KoyRWAdrJX9lIbsroDoB50z27YkFeu3dGpgR5dMFQVleFME2Xy4TsgN/HCrS9j4/
QseUn2oTEl9uAduEEDnN3Suzx4fZw/HaTBUm7poME9Lo+vsjQhGnTGZWiN09RT4y
oNnEaqsjh4+Dld2B+72qseVb5efPnJAoNouv5xYEco3znCCtZnExPLxkBFs1PN4C
hH/RyWcWbHO+3QwggodloKVdn42j/AoD9dQ+2YR9L9shOlRCdVE8rfqymaHZp7DS
tDcZDSvspBws7WizdQkI3lxTslXrN8tAlPzHt3v78GaZIPnyGF46LlEEnLgLnXg5
l5afbLqOLuc=
=ojUa
-----END PGP SIGNATURE-----

--==_Exmh_1412881303_2528P--
