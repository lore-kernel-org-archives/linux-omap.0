From: Felipe Balbi <balbi@ti.com>
Subject: Re: [next-20150119]regression (mm)?
Date: Mon, 19 Jan 2015 11:43:17 -0600
Message-ID: <20150119174317.GK20386@saruman>
References: <54BD33DC.40200@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44555 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbbASRod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 12:44:33 -0500
Content-Disposition: inline
In-Reply-To: <54BD33DC.40200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 19, 2015 at 10:42:04AM -0600, Nishanth Menon wrote:
> Most platforms seem broken intoday's next tag.
>=20
> https://github.com/nmenon/kernel-test-logs/tree/next-20150119
> (defconfig: omap2plus_defconfig)
>=20
> > [    7.166600] ------------[ cut here ]------------
> > [    7.171676] WARNING: CPU: 0 PID: 54 at mm/mmap.c:2859 exit_mmap+0x1a=
8/0x21c()
> > [    7.179194] Modules linked in:
> > [    7.182479] CPU: 0 PID: 54 Comm: init Not tainted 3.19.0-rc5-next-20=
150119-00002-gfdefcded1272 #1
> > [    7.191863] Hardware name: Generic AM33XX (Flattened Device Tree)
> > [    7.198318] [<c00153f0>] (unwind_backtrace) from [<c0011a74>] (show_=
stack+0x10/0x14)
> > [    7.206528] [<c0011a74>] (show_stack) from [<c0580150>] (dump_stack+=
0x78/0x94)
> > [    7.214191] [<c0580150>] (dump_stack) from [<c003d4d0>] (warn_slowpa=
th_common+0x7c/0xb4)
> > [    7.222751] [<c003d4d0>] (warn_slowpath_common) from [<c003d524>] (w=
arn_slowpath_null+0x1c/0x24)
> > [    7.232038] [<c003d524>] (warn_slowpath_null) from [<c012de64>] (exi=
t_mmap+0x1a8/0x21c)
> > [    7.240536] [<c012de64>] (exit_mmap) from [<c003abb8>] (mmput+0x44/0=
xec)
> > [    7.247612] [<c003abb8>] (mmput) from [<c0151368>] (flush_old_exec+0=
x300/0x5a4)
> > [    7.255357] [<c0151368>] (flush_old_exec) from [<c0195c10>] (load_el=
f_binary+0x2ec/0x1144)
> > [    7.264111] [<c0195c10>] (load_elf_binary) from [<c0150ea0>] (search=
_binary_handler+0x88/0x1ac)
> > [    7.273311] [<c0150ea0>] (search_binary_handler) from [<c019554c>] (=
load_script+0x260/0x280)
> > [    7.282232] [<c019554c>] (load_script) from [<c0150ea0>] (search_bin=
ary_handler+0x88/0x1ac)
> > [    7.291066] [<c0150ea0>] (search_binary_handler) from [<c0151f0c>] (=
do_execveat_common+0x538/0x6c4)
> > [    7.300628] [<c0151f0c>] (do_execveat_common) from [<c01520c4>] (do_=
execve+0x2c/0x34)
> > [    7.308881] [<c01520c4>] (do_execve) from [<c000e5e0>] (ret_fast_sys=
call+0x0/0x4c)
> > [    7.316881] ---[ end trace 3b8a46b1b280f423 ]---

seems like it's caused by:

b316feb3c37ff19cddcaf1f6b5056c633193257d is the first bad commit

Adding Kiryl to the loop.

git bisect start
# good: [ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc] Linux 3.19-rc5
git bisect good ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc
# bad: [a0d4287f787889e59db0fd295853a0f1f55d0699] Add linux-next specific f=
iles for 20150119
git bisect bad a0d4287f787889e59db0fd295853a0f1f55d0699
# good: [1c2f70b77b8ca77f10c59d479d009e07359d00d2] Merge remote-tracking br=
anch 'drm/drm-next'
git bisect good 1c2f70b77b8ca77f10c59d479d009e07359d00d2
# good: [73c1390843223d8bfc85795c560c36b3d0ffee40] Merge remote-tracking br=
anch 'leds/for-next'
git bisect good 73c1390843223d8bfc85795c560c36b3d0ffee40
# good: [7bc6bef35d48e91ad796b6eead7304998842c782] Merge remote-tracking br=
anch 'pinctrl/for-next'
git bisect good 7bc6bef35d48e91ad796b6eead7304998842c782
# bad: [45e1eaa38732ffa3de0d18fe95d2d2b960a7c777] lib: bitmap: change bitma=
p_shift_right to take unsigned parameters
git bisect bad 45e1eaa38732ffa3de0d18fe95d2d2b960a7c777
# good: [c82a73a0369a7dd6dcfaf9e6bd572a4e5deda223] mm, page_alloc: reduce n=
umber of alloc_pages* functions' parameters
git bisect good c82a73a0369a7dd6dcfaf9e6bd572a4e5deda223
# bad: [0b1c810fbc4bbff7e314dd6ff91c2b4af499199d] mm: don't split THP page =
when syscall is called
git bisect bad 0b1c810fbc4bbff7e314dd6ff91c2b4af499199d
# good: [54faa439355a9ae476a446429967e9e38f04363e] oom, PM: make OOM detect=
ion in the freezer path raceless
git bisect good 54faa439355a9ae476a446429967e9e38f04363e
# bad: [b6c9f11c6b6993303067f7c04a73258226a6e77e] mm/compaction: add tracep=
oint to observe behaviour of compaction defer
git bisect bad b6c9f11c6b6993303067f7c04a73258226a6e77e
# good: [9ce5d3fb13a80f28db450de4ecf2727893e99c93] mm: pagemap_read: limit =
scan to virtual region being asked
git bisect good 9ce5d3fb13a80f28db450de4ecf2727893e99c93
# bad: [1a7a376546ca56e7750987c15d0c7541c17a512c] mm/compaction: change tra=
cepoint format from decimal to hexadecimal
git bisect bad 1a7a376546ca56e7750987c15d0c7541c17a512c
# bad: [4081187ff19cf2186010c003939c17d70d0bbb27] page_writeback: put accou=
nt_page_redirty() after set_page_dirty()
git bisect bad 4081187ff19cf2186010c003939c17d70d0bbb27
# bad: [b316feb3c37ff19cddcaf1f6b5056c633193257d] mm: account pmd page tabl=
es to the process
git bisect bad b316feb3c37ff19cddcaf1f6b5056c633193257d
# first bad commit: [b316feb3c37ff19cddcaf1f6b5056c633193257d] mm: account =
pmd page tables to the process

