From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Tue, 23 Oct 2012 19:17:55 +0300
Message-ID: <5086C333.9000801@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA7BD79107FE290EF1069D5C8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57293 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932946Ab2JWQR5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 12:17:57 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NGHvlm026671
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 11:17:57 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NGHv8V012727
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 11:17:57 -0500
In-Reply-To: <5086BB01.1080802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enigA7BD79107FE290EF1069D5C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-23 18:42, Ricardo Neri wrote:

>> What registers does the audio side need to access?
>=20
> It only needs access to the DMA audio data port. All other operations
> that the audio driver needs are done through the omapdss audio interfac=
e.

Hmm, so the audio side only needs the address of one register, for the
audio data, and this address is given to sDMA? You have
OMAP_HDMI_AUDIO_DMA_PORT in the audio code, is it the HDMI_WP_AUDIO_DATA
register?

If so, you could pass only that one address, instead of the whole HDMI
register space?

My point here is that we should make it very clear what the audio side
can access. If we pass the whole HDMI register space, we should, in
theory, be prepared to cope with the audio driver changing any register
there. But if we pass only one register (or certain small ranges), we
know the rest of the registers are safe.

>> Why are part of the
>> registers accessed via the hdmi driver API, and some directly? I imagi=
ne
>> it'd be better to do either one of those, but not both.
>=20
> This is because in the current omapdss audio interface we have no
> functionality to handle the DMA transfers for audio. Do you think it
> would be good to explore implementing support for that? At this point i=
t
> is not clear for me how to do it without duplicating the functionality
> that ASoC provides for that.

No, if the common ASoC code provides functionality for this, we should
at least try to use it.

I was looking at the ti_hdmi_4xxx_ip.h, searching for audio related
registers by searching "AUD" string. I don't know if it makes any sense
(you're better to have a say on that), but I think we could pass some of
the audio registers ranges to the audio driver for use.

For example, the HDMI_WP_AUDIO_* registers are together, we could give
those to the audio driver if it makes sense. HDMI_CORE_AV_AUD* registers
are a bit scattered, but... I guess it wouldn't be difficult to pass
those also, there's still only a couple separate ranges.

But I also have no problem with having the hdmi audio API in the hdmi
video driver, as we do now. And I think we in any case need a few
functions, even if we would give the audio driver access to the AUD
registers.

 Tomi



--------------enigA7BD79107FE290EF1069D5C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhsMzAAoJEPo9qoy8lh71lxoP/2SXUj7iKBm16F5ecNqE7chD
qgoBuxLrTsBp2k/WNsQov8d8qGs8b6ODBcTm/ze17m8yhKmtYaa2t9FM2ZfdWAV7
la0dIwXYia/vGNAjU0rf2Chs0s7VWpHcEExbnz5FzmK+p2zho1uC1W61TVWlXY4i
ZWPzxl/q99fgZRGxuA5ZfeUOIwRVp/41LW1s3GBZ3FRGtL6oCLie2NofRgxUtUHs
I9uw9dp80c293P6QSk9y0RLBUaL75IyOfO1E+fgnoCOMR07cck4Lu44XyiXKAk5T
pBiZJKEs4JjjvaoS6+JSBLjw1n8h2iIWSIpqrfzwyNOKMrAldh9iHDRb+UKhAIZ2
WpnJjJJfcEpCXS1Xn9UnKgbAy0osABqEt1m0KuerhFK1LT177/1cw4HEUqj0ByLQ
8dQULSkorC39qIFuKfY0oGpS7WUUrhjDhOZuSlDYQ0XkzZiMSKy38PpuJ43SU6Zw
jwwF/2hN7aNfKWgmW62vAAaswuifzhPlXbtj/7rsWO62Pyc7gYbgQHamY5HFNIEO
YEW46wtnanPdKApd5Qj/3R5GZeAQ7flcVwwrjsH9ts2w6YNRtikvj+lmzPWG6CX0
YT5ySvYdRWDwhGrZoe6kvqTWITW85pgXvTiIYtv69r2ZxdsgQeydRHp14kIJaA44
rbmlI0yGpIkCp4EVb0/P
=4Yc6
-----END PGP SIGNATURE-----

--------------enigA7BD79107FE290EF1069D5C8--
