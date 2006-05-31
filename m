From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Fwd: booting process
Date: Wed, 31 May 2006 19:30:42 -0300
Message-ID: <ae36f8040605311530j7ea098f5q2a28f5968fec3d4e@mail.gmail.com>
References: <14ACE099F888004586603AEC0A559C2E133F4C@DLEE09.ent.ti.com>
	<ae36f8040605311447r6a010a5fn3bd0ea9d46f6914b@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040605311447r6a010a5fn3bd0ea9d46f6914b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

After Mr. Luis Ries asked me i published the last e-mails exchanged
with "Menon, Nishanth"  on list

---------- Forwarded message ----------
From: Lu=EDs Cargnini <lvcargnini@gmail.com>
Date: May 31, 2006 6:47 PM
Subject: Re: booting process
To: "Menon, Nishanth" <x0nishan@ti.com>

i did it and this happened

Skipping reset check for DSP domain clock "dspper_ck"
jffs2_scan_eraseblock(): Node at 0x00dc0000 {0x1985, 0x2001,
0x00000008) has invalid CRC 0x640620a0 (calculated 0x26b486ed)
 jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at
0x00dc0004: 0x0008 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0008:
0x20a0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc000c:
0x0001 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0014:
0x0002 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0024:
0x8355 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0028:
0x0002 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc002c:
0x0984 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0030:
0x0044 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00dc0034:
0x6900 instead
Further such events for this erase block will not be printed
Old JFFS2 bitmask found at 0x00dc0964
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00dc4c4c
You cannot use older JFFS2 filesystems with newer kernels
jffs2_scan_eraseblock(): Node at 0x00de0000 {0x1985, 0x2002,
0x00000004) has invalid CRC 0xc004b0b1 (calculated 0xeaf64bfb)
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0004:
0x0004 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0008:
0xb0b1 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de000c:
0x0001 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0010:
0x0010 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0014:
0x818c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0018:
0x0008 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de001c:
0x0024 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0020:
0x00e0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00de0028:
0x0020 instead
Further such events for this erase block will not be printed
Old JFFS2 bitmask found at 0x00de0e3c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00de6a24
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00deaa40
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00dedde4
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00df8684
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00dff8f8
You cannot use older JFFS2 filesystems with newer kernels
jffs2_scan_eraseblock(): Node at 0x00e00000 {0x1985, 0x2002,
0x00000000) has invalid CRC 0xe40c00a1 (calculated 0x6594dcac)
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00008:
0x00a1 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e0000c:
0x0001 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00010:
0x0044 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00014:
0x81e8 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00018:
0x0008 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e0001c:
0x002c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00020:
0x00e0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e00028:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e0002c:
0xa105 instead
Further such events for this erase block will not be printed
Old JFFS2 bitmask found at 0x00e03d20
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e0b9d4
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e0cc7c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e11320
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e1e578
You cannot use older JFFS2 filesystems with newer kernels
jffs2_scan_eraseblock(): Node at 0x00e20000 {0x1985, 0x2002,
0x00000000) has invalid CRC 0x000cb010 (calculated 0x6594dcac)
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20008:
0xb010 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e2000c:
0x0005 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20010:
0x0001 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20014:
0x0080 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20018:
0x0040 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e2001c:
0x0002 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20020:
0x8020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e20028:
0x0460 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e2002c:
0x2000 instead
Further such events for this erase block will not be printed
Old JFFS2 bitmask found at 0x00e21a7c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e21c90
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e22238
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e2323c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e23f50
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e23ffc
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e2617c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e31804
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e3c9a0
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e3f450
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e3f748
You cannot use older JFFS2 filesystems with newer kernels
jffs2_scan_eraseblock(): Node at 0x00e40000 {0x1985, 0x2002,
0x0000000c) has invalid CRC 0xa00e0090 (calculated 0x2f426314)
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40004:
0x000c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40008:
0x0090 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e4000c:
0x0084 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40014:
0x81a0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40018:
0x00a0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e4001c:
0x0003 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40020:
0x00c0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40024:
0x2ef0 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00e40028:
0x0810 instead
Further such events for this erase block will not be printed
Old JFFS2 bitmask found at 0x00e41f1c
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e426ac
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e442d4
You cannot use older JFFS2 filesystems with newer kernels
Old JFFS2 bitmask found at 0x00e46c60
You cannot use older JFFS2 filesystems with newer kernels
VFS: Mounted root (jffs2 filesystem).
Freeing init memory: 108K
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init=3D option to k=
ernel.

now what could be ?


 On 5/31/06, Menon, Nishanth <x0nishan@ti.com> wrote:
>
>
>
>
>
> I use somethin like this: setenv bootargs mem=3D32M console=3DttyS0,11520=
0n8 noinitrd root=3D/dev/mtdblock4 rootfstype=3Djffs2 devfs=3Dmount
>
>
>
> Maybe even, edit the .config and modify the CONFIG_CMDLINE to this.
>
>
>
> This might work for u=85 and I think the partition is mtdblock3=85
>
>
>
> Regds,
>
> nm
>
>
>   ________________________________


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
