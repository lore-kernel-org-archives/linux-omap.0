From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] security: device_cgroup: fix RCU lockdep splat
Date: Tue, 1 Sep 2015 08:08:22 -0500
Message-ID: <20150901130822.GA4728@saruman.tx.rr.com>
References: <1441053629-31844-1-git-send-email-balbi@ti.com>
 <alpine.LFD.2.11.1509011109150.1709@denkbrett>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1509011109150.1709@denkbrett>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Felipe Balbi <balbi@ti.com>, James Morris <james.l.morris@oracle.com>, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2015 at 11:12:18AM +0200, Sebastian Ott wrote:
> On Mon, 31 Aug 2015, Felipe Balbi wrote:
> > while booting AM437x device, the following splat
> > triggered:
> >=20
> > [   12.005238] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   12.009749] [ INFO: suspicious RCU usage. ]
> > [   12.014116] 4.2.0-next-20150831 #1154 Not tainted
> > [   12.019050] -------------------------------
> > [   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new_ex=
 called without proper synchronization!
> > [   12.033576] other info that might help us debug this:
> >=20
> > [   12.041942] rcu_scheduler_active =3D 1, debug_locks =3D 0
> > [   12.048796] 4 locks held by systemd/1:
> > [   12.052700]  #0:  (sb_writers#7){.+.+.+}, at: [<c017af84>] __sb_star=
t_write+0x8c/0xb0
> > [   12.060954]  #1:  (&of->mutex){+.+.+.}, at: [<c01f1600>] kernfs_fop_=
write+0x50/0x1b8
> > [   12.069085]  #2:  (s_active#30){++++.+}, at: [<c01f1608>] kernfs_fop=
_write+0x58/0x1b8
> > [   12.077310]  #3:  (devcgroup_mutex){+.+...}, at: [<c0317bfc>] devcgr=
oup_access_write+0x20/0x658
> > [   12.086575] stack backtrace:
> > [   12.091124] CPU: 0 PID: 1 Comm: systemd Not tainted 4.2.0-next-20150=
831 #1154
> > [   12.098609] Hardware name: Generic AM43 (Flattened Device Tree)
> > [   12.104807] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_=
stack+0x10/0x14)
> > [   12.112924] [<c0013a58>] (show_stack) from [<c034f014>] (dump_stack+=
0x84/0x9c)
> > [   12.120491] [<c034f014>] (dump_stack) from [<c0317a04>] (verify_new_=
ex+0xc4/0xdc)
> > [   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcgrou=
p_access_write+0x374/0x658)
> > [   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800>] =
(cgroup_file_write+0x28/0x1bc)
> > [   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (kern=
fs_fop_write+0xc0/0x1b8)
> > [   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__vfs=
_write+0x1c/0xd8)
> > [   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_write+=
0x90/0x16c)
> > [   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write+0x=
44/0x9c)
> > [   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_sys=
call+0x0/0x1c)
> >=20
> > Fix it by making sure rcu_read_lock() is held
> > around devcgroup_update_access().
>=20
> With this patch applied I got the following:
>=20
> [    4.079102] BUG: sleeping function called from invalid context at mm/s=
lub.c:1266
> [    4.079105] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: systemd

that didn't trigger here. maybe I didn't have lock debugging enabled.
I'll have a look.

--=20
balbi

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5aNGAAoJEIaOsuA1yqRE/vYP/irPqXndibyLB0WUYoWY8rk6
lxZbt0kS0uBekMSghzk5lMHgFMpXzZRWGB6mBtz4MeQobRvHi2n2LhGXFrIt+Iyv
FyjXnXy0OGLzIqzvThe+lb9ptzRXZzdjWDAOg626XUEdHUsWE5BKBHY1lvDH0rzq
S+sqErFbYMerKmL6HWF2IJRadkXFeuhAVQ5HelyI6/0qVCF0O23P06iB58f0gQmB
68s3aVv4FoOGTtdyHmbEUXdfHtUImLYsBUP26Moj1rup3agPLIXkpnNo4X9c71bl
SV02Z0FSQtQq/64bgw0nDSy+sv+QvtTcYyDYAuXwRbxUJWRgMIicXyQ8n/4x4lFw
KXTjxj2EMfuLaDI1Y5AAM97f5JnbrmpP2+4arDir7rCxb08nyg//LZVKopkwv01q
jyxuGGfH4yr+lF6pcM8kW9tO8BdkxLrzvvfwafFAgz11w1HVcBUMYYV2s0Oy0fNs
Guux8M7Fa1ikzwe6cZzrmsilSpiA9imUkHlIS22znACdg0B+hwKdnSE4UaU6gPFU
0SBxvxXH8WHwIlSd1tHjl7Ib+i84oGQi/qs6PurLoGY2EN0XqYXKqj1buOlWC2Zg
OtL2IpqIsa8YraKsbV7hdRHayph8OlxDg6+M0qHxfzfKypgvDUc7K6bV+mFPGZN7
nIxIBWgl7nFsUUXUcqWs
=0uQl
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
