From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS cmdline resolution not working for HDMI?
Date: Fri, 05 Oct 2012 14:04:54 +0300
Message-ID: <1349435094.2401.17.camel@deskari>
References: <20121004175604.GE3874@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SCdr3RM5PdzVzp449Qct"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49533 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932194Ab2JELE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 07:04:59 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1235181lbo.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 04:04:56 -0700 (PDT)
In-Reply-To: <20121004175604.GE3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-SCdr3RM5PdzVzp449Qct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-10-04 at 10:56 -0700, Tony Lindgren wrote:
> Hi,
>=20
> FYI, looks like for some reason DSS command line is not
> working for HDMI while it works for DSS. On my panda es
> I'm trying to set my motorola lapdock resolution from
> cmdline with:
>=20
> omapdss.def_disp=3Dhdmi omapfb.mode=3Dhdmi:1366x768@60
>=20
> But it does not seem to do anything and resolution is
> VGA. If I change the cable to DVI port this works:
>=20
> omapdss.def_disp=3Ddvi omapfb.mode=3Ddvi:1366x768@60
>=20
> Any ideas? This is with current linux next.

That's because our HDMI only supports certain timings. To be honest, I
don't really understand this restriction, as I believe the hardware
should be able to use more or less any timings just like DVI.

The 1366x768@60 mode is parsed with fbdev functions, which returns a
video timings. These timings are then given to the HDMI driver, which
tries to find matching timings from its timing table. And when it
doesn't find a match, it fails.

This is a known problem, and the hdmi driver would really need some love
in other aspects also. I'm not sure what would be the best way to
improve this without doing major rewrites. Perhaps the check in the hdmi
driver could be more relaxed, but that needs some careful thought.

> I can change the HDMI resolution OK from userspace with:
>=20
> echo "1" > /sys/devices/platform/omapdss/display1/enabled
> echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
> echo "tv" > /sys/devices/platform/omapdss/overlay0/manager
> echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
> echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/d=
isplay1/timings

That's because the above line has timings that are in the hdmi driver's
table. They are somewhat different than what fbdev gives for
"1366x768@60".

> The reason to use HDMI instead of DVI here is that HDMI
> also has the speakers on the lapdock ;)
>=20
> Then I'm able to switch between HDMI panel and DVI panel
> just fine using overlay0. I don't know if getting both
> HDMI and DVI to work the same time using overlay1 is
> supposed to work, but trying use overlay1 produces the
> following:

HDMI and DVI cannot be used reliably at the same time, due to a HW issue
we've had unresolved for a long time. Luckily, it was solved this week
and we'll have a patch for next merge window to get this working.

> echo "1" > /sys/devices/platform/omapdss/display0/enabled
> echo "0" > /sys/devices/platform/omapdss/overlay1/enabled
> echo "lcd2" > /sys/devices/platform/omapdss/overlay1/manager
> echo "1" > /sys/devices/platform/omapdss/overlay1/enabled
> echo "170666,1920/336/128/208,1200/38/1/3" > /sys/devices/platform/omapds=
s/display0/timings
>=20
> [  816.446044] omapdss DPI: Could not find exact pixel clock. Requested 2=
3500 kHz, got 23630 kHz
> [  881.639221] omapdss APPLY: timeout in wait_pending_extra_info_updates
> [  958.946594] ------------[ cut here ]------------
> [  958.953277] WARNING: at drivers/bus/omap_l3_noc.c:97 l3_interrupt_hand=
ler+0xc0/0x184()
> [  958.965576] L3 standard error: TARGET:DMM2 at address 0x0
> ...

Having said the above, I don't quite know where this error comes from...
Tiler (DMM) is not even used by omapfb.

 Tomi


--=-SCdr3RM5PdzVzp449Qct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQbr7WAAoJEPo9qoy8lh71lIgP/i7BSSdnThDyOGO9E3oeSVtD
eAe/yntMg5YY6tpUqrC7x4BnAKDe6xVE6H+LIxdl/F3NRk5vxt7uIDwJtbMKKsM4
VIJyPSVlIkOx7gckNVAr2mflk4hrZN8Sj28lhfg48FtgvIOdE2jME1qH9ogDZbei
CJj7GyexMCy51qPvVWZ9YzOSA3sZLxYbaNWn7x6dKmi1PGZrxFXblsqUL4vuTsP2
XOJeAP/G9/ltiQPHV1LRfI7dQmo73MZiPb/sQ89XJHVIJU34BqJiu1xKNYwfAKiu
cZGQ0dyvvrHcYHzrfilC12A8JON9ugLnj2NK1HDvDy/0Vr99jetaP8VRPx0XSAk9
VP7zMY1qBIjAkyspwVGkghNaehHB8CpV4PZKwhwlXgmQYqbUpfONzeTljjzH4Bwz
hE0HAvzBB3T0jY3q2iBkYXRiG/Gajg3AwtWrdXfuLSp2kdmPCV4tVcnlzL+UvJfn
ZSQxMUvVTZNspctPAzriZi7o6shOqjiiKNWoN3lr1VKcPw6XkM2S3cEkXTM4jrUI
e6ItPK6dKLQZ9sUpER9dUpcoCoUrmph8zs2XofswA3ISEPRLLrDH1trc7Tk4cRUE
MfXw5QXyoBa7Hu+hAvjVQt+E7Fx2axAEdXdtXLSqA9oKhM47QBPqVOciOJh/XRBb
6gkci7l0/fAiou2R42Un
=j7xb
-----END PGP SIGNATURE-----

--=-SCdr3RM5PdzVzp449Qct--

