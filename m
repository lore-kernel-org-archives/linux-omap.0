From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: write-through caching support for omapfb
Date: Thu, 24 May 2012 10:43:37 +0300
Message-ID: <1337845417.2909.31.camel@deskari>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/+LJlvIHHM8hADtSsdI2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:44834 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752759Ab2EXHnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 03:43:43 -0400
Received: by lahj13 with SMTP id j13so5175915lah.25
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 00:43:40 -0700 (PDT)
In-Reply-To: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk


--=-/+LJlvIHHM8hADtSsdI2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-22 at 22:54 +0300, Siarhei Siamashka wrote:
> This is a very simple few-liner patchset, which allows to optionally
> enable write-through caching for OMAP DSS framebuffer. The problem with
> the current writecombine cacheability attribute is that it only speeds
> up writes. Uncached reads are slow, even though the use of NEON mitigates
> this problem a bit.
>=20
> Traditionally, xf86-video-fbdev DDX is using shadow framebuffer in the
> system memory. Which contains a copy of the framebuffer data for the
> purpose of providing fast read access to it when needed. Framebuffer
> read access is required not so often, but it still gets used for
> scrolling and moving windows around in Xorg server. And the users
> perceive their linux desktop as rather sluggish when these operations
> are not fast enough.
>=20
> In the case of ARM hardware, framebuffer is typically physically
> located in the main memory. And the processors still support
> write-through cacheability attribute. According to ARM ARM, the writes
> done to write-through cached memory inside the level of cache are
> visible to all observers outside the level of cache without the need
> of explicit cache maintenance (same rule as for non-cached memory).
> So write-through cache is a perfect choice when only CPU is allowed
> to modify the data in the framebuffer and everyone else (screen
> refresh DMA) is only reading it. That is, assuming that write-through
> cached memory provides good performance and there are no quirks.
> As the framebuffer reads become fast, the need for shadow framebuffer
> disappears.

I ran my own fb perf test on omap3 overo board ("perf" test in
https://gitorious.org/linux-omap-dss2/omapfb-tests) :

vram_cache=3Dn:

sequential_horiz_singlepixel_read: 25198080 pix, 4955475 us, 5084897 pix/s
sequential_horiz_singlepixel_write: 434634240 pix, 4081146 us, 106498086 pi=
x/s
sequential_vert_singlepixel_read: 20106240 pix, 4970611 us, 4045023 pix/s
sequential_vert_singlepixel_write: 98572800 pix, 4985748 us, 19770915 pix/s
sequential_line_read: 40734720 pix, 4977906 us, 8183103 pix/s
sequential_line_write: 1058580480 pix, 5024628 us, 210678378 pix/s
nonsequential_singlepixel_write: 17625600 pix, 4992828 us, 3530183 pix/s
nonsequential_singlepixel_read: 9661440 pix, 4952973 us, 1950634 pix/s

vram_cache=3Dy:

sequential_horiz_singlepixel_read: 270389760 pix, 4994154 us, 54141253 pix/=
s
sequential_horiz_singlepixel_write: 473149440 pix, 3932801 us, 120308512 pi=
x/s
sequential_vert_singlepixel_read: 18147840 pix, 4976226 us, 3646908 pix/s
sequential_vert_singlepixel_write: 100661760 pix, 4993164 us, 20159914 pix/=
s
sequential_line_read: 285143040 pix, 4917267 us, 57988114 pix/s
sequential_line_write: 876710400 pix, 5012146 us, 174917171 pix/s
nonsequential_singlepixel_write: 17625600 pix, 4977967 us, 3540722 pix/s
nonsequential_singlepixel_read: 9661440 pix, 4944885 us, 1953825 pix/s

These also show quite a bit of improvement in some read cases.
Interestingly some of the write cases are also faster.

Reading pixels vertically is slower with vram_cache. I guess this is
because the cache causes some overhead, and we always miss the cache so
the caching is just wasted time.

I would've also presumed the difference in sequential_line_write would
be bigger. write-through is effectively no-cache for writes, right?

If the user of the fb just writes to the fb and vram_cache=3Dy, it means
that the cache is filled with pixel data that is never used, thus
lowering the performance of all other programs?

I have to say I don't know much of the cpu caches, but the read speed
improvements are very big, so I think this is definitely interesting
patch. So if you get the first patch accepted I see no problem with
adding this to omapfb as an optional feature.

However, "vram_cache" is not a very good name for the option.
"vram_writethrough", or something?

Did you test this with VRFB (omap3) or TILER (omap4)? I wonder how those
are affected.

 Tomi


--=-/+LJlvIHHM8hADtSsdI2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPveapAAoJEPo9qoy8lh71DAYP/03qhKDOOdv91m8/WhUzow6c
+QUSQp2iewYQ3jXwW8AdmJ9UMJzM4BCrWgZm51Ua6jFrG/6pzJiFl/948JB05IEW
1BZHmEXwDi2gX2p++D4rrn0rcPM1raxrSPLrX1K0pnSBlziZgvMW+IExN5f/6Hc4
1sYeBS2zECItBB/vUa34yTn9BPodhleVjcgd2jG5c6Y9+179Aypoh5JqOWiEubwI
YL0u4EcUZkiwNoFYhRTTfIm8UOOiilJYLG8rwk8klCyAsEwNaxJw7hjx/QWGmpHO
RpiIhEH6eF6xmi3pVo8qpdVJI9S4Yyi1Zmgl6sfvIlZnAecke22ek7DmHggj5agh
fYhWG9ugINYU0qvKRO1bIRyTjSHp5WypDUaD4t+ylYphGzUbN+79KsXEhe/9fQga
6SvR08wM2hSSoIqCu80k+4G0vd1rO69F0Td8hXqyp+Ga1FMI4t2Srf12V9vmUhCl
I7VbAwKbS+bSPztnfoy908sNdx0rkuzTk0eWX4sdNxkDe1RM8qDsD5MDs/t7QinH
8PdPtiU58DvngAplBwpDrtNnBETl0MX+dkAxuu0eNlL2vbXd643tOurQ7OgB8hOv
LRPmJn0sADDNbYyz/Jt7MO/LllChe9evJs6JUzf5tZ49y/tpDDwwdbroJ0Zd87kQ
RuaNyI3OPoR617nJAlRd
=YM7u
-----END PGP SIGNATURE-----

--=-/+LJlvIHHM8hADtSsdI2--

