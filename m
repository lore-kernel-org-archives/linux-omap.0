From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] OMAP: DSS: DPI: disable vt-switch on suspend/resume.
Date: Thu, 26 Feb 2015 09:26:46 +1100
Message-ID: <20150226092646.7e20df30@notabene.brown>
References: <20150225203708.0eb2fa96@notabene.brown>
	<54ED9DF8.8030105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Qc3He_H.LtfIWK.teWUvQfH"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54ED9DF8.8030105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/Qc3He_H.LtfIWK.teWUvQfH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2015 12:03:36 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> On 25/02/15 11:37, NeilBrown wrote:
> >=20
> > These devices do not need to return to non-graphic console
> > for suspend, so disable that option.
> > This means there is less work to do in the suspend/resume cycle,
> > making it smoother and cheaper.
> >=20
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> >=20
> > --
> > Hi Tomi,
> >  I wonder if you would consider this patch too.  It works for me and
> > removes pointless vt switching.  I assume no-one would need or want that
> > switching on suspend/resume but I guess I cannot be certain.
> >=20
> > Maybe a module-parameter could be used if there was any uncertainty.
>=20
> I was just yesterday picking patches from TI's kernel on top of
> mainline, and there's a similar one for omapfb and for omapdrm. Here's
> for omapfb:
>=20
> http://git.ti.com/android-sdk/kernel-video/commit/5915d8744c927307987b12b=
14bc6aa37b3bac05c?format=3Dpatch
>=20
> The patch in TI's kernel claims it's needed to make resume work. You're
> saying it just optimizes suspend/resume. I hadn't picked this up
> earlier, because I didn't understand why pm_set_vt_switch() would be
> needed to make resume work. And never had time to study it, so I still
> don't know what it's about...
>=20
> Looking at the drivers/tty/vt/vt_ioctl.c, it sounds to me that we should
> always do pm_set_vt_switch(0), as omapdss restores everything just fine
> on resume. Although it makes me wonder how it works if there are two
> display controllers, one needing the switch and the other not...

I wondered that too.  It would seem to make more sense for
pm_set_vt_switch(0) to be the default, that drivers which need the textmode
switch should call (1).  But I suspect there are "historical reasons" for t=
he
current situation.

My experience is that suspend works just find without this setting, and I
don't even notice the vt switch, unless I have DEBUG_DRIVERS which slows
suspend/resume down so much (writing lots of test to a serial console) that
the transition is noticeable.
I made the patch because I think it is the right thing to do, rather than
because it fixed a particular symptom.

I suspect that if suspend doesn't work without this patch, then something v=
ery
different is being done in user-space.  Maybe some other display manager, n=
ot
X.  Maybe the X server is running on vt1 rather than vt7.



>=20
> Your patch does the call in a bit odd place, so I'll be queuing the
> patches for omapfb and omapdrm. Or actually, maybe the call could be
> done in one place in omapdss driver, as you do, but in omap_dsshw_probe().

I just figured that it had to be in some 'probe' function somewhere - I have
no opinion about which one (maybe all?-).  I'm perfectly happy with it
appearing anywhere that affects omap dss devices.

One thing I was reminded while testing and may as well mention:
I usually blank my display before suspending (using
FBIOBLANK/FB_BLANK_POWERDOWN ioctls).  However if I don't then I get a
warning:

