From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: problems compiling u-Boot 1.1.4 (2)
Date: Wed, 15 Feb 2006 22:01:10 +0000
Message-ID: <ae36f8040602151401j4776aaccge3bd4818a95c60c5@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

this lines deescribes the problem occured (after error message i wrote
more informations):

make[1]: Leaving directory `/root/instramed/u-boot-1.1.4/common'
UNDEF_SYM=3D`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
lib_arm/libarm.a fs/cramfs/libcramfs.a fs/fat/libfat.a
fs/fdos/libfdos.a fs/jffs2/libjffs2.a fs/reiserfs/libreiserfs.a
fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a rtc/librtc.a
dtt/libdtt.a drivers/libdrivers.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstatic -T
/root/instramed/u-boot-1.1.4/board/omap5912osk/u-boot.lds -Ttext
0x11080000  $UNDEF_SYM cpu/arm926ejs/start.o \
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
lib_arm/libarm.a fs/cramfs/libcramfs.a fs/fat/libfat.a
fs/fdos/libfdos.a fs/jffs2/libjffs2.a fs/reiserfs/libreiserfs.a
fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a rtc/librtc.a
dtt/libdtt.a drivers/libdrivers.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a --end-group -L
/opt/arm-linux/lib/gcc/arm-linux/4.0.2 -lgcc \
                -Map u-boot.map -o u-boot
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_divsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_modsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_modsi3.o)
lib_arm/libarm.a(board.o): In function `start_armboot':
/root/instramed/u-boot-1.1.4/lib_arm/board.c:236: undefined reference
to `flash_init'
common/libcommon.a(cmd_bootm.o): In function `do_imls':
/root/instramed/u-boot-1.1.4/common/cmd_bootm.c:1160: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `abbrev_spec':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:106: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `addr_spec':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:195: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_fill_sect_ranges':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:278: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flinfo':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:292: undefined
reference to `flash_print_info'
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:304: undefined
reference to `flash_print_info'
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:306: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_erase':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:432: undefined
reference to `flash_erase'
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:442: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flerase':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:385: undefined
reference to `flash_erase'
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:401: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_protect':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:671: undefined
reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_protect':
/root/instramed/u-boot-1.1.4/common/cmd_flash.c:617: undefined
reference to `flash_info'
common/libcommon.a(flash.o): In function `addr2info':
/root/instramed/u-boot-1.1.4/common/flash.c:122: undefined reference
to `flash_info'
common/libcommon.a(flash.o): In function `flash_write':
/root/instramed/u-boot-1.1.4/common/flash.c:177: undefined reference
to `write_buff'
make: *** [u-boot] Error 1




someone know something about thi error in linker:

arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_divsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_modsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/arm-linux/lib/gcc/arm-linux/4.0.2/libgcc.a(_modsi3.o)
lib_arm/libarm.a(board.o): In function `start_armboot':




--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