I've added a dump_mm() call when the bug happens followed by a
while (true) loop (to avoid constant reprinting of the same thing),
here's what I get:

[    7.235903] ------------[ cut here ]------------
[    7.240881] WARNING: CPU: 0 PID: 58 at mm/mmap.c:2859 exit_mmap+0x1b4/0x=
218()
[    7.248369] Modules linked in: ipv6 autofs4
[    7.252792] CPU: 0 PID: 58 Comm: systemd Not tainted 3.19.0-rc5-next-201=
50119-dirty #888
[    7.261274] Hardware name: Generic AM43 (Flattened Device Tree)
[    7.267512] [<c0015afc>] (unwind_backtrace) from [<c001221c>] (show_stac=
k+0x10/0x14)
[    7.275651] [<c001221c>] (show_stack) from [<c058972c>] (dump_stack+0x84=
/0x9c)
[    7.283249] [<c058972c>] (dump_stack) from [<c003def0>] (warn_slowpath_c=
ommon+0x78/0xb4)
[    7.291750] [<c003def0>] (warn_slowpath_common) from [<c003dfc8>] (warn_=
slowpath_null+0x1c/0x24)
[    7.300977] [<c003dfc8>] (warn_slowpath_null) from [<c0133410>] (exit_mm=
ap+0x1b4/0x218)
[    7.309376] [<c0133410>] (exit_mmap) from [<c003b5f0>] (mmput+0x44/0xec)
[    7.316385] [<c003b5f0>] (mmput) from [<c0157e68>] (flush_old_exec+0x264=
/0x5d4)
[    7.324061] [<c0157e68>] (flush_old_exec) from [<c019f180>] (load_elf_bi=
nary+0x288/0x1234)
[    7.332727] [<c019f180>] (load_elf_binary) from [<c0158304>] (search_bin=
ary_handler+0x84/0x1e8)
[    7.341857] [<c0158304>] (search_binary_handler) from [<c0158c84>] (do_e=
xecveat_common+0x53c/0x6b8)
[    7.351346] [<c0158c84>] (do_execveat_common) from [<c0158e24>] (do_exec=
ve+0x24/0x2c)
[    7.359561] [<c0158e24>] (do_execve) from [<c000e6c0>] (ret_fast_syscall=
+0x0/0x4c)
[    7.367485] ---[ end trace 633a89eb76b1d46e ]---
[    7.372360] mm ed29fa00 mmap ed29b6b8 seqnum 0 task_size 3204448256
[    7.372360] get_unmapped_area c001cfc0
[    7.372360] mmap_base 3069620224 mmap_legacy_base 0 highest_vm_end 32027=
11552
[    7.372360] pgd ed184000 mm_users 0 mm_count 1 nr_ptes 1 nr_pmds 4294967=
292 map_count 59
[    7.372360] hiwater_rss 37 hiwater_vm 37e total_vm 37e locked_vm 0
[    7.372360] pinned_vm 0 shared_vm 324 exec_vm 254 stack_vm 22
[    7.372360] start_code 10000 end_code c9d48 start_data da1b8 end_data ea=
1a4
[    7.372360] start_brk eb000 brk 10c000 start_stack becd5f10
[    7.372360] arg_start becd5fd4 arg_end becd5fdf env_start becd5fdf env_e=
nd becd5ff1
[    7.372360] binfmt c08b3158 flags cd core_state   (null)
[    7.372360] ioctx_table   (null)
[    7.372360] owner   (null) exe_file ee49d040
[    7.372360] tlb_flush_pending 0
[    7.448908] flags: 0x0()

