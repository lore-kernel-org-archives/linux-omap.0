From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: regression: crash from 'ls /sys/modules/wl1251_spi/notes'
Date: Fri, 1 Jan 2010 11:08:01 +0800
Message-ID: <2375c9f90912311908r667966e1m919430c40cd9c571@mail.gmail.com>
References: <87k4w4wux9.fsf@purkki.valot.fi>
	 <1262188157.2749.21.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751896Ab0AADII@vger.kernel.org>
In-Reply-To: <1262188157.2749.21.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, Helge Deller <deller@gmx.de>, rusty@rustcorp.com.au, akpm@linux-foundation.org, roland@redhat.com, dave@hiauly1.hia.nrc.ca, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 30, 2009 at 11:49 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2009-12-30 at 13:41 +0200, Kalle Valo wrote:
>> Hello,
>>
>> I noticed weird crashes related to wl1251_spi notes sysfs directory
>> with current wireless-testing (2.6.33-rc2 plus some wireless patches=
).
>> The simplest way to reproduce the problem is to do this on a nokia n=
900
>> (arm/omap 3430):
>>
>> # ls /sys/module/wl1251_spi/notes/
>> [ 4776.503234] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>> [ 4776.511596] pgd =3D cce88000
>> [ 4776.514343] [00000000] *pgd=3D8f04a031, *pte=3D00000000, *ppte=3D=
00000000
>> [ 4776.520812] Internal error: Oops: 17 [#1]
>> [ 4776.524871] last sysfs file: /sys/class/net/wlan0/flags
>> [ 4776.530151] Modules linked in: wl1251_spi wl1251 mac80211 cfg8021=
1
>> [ 4776.536468] CPU: 0 =C2=A0 =C2=A0Not tainted =C2=A0(2.6.33-rc2-wl-=
47091-g981eb84
>> #12)
>> [ 4776.542999] PC is at strlen+0xc/0x20
>> [ 4776.546630] LR is at sysfs_readdir+0x15c/0x1e0
>> [ 4776.551116] pc : [<c01476ac>] =C2=A0 =C2=A0lr : [<c00f5e6c>] =C2=A0=
 =C2=A0psr: a0000013
>> [ 4776.551147] sp : cce87f28 =C2=A0ip : 22222222 =C2=A0fp : be99961c
>> [ 4776.562744] r10: cce87f80 =C2=A0r9 : 00000000 =C2=A0r8 : 00000000
>> [ 4776.568023] r7 : c00b9540 =C2=A0r6 : cce87f80 =C2=A0r5 : ccec4458=
 =C2=A0r4 :
>> ce808980
>> [ 4776.574615] r3 : 00000000 =C2=A0r2 : 00000002 =C2=A0r1 : 22222222=
 =C2=A0r0 :
>> 00000000
>> [ 4776.581207] Flags: NzCv =C2=A0IRQs on =C2=A0FIQs on =C2=A0Mode SV=
C_32 =C2=A0ISA ARM
>> Segment user
>> [ 4776.588409] Control: 10c5387d =C2=A0Table: 8ce88019 =C2=A0DAC: 00=
000015
>> [ 4776.594238] Process ls (pid: 1148, stack limit =3D 0xcce862e8)
>> [ 4776.599945] Stack: (0xcce87f28 to 0xcce88000)
>> [ 4776.604370] 7f20: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 00000001 00000000 00000e16
>> 00000000 00000004 22222222
>> [ 4776.612640] 7f40: ce808980 ce808980 cf79e34c c00b9540 00000000
>> cf79e2b8 cce86000 c00b982c
>> [ 4776.620910] 7f60: 00000001 00000000 00001000 000690d0 ce808980
>> c002bae4 00000000 c00b98c4
>> [ 4776.629180] 7f80: 00069100 000690e8 00000fd0 ffffffea 00000000
>> 00000000 00000000 00000000
>> [ 4776.637451] 7fa0: 000000d9 c002b940 00000000 00000000 00000003
>> 000690d0 00001000 00000000
>> [ 4776.645721] 7fc0: 00000000 00000000 00000000 000000d9 000690c8
>> 00000001 00000000 be99961c
>> [ 4776.654022] 7fe0: 400ef954 be999614 400efa10 400ef908 60000010
>> 00000003 80c69021 80c69421
>> [ 4776.662292] [<c01476ac>] (strlen+0xc/0x20) from [<c00f5e6c>]
>> (sysfs_readdir+0x15c/0x1e0)
>> [ 4776.670501] [<c00f5e6c>] (sysfs_readdir+0x15c/0x1e0) from
>> [<c00b982c>] (vfs_readdir+0x80/0xb4)
>> [ 4776.679229] [<c00b982c>] (vfs_readdir+0x80/0xb4) from [<c00b98c4>=
]
>> (sys_getdents64+0x64/0xb4)
>> [ 4776.687866] [<c00b98c4>] (sys_getdents64+0x64/0xb4) from
>> [<c002b940>] (ret_fast_syscall+0x0/0x38)
>> [ 4776.696838] Code: c027700c e1a03000 ea000000 e2833001 (e5d32000)
>> [ 4776.703063] ---[ end trace 6a3b0fdf4e9def99 ]---
>> [ 4776.707794] Kernel panic - not syncing: Fatal exception
>
>> Also removing wl1251_spi causes a crash. The reason for this is that=
 a
>> sysfs file with a null string as name is trying to be removed from t=
he
>> notes directory.
>
> Yes, this is because the notes sections describe the text sections.
> When we ignore an empty text section, we'd need to ignore its
> corresponding notes section.
>
> The reason we didn't see this on parisc is because our compiler doesn=
't
> actually produce any notes sections.
>
>> I found out that reverting this patch solves the problem:
>>
>> =C2=A0 commit 35dead4235e2b67da7275b4122fed37099c2f462
>> =C2=A0 Author: Helge Deller <deller@gmx.de>
>> =C2=A0 Date: =C2=A0 Thu Dec 3 00:29:15 2009 +0100
>>
>> =C2=A0 =C2=A0 modules: don't export section names of empty sections =
via sysfs
>>
>> =C2=A0 =C2=A0 On the parisc architecture we face for each and every =
loaded
>> =C2=A0 =C2=A0 kernel module this kernel "badness warning":
>>
>> =C2=A0 =C2=A0 =C2=A0 sysfs: cannot create duplicate filename
>> =C2=A0 =C2=A0 '/module/ac97_bus/sections/.text'
>> =C2=A0 =C2=A0 =C2=A0 Badness at fs/sysfs/dir.c:487
>>
>> =C2=A0 =C2=A0 Reason for that is, that on parisc all kernel modules =
do have
>> =C2=A0 =C2=A0 multiple .text sections due to the usage of the
>> =C2=A0 =C2=A0 -ffunction-sections compiler flag which is needed to r=
each all
>> =C2=A0 =C2=A0 jump targets on this platform.
>>
>> =C2=A0 =C2=A0 An objdump on such a kernel module gives:
>> =C2=A0 =C2=A0 Sections:
>> =C2=A0 =C2=A0 Idx Name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size =C2=A0=
 =C2=A0 =C2=A0VMA =C2=A0 =C2=A0 =C2=A0 LMA =C2=A0 =C2=A0 =C2=A0 File of=
f =C2=A0Algn
>> =C2=A0 =C2=A0 =C2=A0 0 .note.gnu.build-id 00000024 =C2=A000000000 =C2=
=A000000000 =C2=A000000034
>> =C2=A0 =C2=A0 2**2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 CONTENTS, ALLOC, LOAD, READONLY, DATA
>> =C2=A0 =C2=A0 =C2=A0 1 .text =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000000 =C2=
=A000000000 =C2=A000000000 =C2=A000000058 =C2=A02**0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 CONTENTS, ALLOC, LOAD, READONLY, CODE
>> =C2=A0 =C2=A0 =C2=A0 2 .text.ac97_bus_match 0000001c =C2=A000000000 =
=C2=A000000000 =C2=A000000058
>> =C2=A0 =C2=A0 2**2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 CONTENTS, ALLOC, LOAD, READONLY, CODE
>> =C2=A0 =C2=A0 =C2=A0 3 .text =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000000 =C2=
=A000000000 =C2=A000000000 =C2=A0000000d4 =C2=A02**0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 CONTENTS, ALLOC, LOAD, READONLY, CODE
>> =C2=A0 =C2=A0 ...
>> =C2=A0 =C2=A0 Since the .text sections are empty (size of 0 bytes) a=
nd won't be
>> =C2=A0 =C2=A0 loaded by the kernel module loader anyway, I don't see=
 a reason
>> =C2=A0 =C2=A0 why such sections need to be listed under
>> =C2=A0 =C2=A0 /sys/module/<module_name>/sections/<section_name> eith=
er.
>>
>> =C2=A0 =C2=A0 The attached patch does solve this issue by not export=
ing section
>> =C2=A0 =C2=A0 names which are empty.
>>
>> =C2=A0 =C2=A0 This fixes bugzilla
>> =C2=A0 =C2=A0 http://bugzilla.kernel.org/show_bug.cgi?id=3D14703
>>
>> =C2=A0 =C2=A0 Signed-off-by: Helge Deller <deller@gmx.de>
>> =C2=A0 =C2=A0 CC: rusty@rustcorp.com.au
>> =C2=A0 =C2=A0 CC: akpm@linux-foundation.org
>> =C2=A0 =C2=A0 CC: James.Bottomley@HansenPartnership.com
>> =C2=A0 =C2=A0 CC: roland@redhat.com
>> =C2=A0 =C2=A0 CC: dave@hiauly1.hia.nrc.ca
>> =C2=A0 =C2=A0 Signed-off-by: Linus Torvalds <torvalds@linux-foundati=
on.org>
>>
>> I was also able to reproduce the problem with vanilla 2.6.32. I'm
>> pretty sure (but haven't tested) that 2.6.32-rc8 does not have this
>> problem.
>>
>> My original mail containing more info:
>>
>> http://www.spinics.net/lists/linux-wireless/msg44863.html
>>
>> Simple bandaid patch below fixes the problem. I know it's not a prop=
er
>> solution, but hopefully makes it easier to understand the problem.
>> Unfortunately my knowledge about ELF is too limited to fix this
>> properly, but I can provide more information as needed. Or even try =
to
>> fix it myself if someone else holds my hand :)
>>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1189,10 +1189,13 @@ static void add_notes_attrs(struct module
>> *mod, unsigned int nsect,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!notes_attrs->dir)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>>
>> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < notes; ++i)
>> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < notes; ++i) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WARN_ON(!note=
s_attrs->attrs[i].attr.name))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysfs_cr=
eate_bin_file(notes_attrs->dir,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &notes_attrs->attrs[i]))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod->notes_attrs =3D notes_attrs;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> A better, and more comprehensive patch would be to try not to count t=
he
> empty text sections when we're building the notes section (and actual=
ly
> anywhere else in the file). =C2=A0This patch actually relies on the f=
act that
> if sh_size is zero for the text section it should be for the
> corresponding notes section. =C2=A0If that doesn't work, we'd actuall=
y have
> to do the matching in the construction piece.
>
> Can you try it to see if it works for you? =C2=A0If it doesn't, I'll =
try
> matching notes to text. =C2=A0It works fine on parisc, but as we don'=
t have a
> notes section, that's not saying much ...
>
> Thanks,
>
> James
>