[   87.261077] WARNING: CPU: 0 PID: 1901 at ../drivers/video/fbdev/omap2/ds=
s/dispc.c:558 dispc_mgr_go+0x20/0x8c()
[   87.261138] Modules linked in: ipv6 usb_f_ecm g_ether usb_f_rndis u_ethe=
r libcomposite configfs hso w1_bq27000 libertas_sdio libertas cfg80211 omap=
_hdq itg3200 ehci_omap ehci_hcd uio_pdrv_genirq uio
[   87.261169] CPU: 0 PID: 1901 Comm: Xorg Not tainted 4.0.0-rc1-gta04+ #538
[   87.261169] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[   87.261199] [<c00137e0>] (unwind_backtrace) from [<c00113a4>] (show_stac=
k+0x10/0x14)
[   87.261230] [<c00113a4>] (show_stack) from [<c0033938>] (warn_slowpath_c=
ommon+0x80/0xa8)
[   87.261260] [<c0033938>] (warn_slowpath_common) from [<c0033978>] (warn_=
slowpath_null+0x18/0x1c)
[   87.261291] [<c0033978>] (warn_slowpath_null) from [<c0232538>] (dispc_m=
gr_go+0x20/0x8c)
[   87.261291] [<c0232538>] (dispc_mgr_go) from [<c023e30c>] (dss_set_go_bi=
ts+0xd4/0x100)
[   87.261322] [<c023e30c>] (dss_set_go_bits) from [<c023f308>] (omap_dss_m=
gr_apply+0x16c/0x1b8)
[   87.261352] [<c023f308>] (omap_dss_mgr_apply) from [<c0250790>] (omapfb_=
apply_changes+0x428/0x488)
[   87.261352] [<c0250790>] (omapfb_apply_changes) from [<c0251024>] (omapf=
b_set_par+0x74/0xb0)
[   87.261383] [<c0251024>] (omapfb_set_par) from [<c02281a4>] (fb_set_var+=
0x250/0x330)
[   87.261413] [<c02281a4>] (fb_set_var) from [<c021fa24>] (fbcon_blank+0x6=
c/0x260)
[   87.261444] [<c021fa24>] (fbcon_blank) from [<c0275464>] (do_unblank_scr=
een+0xf8/0x19c)
[   87.261474] [<c0275464>] (do_unblank_screen) from [<c026c268>] (complete=
_change_console+0x50/0xcc)
[   87.261474] [<c026c268>] (complete_change_console) from [<c026ccd8>] (vt=
_ioctl+0x9f4/0x1238)
[   87.261505] [<c026ccd8>] (vt_ioctl) from [<c02621e8>] (tty_ioctl+0xc48/0=
xcac)
[   87.261535] [<c02621e8>] (tty_ioctl) from [<c00dc344>] (do_vfs_ioctl+0x5=
b0/0x61c)
[   87.261566] [<c00dc344>] (do_vfs_ioctl) from [<c00dc3e4>] (SyS_ioctl+0x3=
4/0x58)
[   87.261566] [<c00dc3e4>] (SyS_ioctl) from [<c000ea40>] (ret_fast_syscall=
+0x0/0x34)

I think the Xserver is responding to a 'suspend' notification and is blanki=
ng
the screen, maybe at an awkward time.

I haven't looked into further details yet.  I don't really expect you to, b=
ut
I thought I would mention it.

Thanks,
NeilBrown


--Sig_/Qc3He_H.LtfIWK.teWUvQfH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVO5MJznsnt1WYoG5AQJnig/+OHMHz53+Kty74d1n8eprZx3ERw9GWKmo
Fg9hg9lWpgYJM6nvoAzNG2djgxGQ3OkvPqzHmy/K0W3V9O2uXZlpe5V3A6LNwmuT
rhHqs8WrWO7x1jPdNqTf8gcQ6jjnxZeiwDFe6tgjDIQYFY5i5ebclW7vBncI1Far
J/GMk1ZqStn54xG7dMaqt9cQKwt0twOPbiQqtxY6foLa49JCwzHzzzwux3c2WibG
KI7yqEg3gKsMalvbKW9rd0wM1Wx32CRgTSErUBMD7ctDsLPRgw4q9aKA8sWgKlb8
2MHNoPHG8K+zyjl1vj/bHLXNKTHJgGAek95FH98FwMmhNAQQL6ncYKsJPqDUnZcJ
kT1hc5TyKoYiyRBSXiCuorUmU6L0reVd5KYNNFtj2YN4tz0/8e5Q9ZUGfel6pB3p
1Y88Ycz8WYd+UXU38eSI39Z3fSpSTzWWSHlsRv2Jd3DbRvoBWVIaNvq4/N9trzXg
WlNHKDJMR+12I2/ABo2xR31pA4gjmuaCr2M5eA8xHd9DRWriaQwdpfDdHiDM4h6B
M1WXoz/EFwsT/T67TYekf8JE24GJG3GaANWSz6A0M5wR+lTQLmOptOPLBaEh/uvJ
oNBUiOxk3qLaYCFGJvXulAIDES6XBRfU7P1AGfaPTBiYtEd106AU0Y+yzSN4hYi8
DASO7f67zuY=
=FZ7c
-----END PGP SIGNATURE-----

--Sig_/Qc3He_H.LtfIWK.teWUvQfH--
