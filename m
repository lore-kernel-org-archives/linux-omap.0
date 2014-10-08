From: Felipe Balbi <balbi@ti.com>
Subject: BUG (maybe) with find_get_entry()
Date: Wed, 8 Oct 2014 11:57:14 -0500
Message-ID: <20141008165714.GG22688@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbaJHQ5t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Oct 2014 12:57:49 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

With today's linus/master and with greg/usb-next I keep getting random
kernel oops from find_get_entry() (see below):

[   47.700065] Unable to handle kernel paging request at virtual address ff=
ffffff
[   47.707667] pgd =3D c0004000
[   47.710506] [ffffffff] *pgd=3Dae7f6821, *pte=3D00000000, *ppte=3D00000000
[   47.717135] Internal error: Oops: 17 [#1] SMP ARM
[   47.722047] Modules linked in: g_mass_storage usb_f_mass_storage libcomp=
osite configfs xhci_plat_hcd xhci_hcd snd_soc_davinci_mcasp snd_soc_edma sn=
d_soc_omap snd_soc_evm snd_soc_tlv320aic3x dwc3 snd_soc_core snd_compress o=
mapdrm snd_pcm_dmaengine snd_pcm snd_timer snd fb_sys_fops lis3lv02d_i2c pa=
nel_dpi matrix_keypad lis3lv02d dwc3_omap input_polldev soundcore
[   47.755668] CPU: 0 PID: 1440 Comm: file-storage Not tainted 3.17.0-02899=
-ga7d2165 #229
[   47.763958] task: ed1b22c0 ti: ed20e000 task.ti: ed20e000
[   47.769609] PC is at find_get_entry+0x64/0x100
[   47.774281] LR is at 0xfffffffa
[   47.777590] pc : [<c01065b4>]    lr : [<fffffffa>]    psr: a00f0013
[   47.777590] sp : ed20fc80  ip : 00000000  fp : ed20fcb4
[   47.789564] r10: 600f0013  r9 : c014c854  r8 : 00000004
[   47.795031] r7 : ec1909b8  r6 : 00000001  r5 : 00000000  r4 : ec190880
[   47.801837] r3 : ed20fc6c  r2 : 00000000  r1 : 00000004  r0 : ffffffff
[   47.808640] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[   47.816251] Control: 10c5387d  Table: ad768059  DAC: 00000015
[   47.822237] Process file-storage (pid: 1440, stack limit =3D 0xed20e248)
[   47.829034] Stack: (0xed20fc80 to 0xed210000)
[   47.833585] fc80: 00000000 00000000 c0106550 00000000 ed20fcf8 ec190880 =
ec1909b4 00000004
[   47.842119] fca0: 00000004 ec19090c ed20fcd4 ed20fcb8 c010716c c010655c =
00013ef0 ec190880
[   47.850657] fcc0: 00000000 00000002 ed20fd4c ed20fcd8 c011df94 c0107150 =
00000006 ed1b22c0
[   47.859183] fce0: c014c854 600f0013 ed20fd1c ed20fcf8 00000002 ed20fd84 =
000000d0 00000000
[   47.867707] fd00: 00004000 00000000 00000000 ec1909b4 00000004 c011efd0 =
c0089b64 c00899dc
[   47.876241] fd20: ec190880 ec190880 00000000 00000000 00000004 ec19090c =
c014c854 600f0013
[   47.884761] fd40: ed20fdb4 ed20fd50 c011efd0 c011df08 000200da 00000000 =
c014c854 bf2047f8
[   47.893280] fd60: 00000005 ed721e80 ed20fde0 ec1909b4 00000002 ed1b22c0 =
ed20fdcc 00000000
[   47.901816] fd80: ed20fdb4 00000000 c0089a3c 00004000 00000000 ed20fe80 =
ed721e80 ed1b22c0
[   47.910340] fda0: 00000000 00004000 ed20fe3c ed20fdb8 c014c854 c011eed4 =
00004000 00004000
[   47.918866] fdc0: ed20fdf4 ec504000 00004000 00000002 00000000 00004000 =
ed20fdc4 00000001
[   47.927387] fde0: ed721e80 00000000 00000000 00000000 ed1b22c0 00000000 =
00000000 00000000
[   47.935922] fe00: 00004000 00000000 00004000 00000000 00000000 00000000 =
ec504000 ed721e80
[   47.944452] fe20: ec504000 ed20fe80 ed73ec00 00004000 ed20fe6c ed20fe40 =
c014d054 c014c7bc
[   47.952984] fe40: ed20fe6c ed20fe50 ed2769e0 ed2bf104 ed2bf000 ed73ec00 =
00004000 00000000
[   47.961505] fe60: ed20feb4 ed20fe70 bf2b57cc c014cfc8 3732333d ed20e000 =
00004000 00000000
[   47.970032] fe80: 00004000 00000000 00000000 ed2bf000 ed2769c0 00000000 =
ed2bf038 ed2bf000
[   47.978575] fea0: ed20e038 ed2bf07c ed20ff24 ed20feb8 bf2b6a08 bf2b56b8 =
00000001 c00899dc
[   47.987100] fec0: a00f0013 ed401bd4 00000000 00052000 00000000 ed20fee0 =
c0089c50 c0089a70
[   47.995631] fee0: ed20ff04 ed20fef0 c064f3a4 ed276840 00000000 ed2bf000 =
bf2b6244 ed276840
[   48.004154] ff00: 00000000 ed2bf000 bf2b6244 00000000 00000000 00000000 =
ed20ffac ed20ff28
[   48.012683] ff20: c0065bdc bf2b6250 c0089c50 00000000 ed20ff54 ed2bf000 =
00000000 00000000
[   48.021204] ff40: dead4ead ffffffff ffffffff c0a8a238 00000000 00000000 =
c08070f8 ed20ff5c
[   48.029735] ff60: ed20ff5c 00000000 00000000 dead4ead ffffffff ffffffff =
c0a8a238 00000000
[   48.038265] ff80: 00000000 c08070f8 ed20ff88 ed20ff88 ed276840 c0065af8 =
00000000 00000000
[   48.046785] ffa0: 00000000 ed20ffb0 c000eea8 c0065b04 00000000 00000000 =
00000000 00000000
[   48.055307] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[   48.063837] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
ebfffffe e89da830
[   48.072389] [<c01065b4>] (find_get_entry) from [<c010716c>] (find_lock_e=
ntry+0x28/0x7c)
[   48.080753] [<c010716c>] (find_lock_entry) from [<c011df94>] (shmem_getp=
age_gfp+0x98/0x7f8)
[   48.089469] [<c011df94>] (shmem_getpage_gfp) from [<c011efd0>] (shmem_fi=
le_read_iter+0x108/0x3a0)
[   48.098731] [<c011efd0>] (shmem_file_read_iter) from [<c014c854>] (new_s=
ync_read+0xa4/0xcc)
[   48.107435] [<c014c854>] (new_sync_read) from [<c014d054>] (vfs_read+0x9=
8/0x158)
[   48.115189] [<c014d054>] (vfs_read) from [<bf2b57cc>] (do_read+0x120/0x2=
c8 [usb_f_mass_storage])
[   48.124382] [<bf2b57cc>] (do_read [usb_f_mass_storage]) from [<bf2b6a08>=
] (fsg_main_thread+0x7c4/0x13f8 [usb_f_mass_storage])
[   48.136199] [<bf2b6a08>] (fsg_main_thread [usb_f_mass_storage]) from [<c=
0065bdc>] (kthread+0xe4/0x100)
[   48.145919] [<c0065bdc>] (kthread) from [<c000eea8>] (ret_from_fork+0x14=
/0x20)
[   48.153446] Code: e1a01008 eb08abbe e3500000 0a00001b (e5904000)=20
[   48.159912] ---[ end trace 085ec657b3a800cd ]---

I can reproduce this exact Oops with g_mass_storage running on two
different boards (one with Cortex A8 and the other with Cortex A9) with
either tmpfs or mmc as backing store. I don't remember seeing this when
I was testing my pull request to be sent for Greg's next branch.

I'll see if v3.17 also fails with my current setup...
=2E.. alright v3.17 also fails here.

--=20
balbi

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNWzqAAoJEIaOsuA1yqREOKoP+wWmqLUBMVFWSmQ0KHh+LeaJ
KIg2rDJJyUY9sxO+KGyGmggZUJMIA7NPagcistDGX/GLtr2b28O84K0Neq36tJed
dHPPjkGXyh0E0hKa0i1lgAGH12onvodwmW8Xkgm9E6qiqoAxSHBEEOBUo2Ej9JCF
8pAmPf2ukMGMOvEk9HKv8AHxDxJ9N4/3mQNxENVme3Ad6Wita4yZBdXVXRbFRrxP
lEmKzECMUWcbDbpJ8gRM6muSTtQHX9pzDvzlGO0V2p6UgDyHN0cCQpZ6mOeNdJ6D
Ba3QXNgg0/7y92z1Bs8seFIRKWtuiI2MuPevOseDpWAsBr2uGOpl/fOHtbaKI30s
7QHDf4v32FbP3EAs+GHYnnAdGdvYSwIK/ezetZ1iO6geJpieUp96z4jkLVxvNoRa
HMSJiG5ZBvc+/xkB+MD6hvsf9ooDp+/rWBCUa50JV8S/JewH943shv015wzl3XLz
K6oYbViDiSMwaFRT21d0bgXxX5dlce8t1KTqtIx16ug8qKskZMTZY/FqqH4FGfkM
y7apZK1SakoKc+VnPQAWrJvB8h0K3l0SRkiFUILAlRDJPAVV1CVNfe6Kvmsai+VO
AwT3W+f0gd1vtD9xaoKt0PXe6zArpe9RfLni1B5pVLpzUTx2gzXQKU6wsg9HvKXL
nhT5G49HpDlDJBSgIqED
=JpPA
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
