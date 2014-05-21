From: Sebastian Reichel <sre@kernel.org>
Subject: Locking problem during N900 shutdown with power management patchset
Date: Thu, 22 May 2014 01:54:36 +0200
Message-ID: <20140521235436.GB29118@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37680 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbaEUXyn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 19:54:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

Now that I have added the dma fix in addition to the idle support
patchset I can do clean shutdowns (versus removing battery :)) and
see the following final warning during shutdown:

[ 3724.136474] reboot: Power down
[ 3724.139770] ------------[ cut here ]------------
[ 3724.144683] WARNING: CPU: 0 PID: 3076 at kernel/locking/lockdep.c:2742 lockdep_trace_alloc+0xd8/0xf8()
[ 3724.154510] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[ 3724.160217] Modules linked in:
[ 3724.163665] CPU: 0 PID: 3076 Comm: halt Not tainted 3.15.0-rc5-00035-gf6796c0 #89
[ 3724.171630] [<c0014cdc>] (unwind_backtrace) from [<c0011924>] (show_stack+0x10/0x14)
[ 3724.179840] [<c0011924>] (show_stack) from [<c056baf0>] (dump_stack+0x80/0x9c)
[ 3724.187499] [<c056baf0>] (dump_stack) from [<c003fc44>] (warn_slowpath_common+0x68/0x8c)
[ 3724.196044] [<c003fc44>] (warn_slowpath_common) from [<c003fcfc>] (warn_slowpath_fmt+0x30/0x40)
[ 3724.205261] [<c003fcfc>] (warn_slowpath_fmt) from [<c00855cc>] (lockdep_trace_alloc+0xd8/0xf8)
[ 3724.214385] [<c00855cc>] (lockdep_trace_alloc) from [<c0111e80>] (__kmalloc_track_caller+0x38/0x184)
[ 3724.224060] [<c0111e80>] (__kmalloc_track_caller) from [<c00f0e1c>] (kmemdup+0x1c/0x38)
[ 3724.232543] [<c00f0e1c>] (kmemdup) from [<c0383a70>] (regmap_bulk_write+0xf8/0x19c)
[ 3724.240661] [<c0383a70>] (regmap_bulk_write) from [<c038df6c>] (twl_i2c_write+0x48/0x8c)
[ 3724.249237] [<c038df6c>] (twl_i2c_write) from [<c038fb48>] (twl4030_power_off+0x20/0x40)
[ 3724.257781] [<c038fb48>] (twl4030_power_off) from [<c000f394>] (machine_power_off+0x24/0x2c)
[ 3724.266723] [<c000f394>] (machine_power_off) from [<c00640d4>] (SyS_reboot+0xf0/0x1dc)
[ 3724.275115] [<c00640d4>] (SyS_reboot) from [<c000e6a0>] (ret_fast_syscall+0x0/0x48)
[ 3724.283203] ---[ end trace b06de91d3cd82ea1 ]---

Is this already being worked on or should I try to trace the
problem?

-- Sebastian

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTfTy7AAoJENju1/PIO/qad08P/Rq2GeJxTIAiHL2HKmpdFHbq
GwBz6frokjwYai217LSLphc7nTqj4t8FOny22Muac0Y4Kj/i/PvlNuu3UGYecRS3
PYWPcMyzm18JdNJz2WX05tFHvhOYk81uKFw3fME9gx1WeC3sRKDCOhqhACA22gWg
/fH1ijwk/Il8U0JZbv2lngFibgf3TMjOutgCzX5x/h09nm9NsjCgqPZirXJaR5rM
XbJbJj+qLh2U/kGLqNsQfF0ApdGLNE+QDto58H0JDrZQRqOBJfG4D/rLDux2ay/8
sL9pKe3bBzaazFbD1M70AE4tEKH28Fc2CU8LCvPmw08+Z7KOIdgu3XIF7VX+SxZl
L+62BdKYW/9Y4JztAKk0C6OI9iPy8S7JMyveTLwDNYp7ep/YY28T5LjhEEZaIaAW
ka1rOo0pT/Tp9IvRCeCmAD/ov41fwsHnUAEliSgEEw/3J9mxDmMpFBxrL1rmVM5A
xuHgTZFl1oli2nQvyl+idn3mOy5jFPEG6fiCKn6C4eOt40sUoKsT+fcs6p5Zsgj8
iznB6clrKxcHKdcg0+MPCwi8TCquYccNwD6WNJbP6SSGDFD2ifCGJvsjLWymFfYH
+J5VtLc0sn2JccZvs7B++DZMZHCNObx1Qgi2IMh8Zi7ZYUxdOz5j6ISoUC1HU+ZS
rrZgvUBVdy0KwQfWjMy6
=/A26
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