This patch looks fine for me, except that I don't think it's necessary
to introduce an inline function for that...

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks!

> ---
>
> diff --git a/kernel/module.c b/kernel/module.c
> index e96b8ed..957f912 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -132,6 +132,11 @@ void __module_put_and_exit(struct module *mod, l=
ong code)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(__module_put_and_exit);
>
> +static inline int section_allocated(Elf_Shdr hdr)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (hdr.sh_flags & SHF_ALLOC) && hdr.sh_si=
ze !=3D 0;
> +}
> +
> =C2=A0/* Find a module section: 0 means not found. */
> =C2=A0static unsigned int find_sec(Elf_Ehdr *hdr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Elf_Shdr *sechdrs,
> @@ -142,7 +147,7 @@ static unsigned int find_sec(Elf_Ehdr *hdr,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 1; i < hdr->e_shnum; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Alloc bit c=
leared means "ignore it." */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((sechdrs[i].sh=
_flags & SHF_ALLOC)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (section_alloca=
ted(sechdrs[i])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&& strcmp(secstrings+sechdrs[i].sh_name, name) =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -1051,8 +1056,7 @@ static void add_sect_attrs(struct module *mod, =
unsigned int nsect,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Count loaded sections and allocate stru=
ctures */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < nsect; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sechdrs[i].sh_=
flags & SHF_ALLOC
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && s=
echdrs[i].sh_size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (section_alloca=
ted(sechdrs[i]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0nloaded++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0size[0] =3D ALIGN(sizeof(*sect_attrs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+ nloaded * sizeof(sect_attrs->attrs[0]),
> @@ -1070,9 +1074,7 @@ static void add_sect_attrs(struct module *mod, =
unsigned int nsect,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sattr =3D &sect_attrs->attrs[0];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gattr =3D &sect_attrs->grp.attrs[0];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < nsect; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (! (sechdrs[i].=
sh_flags & SHF_ALLOC))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!sechdrs[i].sh=
_size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!section_alloc=
ated(sechdrs[i]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sattr->address=
 =3D sechdrs[i].sh_addr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sattr->name =3D=
 kstrdup(secstrings + sechdrs[i].sh_name,
> @@ -1156,7 +1158,7 @@ static void add_notes_attrs(struct module *mod,=
 unsigned int nsect,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Count notes sections and allocate struc=
tures. =C2=A0*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notes =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < nsect; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((sechdrs[i].sh=
_flags & SHF_ALLOC) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (section_alloca=
ted(sechdrs[i]) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(sechdrs[i].sh_type =3D=3D SHT_NOTE))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0++notes;
>
> @@ -1172,7 +1174,7 @@ static void add_notes_attrs(struct module *mod,=
 unsigned int nsect,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notes_attrs->notes =3D notes;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nattr =3D &notes_attrs->attrs[0];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (loaded =3D i =3D 0; i < nsect; ++i) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(sechdrs[i].s=
h_flags & SHF_ALLOC))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!section_alloc=
ated(sechdrs[i]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sechdrs[i]=
=2Esh_type =3D=3D SHT_NOTE) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0nattr->attr.name =3D mod->sect_attrs->attrs[loaded].name;
> @@ -1720,7 +1722,7 @@ static char elf_type(const Elf_Sym *sym,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return '?';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sechdrs[sym->st_shndx].sh_flags & SHF_=
EXECINSTR)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 't';
> - =C2=A0 =C2=A0 =C2=A0 if (sechdrs[sym->st_shndx].sh_flags & SHF_ALLO=
C
> + =C2=A0 =C2=A0 =C2=A0 if (section_allocated(sechdrs[sym->st_shndx])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&& sechdrs[sym->st_shndx].sh=
_type !=3D SHT_NOBITS) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(sechdrs[=
sym->st_shndx].sh_flags & SHF_WRITE))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 'r';
> @@ -1751,7 +1753,7 @@ static bool is_core_symbol(const Elf_Sym *src, =
const Elf_Shdr *sechdrs,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sec =3D sechdrs + src->st_shndx;
> - =C2=A0 =C2=A0 =C2=A0 if (!(sec->sh_flags & SHF_ALLOC)
> + =C2=A0 =C2=A0 =C2=A0 if (!section_allocated(*sec)
> =C2=A0#ifndef CONFIG_KALLSYMS_ALL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| !(sec->sh_flags & SHF_EXE=
CINSTR)
> =C2=A0#endif
> @@ -1913,7 +1915,7 @@ static void kmemleak_load_module(struct module =
*mod, Elf_Ehdr *hdr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kmemleak_scan_area(mod, sizeof(struct modu=
le), GFP_KERNEL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 1; i < hdr->e_shnum; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(sechdrs[i].s=
h_flags & SHF_ALLOC))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!section_alloc=
ated(sechdrs[i]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncmp(se=
cstrings + sechdrs[i].sh_name, ".data", 5) !=3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&& strncmp(secstrings + sechdrs[i].sh_name, ".bss", 4) !=3D 0)
> @@ -2139,7 +2141,7 @@ static noinline struct module *load_module(void=
 __user *umod,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < hdr->e_shnum; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *dest;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(sechdrs[i].s=
h_flags & SHF_ALLOC))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!section_alloc=
ated(sechdrs[i]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sechdrs[i]=
=2Esh_entsize & INIT_OFFSET_MASK)
> @@ -2287,7 +2289,7 @@ static noinline struct module *load_module(void=
 __user *umod,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don't bothe=
r with non-allocated sections */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(sechdrs[info=
].sh_flags & SHF_ALLOC))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!section_alloc=
ated(sechdrs[info]))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sechdrs[i]=
=2Esh_type =3D=3D SHT_REL)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
