From: "Djordje Nijemcevic" <chief@verat.net>
Subject: U-boot 1.1.4 compilation problem
Date: Wed, 1 Mar 2006 16:46:06 +0100 (CET)
Message-ID: <9212.212.62.63.198.1141227966.squirrel@webmail.verat.net>
References: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
Reply-To: chief@verat.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060301.175750.92583404.kaminaga@sm.sony.co.jp>
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

Hello,
I have problem compiling U-boot 1.1.4.

The report looks like following:
------------------------------------------------------------------
arm-linux-ld -Bstatic -T
/mnt/downloads/u-boot-1.1.4/board/omap5912osk/u-boot.lds -Ttext 0x11080000
 $UNDEF_SYM cpu/arm926ejs/start.o \
                --start-group lib_generic/libgeneric.a
board/omap5912osk/libomap5912osk.a
cpu/arm926ejs/libarm926ejs.a lib_arm/libarm.a
fs/cramfs/libcramfs.a fs/fat/libfat.a fs/fdos/libfdos.a
fs/jffs2/libjffs2.a fs/reiserfs/libreiserfs.a
fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a
drivers/sk98lin/libsk98lin.a post/libpost.a
post/cpu/libcpu.a common/libcommon.a --end-group -L
/usr/local/lib/gcc/arm-linux/3.4.5 -lgcc \
                -Map u-boot.map -o u-boot
lib_arm/libarm.a(board.o): In function `start_armboot':
/mnt/downloads/u-boot-1.1.4/lib_arm/board.c:236: undefined reference to
`flash_init'
common/libcommon.a(cmd_bootm.o): In function `do_imls':
/mnt/downloads/u-boot-1.1.4/common/cmd_bootm.c:1160: undefined reference
to `flash_info'
common/libcommon.a(cmd_flash.o): In function `abbrev_spec':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:106: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `addr_spec':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:195: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_fill_sect_ranges':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:278: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flinfo':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:292: undefined reference to
`flash_print_info'
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:304: undefined reference to
`flash_print_info'
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:306: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_erase':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:432: undefined reference to
`flash_erase'
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:442: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `do_flerase':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:385: undefined reference to
`flash_erase'
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:401: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `flash_sect_protect':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:671: undefined reference to
`flash_info'
common/libcommon.a(cmd_flash.o): In function `do_protect':
/mnt/downloads/u-boot-1.1.4/common/cmd_flash.c:617: undefined reference to
`flash_info'
common/libcommon.a(flash.o): In function `addr2info':
/mnt/downloads/u-boot-1.1.4/common/flash.c:122: undefined reference to
`flash_info'
common/libcommon.a(flash.o): In function `flash_write':
/mnt/downloads/u-boot-1.1.4/common/flash.c:177: undefined reference to
`write_buff'
make: *** [u-boot] Error 1
------------------------------------------------------------

Can someone help?
I know that there should be a patch for omap5912osk.h that solves the
problem, but I can't find it...

Thanks
Djordje
