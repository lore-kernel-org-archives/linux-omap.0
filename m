From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Converting OMAP's custom vram allocator
Date: Wed, 05 Sep 2012 13:08:53 +0300
Message-ID: <1346839733.32747.1.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pbJJBUmOfMjCkZGl0hTm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:53993 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab2IEKI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 06:08:58 -0400
Received: by lagy9 with SMTP id y9so189849lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 03:08:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>


--=-pbJJBUmOfMjCkZGl0hTm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

OMAP has a custom video ram allocator, which I'd like to remove and use
the standard dma allocation functions.

There are two problems for which I'd like to hear suggestions or
comments:

First one is that the dma_alloc_* functions map the allocated memory for
cpu use. In many cases with OMAP DSS (display subsystem) this is not
needed: the memory may be written only by the SGX or the DSP, and it's
only read by the DSS, so it's never touched by the CPU.

This is even more true when using VRFB on omap3 (and probably TILER on
omap4) for rotation, as VRFB hides the actual memory and offers rotated
views. In this case the backend memory is never accessed by anyone else
than VRFB.

Is there a way to allocate the memory without creating a mapping? While
it won't break anything as such, the allocated areas can be quite large
thus causing large areas of the kernel's memory space to be needlessly
reserved.

The second case is passing a framebuffer address from the bootloader to
the kernel. Often with mobile devices the bootloader will initialize the
display hardware, showing a company logo or such. To keep the image on
the screen when kernel starts we need to reserve the same physical
memory area early at boot, and use that for the framebuffer.

I'm not sure if there's any actual problem with this one, presuming
there is a solution for the first case. Somehow the memory is reserved
at early boot time, and this is passed to the fb driver. But can the
memory be managed the same way as in normal case (for example freeing
it), or does it need to be handled as a special case?

 Tomi


--=-pbJJBUmOfMjCkZGl0hTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQRyS1AAoJEPo9qoy8lh71/9QP/2UsiC8tlAzrl3d9eeMOFRQg
e8Kx7Y8nJwKSBH5eLJFOTCxZLlXhiTZb8MQh58vF9hTii55met9xLgwQl/ZkX5Qi
8iYuQciTFTpcSqsiDBeIPhPOSe7B43eGztx3j5GvFozxHLTRuzV0tD0StTkJ1K7s
RU2Dqf1jtYXjTNd+cUUDdMSZalydK8A8hD3EFHmYK0ILjjPlATLp2jjYLE7mu+qL
xorStah73tkIHwsP5gAlQUSrl8oMQOAgIVNCZboi0+6cNLX8qtGsWUn+PFL5G7wq
ypAzYfgmparWgsoqRNVakc+BxUVAluf2JseoHhV7oA9MkRaScxIvabSAvFYCNQ2H
2vvr8vCcsZoZUIftfgI+Ri5TV1PsWJtO9ryQ63HH4HSHBfbjQFzK9L1roTzYWxjM
1tIDvTvYP8twSLZWaMsLVCTIU5kvjIxPCWNpqS4a+reTD+pgyKpu3YCffFRxWlUp
BVtZOq75m3oKYs7rV7MlzvKVVPA8BzMjOAXi/fIqTBe+hp3VH0Coy1FHuSlGSOfc
T1ZQLqv91Gz9tStxHa95p344gY7Ndw61IjVcqTOt4Ggv76NN1QVY71kU/0wwyeAG
7HKWuIYRFaUd1j47LHJ6GZypldAtQC8zyVMnXuPT2eaH0Yqpk32Qdgx7dsQ9rIiD
L5t6hR78/bNhzCHJW0C3
=pbGM
-----END PGP SIGNATURE-----

--=-pbJJBUmOfMjCkZGl0hTm--

