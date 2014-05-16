From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS and HDMI kernel panic on OMAP4
Date: Fri, 16 May 2014 08:24:08 +0300
Message-ID: <5375A0F8.9000208@ti.com>
References: <CAGhQ9VyEsX2FmJj4TWgrKMggz=zH--rrVKaztV6AWwLQZTsDUg@mail.gmail.com> <CAGhQ9VxU1Zk0Prdq-PwkM=e8W6pZ=JXFa__xjCx4ofCVyWJ0kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qjWUgF2IfV9X7mcwG5tQITtPM034VTVwR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37961 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbaEPFYO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 01:24:14 -0400
In-Reply-To: <CAGhQ9VxU1Zk0Prdq-PwkM=e8W6pZ=JXFa__xjCx4ofCVyWJ0kw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org

--qjWUgF2IfV9X7mcwG5tQITtPM034VTVwR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/05/14 00:26, Joachim Eastwood wrote:
> On 15 May 2014 23:14, Joachim  Eastwood <manabian@gmail.com> wrote:
>> Hello Tomi,
>>
>> I wanted to test my Variscite patches after Tony merged them into his
>> 3.16 dt branch so created a base branch from Linus master and pull in
>> Tony's 3.16 dt and your dss for-next branch.
>>
>> I discovered that booting with a HDMI monitor connected or plugging in=

>> one cause a kernel panic. See the log at:
>> http://slexy.org/raw/s20xo68UPx
>>
>> Any idea what it could be?
>>
>> I also noted this in the boot log:
>> [ 0.984527] omapdss_hdmi 58006000.encoder: can't request region for
>> resource [mem 0x58006400-0x580073ff]
>>
>> I don't think I have seen this before.
>>
>> What I previously have tested have been Linus master + my Variscite
>> patches and your panel-dpi dt + hdmi hpd patches cherry-picked.
>=20
> Reverting "OMAPDSS: HDMI: cleanup ioremaps" 59b3d38a3691396783df108
> from your for-next branch fixes the problem.

I think that's somehow HDMI audio enabled. I bet if you disable HDMI
audio, the error goes away.

If I cat /proc/iomem, I see:

58006000-58006fff : omap-hdmi-audio-dai
  58006200-580062ff : pll
  58006300-580063ff : phy

Without sound support, I don't get the error and I see:

58006200-580062ff : pll
58006300-580063ff : phy
58006400-580073ff : core

Reverting 59b3d38a3691396783df108e6afbba30656edccb helps, because before
that patch the hdmi driver didn't actually reserve the regions.

So, I don't really have any idea yet what's going on there, but the
problem is somewhere around hdmi audio.

 Tomi



--qjWUgF2IfV9X7mcwG5tQITtPM034VTVwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdaD7AAoJEPo9qoy8lh71jLEQAJuEtfwxy8tdBnaO0VehFmhk
RXoYtVj1R/bf+FQycXX4qD3eu3163meGcylEThG3FMg3MSe/5MVH1LTtWYCr1L8x
WJOovaYU/nySaf5NgpOrxbkz0SHfncuKnpzDBqSpBJmTrwbaV/jV/9nEgkR+4zvN
haeUqoKG1ArjGJFur9rKGANOlknGC8iMb1igHprU+85499SUQhKGOFBxkqzI53Yv
33wfZKjttCA8Qy3udCA8hirr3vrOQnchZJeRo33nqGOFSv66BDB93S/lw3OYUXkf
d2BvcmJ8x7CsHCKhQPgQCdtSY2ZqRMH+nvqyBh39aKG0QHOAjgE6S4LLy3r3DvJq
m/DbZY15GSrLC+KD5gCHDNRs74Rtjqu+WtRKGdtXsQ+keOFZq2v2tYKV6rGe+EQM
e3XZr5F6fpJDB1LuRfZ51oPsCzwPiH62lbjO7TdHPk3nXmONOyrG610eOoMeiN7r
t7EpG6y1UcTMLnanUE4R6BAPKYtie1j5hwJ/6yE6wiEwb9EbgS0ht2ITRxvqKQgk
Uh1ZqFR8e/eJ7MVH89mUzAdOIVrxBRPJYtkNoXCBsoml3kv5E74A4GFlYe/QKsg0
eFvOZHkAHh2/nAUVmbQcAd6GWtGNlvTQAEd0wHk7RNZzdoPXJpfFlWUrqGP7fiFa
x468YIEntLVNKgwzLQfI
=t8ex
-----END PGP SIGNATURE-----

--qjWUgF2IfV9X7mcwG5tQITtPM034VTVwR--