Looking at nr_pmds, that's basically (unsigned long) -4, which tells me
we are decrementing mm->nr_pmds without incrementing first. In, when I
add:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ba5f3bcca55d..8425fb419eab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1440,11 +1440,15 @@ static inline unsigned long mm_nr_pmds(struct mm_st=
ruct *mm)
 static inline void mm_inc_nr_pmds(struct mm_struct *mm)
 {
 	atomic_long_inc(&mm->nr_pmds);
+	printk(KERN_INFO "=3D=3D=3D> %s nr_pmds %ld\n", __func__,
+			atomic_long_read(&mm->nr_pmds));
 }
=20
 static inline void mm_dec_nr_pmds(struct mm_struct *mm)
 {
 	atomic_long_dec(&mm->nr_pmds);
+	printk(KERN_INFO "=3D=3D=3D> %s nr_pmds %ld\n", __func__,
+			atomic_long_read(&mm->nr_pmds));
 }
 #endif

I start getting:

[...]

[    5.935390] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -1
[    6.236832] random: systemd urandom read with 34 bits of entropy
available
[    6.276340] systemd[1]: systemd 215 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +SYSVINIT +LIBC
RYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[    6.291380] systemd[1]: Detected architecture 'arm'.

Welcome to Debian GNU/Linux 8 (jessie)!

[    6.434013] systemd[1]: Inserted module 'autofs4'
[    7.152037] NET: Registered protocol family 10
[    7.165770] systemd[1]: Inserted module 'ipv6'
[    7.170646] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -2
[    7.174932] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -3
[    7.179427] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -4
[    7.258496] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -1
[    7.262809] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -2
[    7.267206] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -3
[    7.271486] =3D=3D=3D> mm_dec_nr_pmds nr_pmds -4
[    7.275884] ------------[ cut here ]------------
[    7.280773] WARNING: CPU: 0 PID: 58 at mm/mmap.c:2859 exit_mmap+0x1b4/0x=
218()

[...]

Which confirms my suspicion. So we never increment nr_pmds, but we
decrement it. The simplest "fix" is to make mm_nr_pmds() return a signed
long (see below) and cast roundup()'s return to (signed long), but
that's not what we really want in this case because it's clear our PMD
accounting is bogus.

Kiryl, any better idea on how to balance mm_inc_nr_pmds() and
mm_dec_nr_pmds() ?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ba5f3bcca55d..c0ce2e8a9d45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1432,7 +1432,7 @@ static inline void mm_dec_nr_pmds(struct mm_struct *m=
m) {}
 #else
 int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
=20
-static inline unsigned long mm_nr_pmds(struct mm_struct *mm)
+static inline long mm_nr_pmds(struct mm_struct *mm)
 {
 	return atomic_long_read(&mm->nr_pmds);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 25271805ab39..703474d3336b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2856,7 +2856,7 @@ void exit_mmap(struct mm_struct *mm)
 			round_up(FIRST_USER_ADDRESS, PMD_SIZE) >> PMD_SHIFT);
 #ifdef PUD_SHIFT
 	WARN_ON(mm_nr_pmds(mm) >
-			round_up(FIRST_USER_ADDRESS, PUD_SIZE) >> PUD_SHIFT);
+			(signed long) round_up(FIRST_USER_ADDRESS, PUD_SIZE) >> PUD_SHIFT);
 #endif
 }
=20

--=20
balbi

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvUI1AAoJEIaOsuA1yqREuUQP/iWrKso8cMX6jbtfud2cVwEu
1HMEWzFZW89kfFqNvrtX2QuwFjcM0ZWCyZcGT2H71fAM0kS4huzuSWbhojXsIob7
OeItU9jpOHeFB0hUIk7e0uztOLrIQMLz9HVGOC38wVL5T73mPb7tUM09aomr1qMq
4LH2gJ5/AWAwJuyepesNBDxqkKfIfDm1YbNyPl+tJDn0PCM3Lc6cNsPmpT8Vtgso
TFdkANBV9DWKhG3EmFAl1ksfH+DlvnnDB2LexouFArgRYUJ40u89nP/x/9NOPB5e
FKFI5WN12PCiyjGyhpqSRioqloDUZuifZ0PNATxa1eGJn7aQ8H79iyyFpCpW0Ck8
vkKApMwJMcAquybg/Q7bLC2GODjIYWEsX5BWgTYg1n9IF3fz2RVozmjpW9jLQjF/
/2ZXOKTV7QnNMRNDu4OsUZYqmx1XQv1KM9GU/YupU7KbRRHLLbII6MQjvyRnmEq0
/HAZxzuOcvTgnvINWnwYxQ2KbOT5pq4JhlNcW5omMIuXWAQJSyDdWUAvxPXPDYxt
74ojiuy93UXxCxJhpYWFhBfgYIL3s/sY7YWxDKIy9h22VN5VMOkHlWbQcKIdIG38
GWPVtfMkrYwWDhMrhFGodxn36ztLeKcpmcQagTxZMKpxJh1OFnRGBoRXpi6MWpCu
WfdeWXHLci36ozdiq8MH
=GipU
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
