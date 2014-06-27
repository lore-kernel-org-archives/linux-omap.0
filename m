From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC
 DAI component driver implementation
Date: Fri, 27 Jun 2014 16:06:38 +0300
Message-ID: <53AD6C5E.10805@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
 <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
 <53AD5F65.2010107@ti.com> <53AD62FB.10402@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6771528958838021117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <53AD62FB.10402@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, jyri.sarha@iki.fi
List-Id: linux-omap@vger.kernel.org

--===============6771528958838021117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KxKoHj7hsPHPgd26dWt9JF3ASBTu067xk"

--KxKoHj7hsPHPgd26dWt9JF3ASBTu067xk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/06/14 15:26, Jyri Sarha wrote:
> On 06/27/2014 03:11 PM, Tomi Valkeinen wrote:
>> On 26/06/14 22:20, Jyri Sarha wrote:
> ...
>>> +static struct asoc_simple_card_info card_info =3D {
>>> +    .name =3D "HDMI",
>>> +    .card =3D "OMAPHDMI",
>>> +    .codec_dai.name =3D "hdmi-hifi",
>>> +};
>>
>> The above is not const. That, and the contents of the struct make me
>> wonder, what happens if we have two HDMI instances?
>>
>> I know the core driver doesn't work with multiple instances yet, but a=
s
>> I mentioned, it has to be done sooner or later. And on the core driver=

>> side it should be quite straightforward.
>>
>> I'd rather not introduce new restrictions for that goal.
>>
>=20
> Ok, I'll alloc that with devm_kzalloc().

Do the strings in the struct need to be unique? If so, you probably need
to append something to them based on the hdmi device instance.

 Tomi



--KxKoHj7hsPHPgd26dWt9JF3ASBTu067xk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrWxfAAoJEPo9qoy8lh712uIP/3P/+eDyb1vEOvrlypTMCv8X
LxBlDw+ujSjQf6+KleR8oM/l08ewyz2yQGyKquAJtN4cUVUuhD31tWZ7cMrIV0J7
OPfQd0uqcDaq8lpWxp9W06uGNP9VrjEAGU8RZMoABlxabBZrq6FkY6diCybyS0gP
xoKu/mF5TMJPWiCwDILIYlnoolclj3gSI4qR/u4mNRk+i7UqUIqw8VKBzbzSQrCb
QpgF5vIfDBg4v+enFc3RDkFqZ2mSr0TcrVzeYV3vvbbme78qWWQL9Kn6Kl8wCxg+
WQAyEaZOoITr4Rlh4gZ8ipTrdm01mkUht1PMX0OWPxiEMHoehqPKifXZJKyMOTce
D76eWqfjxVEg1Pl17+MokdUUUlIEnsHnMiOk7EFwI0CMAROQX45O0EMR6klkQ8Cm
e59+tAcyPd5quNqiNw4UbEDzEBMA8j6YbhCLSGG9iFA8g8lvmpqhJRwuZsOrYHK4
tPeqnxQcjMaJmRhO1KbQWCGEnlLRt6eTMmImT2xHoUA9dXaJcbQnfqXmgKm3OZFk
yc5NhrPp5wnthdAqRJn+8kXzbYLvlpNfuYv79bFacN5cPquhq1PBaDYZwV93hiXN
MYZ3f10S6d6wDaKUtm2GLG+yIjei8RQHBBQAeoZRLhVTCNPEDoBy0HT7j6EyvWv/
rJ7o78u0w48oi9l2mo77
=4e+G
-----END PGP SIGNATURE-----

--KxKoHj7hsPHPgd26dWt9JF3ASBTu067xk--

--===============6771528958838021117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6771528958838021117==--
