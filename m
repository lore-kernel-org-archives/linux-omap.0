From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: problems compiling Das u-Boot 1.1.4 for omap osk 5912
Date: Thu, 11 May 2006 13:50:25 -0700
Message-ID: <ae36f8040605111350u3ba2c1b6r1dc856db29aa3c87@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty

Hi, i'm encountering the following problem to compile u-boot 1.1.4
UNDEF_SYM=3D`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
lib_arm/libarm.a fs/cramfs/libcramfs.a
fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a
disk/libdisk.a rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a
drivers/sk98lin/libsk98lin.a post/libpost.a post/cpu/libcpu.a
common/libcommon.a |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstatic -T
/home/lvcargnini/puc/instramed/u-boot-1.1.4/board/omap5912osk/u-boot.lds
-Ttext 0x11080000  $UNDEF_SYM cpu/arm926ejs/start.o \
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a cpu/arm926ejs/libarm926ejs.a
lib_arm/libarm.a fs/cramfs/libcramfs.a fs/fat/libfat.a
fs/fdos/libfdos.a fs/jffs2/libjffs2.a fs/reiserfs/libreiserfs.a
fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a rtc/librtc.a
dtt/libdtt.a drivers/libdrivers.a drivers/sk98lin/libsk98lin.a
post/libpost.a post/cpu/libcpu.a common/libcommon.a --end-group -L
/opt/omap-linux/lib/gcc/arm-linux/4.0.3 -lgcc \
                -Map u-boot.map -o u-boot
arm-linux-ld: ERROR:
/opt/omap-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/omap-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_divsi3.o)
arm-linux-ld: ERROR:
/opt/omap-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o) uses
hardware FP, whereas u-boot uses software FP
arm-linux-ld: failed to merge target specific data of file
/opt/omap-linux/lib/gcc/arm-linux/4.0.3/libgcc.a(_modsi3.o)
lib_arm/libarm.a(board.o): In function `start_armboot':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/lib_arm/board.c:236:
undefined reference to `flash_init'
common/libcommon.a(cmd_bootm.o): In function `do_imls':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_bootm.c:1160:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `abbrev_spec':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:106:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `addr_spec':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:195:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_fill_sect_ranges':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:278:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flinfo':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:292:
undefined reference to `flash_print_info'
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:304:
undefined reference to `flash_print_info'
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:306:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_erase':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:432:
undefined reference to `flash_erase'
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:442:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flerase':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:385:
undefined reference to `flash_erase'
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:401:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_protect':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:671:
undefined reference to `flash_info'
common/libcommon.a(cmd_flash.o): In function `do_protect':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/cmd_flash.c:617:
undefined reference to `flash_info'
common/libcommon.a(flash.o): In function `addr2info':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/flash.c:122:
undefined reference to `flash_info'
common/libcommon.a(flash.o): In function `flash_write':
/home/lvcargnini/puc/instramed/u-boot-1.1.4/common/flash.c:177:
undefined reference to `write_buff'
make: *** [u-boot] Error 1
