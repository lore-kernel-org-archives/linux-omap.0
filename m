From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems compiling Das u-Boot 1.1.4 for omap osk 5912
Date: Thu, 11 May 2006 18:50:06 -0300
Message-ID: <ae36f8040605111450l72b35621v274d4e2cb7f6c1bb@mail.gmail.com>
References: <ae36f8040605111350u3ba2c1b6r1dc856db29aa3c87@mail.gmail.com>
	<200605112305.17157.sr@denx.de>
	<ae36f8040605111414i1ed662c3o85e3fdfb805b3adc@mail.gmail.com>
	<ae36f8040605111439u690e08bbu7d6fdc876d99e597@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040605111439u690e08bbu7d6fdc876d99e597@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

hi after downloaded the git tree version i try to compilate it and i
received the following :

make[1]: Leaving directory `/home/lvcargnini/puc/instramed/u-boot.git
/common'
UNDEF_SYM=3D`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstamake[1]: Leaving directory
`/home/lvcargnini/puc/instramed/u-boot.git/common'
UNDEF_SYM=3D`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstatic -T /home/lvcargnini/puc/instramed/u-boot.git
/board/omap5912osk/u-boot.lds -Ttext 0x11080000  -marmelf_linux $UNDEF_SYM
cpu/arm926ejs/start.o \
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  --end-group -L
/opt/arm-linux/lib/gcc/arm-linux/4.0.3 -lgcc \
                -Map u-boot.map -o u-boot
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o)
tic -T /home/lvcargnini/puc/instramed/u-boot.git/board/omap5912osk/u-
boot.lds -Ttext 0x11080000  -marmelf_linux $UNDEF_SYM cpu/arm926ejs/start.o
\
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  --end-group -L
/opt/arm-linux/lib/gcc/arm-linux/4.0.3 -lgcc \
                -Map u-boot.map -o u-boot
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o)


and withou -marm_linux the following:

make[1]: Leaving directory `/home/lvcargnini/puc/instramed/u-boot.git
/common'
UNDEF_SYM=3D`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstatic -T /home/lvcargnini/puc/instramed/u-boot.git
/board/omap5912osk/u-boot.lds -Ttext 0x11080000  $UNDEF_SYM
cpu/arm926ejs/start.o \
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
cpu/arm926ejs/omap/libomap.a lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/nand/libnand.a
drivers/nand_legacy/libnand_legacy.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a  --end-group -L
/opt/arm-linux/lib/gcc/arm-linux/4.0.3 -lgcc \
                -Map u-boot.map -o u-boot
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o) uses hardware FP=
,
whereas u-boot uses
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o) uses hardware FP=
,
whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o)

linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o)
make: *** [u-boot] Error 1



On 5/11/06, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> Hi i tried the following :
>
> cg-clone rsync://www.denx.de/git/u-boot.git u-boot/
>
>
>
> On 5/11/06, Lu=EDs Cargnini < lvcargnini@gmail.com> wrote:
> >
> > On 5/11/06, Stefan Roese < sr@denx.de> wrote:
> > Please what is the git tree of u-boot, to i could get it
> > thanks, for the ASAP answers.
> > > On Thursday 11 May 2006 22:50, Lu=EDs Cargnini wrote:
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > --
> > Thanks && Regards
> > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Mastering Degree student @ PUC-RS Electrical Engineer Faculty
> >
>
>
>
> --
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
>



--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
