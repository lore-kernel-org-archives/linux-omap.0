From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] security: device_cgroup: fix RCU lockdep splat
Date: Wed, 2 Sep 2015 07:56:08 -0500
Message-ID: <20150902125608.GA8299@saruman.tx.rr.com>
References: <1441053629-31844-1-git-send-email-balbi@ti.com>
 <alpine.LFD.2.11.1509011109150.1709@denkbrett>
 <20150901130822.GA4728@saruman.tx.rr.com>
 <CA+5PVA6j+whjzpV-e6HJKqyJwVY7Mzb6AEj2YOMfa=J29AJMjQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA6j+whjzpV-e6HJKqyJwVY7Mzb6AEj2YOMfa=J29AJMjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 08:29:14AM -0400, Josh Boyer wrote:
> On Tue, Sep 1, 2015 at 9:08 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Sep 01, 2015 at 11:12:18AM +0200, Sebastian Ott wrote:
> >> On Mon, 31 Aug 2015, Felipe Balbi wrote:
> >> > while booting AM437x device, the following splat
> >> > triggered:
> >> >
> >> > [   12.005238] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > [   12.009749] [ INFO: suspicious RCU usage. ]
> >> > [   12.014116] 4.2.0-next-20150831 #1154 Not tainted
> >> > [   12.019050] -------------------------------
> >> > [   12.023408] security/device_cgroup.c:405 device_cgroup:verify_new=
_ex called without proper synchronization!
> >> > [   12.033576] other info that might help us debug this:
> >> >
> >> > [   12.041942] rcu_scheduler_active =3D 1, debug_locks =3D 0
> >> > [   12.048796] 4 locks held by systemd/1:
> >> > [   12.052700]  #0:  (sb_writers#7){.+.+.+}, at: [<c017af84>] __sb_s=
tart_write+0x8c/0xb0
> >> > [   12.060954]  #1:  (&of->mutex){+.+.+.}, at: [<c01f1600>] kernfs_f=
op_write+0x50/0x1b8
> >> > [   12.069085]  #2:  (s_active#30){++++.+}, at: [<c01f1608>] kernfs_=
fop_write+0x58/0x1b8
> >> > [   12.077310]  #3:  (devcgroup_mutex){+.+...}, at: [<c0317bfc>] dev=
cgroup_access_write+0x20/0x658
> >> > [   12.086575] stack backtrace:
> >> > [   12.091124] CPU: 0 PID: 1 Comm: systemd Not tainted 4.2.0-next-20=
150831 #1154
> >> > [   12.098609] Hardware name: Generic AM43 (Flattened Device Tree)
> >> > [   12.104807] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (sh=
ow_stack+0x10/0x14)
> >> > [   12.112924] [<c0013a58>] (show_stack) from [<c034f014>] (dump_sta=
ck+0x84/0x9c)
> >> > [   12.120491] [<c034f014>] (dump_stack) from [<c0317a04>] (verify_n=
ew_ex+0xc4/0xdc)
> >> > [   12.128326] [<c0317a04>] (verify_new_ex) from [<c0317f50>] (devcg=
roup_access_write+0x374/0x658)
> >> > [   12.137426] [<c0317f50>] (devcgroup_access_write) from [<c00d2800=
>] (cgroup_file_write+0x28/0x1bc)
> >> > [   12.146796] [<c00d2800>] (cgroup_file_write) from [<c01f1670>] (k=
ernfs_fop_write+0xc0/0x1b8)
> >> > [   12.155620] [<c01f1670>] (kernfs_fop_write) from [<c0177c94>] (__=
vfs_write+0x1c/0xd8)
> >> > [   12.163783] [<c0177c94>] (__vfs_write) from [<c0178594>] (vfs_wri=
te+0x90/0x16c)
> >> > [   12.171426] [<c0178594>] (vfs_write) from [<c0178db4>] (SyS_write=
+0x44/0x9c)
> >> > [   12.178806] [<c0178db4>] (SyS_write) from [<c000f680>] (ret_fast_=
syscall+0x0/0x1c)
> >> >
> >> > Fix it by making sure rcu_read_lock() is held
> >> > around devcgroup_update_access().
> >>
> >> With this patch applied I got the following:
> >>
> >> [    4.079102] BUG: sleeping function called from invalid context at m=
m/slub.c:1266
> >> [    4.079105] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: syste=
md
> >
> > that didn't trigger here. maybe I didn't have lock debugging enabled.
> > I'll have a look.
>=20
> Did you happen to get a chance to poke further?  I'm seeing the
> original splat on all my machines as well.

in today's TODO.

--=20
balbi

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5vHoAAoJEIaOsuA1yqREWTAP/1pOuXxYXRZenMSiTeQagcn6
wP4ZxneSmpnPb+1zfnws3DcILK7GDnv6CkrfUxOIxVMj/zAbwRXZMXROnXQSqNVM
hRmrcd1kXD7iDC8XRjH3DO28vNc76rWxx2ObocAx/XiLRgzUSJKkzMSAbytER9cp
PlOcfkDvGsgBGJZ0jXE8EoUmS3V8PEpbDLbSjJ7Kb4eexLidEYZWgy+lnHOxhlLs
Qu+s/X/pKGQY8ol7lAcqzwUjY8+8LxKLldYw7CHKVxb9IRsOE3evmWUuPn4PS0xc
DAPNQxzedNV0T6dMKC4zH1Mx6yshmhaqzU/lCvQDSZGm/v8h0WYBlT1oaW/1Bl1A
2GuEXPUzB0FbNeBol4MGsarxybURWKMbJ0+/zeCWff14gH7Mht61D1MIcc8MKSap
GK0MMcCV2jSfYY1pAyhJxzYO1IGEMHRHD6bJPTGaz5nkIONMq5N1Iv0BkUDH5t3w
Rq9bu4tzre6x8SvGHSZ4W2m264Y0deT5s3aT5p6oRxMJXhxIQRyfB7y9adZT9CzZ
Oo7oEtHNomY3geVA6Kxzlt0uYQdjwjQx/JBIDizbne/i0XsAN3+NOl7LVOkGgArJ
zQW62R/ucacpYEQiQHUUvQjafqR+VjLu/8btaSq1QkmZzVpuQZfYnj5EkdL2jhpI
uFIOd7UgjTesZ0sjjRN5
=GxT8
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
