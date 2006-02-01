From: Vineet Tuli <vineet@cybernetra.com>
Subject: Re: Howto build a gcc 4.0 toolchain for ARM?
Date: Wed, 01 Feb 2006 14:57:18 +0530
Message-ID: <1138786038.2892.1.camel@meenakshi.linux>
References: <43D746D5.80202@freescale.com>
	<1138346601.2518.9.camel@meenakshi.linux>
	<ae36f8040601270748j6117dcf3w@mail.gmail.com>
	<1138679218.2553.2.camel@meenakshi.linux>
	<ae36f8040601311057t2967cb33h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040601311057t2967cb33h@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@ieee.org
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Remove all occurances of -lgcc_eh from the files: Makeconfig, configure
and configure.in from top level glibc soruce code directory and
recompile.

On Tue, 2006-01-31 at 16:57 -0200, Lu=C3=ADs Cargnini wrote:
> ok i passed the compiler=20
> but after added some patchs to glibc.2.3.5
>=20
> glibc-2.3.5-allow-gcc-4.0-wordexp.patch   =20
> glibc-2.3.5-allow-gcc4-string.patch       =20
> glibc-2.3.5-allow-gcc4-symbols.patch     =20
> glibc-2.3.5-allow-gcc4-wcstol_l.patch  =20
> and your own patch
> i received the following  error:
> /opt/arm-linux/lib/gcc/arm-linux/4.0.2/../../../../arm-linux/bin/ld:
> cannot find -lgcc_eh
> collect2: ld returned 1 exit status
> make[2]: ***
> [/home/lvcargnini/puc/mestrado/instramed/builds/linux/bglibc/iconv/icon=
vconfig] Error 1=20
> make[2]: Leaving directory
> `/home/lvcargnini/puc/mestrado/instramed/builds/linux/glibc-2.3.5/iconv=
'
> make[1]: *** [iconv/others] Error 2
> make[1]: Leaving directory
> `/home/lvcargnini/puc/mestrado/instramed/builds/linux/glibc- 2.3.5'
>=20
> On 31/01/06, Vineet Tuli <vineet@cybernetra.com> wrote:
>         Sorry for replying late. I was not available at office. Please
>         use the
>         option --disable-shared while compiling gcc. This will resolve
>         the error
>         of crti.o.
>        =20
>         This will give an error "cannot create executables" in the end
>         which can=20
>         be safely ignored.
>        =20
>         Vineet
>        =20
>         On Fri, 2006-01-27 at 13:48 -0200, Lu=C3=ADs Cargnini wrote:
>         > this step:
>         > [root at localhost]# cd /usr/src
>         > [root at localhost
>         > ]# tar =E2=80=93xjf  gcc-4.0.2.tar.bz2=20
>         >
>         > A configuration file must be modified so that the compiler
>         is built without libc includes. Edit
>         the /usr/src/gcc-4.0.2/gcc/config/arm/t-linux file and append
>         >
>         > =E2=80=93Dinhibit_libc =E2=80=93D__gthr_posix_h to the line s=
tarting with
>         TARGET_LIBGCC2_CFLAGS =3D.=20
>         >
>         >
>         > The top of the file is shown below, after appending the
>         flags.
>         >
>         > # Just for these, we omit the frame pointer since it makes
>         such a big
>         > # difference. It is then pointless adding debugging.=20
>         > TARGET_LIBGCC2_CFLAGS =3D -fomit-frame-pointer -fPIC =E2=80=93
>         Dinhibit_libc =E2=80=93D__gthr_posix_h
>         >
>         > LIBGCC2_DEBUG_CFLAGS =3D -g0
>         >
>         > Go to the /usr/src/build/gcc-4.0.2 directory to configure
>         and build the GNU C compiler with the commands below.=20
>         >
>         > [
>         > root at localhost]# cd /usr/src/build/gcc-4.0.2
>         > [root at localhost]# ../../gcc-4.0.2/configure
>         =E2=80=93-target=3Darm-linux =E2=80=93-prefix=3D/opt/armv4 --di=
sable-threads
>         =E2=80=93-enable-languages=3Dc
>         >
>         > [root at localhost]# make=20
>         > isn't working for me io always receive some error
>         >
>         > that was crti.o how to fix this ??
>         >
>         > [
>         > root at localhost]# make install
>         >
>         >
>         > On 27/01/06, Vineet Tuli < vineet@cybernetra.com> wrote:
>         >         Some problem in my mail system. Attachment not
>         going.
>         >         Including the
>         >         patches herein:
>         >
>         >         --- elf/dynamic- link.h.old      2005-03-12
>         18:12:37.000000000
>         >         -0800
>         >         +++ elf/dynamic-link.h  2005-03-12
>         18:12:59.777820848 -0800
>         >         @@ -19,43 +19,6 @@
>         >
>         >         #include <elf.h >
>         >         #include <assert.h>
>         >         -
>         >         -#ifdef RESOLVE
>         >         -/* We pass reloc_addr as a pointer to void, as
>         opposed to a
>         >         pointer to
>         >         -   ElfW(Addr), because not all architectures can
>         assume that=20
>         >         the
>         >         -   relocated address is properly aligned, whereas
>         the
>         >         compiler is
>         >         -   entitled to assume that a pointer to a type is
>         properly
>         >         aligned for=20
>         >         -   the type.  Even if we cast the pointer back to
>         some other
>         >         type with
>         >         -   less strict alignment requirements, the compiler
>         might
>         >         still
>         >         -   remember that the pointer was originally more
>         aligned,=20
>         >         thereby
>         >         -   optimizing away alignment tests or using word
>         instructions
>         >         for
>         >         -   copying memory, breaking the very code written
>         to handle
>         >         the
>         >         -   unaligned cases.  */
>         >         -auto void __attribute__((always_inline))
>         >         -elf_machine_rel (struct link_map *map, const
>         ElfW(Rel)
>         >         *reloc,
>         >         -                const ElfW(Sym) *sym, const struct=20
>         >         r_found_version *version,
>         >         -                void *const reloc_addr);
>         >         -auto void __attribute__((always_inline))
>         >         -elf_machine_rela (struct link_map *map, const
>         ElfW(Rela)=20
>         >         *reloc,
>         >         -                 const ElfW(Sym) *sym, const struct
>         >         r_found_version *version,
>         >         -                 void *const reloc_addr);
>         >         -auto void __attribute__((always_inline))=20
>         >         -elf_machine_rel_relative (ElfW(Addr) l_addr, const
>         ElfW(Rel)
>         >         *reloc,
>         >         -                         void *const reloc_addr);
>         >         -auto void __attribute__((always_inline))=20
>         >         -elf_machine_rela_relative (ElfW(Addr) l_addr, const
>         >         ElfW(Rela) *reloc,
>         >         -                          void *const reloc_addr);
>         >         -# if ELF_MACHINE_NO_RELA || defined
>         ELF_MACHINE_PLT_REL=20
>         >         -auto void __attribute__((always_inline))
>         >         -elf_machine_lazy_rel (struct link_map *map,
>         >         -                     ElfW(Addr) l_addr, const
>         ElfW(Rel)
>         >         *reloc);
>         >         -# else
>         >         -auto void __attribute__((always_inline))
>         >         -elf_machine_lazy_rel (struct link_map *map,
>         >         -                     ElfW(Addr) l_addr, const
>         ElfW(Rela)
>         >         *reloc);=20
>         >         -# endif
>         >         -#endif
>         >         -
>         >         #include <dl-machine.h>
>         >
>         >         #ifndef VERSYMIDX
>         >
>         >
>         >
>         >         ---
>         glibc-2.3.5.orig/iconvdata/jis0208.h        2003-06-11=20
>         >         21:40: 42.000000000 +0000
>         >         +++ glibc-2.3.5/iconvdata/jis0208.h     2005-07-15
>         >         18:32:20.726328528 +0000
>         >         @@ -24,15 +24,6 @@
>         >         #include <gconv.h >
>         >         #include <stdint.h>
>         >
>         >         -/* Conversion table.  */
>         >         -extern const uint16_t __jis0208_to_ucs[];
>         >         -
>         >         -extern const char
>         __jisx0208_from_ucs4_lat1[256][2];=20
>         >         -extern const char
>         __jisx0208_from_ucs4_greek[0xc1][2];
>         >         -extern const struct jisx0208_ucs_idx
>         >         __jisx0208_from_ucs_idx[];
>         >         -extern const char __jisx0208_from_ucs_tab[][2];=20
>         >         -
>         >         -
>         >         /* Struct for table with indeces in UCS mapping
>         table.  */
>         >         struct jisx0208_ucs_idx
>         >         {
>         >         @@ -42,6 +33,15 @@
>         >         };=20
>         >
>         >
>         >         +/* Conversion table.  */
>         >         +extern const uint16_t __jis0208_to_ucs[];
>         >         +
>         >         +extern const char
>         __jisx0208_from_ucs4_lat1[256][2];
>         >         +extern const char
>         __jisx0208_from_ucs4_greek[0xc1][2];=20
>         >         +extern const struct jisx0208_ucs_idx
>         >         __jisx0208_from_ucs_idx[];
>         >         +extern const char __jisx0208_from_ucs_tab[][2];
>         >         +
>         >         +
>         >         static inline uint32_t=20
>         >         __attribute ((always_inline))
>         >         jisx0208_to_ucs4 (const unsigned char **s, size_t
>         avail,
>         >         unsigned char offset)
>         >
>         >
>         >
>         >         --- libc/include/libc-symbols.h 2005/02/11 00:29:46
>         1.70
>         >         +++ libc/include/libc-symbols.h 2005/03/17 21:06:27
>         1.71
>         >         @@ -583,78 +583,23 @@
>         >         #  define hidden_proto(name, attrs...) \
>         >            __hidden_proto (name, __GI_##name, ##attrs)=20
>         >         #  define __hidden_proto(name, internal, attrs...) \
>         >         -  extern __typeof (name) internal; \
>         >            extern __typeof (name) name __asm__
>         (__hidden_asmname
>         >         (#internal)) \=20
>         >            __hidden_proto_hiddenattr (attrs);
>         >         #  define __hidden_asmname(name) \
>         >            __hidden_asmname1 (__USER_LABEL_PREFIX__, name)
>         >         #  define __hidden_asmname1(prefix, name)=20
>         >         __hidden_asmname2(prefix, name)
>         >         #  define __hidden_asmname2(prefix, name) #prefix
>         name
>         >         -#  ifdef HAVE_ASM_SET_DIRECTIVE
>         >         -#   define __hidden_def1(original,
>         >         alias)                      \
>         >         -  ASM_GLOBAL_DIRECTIVE C_SYMBOL_NAME (alias)
>         >         ASM_LINE_SEP      \
>         >         -  .set C_SYMBOL_NAME (alias), C_SYMBOL_NAME
>         (original)
>         >         -#   ifdef HAVE_ASM_GLOBAL_DOT_NAME=20
>         >         -#     define __hidden_dot_def1(original, alias)
>         >         ASM_LINE_SEP   \
>         >         -  ASM_GLOBAL_DIRECTIVE C_SYMBOL_DOT_NAME (alias)
>         >         ASM_LINE_SEP  \
>         >         -  .set C_SYMBOL_DOT_NAME (alias),
>         C_SYMBOL_DOT_NAME=20
>         >         (original)
>         >         -#   else
>         >         -#     define __hidden_dot_def1(original, alias)
>         >         -#   endif
>         >         -#  else
>         >         -#   define __hidden_def1(original,=20
>         >         alias)                      \
>         >         -  ASM_GLOBAL_DIRECTIVE C_SYMBOL_NAME (alias)
>         >         ASM_LINE_SEP      \
>         >         -  C_SYMBOL_NAME (alias) =3D C_SYMBOL_NAME (original)
>         >         -#   ifdef HAVE_ASM_GLOBAL_DOT_NAME=20
>         >         -#    define __hidden_dot_def1(original, alias)
>         >         ASM_LINE_SEP    \
>         >         -  ASM_GLOBAL_DIRECTIVE C_SYMBOL_DOT_NAME (alias)
>         >         ASM_LINE_SEP  \
>         >         -  C_SYMBOL_DOT_NAME (alias) =3D C_SYMBOL_DOT_NAME
>         (original)=20
>         >         -#   else
>         >         -#    define __hidden_dot_def1(original, alias)
>         >         -#   endif
>         >         -#  endif
>         >         -#  define __hidden_def2(...) #__VA_ARGS__
>         >         -#  define __hidden_def3(...) __hidden_def2
>         (__VA_ARGS__)=20
>         >         -#  define hidden_def(name)
>         >         \
>         >         -  __asm__ (__hidden_def3 (__hidden_def1
>         (__GI_##name, name)
>         >         \
>         >         -  __hidden_dot_def1 (__GI_##name, name)));
>         >         -#  define
>         >
>         hidden_data_def(name)                                        \
>         >         -  __asm__ (__hidden_def3 (__hidden_def1
>         (__GI_##name,
>         >         name)));
>         >         -#  define hidden_ver(local,=20
>         >         name)                              \
>         >         -  __asm__ (__hidden_def3 (__hidden_def1 (local,
>         __GI_##name)
>         >         \
>         >         -  __hidden_dot_def1 (local, __GI_##name)));
>         >         -#  define hidden_data_ver(local, name)=20
>         >         \
>         >         -  __asm__ (__hidden_def3 (__hidden_def1 (local,
>         >         __GI_##name)));
>         >         -#  ifdef HAVE_WEAK_SYMBOLS
>         >         -#   ifdef HAVE_ASM_WEAKEXT_DIRECTIVE
>         >         -#    define __hidden_weak1(original,=20
>         >         alias)                    \
>         >         -  .weakext C_SYMBOL_NAME (alias), C_SYMBOL_NAME
>         (original)
>         >         -#    ifdef HAVE_ASM_GLOBAL_DOT_NAME
>         >         -#     define __hidden_dot_weak1(original, alias)=20
>         >         ASM_LINE_SEP    \
>         >         -  .weakext C_SYMBOL_DOT_NAME (alias),
>         C_SYMBOL_DOT_NAME
>         >         (original)
>         >         -#    else
>         >         -#     define __hidden_dot_weak1(original, alias)=20
>         >         -#    endif
>         >         -#   else /* ! HAVE_ASM_WEAKEXT_DIRECTIVE */
>         >         -#    define __hidden_weak1(original,
>         >         alias)                    \
>         >         -  .weak C_SYMBOL_NAME (alias) ASM_LINE_SEP=20
>         >         \
>         >         -  C_SYMBOL_NAME (alias) =3D C_SYMBOL_NAME (original)
>         >         -#    ifdef HAVE_ASM_GLOBAL_DOT_NAME
>         >         -#     define __hidden_dot_weak1(original, alias)
>         >         ASM_LINE_SEP    \=20
>         >         -  .weak C_SYMBOL_DOT_NAME (alias) ASM_LINE_SEP \
>         >         -  C_SYMBOL_DOT_NAME (alias) =3D C_SYMBOL_DOT_NAME
>         (original)
>         >         -#    else
>         >         -#     define __hidden_dot_weak1(original, alias)=20
>         >         -#    endif
>         >         -#   endif
>         >         -#   define hidden_weak(name)
>         >         \
>         >         -  __asm__ (__hidden_def3 (__hidden_weak1
>         (__GI_##name, name)
>         >         \
>         >         -  __hidden_dot_weak1 (__GI_##name, name)));=20
>         >         -#   define
>         >
>         hidden_data_weak(name)                                      \
>         >         -  __asm__ (__hidden_def3 (__hidden_weak1
>         (__GI_##name,
>         >         name)));
>         >         -#  else=20
>         >         -#   define hidden_weak(name) hidden_def (name)
>         >         -#  endif
>         >         +#  define __hidden_ver1(local, internal, name) \
>         >         +  extern __typeof (name) __EI_##name
>         __asm__(__hidden_asmname=20
>         >         (#internal)); \
>         >         +  extern __typeof (name) __EI_##name \
>         >         +       __attribute__((alias (__hidden_asmname
>         (#local))))
>         >         +#  define hidden_ver(local,
>         name)      __hidden_ver1(local,=20
>         >         __GI_##name, name);
>         >         +#  define hidden_data_ver(local, name)
>         hidden_ver(local,
>         >         name)
>         >         +#  define hidden_def(name)
>         >         __hidden_ver1(__GI_##name, name, name);=20
>         >         +#  define
>         >
>         hidden_data_def(name)                hidden_def(name)
>         >         +#  define hidden_weak(name) \
>         >         +       __hidden_ver1(__GI_##name, name, name)
>         >         __attribute__((weak));=20
>         >         +#  define hidden_data_weak(name)
>         hidden_weak(name)
>         >         # else
>         >         /* For assembly, we need to do the opposite of what
>         we do in
>         >         C:
>         >
>         >
>         >
>         >         --- wcsmbs/wcscoll.c    2004/03/14 21:05:48     1.13
>         >         +++ wcsmbs/wcscoll.c    2005/03/17 21:06:24     1.14
>         >         @@ -22,12 +22,11 @@
>         >
>         >         #define STRING_TYPE wchar_t=20
>         >         #define USTRING_TYPE wint_t
>         >         -#define STRCOLL __wcscoll
>         >         +#define STRCOLL wcscoll
>         >         #define STRCOLL_L __wcscoll_l
>         >
>         >         #include "../string/strcoll.c"=20
>         >
>         >         #ifndef USE_IN_EXTENDED_LOCALE_MODEL
>         >         -weak_alias (__wcscoll, wcscoll)
>         >         libc_hidden_weak (wcscoll)
>         >         #endif
>         >
>         >
>         >
>         >
>         >         --- glibc-2.3.4/sysdeps/arm/dl-machine.h.old    Sun
>         Mar 20
>         >         17:54:37 2005
>         >         +++ glibc-2.3.4/sysdeps/arm/dl-machine.h        Sun
>         Mar 20
>         >         17:57:32 2005
>         >         @@ -359,7 +359,14 @@=20
>         >         # endif
>         >
>         >         /* Deal with an out-of-range PC24 reloc.  */
>         >         -static Elf32_Addr
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline Elf32_Addr
>         >         +#else=20
>         >         +  static inline Elf32_Addr
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)
>         >         +  __attribute ((always_inline))
>         >         +#endif=20
>         >         fix_bad_pc24 (Elf32_Addr *const reloc_addr,
>         Elf32_Addr value)
>         >         {
>         >            static void *fix_page;
>         >         @@ -392,7 +399,14 @@
>         >         /* Perform the relocation specified by RELOC and SYM
>         (which is=20
>         >         fully resolved).
>         >             MAP is the object containing the reloc.  */
>         >
>         >         -static inline void
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline void
>         >         +#else=20
>         >         +  static inline void
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)
>         >         +  __attribute ((always_inline))
>         >         +#endif=20
>         >         elf_machine_rel (struct link_map *map, const
>         Elf32_Rel
>         >         *reloc,
>         >                          const Elf32_Sym *sym, const struct
>         >         r_found_version *version,
>         >                          void *const reloc_addr_arg)=20
>         >         @@ -517,7 +531,14 @@
>         >         }
>         >
>         >         # ifndef RTLD_BOOTSTRAP
>         >         -static inline void
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline void
>         >         +#else=20
>         >         +  static inline void
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)
>         >         +  __attribute ((always_inline))
>         >         +#endif=20
>         >         elf_machine_rela (struct link_map *map, const
>         Elf32_Rela
>         >         *reloc,
>         >                           const Elf32_Sym *sym, const struct
>         >         r_found_version *version,
>         >                           void *const reloc_addr_arg)=20
>         >         @@ -597,7 +618,14 @@
>         >         }
>         >         # endif
>         >
>         >         -static inline void
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline void
>         >         +#else
>         >         +  static inline void
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)
>         >         +  __attribute ((always_inline))
>         >         +#endif=20
>         >         elf_machine_rel_relative (Elf32_Addr l_addr, const
>         Elf32_Rel
>         >         *reloc,
>         >                                   void *const
>         reloc_addr_arg)
>         >         {
>         >         @@ -606,7 +634,14 @@=20
>         >         }
>         >
>         >         # ifndef RTLD_BOOTSTRAP
>         >         -static inline void
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline void
>         >         +#else
>         >         +  static inline void=20
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)
>         >         +  __attribute ((always_inline))
>         >         +#endif
>         >         elf_machine_rela_relative (Elf32_Addr l_addr, const
>         Elf32_Rela=20
>         >         *reloc,
>         >                                    void *const
>         reloc_addr_arg)
>         >         {
>         >         @@ -615,7 +650,14 @@
>         >         }
>         >         # endif
>         >
>         >         -static inline void=20
>         >         +#if __GNUC__ >=3D 4
>         >         +  auto inline void
>         >         +#else
>         >         +  static inline void
>         >         +#endif
>         >         +#if __GNUC__ >=3D 4 || (__GNUC__ =3D=3D 3 &&
>         __GNUC_MINOR__ >=3D 2)=20
>         >         +  __attribute ((always_inline))
>         >         +#endif
>         >         elf_machine_lazy_rel (struct link_map *map,
>         >                               Elf32_Addr l_addr, const
>         Elf32_Rel
>         >         *reloc)=20
>         >         {
>         >
>         >
>         >
>         >
>         >
>         >         ---
>         >
>         glibc-2.3.2/sysdeps/unix/sysv/linux/arm/ioperm.c.old        200=
3-02-20 14:22: 24.000000000 -0800
>         >         +++
>         >
>         glibc-2.3.2/sysdeps/unix/sysv/linux/arm/ioperm.c    2004-01-31
>         >         16:01:50.000000000 -0800
>         >         @@ -47,6 +47,12 @@
>         >         #include <asm/page.h>
>         >         #include <sys/sysctl.h>=20
>         >
>         >         +/* see
>         >
>         http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0529.html
>         >         */
>         >         +#include <linux/version.h>=20
>         >         +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23))
>         >         +#define CTL_BUS_ISA BUS_ISA    /* and hope it's not
>         the one
>         >         from linux/input.h */
>         >         +#endif
>         >         +=20
>         >         #define PATH_ARM_SYSTYPE       "/etc/arm_systype"
>         >         #define PATH_CPUINFO           "/proc/cpuinfo"
>         >
>         >         @@ -80,7 +86,7 @@
>         >           * Initialize I/O system.  There are several ways
>         to get the=20
>         >         information
>         >           * we need.  Each is tried in turn until one
>         succeeds.
>         >           *
>         >         - * 1. Sysctl (CTL_BUS, BUS_ISA, ISA_*).  This is
>         the
>         >         preferred method=20
>         >         + * 1. Sysctl (CTL_BUS, CTL_BUS_ISA, ISA_*).  This
>         is the
>         >         preferred method
>         >           *    but not all kernels support it.
>         >           *
>         >           * 2. Read the value (not the contents) of symlink=20
>         >         PATH_ARM_SYSTYPE.
>         >         @@ -100,8 +106,8 @@
>         >         {
>         >            char systype[256];
>         >            int i, n;
>         >         -  static int iobase_name[] =3D { CTL_BUS, BUS_ISA,=20
>         >         BUS_ISA_PORT_BASE };
>         >         -  static int ioshift_name[] =3D { CTL_BUS, BUS_ISA,
>         >         BUS_ISA_PORT_SHIFT };
>         >         +  static int iobase_name[] =3D { CTL_BUS,
>         CTL_BUS_ISA,
>         >         BUS_ISA_PORT_BASE };=20
>         >         +  static int ioshift_name[] =3D { CTL_BUS,
>         CTL_BUS_ISA,
>         >         BUS_ISA_PORT_SHIFT };
>         >            size_t len =3D sizeof(io.base);
>         >
>         >            if (! sysctl (iobase_name, 3, &io.io_base, &len,
>         NULL, 0)=20
>         >
>         >
>         >
>         >         --- string/strcoll.c    2004/03/14 20:51:30     1.33
>         >         +++ string/strcoll.c    2005/03/17 21:06:24     1.34
>         >         @@ -23,6 +23,7 @@
>         >         # define STRING_TYPE char=20
>         >         # define STRCOLL strcoll
>         >         # define STRCOLL_L __strcoll_l
>         >         +# define USE_HIDDEN_DEF
>         >         #endif
>         >
>         >         #include "../locale/localeinfo.h"
>         >         @@ -35,6 +36,7 @@
>         >         {
>         >            return STRCOLL_L (s1, s2, _NL_CURRENT_LOCALE);
>         >         }
>         >         -#if !defined WIDE_CHAR_VERSION
>         >         -libc_hidden_def (strcoll)=20
>         >         +
>         >         +#ifdef USE_HIDDEN_DEF
>         >         +libc_hidden_def (STRCOLL)
>         >         #endif
>         >
>         >
>         >
>         >         --- include/wchar.h     2004/03/14 20:45:10     1.26
>         >         +++ include/wchar.h     2005/03/17 21:06:24     1.27
>         >         @@ -56,7 +56,6 @@
>         >         extern int __wcsncasecmp (__const wchar_t *__s1,
>         __const
>         >         wchar_t *__s2,
>         >                                   size_t __n)
>         >               __attribute_pure__;=20
>         >         -extern int __wcscoll (__const wchar_t *__s1,
>         __const wchar_t
>         >         *__s2);
>         >         extern size_t __wcslen (__const wchar_t *__s)
>         >         __attribute_pure__;
>         >         extern size_t __wcsnlen (__const wchar_t *__s,
>         size_t=20
>         >         __maxlen)
>         >               __attribute_pure__;
>         >
>         >
>         ***************************************************************=
****************
>         >
>         >         On Wed, 2006-01-25 at 09:37 +0000, Steve
>         Papacharalambous=20
>         >         wrote:
>         >         > Hi Vineet,
>         >         >
>         >         > I was looking at your steps on how to build a
>         gcc-4.0
>         >         toolchain for ARM:
>         >         >
>         >         >=20
>         >
>         http://linux.omap.com/pipermail/linux-omap-open-source/2005-Nov=
ember/005665.html
>         >         >
>         >         > The patches for glibc-2.3.5 that you mention don't
>         appear to
>         >         be attached
>         >         > to the page, can you let me know where I can get
>         these
>         >         patches please?
>         >         >
>         >         > Thanks,=20
>         >         >
>         >         > Steve
>         >         >
>         >
>         >         _______________________________________________
>         >         Linux-omap-open-source mailing list
>         >         Linux-omap-open-source@linux.omap.com
>         >
>         http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>         >
>         >
>         >
>         > --
>         > Thanks && Regards
>         > Msc. Bsc. Lu=C3=ADs Vit=C3=B3rio Cargnini
>         > IEEE Member
>         > Mastering Degree student @ PUC-RS Electrical Engineer
>         Faculty
>        =20
>=20
>=20
>=20
> --=20
> Thanks && Regards
> Msc. Bsc. Lu=C3=ADs Vit=C3=B3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
