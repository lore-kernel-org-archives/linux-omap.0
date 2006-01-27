From: Vineet Tuli <vineet@cybernetra.com>
Subject: Re: Howto build a gcc 4.0 toolchain for ARM?
Date: Fri, 27 Jan 2006 12:53:20 +0530
Message-ID: <1138346601.2518.9.camel@meenakshi.linux>
References: <43D746D5.80202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43D746D5.80202@freescale.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Papacharalambous <stevep@freescale.com>
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Some problem in my mail system. Attachment not going. Including the
patches herein:

--- elf/dynamic-link.h.old	2005-03-12 18:12:37.000000000 -0800
+++ elf/dynamic-link.h	2005-03-12 18:12:59.777820848 -0800
@@ -19,43 +19,6 @@
 
 #include <elf.h>
 #include <assert.h>
-
-#ifdef RESOLVE
-/* We pass reloc_addr as a pointer to void, as opposed to a pointer to
-   ElfW(Addr), because not all architectures can assume that the
-   relocated address is properly aligned, whereas the compiler is
-   entitled to assume that a pointer to a type is properly aligned for
-   the type.  Even if we cast the pointer back to some other type with
-   less strict alignment requirements, the compiler might still
-   remember that the pointer was originally more aligned, thereby
-   optimizing away alignment tests or using word instructions for
-   copying memory, breaking the very code written to handle the
-   unaligned cases.  */
-auto void __attribute__((always_inline))
-elf_machine_rel (struct link_map *map, const ElfW(Rel) *reloc,
-		 const ElfW(Sym) *sym, const struct r_found_version *version,
-		 void *const reloc_addr);
-auto void __attribute__((always_inline))
-elf_machine_rela (struct link_map *map, const ElfW(Rela) *reloc,
-		  const ElfW(Sym) *sym, const struct r_found_version *version,
-		  void *const reloc_addr);
-auto void __attribute__((always_inline))
-elf_machine_rel_relative (ElfW(Addr) l_addr, const ElfW(Rel) *reloc,
-			  void *const reloc_addr);
-auto void __attribute__((always_inline))
-elf_machine_rela_relative (ElfW(Addr) l_addr, const ElfW(Rela) *reloc,
-			   void *const reloc_addr);
-# if ELF_MACHINE_NO_RELA || defined ELF_MACHINE_PLT_REL
-auto void __attribute__((always_inline))
-elf_machine_lazy_rel (struct link_map *map,
-		      ElfW(Addr) l_addr, const ElfW(Rel) *reloc);
-# else
-auto void __attribute__((always_inline))
-elf_machine_lazy_rel (struct link_map *map,
-		      ElfW(Addr) l_addr, const ElfW(Rela) *reloc);
-# endif
-#endif
-
 #include <dl-machine.h>
 
 #ifndef VERSYMIDX



--- glibc-2.3.5.orig/iconvdata/jis0208.h	2003-06-11 21:40:42.000000000 +0000
+++ glibc-2.3.5/iconvdata/jis0208.h	2005-07-15 18:32:20.726328528 +0000
@@ -24,15 +24,6 @@
 #include <gconv.h>
 #include <stdint.h>
 
-/* Conversion table.  */
-extern const uint16_t __jis0208_to_ucs[];
-
-extern const char __jisx0208_from_ucs4_lat1[256][2];
-extern const char __jisx0208_from_ucs4_greek[0xc1][2];
-extern const struct jisx0208_ucs_idx __jisx0208_from_ucs_idx[];
-extern const char __jisx0208_from_ucs_tab[][2];
-
-
 /* Struct for table with indeces in UCS mapping table.  */
 struct jisx0208_ucs_idx
 {
@@ -42,6 +33,15 @@
 };
 

+/* Conversion table.  */
+extern const uint16_t __jis0208_to_ucs[];
+
+extern const char __jisx0208_from_ucs4_lat1[256][2];
+extern const char __jisx0208_from_ucs4_greek[0xc1][2];
+extern const struct jisx0208_ucs_idx __jisx0208_from_ucs_idx[];
+extern const char __jisx0208_from_ucs_tab[][2];
+
+
 static inline uint32_t
 __attribute ((always_inline))
 jisx0208_to_ucs4 (const unsigned char **s, size_t avail, unsigned char offset)



