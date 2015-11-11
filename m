From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Wed, 11 Nov 2015 13:40:54 -0600
Message-ID: <874mgss4s9.fsf@saruman.tx.rr.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, tony@atomide.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> Hi Paul, Tony,
>
> Changes since v2:
> - DTS patch added which is needed because of the clock handling changes
>
> Felip Balbi reported that linux-next is broken right now since the DTS pa=
rt of
> the earlier series has been applied, but we do not have the mcasp hwmod i=
n the
> kernel:
> ...
> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> ...
> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIX=
ME: missing hwmod/omap_dev info
> [    6.130790] ------------[ cut here ]------------
> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 =
l3_interrupt_handler+0x220/0x34c()
> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3=
 (Read): Data Access in User mode during Functional access
> ...
>
> This is the followup series for the hwmod changes needed to get audio wor=
king
> on DRA7xx family based boards.
> The DTS patches has been applied by Tony from the original series:
> http://www.spinics.net/lists/linux-omap/msg121473.html
>
> I have addressed your comments in the hwmod data and did some research al=
so
> regarding to the use of ahclkx as fclk in the original submission.
> It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> ahclkx/r) to be able to access registers. The original patch where we han=
dled
> the ahclkx as fclk worked, because the fclk clock got enabled in the HW w=
/o
> any SW interaction.
> All in all, the McASP found in DRA7 needs all clocks to be enabled.
> To satisfy this I have introduced a new flag to hwmod, which means that t=
he
> listed optional clocks need to be handled alongside with the fclk clock.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: DTS: dra7: Fix McASP3 node regarding to clocks
>   ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
>   ARM: OMAP: DRA7: hwmod: Add data for McASP3

I have tested these patches with today's HEAD + rtc 1307 fix. Boots fine
and I can't see the splat I was seeing with beagle x15.

Tested-by: Felipe Balbi <balbi@ti.com>

logs: http://hastebin.com/ololizojat

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQ5nIAAoJEIaOsuA1yqREBBIP/3Nw1hNVID6wNMyjIQGui8Li
+OrSl2zrL5c9WdrqwViIaPOjOnJq2y9JE4keDlQ+8D+NFeMrK3yk2uevhmrvbFia
WOYr3WVX6jxCKBCuuO/RzAAB+Yhz3IAYU5BghdPhkUxZGp1HbWxjlVNFY0apIWl2
hv30E7DERmaWxz8Lqr4GVQpiQDPYpO/cLxHwoCRbdORKGeZaU1dht26xVLIRL6xv
9jV1uh0B49yvQorooynsgs7iUW92Zj+0ICvVHs5ZVvQK4FIyTv6TdHt4S/eHRMOw
69iyVP/9kJ1KqpVZroEWn+9G//khihQGsbbkWxHAUuC7TR76M7yBSaGmi5slIpl3
PZ8GX4n42xYHvVleskXw6jsIp8F9DOCAukcLxXrUDOzD1odm1MYKhQ9DBVFMFC0b
8ZassNAk66MJ/EaoQc67P3k6f62hHMCgokckKsnMlzwU59cCB8RYX4MwB6c+ccsD
If4jCrJ93Yb7pUvvXQR/yWtEXlw91opv/n4Nsie6DCjEzkzdgFBNcvNQuIH51QUA
0ArRNaT6ZlFjzQEOOHlWlYYl6iQkKEuUlvsswPsLos2FYMjqQYG9YcEMNrzt9s04
w5VQwVBKFum+sjJXNCjrx1pL1EL4rESey5xuNJiJobyU6/N5Z1MF5tknTLo5UPYG
JBdl4Ok2CwGALA3cCadD
=5qGi
-----END PGP SIGNATURE-----
--=-=-=--
