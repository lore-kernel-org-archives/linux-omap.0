From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Mon, 4 Jan 2016 13:37:20 +0200
Message-ID: <568A5970.2000201@ti.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VQjKfBFtWNrtiI5TkO637O6wjGXB8G92r"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201601011301.27415@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

--VQjKfBFtWNrtiI5TkO637O6wjGXB8G92r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/01/16 14:01, Pali Roh=C3=A1r wrote:
> Hi Tomi! Can you review this patch? It is waiting here for two years!
>=20
> On Thursday 26 December 2013 00:12:39 Ivaylo Dimitrov wrote:
>> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>>
>> On memory limited devices, CMA fails easily when asked to allocate
>> big chunks of memory like framebuffer memory needed for video
>> playback.
>>
>> Add boot parameter "omapfb_memsize" which allocates memory to be used
>> as dma coherent memory, so dma_alloc_attrs won't hit CMA allocator
>> when trying to allocate memory for the framebuffers

We probably need exactly the same for omapdrm, as omapfb is on the way
to being deprecated. And sounds to me that we probably need similar for
other devices which try to do large allocations (camera? video decoders?)=
=2E

So I really think this should be somehow be a general option for any devi=
ce.

I also wonder if CMA can be improved to not need anything like this? If
you just increase the CMA area, won't that increase the chances CMA will
work?

 Tomi


--VQjKfBFtWNrtiI5TkO637O6wjGXB8G92r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWillwAAoJEPo9qoy8lh71tDQP/3991MfScsZ6ysMLAb9fikKR
DRrpB1d2nVZD2N3DA21sz9UMKHy54UjfxajyfUXKVbAgplriWlWkk6aPvBsbEaXC
03T7DnlrT/J48/2ofCof9KMWDaUE+HOl8BgLvfRzpV5Bt97Awqcqih1WVReeKLOV
f+d32cmH4AhCcO9gCsKtiiLzhrQpMGp9b1s3C9aWHXzNWFceRNDzmmTcdZk0aCy6
XGPjzwaVr4I/GUZP2JtlaxOljSgkcBR5KLYuPxSlfZSjn4HMJF0eDdDdtkN3Rj0W
2p93dIpcirDU6xWkDg1OzdPtgAbs+UvzALXBAdQ076oJmTt0YuNoGgmXYBjY7mKL
N2x+ARwpb9gXM8h7U3P3A2Kc/4lxL0pq0trhtDHEabVx4Jqz4+oj39jRbEZ0x0Di
6/IbRjls82oZZFSkep/iog8SWm/h3J+laS1hJVSB4mFM1LbiNqV0iLTeLlaC7u89
XE7/QF6tqy5WsuMwvlQVu8Us8XTWwGtIN0PBkRxVawPQiQSemxQcBIojLiiVUrc7
MmTAcz+hIBQvVd3vW5rYqlXZ+3nbJxDelpMchYfpljRvOY+ofEuE8ThVJYa2pb4b
H37w/2rUG3i8J+J750H3rGuofT91v+eXUPrKkTmUJ6znVlylRb6wvdDnDwvJlmQ2
qN65J006Z1SXgqAtKGbH
=v9pd
-----END PGP SIGNATURE-----

--VQjKfBFtWNrtiI5TkO637O6wjGXB8G92r--
