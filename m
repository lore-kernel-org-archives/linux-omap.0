From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Wed, 8 Jan 2014 16:13:39 +0200
Message-ID: <52CD5D13.9090806@ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com> <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com> <20140107235951.GH5074@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="G2pQxN3Uxuf0OcpLHQ5CufK7xDkKS8O5l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54931 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756593AbaAHOON (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jan 2014 09:14:13 -0500
In-Reply-To: <20140107235951.GH5074@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

--G2pQxN3Uxuf0OcpLHQ5CufK7xDkKS8O5l
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-08 01:59, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131230 05:21]:
>> The omapfb driver uses dma_alloc to reserve memory for the framebuffer=
s.
>> However, on some use cases, even when CMA is in use, it's quite probab=
le
>> that omapfb fails to allocate the fb, either due to not enough free dm=
a
>> memory, fragmented dma memory, or CMA failing to make enough contiguou=
s
>> space.
>>
>> This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
>> used to give the size of a memory area reserved exclusively for omapfb=
,
>> and optionally a physical address where the memory area is reserved.
>>
>> The memory area is reserved with memblock, and assigned to omapfb with=

>> dma_declare_coherent_memory. The dma_alloc function will first try to
>> allocate the fb from the coherent memory area, and if that fails, it'l=
l
>> use the normal method of allocation.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Ivaylo Dimitrov <freemangordon@abv.bg>
>=20
> Feel free to queue this along with the DSS patches:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

This introduces new kernel boot parameter, and I haven't really had time
to test and think about this. If Ivaylo doesn't insist on this to be
merged for 3.14, I'd rather leave this for 3.15 as adding new parameter
that we need to support "forever" should be thought a bit more.

 Tomi



--G2pQxN3Uxuf0OcpLHQ5CufK7xDkKS8O5l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzV0UAAoJEPo9qoy8lh71KXcP/0PmuisX0VgIsz8zsqsijP7o
DIphZXyyivZ6x0nf4LK+sglp4H+kE9YTXDby72l+sU0yoSW1qCGLiSqbUa7EK34a
CagKy3apRrug2BJUvfQQQ7mHp1IK1YDu7FCeosNsm0JbQcfdTvaNm7EqoG1FitH8
wCyI+b3+UlKm3bzfBcsBn4kirxeU8Z0xYB4GxcHfJORsvQwYH7ifOPIzPUuBI35V
XTt4Ob7J8Vvk9c7/igzn5SAjsrqX41F/09ZurMGFfsJa5LHlJPNQdmTxUzVhCPvn
h8cjryS3AhF36u/vYBdZeK2xs9rsQOWth2p2sFbdfphW8XI5rOqjfZNr/Ew1V3B5
NwdfUhq9O0Fi1DyP1V/ruyQd3oj7hen1aetmkeWaotvzLNoFQIpOzMHSXh06VLPN
cP7TxNCIVD3q1aI80aHXFtHF6tUrkfNdmY/rckijFaQkj1ZgFgKmFWmUEJysGcnx
wbN9tmRVFUyW7DVbZz401XRJbxXAXI3Kwj7/6wI6pwMCmgBb26J7QeF68CQySM22
INHBRCg2vcSl/A8cHhW+CDwmK/DiQ1pgL6553EZJ5vpZqdaGqGRbLc65q3QxxgRi
g9BeKX9TlASugGqxpM3ziRzWA16noqEBculDNkDWJFYxKamZp0cDT3ELMJc3MBO7
7LOxpzwO4jjEPyJY5Koy
=odw/
-----END PGP SIGNATURE-----

--G2pQxN3Uxuf0OcpLHQ5CufK7xDkKS8O5l--
