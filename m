From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 0/3] OMAPDSS: Enable dynamic debug printing
Date: Fri, 28 Sep 2012 14:34:17 +0300
Message-ID: <1348832057.2437.24.camel@deskari>
References: <cover.1348636132.git.cmahapatra@ti.com>
	 <cover.1348826106.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6guojyXqHZcqke7nTlbw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56305 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757416Ab2I1LeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:34:21 -0400
Received: by lagh6 with SMTP id h6so992199lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 04:34:19 -0700 (PDT)
In-Reply-To: <cover.1348826106.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-6guojyXqHZcqke7nTlbw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-28 at 15:53 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> this patch series aims at cleaning up of DSS of printk()'s enabled with
> dss_debug and replace them with generic dynamic debug printing.
>=20
> The 1st patch
>  * moved DEBUG flag definition to Makefile
> The 2nd patch=20
>  * replaces printk() in DSSDBG definition with pr_debug()
>  * removes DSSDBGF definition and replaces its instances with DSSDBG()=
=20
> The 3rd patch
>  * cleans up printk()'s in omap_dispc_unregister_isr() and=20
>    _dsi_print_reset_status() with pr_debug()
>  * removes dss_debug variable
>=20
> Changes from V1 to V2:
>  * added debug messages to DSSDBG calls
>  * added patch "OMAPDSS: Remove dss_debug variable"
>=20
> Changes from V2 to V3
>  * added patch "OMAPDSS: Move definition of DEBUG flag to Makefile"
>=20
> All your comments and suggestions are welcome.

There's one thing that's not quite nice about omapdss's debug print
behavior after this series.

CONFIG_OMAP2_DSS_DEBUG_SUPPORT is marked "default y", and it's also been
safe to enable earlier as we had the dss_debug variable to prevent the
debug prints. But after this series, the debug prints are enabled, and
will spam the kernel log quite heavily.

And that happens with both dynamic debugging enabled and disabled.

How things should work:

For kernels with dynamic debugging disabled: by default the dss debugs
are not compiled, and the user needs to explicitly enable them in the
kernel config.

For kernels with dynamic debugging enabled: by default the dss debugs
are compiled in, but not enabled. A Kconfig option can be set to make
the debugs enabled by default.

In addition to those, we have the debugfs files. Those should be usable
regardless of the debug prints.

So I suggest the following:

- Remove CONFIG_OMAP2_DSS_DEBUG_SUPPORT. We can't re-use it, because it
may be enabled in user's kernel configs.
- Add new Kconfig option: CONFIG_OMAP2_DSS_DEBUG. This will set DEBUG in
the makefile. This is off by default.
- Add new Kconfig option: CONFIG_OMAP2_DSS_DEBUGFS. This will be use to
decide if debugfs functionality is compiled in or not. This is off by
default.

 Tomi


--=-6guojyXqHZcqke7nTlbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZYs5AAoJEPo9qoy8lh71EKMQAIfKXmZHfNirv0f20xmO+yRW
9vRBzINcV0lk6R0FFnBaK0BS5FtFPZ30/ooSHLkirnMxX7FNVLqAS7LyzyWRMLxP
03jEvdkPnGHKC+UDvCvZrq1EKSHjn/YBNjV+Ow+YBXl2/BmE6I3CCuQe9qanX6mW
1/LLe/FXV3anRS8JiJprHZ5jRd4+wZ+OoVtSf9ObaNIWXCaJajgk7qhax5AmqL+F
QFas53SpsR0wlI/+B9ijzZ7443rwndEp7L02Dov86LLPlDBcZz0FNuj8tUdw9mDy
m7u3rsqP9oYP9qqGld5K6/38zCCu4UG4NFLWNUKuS0OrO+ncdvUiZ23XSTBKvo+I
01CrtGiIPcXNmzbVXjb1ZnDj7f7rlS4Qyl8nySQq2xKie/0/QV+Saiimp8yb07tR
NSN6DXoi7KLe6Y+QcoKylfm8/PvwGzU9XTkqKaBiD/RGCo93YrN19kcDlN0ZnOE2
m2CDBM11lsKtIx5zLjwKV0jSTypKwLFqcI6NmDzPEk4gzG0wcd6Jo5ZtoyID1Tih
LdOjWsA6Q/GrT7fDRBqtT1HJpONJ1vSjJnlKy00Gkn9ycx3ExSBZ3vrJ7x0JXfSW
ZFSuxX7cw3C/btvBDIqOHRTbTfKnpz76gkundbIvg4523VJgv7ARjsAxPnm51IN5
NP384w5JAp+7RFkwDwu7
=n1rh
-----END PGP SIGNATURE-----

--=-6guojyXqHZcqke7nTlbw--

