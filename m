From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: SOLVED-+upgraded toolchain with gcc-4.0.2
Date: Tue, 14 Feb 2006 02:22:40 +0000
Message-ID: <ae36f8040602131822i33a17b6dl@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi after some e-mails among list me and Vineet Tuli i have generated a
toolchain for omap. But i have made some changes
i have created a new toolchain with following tools:
binutils-2.16.1
gcc-4.0.2
glibc-2.3.6 (+glibc-linuxthreads)

some changes in glibc were nececssary, following the patches for glibc-2.3.=
6:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -r -u glibc-2.3.6/Makeconfig glibc-2.3.6-patched/Makeconfig
--- glibc-2.3.6/Makeconfig=092005-02-16 10:50:19.000000000 +0000
+++ glibc-2.3.6-patched/Makeconfig=092006-02-14 00:23:58.650233320 +0000
@@ -503,12 +503,12 @@
   libunwind =3D -lunwind
 endif
 ifneq ($(have-as-needed),yes)
- libgcc_eh :=3D -lgcc_eh $(libunwind)
+ libgcc_eh :=3D $(libunwind)
 else
  libgcc_eh :=3D -Wl,--as-needed -lgcc_s$(libgcc_s_suffix) $(libunwind)
-Wl,--no-as-needed
 endif
 gnulib :=3D -lgcc $(libgcc_eh)
-static-gnulib :=3D -lgcc -lgcc_eh $(libunwind)
+static-gnulib :=3D -lgcc $(libunwind)
 libc.so-gnulib :=3D -lgcc
 endif
 ifeq ($(elf),yes)
Only in glibc-2.3.6-patched/: autom4te.cache
diff -r -u glibc-2.3.6/configure glibc-2.3.6-patched/configure
--- glibc-2.3.6/configure=092005-11-04 00:37:15.000000000 +0000
+++ glibc-2.3.6-patched/configure=092006-02-14 00:24:49.436512632 +0000
@@ -6304,7 +6304,7 @@
   ac_status=3D$?
   echo "$as_me:$LINENO: \$? =3D $ac_status" >&5
   (exit $ac_status); }; } ||
-   { ac_try=3D'$libc_unwind_check -lgcc_eh -lgcc >&5'
+   { ac_try=3D'$libc_unwind_check -lgcc >&5'
   { (eval echo "$as_me:$LINENO: \"$ac_try\"") >&5
   (eval $ac_try) 2>&5
   ac_status=3D$?
diff -r -u glibc-2.3.6/configure.in glibc-2.3.6-patched/configure.in
--- glibc-2.3.6/configure.in=092005-07-18 01:38:55.000000000 +0000
+++ glibc-2.3.6-patched/configure.in=092006-02-14 00:24:33.881877296 +0000
@@ -1760,7 +1760,7 @@
 =09=09=09    -lgcc"
 # Some platforms' specs put -lgcc first.  The second one doesn't hurt.
 if AC_TRY_COMMAND([$libc_unwind_check >&AS_MESSAGE_LOG_FD]) ||
-   AC_TRY_COMMAND([$libc_unwind_check -lgcc_eh -lgcc >&AS_MESSAGE_LOG_FD])
+   AC_TRY_COMMAND([$libc_unwind_check -lgcc >&AS_MESSAGE_LOG_FD])
 then
   if $libc_unwind_check -v 2>&1 >/dev/null \
      | grep -- --eh-frame-hdr 2>&1 >/dev/null; then
diff -r -u glibc-2.3.6/sysdeps/arm/dl-machine.h
glibc-2.3.6-patched/sysdeps/arm/dl-machine.h
--- glibc-2.3.6/sysdeps/arm/dl-machine.h=092005-10-17 04:52:36.000000000 +0=
000
+++ glibc-2.3.6-patched/sysdeps/arm/dl-machine.h=092006-02-14
00:18:24.149085224 +0000
@@ -357,7 +357,15 @@
 #ifdef RESOLVE

 /* Deal with an out-of-range PC24 reloc.  */
-static Elf32_Addr
+/* static Elf32_Addr */
+#if __GNUC__ >=3D 4
+  auto inline Elf32_Addr
+#else
+  static inline Elf32_Addr
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 fix_bad_pc24 (Elf32_Addr *const reloc_addr, Elf32_Addr value)
 {
   static void *fix_page;
@@ -390,8 +398,17 @@
 /* Perform the relocation specified by RELOC and SYM (which is fully resol=
ved).
    MAP is the object containing the reloc.  */

-auto inline void
+/* auto inline void
 __attribute__ ((always_inline))
+*/
+#if __GNUC__ >=3D 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rel (struct link_map *map, const Elf32_Rel *reloc,
 =09=09 const Elf32_Sym *sym, const struct r_found_version *version,
 =09=09 void *const reloc_addr_arg)
@@ -516,8 +533,19 @@
 }

 # ifndef RTLD_BOOTSTRAP
+
+/*
 auto inline void
 __attribute__ ((always_inline))
+*/
+#if __GNUC__ >=3D 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rela (struct link_map *map, const Elf32_Rela *reloc,
 =09=09  const Elf32_Sym *sym, const struct r_found_version *version,
 =09=09  void *const reloc_addr_arg)
@@ -597,8 +625,18 @@
 }
 # endif

