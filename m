From: =?iso-8859-2?q?Micha=B3_Szabat?= <michal611@interia.pl>
Subject: error compiling U-boot-1.1.4  R_ARM_PLT32 __div0
Date: 19 Feb 2006 23:34:08 +0100
Message-ID: <20060219223408.5869BF61E8@poczta.interia.pl>
Mime-Version: 1.0
Content-Type: TEXT/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

=0AHello.=0AI want to compile  U-boot-1.1.4 with toolchine arm-linux-gcc-3.=
4.1 and i have a error=0A...=0Acommon/libcommon.a(flash.o)(.text 0x150): In=
 function `addr2info':=0A/usr/src/u-boot-1.1.4/common/flash.c:122: undefine=
d reference to `flash_info'=0Acommon/libcommon.a(flash.o)(.text 0x2a8): In =
function `flash_write':=0A/usr/src/u-boot-1.1.4/common/flash.c:177: undefin=
ed reference to `write_buff'=0Alib_arm/libarm.a(_umodsi3.o)(.text 0xa8):/us=
r/src/u-boot-1.1.4/lib_arm/_umodsi3. S:79: relocation truncated to fit: R_A=
RM_PLT32 __div0=0A/opt/3.4.1/bin/../lib/gcc/arm-linux/3.4.1/libgcc.a(_divsi=
3.oS)(.text 0x11c):/wor k/crosstool-0.27/build/arm-linux/gcc-3.4.1-glibc-2.=
3.2/gcc-3.4.1/gcc/config/arm/ lib1funcs.asm:735: relocation truncated to fi=
t: R_ARM_PLT32 __div0=0A/opt/3.4.1/bin/../lib/gcc/arm-linux/3.4.1/libgcc.a(=
_modsi3.oS)(.text 0xd8):/work /crosstool-0.27/build/arm-linux/gcc-3.4.1-gli=
bc-2.3.2/gcc-3.4.1/gcc/config/arm/l ib1funcs.asm:795: relocation truncated =
to fit: R_ARM_PLT32 __div0=0Amake: *** [u-boot] B=B3=B1d 1=0AWhat can i do =
with this?=0AI found a patch for binutils for u-boot-1.1.2 like that =0A%u2=
014%u2014%u2014%u2014%u2014%u2014%u2014- from CodeSourcery %u2014%u2014%u20=
14%u2014%u2014%u2014%u2014%u2014%u2014%u2014=0A%u2014 bfd/elf32-arm.h.orig =
2004-04-22 22:11:15.000000000 -0400=0A    bfd/elf32-arm.h 2004-04-22 22:28:=
37.000000000 -0400=0A@@ -2229,6  2229,8 elf32_arm_relocate_section (output_=
bfd,=0Acase R_ARM_PC24:=0Acase R_ARM_ABS32:=0Acase R_ARM_THM_PC22:=0A  case=
 R_ARM_PLT32:=0A =0Aif (info->shared=0A&& (=0A(!info->symbolic && h->dynind=
x !=3D -1)=0A@@ -2262,11  2264,6 elf32_arm_relocate_section (output_bfd,=0A=
relocation =3D 0;=0Abreak;=0A- case R_ARM_PLT32:=0A- if (h->plt.offset !=3D=
 (bfd_vma)-1)=0A- relocation =3D 0;=0A- break;=0A-=0Adefault:=0Aif (unresol=
ved_reloc)=0A_bfd_error_handler=0A%u2014%u2014%u2014%u2014%u2014%u2014%u201=
4%u2014%u2014%u2014%u2014%u2014%u2013 end patch %u2014%u2014%u2014%u2014%u2=
014%u2014%u2014-=0AI don't know if it's good, and I don't know how to use i=
t.=0ASomebody help me?=0A=0ARegards, Micha=B3 Szabat =0A

----------------------------------------------------------------------
Kliknij po wiecej! >>> http://link.interia.pl/f18ed
