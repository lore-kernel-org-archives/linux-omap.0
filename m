From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 3 Jun 2015 16:54:45 -0500
Message-ID: <20150603215445.GK6042@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbFCV5f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 17:57:35 -0400
Content-Disposition: inline
In-Reply-To: <556F7493.2060602@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: balbi@ti.com, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, slash.tmp@free.fr

--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 03, 2015 at 02:41:39PM -0700, Stephen Boyd wrote:
> >>>>AM43xx, even though it's a single processor A9, it still has TWD and =
global
> >>>>timer. I was doing some profiling with RT v4.0 and latency is 3.5x lo=
wer just
> >>>>by switching from gptimer to twd/global.
> >>>>
> >>>>The only problem is that currently, is_smp() check prevents me from u=
sing twd
> >>>>with AM43xx (that's why it's commented below, for testing purposes).
> >>>>
> >>>>In the hopes that we can start a, hopefully, small thread around the =
subject,
> >>>>I'm sending this HACK which I used to get TWD and global timer enable=
d so I
> >>>>could measure latencies with cyclictest.
> >>>>
> >>>>Is it so that TWD shouldn't be available on UP integrations of ARM's =
Cortex-A
> >>>>processors ?
> >>>>
> >>>>
> >>>I wondered about this recently when looking at something unrelated
> >>>and noticed that the check had been introduced as part of
> >>>904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register=
()
> >>>no-op for nosmp").
> >>>
> >>>I suspect this was just the wrong fix at the time, and that the
> >>>real culprit is either alloc_percpu() or request_percpu_irq()
> >>>getting called too early on a machine without SMP support.
> >>>
> >>>Possibly the problem is already resolved independently, if you
> >>>didn't run into it.
> >>no, no splats, nothing at all. See [1]
> >>
> >>[1] http://hastebin.com/helekubutu
> >Adding Shawn
> >
>=20
> Mason was also interested in doing this. See [2]. From what I could tell
> back then, commit 904464b91eca8 was working around the local timer APIs t=
hat
> no longer exist.
>=20
> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=3D3=
92348

A lot of good information on that thread, thanks. Seems like getting
twd/global timer working would also have some effect on context
switching, perhaps ?

cheers

--=20
balbi

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVb3elAAoJEIaOsuA1yqREN/UP/3v4pSbFRwd5D/SsZFOZcm02
TGfu93fpJQikvUBDtb6HEZSfJ+/RW/AhWPzkEZulg2Or54um6jQUEzsvQCyLxmOE
CmW8chov9nYlgLax+NxKLomqbn+hfwvau9LC6PtLFpn5JLtbeGiWy4y312GnCpjN
vIE6NYNvNgTgsEyF8H9VT2Jj4hwoljcG+OEZV5pAwI8G1yi7Lu0qs8qACH3Uph1+
wfWBQbd3buSDCcF4X/aDBFIamkAJxNE/eRdfuxmeVnrLu4Iiq8NzyKLwfogx4o8X
4r/9aLuHQxV9GufcAva9JFVlWedfCjtA4wVARkmP4FwX3N6IguveFgVFZVXMyH+3
MJfbVoaFD8tocbA6AOd3XgTo44jQFFV+9zryMxfgmfwT/v5aRnNoyJb7vypzJAUT
2T8Z0QJ/d/et2Zn/KN0wPHAUH+Vp5aF3R6sF7UQ7GQx0eEecL+HfSwCew1lHpHRu
h2UXYA+ulQYdtgy8V67C6hUH8uC+ER0qswoY8tXXbS67XdHiYyf6EhygLyE+vjZ3
rjuy1dfI0n8oHoclOS2x0drO7vm3R0O+LkG5hxk93ky1+8T5izGfEVCs68pgu90i
u17LvlUXv5s8RzzoPqhDlKAFmqG246SvNu3InF37Yh21JiSaPkisvIZetRHjZg88
8ETV71MGRF5MBhuLPEcT
=Gs+P
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--