--- libc/include/libc-symbols.h	2005/02/11 00:29:46	1.70
+++ libc/include/libc-symbols.h	2005/03/17 21:06:27	1.71
@@ -583,78 +583,23 @@
 #  define hidden_proto(name, attrs...) \
   __hidden_proto (name, __GI_##name, ##attrs)
 #  define __hidden_proto(name, internal, attrs...) \
-  extern __typeof (name) internal; \
   extern __typeof (name) name __asm__ (__hidden_asmname (#internal)) \
   __hidden_proto_hiddenattr (attrs);
 #  define __hidden_asmname(name) \
   __hidden_asmname1 (__USER_LABEL_PREFIX__, name)
 #  define __hidden_asmname1(prefix, name) __hidden_asmname2(prefix, name)
 #  define __hidden_asmname2(prefix, name) #prefix name
-#  ifdef HAVE_ASM_SET_DIRECTIVE
-#   define __hidden_def1(original, alias)			\
-  ASM_GLOBAL_DIRECTIVE C_SYMBOL_NAME (alias) ASM_LINE_SEP	\
-  .set C_SYMBOL_NAME (alias), C_SYMBOL_NAME (original)
-#   ifdef HAVE_ASM_GLOBAL_DOT_NAME
-#     define __hidden_dot_def1(original, alias)	 ASM_LINE_SEP	\
-  ASM_GLOBAL_DIRECTIVE C_SYMBOL_DOT_NAME (alias) ASM_LINE_SEP	\
-  .set C_SYMBOL_DOT_NAME (alias), C_SYMBOL_DOT_NAME (original)
-#   else
-#     define __hidden_dot_def1(original, alias)
-#   endif
-#  else
-#   define __hidden_def1(original, alias)			\
-  ASM_GLOBAL_DIRECTIVE C_SYMBOL_NAME (alias) ASM_LINE_SEP	\
-  C_SYMBOL_NAME (alias) = C_SYMBOL_NAME (original)
-#   ifdef HAVE_ASM_GLOBAL_DOT_NAME
-#    define __hidden_dot_def1(original, alias)	ASM_LINE_SEP	\
-  ASM_GLOBAL_DIRECTIVE C_SYMBOL_DOT_NAME (alias) ASM_LINE_SEP	\
-  C_SYMBOL_DOT_NAME (alias) = C_SYMBOL_DOT_NAME (original)
-#   else
-#    define __hidden_dot_def1(original, alias)
-#   endif
-#  endif
-#  define __hidden_def2(...) #__VA_ARGS__
-#  define __hidden_def3(...) __hidden_def2 (__VA_ARGS__)
-#  define hidden_def(name)					\
-  __asm__ (__hidden_def3 (__hidden_def1 (__GI_##name, name) \
-  __hidden_dot_def1 (__GI_##name, name)));
-#  define hidden_data_def(name)					\
-  __asm__ (__hidden_def3 (__hidden_def1 (__GI_##name, name)));
-#  define hidden_ver(local, name)				\
-  __asm__ (__hidden_def3 (__hidden_def1 (local, __GI_##name) \
-  __hidden_dot_def1 (local, __GI_##name)));
-#  define hidden_data_ver(local, name)				\
-  __asm__ (__hidden_def3 (__hidden_def1 (local, __GI_##name)));
-#  ifdef HAVE_WEAK_SYMBOLS
-#   ifdef HAVE_ASM_WEAKEXT_DIRECTIVE
-#    define __hidden_weak1(original, alias)			\
-  .weakext C_SYMBOL_NAME (alias), C_SYMBOL_NAME (original)
-#    ifdef HAVE_ASM_GLOBAL_DOT_NAME
-#     define __hidden_dot_weak1(original, alias)	ASM_LINE_SEP	\
-  .weakext C_SYMBOL_DOT_NAME (alias), C_SYMBOL_DOT_NAME (original)
-#    else
-#     define __hidden_dot_weak1(original, alias)
-#    endif
-#   else /* ! HAVE_ASM_WEAKEXT_DIRECTIVE */
-#    define __hidden_weak1(original, alias)			\
-  .weak C_SYMBOL_NAME (alias) ASM_LINE_SEP			\
-  C_SYMBOL_NAME (alias) = C_SYMBOL_NAME (original)
-#    ifdef HAVE_ASM_GLOBAL_DOT_NAME
-#     define __hidden_dot_weak1(original, alias)	ASM_LINE_SEP	\
-  .weak C_SYMBOL_DOT_NAME (alias) ASM_LINE_SEP	\
-  C_SYMBOL_DOT_NAME (alias) = C_SYMBOL_DOT_NAME (original)
-#    else
-#     define __hidden_dot_weak1(original, alias)
-#    endif
-#   endif
-#   define hidden_weak(name)					\
-  __asm__ (__hidden_def3 (__hidden_weak1 (__GI_##name, name) \
-  __hidden_dot_weak1 (__GI_##name, name)));
-#   define hidden_data_weak(name)					\
-  __asm__ (__hidden_def3 (__hidden_weak1 (__GI_##name, name)));
-#  else
-#   define hidden_weak(name) hidden_def (name)
-#  endif
+#  define __hidden_ver1(local, internal, name) \
+  extern __typeof (name) __EI_##name __asm__(__hidden_asmname (#internal)); \
+  extern __typeof (name) __EI_##name \
+	__attribute__((alias (__hidden_asmname (#local))))
+#  define hidden_ver(local, name)	__hidden_ver1(local, __GI_##name, name);
+#  define hidden_data_ver(local, name)	hidden_ver(local, name)
+#  define hidden_def(name)		__hidden_ver1(__GI_##name, name, name);
+#  define hidden_data_def(name)		hidden_def(name)
+#  define hidden_weak(name) \
+	__hidden_ver1(__GI_##name, name, name) __attribute__((weak));
+#  define hidden_data_weak(name)	hidden_weak(name)
 # else
 /* For assembly, we need to do the opposite of what we do in C:



--- wcsmbs/wcscoll.c	2004/03/14 21:05:48	1.13
+++ wcsmbs/wcscoll.c	2005/03/17 21:06:24	1.14
@@ -22,12 +22,11 @@
 
 #define STRING_TYPE wchar_t
 #define USTRING_TYPE wint_t
-#define STRCOLL __wcscoll
+#define STRCOLL wcscoll
 #define STRCOLL_L __wcscoll_l
 
 #include "../string/strcoll.c"
 
 #ifndef USE_IN_EXTENDED_LOCALE_MODEL
-weak_alias (__wcscoll, wcscoll)
 libc_hidden_weak (wcscoll)
 #endif




--- glibc-2.3.4/sysdeps/arm/dl-machine.h.old	Sun Mar 20 17:54:37 2005
+++ glibc-2.3.4/sysdeps/arm/dl-machine.h	Sun Mar 20 17:57:32 2005
@@ -359,7 +359,14 @@
 # endif
 
 /* Deal with an out-of-range PC24 reloc.  */
-static Elf32_Addr
+#if __GNUC__ >= 4
+  auto inline Elf32_Addr
+#else
+  static inline Elf32_Addr
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 fix_bad_pc24 (Elf32_Addr *const reloc_addr, Elf32_Addr value)
 {
   static void *fix_page;
@@ -392,7 +399,14 @@
 /* Perform the relocation specified by RELOC and SYM (which is fully resolved).
    MAP is the object containing the reloc.  */
 
-static inline void
+#if __GNUC__ >= 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rel (struct link_map *map, const Elf32_Rel *reloc,
 		 const Elf32_Sym *sym, const struct r_found_version *version,
 		 void *const reloc_addr_arg)
@@ -517,7 +531,14 @@
 }
 
 # ifndef RTLD_BOOTSTRAP
-static inline void
+#if __GNUC__ >= 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rela (struct link_map *map, const Elf32_Rela *reloc,
 		  const Elf32_Sym *sym, const struct r_found_version *version,
 		  void *const reloc_addr_arg)
@@ -597,7 +618,14 @@
 }
 # endif
 
-static inline void
+#if __GNUC__ >= 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rel_relative (Elf32_Addr l_addr, const Elf32_Rel *reloc,
 			  void *const reloc_addr_arg)
 {
@@ -606,7 +634,14 @@
 }
 
 # ifndef RTLD_BOOTSTRAP
-static inline void
+#if __GNUC__ >= 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_rela_relative (Elf32_Addr l_addr, const Elf32_Rela *reloc,
 			   void *const reloc_addr_arg)
 {
@@ -615,7 +650,14 @@
 }
 # endif
 
-static inline void
+#if __GNUC__ >= 4
+  auto inline void
+#else
+  static inline void
+#endif
+#if __GNUC__ >= 4 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 2)
+  __attribute ((always_inline))
+#endif
 elf_machine_lazy_rel (struct link_map *map,
 		      Elf32_Addr l_addr, const Elf32_Rel *reloc)
 {





--- glibc-2.3.2/sysdeps/unix/sysv/linux/arm/ioperm.c.old	2003-02-20 14:22:24.000000000 -0800
+++ glibc-2.3.2/sysdeps/unix/sysv/linux/arm/ioperm.c	2004-01-31 16:01:50.000000000 -0800
@@ -47,6 +47,12 @@
 #include <asm/page.h>
 #include <sys/sysctl.h>
 
+/* see http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0529.html */
+#include <linux/version.h>
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23))
+#define CTL_BUS_ISA BUS_ISA	/* and hope it's not the one from linux/input.h */
+#endif
+
 #define PATH_ARM_SYSTYPE	"/etc/arm_systype"
 #define PATH_CPUINFO		"/proc/cpuinfo"
 
@@ -80,7 +86,7 @@
  * Initialize I/O system.  There are several ways to get the information
  * we need.  Each is tried in turn until one succeeds.
  *
- * 1. Sysctl (CTL_BUS, BUS_ISA, ISA_*).  This is the preferred method
+ * 1. Sysctl (CTL_BUS, CTL_BUS_ISA, ISA_*).  This is the preferred method
  *    but not all kernels support it.
  *
  * 2. Read the value (not the contents) of symlink PATH_ARM_SYSTYPE.
@@ -100,8 +106,8 @@
 {
   char systype[256];
   int i, n;
-  static int iobase_name[] = { CTL_BUS, BUS_ISA, BUS_ISA_PORT_BASE };
-  static int ioshift_name[] = { CTL_BUS, BUS_ISA, BUS_ISA_PORT_SHIFT };
+  static int iobase_name[] = { CTL_BUS, CTL_BUS_ISA, BUS_ISA_PORT_BASE };
+  static int ioshift_name[] = { CTL_BUS, CTL_BUS_ISA, BUS_ISA_PORT_SHIFT };
   size_t len = sizeof(io.base);
 
   if (! sysctl (iobase_name, 3, &io.io_base, &len, NULL, 0)



--- string/strcoll.c	2004/03/14 20:51:30	1.33
+++ string/strcoll.c	2005/03/17 21:06:24	1.34
@@ -23,6 +23,7 @@
 # define STRING_TYPE char
 # define STRCOLL strcoll
 # define STRCOLL_L __strcoll_l
+# define USE_HIDDEN_DEF
 #endif
 
 #include "../locale/localeinfo.h"
@@ -35,6 +36,7 @@
 {
   return STRCOLL_L (s1, s2, _NL_CURRENT_LOCALE);
 }
-#if !defined WIDE_CHAR_VERSION
-libc_hidden_def (strcoll)
+
+#ifdef USE_HIDDEN_DEF
+libc_hidden_def (STRCOLL)
 #endif



--- include/wchar.h	2004/03/14 20:45:10	1.26
+++ include/wchar.h	2005/03/17 21:06:24	1.27
@@ -56,7 +56,6 @@
 extern int __wcsncasecmp (__const wchar_t *__s1, __const wchar_t *__s2,
 			  size_t __n)
      __attribute_pure__;
-extern int __wcscoll (__const wchar_t *__s1, __const wchar_t *__s2);
 extern size_t __wcslen (__const wchar_t *__s) __attribute_pure__;
 extern size_t __wcsnlen (__const wchar_t *__s, size_t __maxlen)
      __attribute_pure__;

*******************************************************************************

On Wed, 2006-01-25 at 09:37 +0000, Steve Papacharalambous wrote:
> Hi Vineet,
> 
> I was looking at your steps on how to build a gcc-4.0 toolchain for ARM:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-November/005665.html
> 
> The patches for glibc-2.3.5 that you mention don't appear to be attached 
> to the page, can you let me know where I can get these patches please?
> 
> Thanks,
> 
> Steve
> 
