From: Pavel Machek <pavel@ucw.cz>
Subject: v4.17-rc1 on motorola droid d4: WARN_ON from
 drivers/gpu/drm/omapdrm/dss/hdmi4.c
Date: Tue, 17 Apr 2018 09:32:28 +0200
Message-ID: <20180417073228.GA9246@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

While playing with screensaver on droid4:

[ 1047.117462] omap-mcbsp 40124000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck
[ 1047.130432] ------------[ cut here ]------------
[ 1047.135559] WARNING: CPU: 1 PID: 2942 at
drivers/gpu/drm/omapdrm/dss/hdmi4.c:667 hdmi_audio_stop+0x5c/0x68
[ 1047.145294] Modules linked in:
[ 1047.148376] CPU: 1 PID: 2942 Comm: pulseaudio Not tainted
4.17.0-rc1-73412-g8f3e00d-dirty #623
[ 1047.157043] Hardware name: Generic OMAP4 (Flattened Device Tree)
[ 1047.163085] [<c0111854>] (unwind_backtrace) from [<c010d740>]
(show_stack+0x10/0x14)
[ 1047.170898] [<c010d740>] (show_stack) from [<c08fc244>]
(dump_stack+0xa8/0xe0)
[ 1047.178161] [<c08fc244>] (dump_stack) from [<c0134d50>]
(__warn+0xf8/0x124)
[ 1047.185180] [<c0134d50>] (__warn) from [<c0134db8>]
(warn_slowpath_null+0x3c/0x48)
[ 1047.192962] [<c0134db8>] (warn_slowpath_null) from [<c053d9dc>]
(hdmi_audio_stop+0x5c/0x68)
[ 1047.192993] [<c053d9dc>] (hdmi_audio_stop) from [<c06f3e2c>]
(hdmi_dai_trigger+0x6c/0x88)
[ 1047.193023] [<c06f3e2c>] (hdmi_dai_trigger) from [<c06e0308>]
(soc_pcm_trigger+0x140/0x184)
[ 1047.193023] [<c06e0308>] (soc_pcm_trigger) from [<c06afc68>]
(snd_pcm_do_stop+0x54/0x58)
[ 1047.193054] [<c06afc68>] (snd_pcm_do_stop) from [<c06afa10>]
(snd_pcm_action_single+0x38/0x78)
[ 1047.193054] [<c06afa10>] (snd_pcm_action_single) from [<c06b1c24>]
(snd_pcm_drop+0x48/0x94)
[ 1047.193054] [<c06b1c24>] (snd_pcm_drop) from [<c06b2d24>]
(snd_pcm_ioctl+0x8e0/0x1308)
[ 1047.193084] [<c06b2d24>] (snd_pcm_ioctl) from [<c02c80cc>]
(do_vfs_ioctl+0x84/0xa70)
[ 1047.193084] [<c02c80cc>] (do_vfs_ioctl) from [<c02c8b14>]
(ksys_ioctl+0x5c/0x80)
[ 1047.193115] [<c02c8b14>] (ksys_ioctl) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)
[ 1047.193115] Exception stack(0xecfc1fa8 to 0xecfc1ff0)
[ 1047.193115] 1fa0:                   00562308 b1986394 00000015
00004143 00000000 00562e20
[ 1047.193115] 1fc0: 00562308 b1986394 0053d4e0 00000036 0000000e
b6fdbce8 00507d80 bed64644
[ 1047.193145] 1fe0: b19867c4 bed644c4 b1916be7 b6c8e716
[ 1047.193145] irq event stamp: 60448
[ 1047.193145] hardirqs last  enabled at (60447): [<c01c6df4>]
ktime_get_ts64+0x19c/0x1dc
[ 1047.193176] hardirqs last disabled at (60448): [<c06b099c>]
snd_pcm_stream_lock_irq+0x24/0x34
[ 1047.193176] softirqs last  enabled at (60078): [<c01024a0>]
__do_softirq+0x2e0/0x59c
[ 1047.193176] softirqs last disabled at (60031): [<c013c684>]
irq_exit+0x144/0x194
[ 1047.193206] ---[ end trace 07b005c418b9f99b ]---
[ 1062.235626] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 1092.313934] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrVowwACgkQMOfwapXb+vLX0ACgqtQxgXXS53SFCo6OJZrWtBjF
/7gAn32SuiZKu4CSMhX1LjM675PXQoi+
=S4Cg
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
