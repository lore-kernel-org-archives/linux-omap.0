From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 12:07:40 +0300
Message-ID: <1340701660.24530.17.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	 <1340695166.2093.22.camel@lappyti>
	 <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tb1qs1M4cPRCIU+3NP5f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:39489 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2FZJHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:07:46 -0400
Received: by lbbgg6 with SMTP id gg6so10451760lbb.22
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 02:07:43 -0700 (PDT)
In-Reply-To: <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-tb1qs1M4cPRCIU+3NP5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 14:02 +0530, Jassi Brar wrote:

> Something non-omapdss in vanilla breaks suspend/resume.

I was able to reproduce (probably) the same issue with omap3 overo. Does
this looks familiar:

[ 2267.140197] ------------[ cut here ]------------
[ 2267.145172] WARNING: at drivers/video/omap2/dss/dispc.c:377 dispc_runtim=
e_get+0x60/0x7c [omapdss]
()
[ 2267.154846] Modules linked in: omapfb panel_generic_dpi omapdss cfbimgbl=
t cfbfillrect cfbcopyarea
 [last unloaded: omapdss]
[ 2267.166595] [<c001b61c>] (unwind_backtrace+0x0/0xf0) from [<c0040238>] (=
warn_slowpath_common+0x4c
/0x64)
[ 2267.176605] [<c0040238>] (warn_slowpath_common+0x4c/0x64) from [<c004026=
c>] (warn_slowpath_null+0
x1c/0x24)
[ 2267.186859] [<c004026c>] (warn_slowpath_null+0x1c/0x24) from [<bf0d7918>=
] (dispc_runtime_get+0x60
/0x7c [omapdss])
[ 2267.197814] [<bf0d7918>] (dispc_runtime_get+0x60/0x7c [omapdss]) from [<=
bf0e3148>] (omapdss_dpi_d
isplay_enable+0x48/0x230 [omapdss])
[ 2267.210479] [<bf0e3148>] (omapdss_dpi_display_enable+0x48/0x230 [omapdss=
]) from [<bf110034>] (gen
eric_dpi_panel_check_timings+0x30/0x7c [panel_generic_dpi])
[ 2267.225311] [<bf110034>] (generic_dpi_panel_check_timings+0x30/0x7c [pan=
el_generic_dpi]) from [<b
f11008c>] (generic_dpi_panel_resume+0xc/0x1c [panel_generic_dpi])
[ 2267.240722] [<bf11008c>] (generic_dpi_panel_resume+0xc/0x1c [panel_gener=
ic_dpi]) from [<bf0de654>
] (dss_resume_device+0x28/0x40 [omapdss])
[ 2267.253936] [<bf0de654>] (dss_resume_device+0x28/0x40 [omapdss]) from [<=
c02bfb94>] (bus_for_each_
dev+0x50/0x7c)
[ 2267.264678] [<c02bfb94>] (bus_for_each_dev+0x50/0x7c) from [<c02c287c>] =
(platform_pm_resume+0x2c/
0x50)
[ 2267.274566] [<c02c287c>] (platform_pm_resume+0x2c/0x50) from [<c02c6da8>=
] (dpm_run_callback.clone
.7+0x30/0xb0)
[ 2267.285186] [<c02c6da8>] (dpm_run_callback.clone.7+0x30/0xb0) from [<c02=
c7b2c>] (device_resume+0x
c8/0x188)
[ 2267.295471] [<c02c7b2c>] (device_resume+0xc8/0x188) from [<c02c7f54>] (d=
pm_resume+0xfc/0x21c)
[ 2267.304534] [<c02c7f54>] (dpm_resume+0xfc/0x21c) from [<c02c8208>] (dpm_=
resume_end+0xc/0x18)
[ 2267.313507] [<c02c8208>] (dpm_resume_end+0xc/0x18) from [<c007fbcc>] (su=
spend_devices_and_enter+0
x15c/0x2d0)
[ 2267.323913] [<c007fbcc>] (suspend_devices_and_enter+0x15c/0x2d0) from [<=
c007fecc>] (pm_suspend+0x
18c/0x208)
[ 2267.334259] [<c007fecc>] (pm_suspend+0x18c/0x208) from [<c007f170>] (sta=
te_store+0x120/0x134)
[ 2267.343292] [<c007f170>] (state_store+0x120/0x134) from [<c0262850>] (ko=
bj_attr_store+0x14/0x20)
[ 2267.352661] [<c0262850>] (kobj_attr_store+0x14/0x20) from [<c0169b6c>] (=
sysfs_write_file+0x100/0x
184)
[ 2267.362457] [<c0169b6c>] (sysfs_write_file+0x100/0x184) from [<c0109008>=
] (vfs_write+0xb4/0x148)
[ 2267.371795] [<c0109008>] (vfs_write+0xb4/0x148) from [<c0109290>] (sys_w=
rite+0x40/0x70)
[ 2267.380310] [<c0109290>] (sys_write+0x40/0x70) from [<c0013d60>] (ret_fa=
st_syscall+0x0/0x3c)
[ 2267.389282] ---[ end trace 54fe7eea726ac84d ]---
[ 2267.394592] dpm_run_callback(): platform_pm_resume+0x0/0x50 returns -13
[ 2267.401641] PM: Device omapdss failed to resume: error -13