+/*
 auto inline void
 __attribute__ ((always_inline))
+*/
+#if __GNUC__ >=3D 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rel_relative (Elf32_Addr l_addr, const Elf32_Rel *reloc,
 =09=09=09  void *const reloc_addr_arg)
 {
@@ -607,8 +645,18 @@
 }

 # ifndef RTLD_BOOTSTRAP
+/*
 auto inline void
 __attribute__ ((always_inline))
+*/
+#if __GNUC__ >=3D 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rela_relative (Elf32_Addr l_addr, const Elf32_Rela *reloc,
 =09=09=09   void *const reloc_addr_arg)
 {
@@ -617,8 +665,18 @@
 }
 # endif

+/*
 auto inline void
 __attribute__ ((always_inline))
+*/
+#if __GNUC__ >=3D 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_lazy_rel (struct link_map *map,
 =09=09      Elf32_Addr l_addr, const Elf32_Rel *reloc)
 {
diff -r -u glibc-2.3.6/sysdeps/unix/sysv/linux/arm/ioperm.c
glibc-2.3.6-patched/sysdeps/unix/sysv/linux/arm/ioperm.c
--- glibc-2.3.6/sysdeps/unix/sysv/linux/arm/ioperm.c=092003-02-20
22:22:35.000000000 +0000
+++ glibc-2.3.6-patched/sysdeps/unix/sysv/linux/arm/ioperm.c=092006-02-14
00:01:15.358485168 +0000
@@ -47,6 +47,13 @@
 #include <asm/page.h>
 #include <sys/sysctl.h>

+/* see http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0529.html */
+#include <linux/version.h>
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23))
+#define CTL_BUS_ISA BUS_ISA    /* and hope it's not the one from
linux/input.h */
+#endif
+
+
 #define PATH_ARM_SYSTYPE=09"/etc/arm_systype"
 #define PATH_CPUINFO=09=09"/proc/cpuinfo"

@@ -81,6 +88,7 @@
  * we need.  Each is tried in turn until one succeeds.
  *
  * 1. Sysctl (CTL_BUS, BUS_ISA, ISA_*).  This is the preferred method
+ *(NEW) 1. Sysctl (CTL_BUS, CTL_BUS_ISA, ISA_*).  This is the preferred me=
thod
  *    but not all kernels support it.
  *
  * 2. Read the value (not the contents) of symlink PATH_ARM_SYSTYPE.
@@ -100,8 +108,12 @@
 {
   char systype[256];
   int i, n;
+  /*
   static int iobase_name[] =3D { CTL_BUS, BUS_ISA, BUS_ISA_PORT_BASE };
   static int ioshift_name[] =3D { CTL_BUS, BUS_ISA, BUS_ISA_PORT_SHIFT };
+  */
+  static int iobase_name[] =3D { CTL_BUS, CTL_BUS_ISA, BUS_ISA_PORT_BASE }=
;
+  static int ioshift_name[] =3D { CTL_BUS, CTL_BUS_ISA, BUS_ISA_PORT_SHIFT=
 };
   size_t len =3D sizeof(io.base);

   if (! sysctl (iobase_name, 3, &io.io_base, &len, NULL, 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

after compiled glibc i recompiled gcc with the following flags:

../gcc-4.0.2/configure --target=3Darm-linux --prefix=3D/opt/arm-linux
--enable-languages=3Dc,c++  --enable-threads --enable-__cxa_atexit
--enable-nls --enable-long-long --enable-c99

why:
 --enable-languages=3Dc,c++

    This option ensures that only the C and C++ compilers are built.
--enable-__cxa_atexit

    This option allows use of __cxa_atexit, rather than atexit, to
register C++ destructors for local statics and global objects and is
essential for fully standards-compliant handling of destructors. It
also affects the C++ ABI and therefore results in C++ shared libraries
and C++ programs that are interoperable with other Linux
distributions.
--enable-c99

    Enable C99 support for C programs.
--enable-long-long

    Enables long long support in the compiler.
--enable-threads=3Dposix || --enable-threads

    This enables C++ exception handling for multi-threaded code.

thats all 8-)

--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
