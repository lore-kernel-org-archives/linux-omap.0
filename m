From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS cmdline resolution not working for HDMI?
Date: Tue, 09 Oct 2012 16:06:50 +0300
Message-ID: <1349788010.2409.38.camel@deskari>
References: <20121004175604.GE3874@atomide.com>
	 <1349435094.2401.17.camel@deskari> <20121005164308.GM3874@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-It76c9iLLx/ImG4+b9nG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:35315 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320Ab2JING6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 09:06:58 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3008986lag.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 06:06:53 -0700 (PDT)
In-Reply-To: <20121005164308.GM3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-It76c9iLLx/ImG4+b9nG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-10-05 at 09:43 -0700, Tony Lindgren wrote:

> Looks like somehow also output_size won't change when changing
> display output from DVI to HDMI.
>=20
> If I boot with DVI panel at 1600x1200, then try to switch to the
> HDMI monitor with the following script:
>=20
> #!/bin/sh
>=20
> export dvi=3Ddisplay0
> export hdmi=3Ddisplay1
> export overlay=3Doverlay0
>=20
> echo 0 > /sys/devices/platform/omapdss/$dvi/enabled
> echo 1 > /sys/devices/platform/omapdss/$hdmi/enabled
> echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/$=
hdmi/timings
> echo 0 > /sys/devices/platform/omapdss/$overlay/enabled
> echo tv > /sys/devices/platform/omapdss/$overlay/manager
> #echo "1366,768" > /sys/devices/platform/omapdss/$overlay/output_size
> echo 1 > /sys/devices/platform/omapdss/$overlay/enabled
> cat /sys/devices/platform/omapdss/$hdmi/timings
> cat /sys/devices/platform/omapdss/$overlay/output_size
>=20
> I get the following which may provide more clues:
>=20
> [64370.820312] omapdss DISPC error: SYNC_LOST on channel tv, restarting t=
he output with video overlays dd
> [64370.831024] omapdss OVERLAY error: overlay 0 horizontally not inside t=
he display area (0 + 1600 >=3D 13)
> [64370.840972] omapdss APPLY error: failed to enable manager 1: check_set=
tings failed
> [64370.849670] omapdss HDMI error: failed to power on device
> [64370.855407] omapdss error: failed to power on
> [64370.862487] omapdss OVERLAY error: overlay 0 horizontally not inside t=
he display area (0 + 1600 >=3D 13)
> [64370.872436] omapdss APPLY error: failed to enable manager 1: check_set=
tings failed
> [64370.880798] omapdss HDMI error: failed to power on device
> [64370.886505] omapdss error: failed to power on
> 85500,1366/70/213/143,768/3/24/3
> 1600,1200

Well, it's not that simple =3D). There are three things to consider:

- Framebuffer in the sdram. It has xres and yres parameters.
- Overlay, and it's input size (from fb) and output sizes (must fit into
the display).
- Display, which has certain size depending on video mode.

Only VID overlays can have different input and output sizes, GFX overlay
does not support scaling.

In the script above you don't change the fb at all. You can do that with
when the overlay is disabled, for example:

fbset -xres 1366 -vxres 1366 -yres 768 -vyres 768

But that only works if there's enough memory allocated for the
framebuffer, but that is the case for you if the fb was bigger
initially. Otherwise you need to set the new size
with /sys/class/graphics/fb0/size before resizing the fb.

And, of course, the framebuffer cannot be in use at that time by, for
example, X.

Yes, it's complex! I hope omapdrm will make all things simple, and we
can forget omapfb. In hindsight, I should've designed omapfb to be much
simpler, and only use gfx overlay. Making it support all overlays is a
never ending source for problems and complexity.

> FYI, I'm also seeing the DVI monitor blank out on it's own for
> about a second or so on regular basis every 10 minutes or so.
> No idea what's causing that, maybe it's a reminder to take
> a short break :)

Well that's something different. I've recently done some testing with
using DSI PLL for generating pixel clock, and I've seen unstabilities
with that. But perhaps there's something else wrong also, even when
using the PRCM for pix clock as in your case.

Does your monitor ever report something like bad signal or such?

 Tomi


--=-It76c9iLLx/ImG4+b9nG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQdCFqAAoJEPo9qoy8lh71i7sP/jhwbEbMnwl9b9359nj+3hTd
yScTUEEx7REsFFI/8s/RrvyT/fqHE4om8u3riyJEZCjZQfDmmEFh7PUU6cg0BhA+
B4hFulxlI4D1U1n+REvMyMjRd71EO7qbB8c2RHpVJmP/rm/7WBhOH4qLZgV//Aj+
DnkXpgcT0ssKWm3kUX3N4TaXy6uPm+qyMRMH4pW0wTu96UDzaoK4ctoMRU2YpSr0
Mk8Hgg+Xfoi24ELw5t1Pnj7mUiGyt8TxPvluyw4PYZqsjzZrJxzVXMYmmH61hzGy
yUk3pNXFwvysBTDjmvYSwhRP+DTBDoi1MH/ynlR8oUsMoNB4XOhRVhqFcJOpGns4
DtDX58EvT0cAVzfj/NSF7G88BNi4BRIxQKLbpzp5ZbqxchBHZ7Jgp8EtklJWkqNf
h5huvA9dO8GjtuYldyMw2U17i4tesiWKhsDeecycu+Do1lOB2HDdfYvIQAJxDRbr
ZHLzArkxN2/f7e9/xrGYa07TgLRM26MZzZ6MOUTh/I66/sKmNhxJSLUIV0zbyZSd
HNI8Z49P50H0Skux/3kpHXMCrxnrVxCm7+lS+r399YsqDO5pOYnvN4LoJvHQ5RSm
9zyEGL5Z8AiHlp0bGfPJbnkNopGojSSN1L2Mc/PygitRkY+u7vk/j+VgNCI9gQv/
6vgJguCEw8DZ/EYHSNTL
=kGBW
-----END PGP SIGNATURE-----

--=-It76c9iLLx/ImG4+b9nG--