I don't remember seeing that with earlier kernel versions, but I'm not
100% sure.

Looking at the log, I can see that both DSS and DISPC runtime_resume
callbacks are called early, and successfully. Later the system resume
callback tries to enable the displays that were enabled when the system
went to suspend, which fails because dispc_runtime_get() returns -EACCES
(and pm_runtime_enabled() returns false).

Interestingly, during suspend dispc_runtime_put() is called, and at that
point pm_runtime_enabled() also returns false, but pm_runtime_put_sync()
still returns 0 instead of -EACCES.

I'll need to study this more, but I don't think this is a problem
related to omapdss's handling of runtime PM, but rather handling system
suspend. omapdss's handling of system suspend is in a rather bad state.

 Tomi


--=-tb1qs1M4cPRCIU+3NP5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6XvcAAoJEPo9qoy8lh71KIIP/2w58gogorZ5WfFtPclB/e8a
YFoDQ6qehma5UZb8Sbg57PC48WuVhhECgUJ23nR9ix7b9XQYfjUO3BuedutYtKAh
5T27wv2hHZyREE48ReCKjg2HAtLJS+YS44vMiTVuBnzsjQmOgKdu5YY3qJwwvOIa
4YQiERzX0TsI57lToelT7Dukot335s4SuP0TDF3nVsxxlKT6RYyvf+KITp+/H+V3
waUCUnFAJP2h1hMrdA6Xi+oJmzYkGaUEfStFoZ7/atTpg8OBI0ciKEintU9gjaog
ZVWqZfFTUgmyk8aK+z5yy6i2nl8EomGTgZDArZ0RZEMKZmKuUyQT0ft1XClLQZ5X
0VeodYMS02whpoFxndb7pnOIyZnYRlLWVSLdz5onr8k3WEU9CaRYT2Ezu1G+Qyxb
SewczJ1/mfvYo3U+7ripPQm0WwScSqLoTmpfLVdFtcv/Yp68WEkpp7inq8oAwwNo
nYQSRC6lRRfopyhJf8sd2w6hoindG1WxPDwDiz5w0CDiORVgTQJYSqYFuyTnkthq
6eWViL1/r23f8pvgmvy+zVDlvTwyUSFTQ8jhaPsPwAD2uiFrqeaq6kMnZcCk9rWI
HYpHWqdRAwOqOJazX/Iz78Nkyu79EgGYh5SFO5LaXIUT28vymXiIZNbulBBvh/Oe
pgFUhoA1hTmJCxkH66CQ
=wal6
-----END PGP SIGNATURE-----

--=-tb1qs1M4cPRCIU+3NP5f--

