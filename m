From: "Bhaskara Rao Kotla" <bhaskar12@gmail.com>
Subject: getting error while building opensource u-boot
Date: Fri, 5 Jan 2007 10:25:26 -0600
Message-ID: <1c5b04b60701050825w76dcc83x98710765846fc712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,
   I am trying to build opensource u-boot from the below location
http://linux.omap.com/pub/bootloader/2430sdp/source/u-boot-SEP1106.tar.gz
and followed below three steps

export CROSS_COMPILE=arm-linux-
make mrproper
make omap2430sdp_config
make

after doing this iam getting below errors...

##############################################
make[1]: Leaving directory
`/data/omap_development/Bhaskar/temp/Opensource/u-boot/common'
UNDEF_SYM=`arm-linux-objdump -x lib_generic/libgeneric.a
board/omap2430sdp/libomap2430sdp.a cpu/arm1136/libarm1136.a lib_arm/libarm.a
fs/cramfs/libcramfs.a fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/onenand/libonenand.a
drivers/nand/libnand.a drivers/nand_legacy/libnand_legacy.a
drivers/sk98lin/libsk98lin.a post/libpost.a post/cpu/libcpu.a
common/libcommon.a  |sed  -n -e
's/.*\(__u_boot_cmd_.*\)/-u\1/p'|sort|uniq`;\
        arm-linux-ld -Bstatic -T
/data/omap_development/Bhaskar/temp/Opensource/u-boot/board/omap2430sdp/u-
boot.lds -Ttext 0x80e80000  $UNDEF_SYM cpu/arm1136/start.o \
                --start-group lib_generic/libgeneric.a
board/omap2430sdp/libomap2430sdp.a cpu/arm1136/libarm1136.a lib_arm/libarm.a
fs/cramfs/libcramfs.a fs/fat/libfat.a fs/fdos/libfdos.a fs/jffs2/libjffs2.a
fs/reiserfs/libreiserfs.a fs/ext2/libext2fs.a net/libnet.a disk/libdisk.a
rtc/librtc.a dtt/libdtt.a drivers/libdrivers.a drivers/onenand/libonenand.a
drivers/nand/libnand.a drivers/nand_legacy/libnand_legacy.a
drivers/sk98lin/libsk98lin.a post/libpost.a post/cpu/libcpu.a
common/libcommon.a  --end-group -L
/data/omapts/linux/arm-tc/gcc-3.4.0/bin/../lib/gcc/arm-linux/3.4.0
-lgcc \
                -Map u-boot.map -o u-boot
lib_arm/libarm.a(_udivsi3.o)(.text+0x8c):/data/omap_development/Bhaskar/temp/Opensource/u-boot/lib_arm/_udivsi3.S:67:
relocation truncated to fit: R_ARM_PLT32 __div0
lib_arm/libarm.a(_umodsi3.o)(.text+0xa8):/data/omap_development/Bhaskar/temp/Opensource/u-boot/lib_arm/_umodsi3.S:79:
relocation truncated to fit: R_ARM_PLT32 __div0
make: *** [u-boot] Error 1
##########################################################################

Can someone tell me what's going wrong or am i doing anything wrong?
Note: I am going to use it for OMAP2430 SDP V2.9 and V4.1 boards.

Thanks,
Regards,
Bhaskara
