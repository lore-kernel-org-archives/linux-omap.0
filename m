From: "Bharat Kumar Reddy" <bharat.mailing@gmail.com>
Subject: Re: Compact Flash Issue on OSK 5912
Date: Mon, 8 May 2006 10:14:36 +0530
Message-ID: <31bab3780605072144m642dc628gfd348f59adeb98aa@mail.gmail.com>
References: <31bab3780605050815v5906b07ap994bcb3204a8b49d@mail.gmail.com>
	<200605051322.42634.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605051322.42634.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello All,
Thanks Dave for you response

Dump of stack backtraces when I tried to copy a file to CF mount point.
################################################################
 Unable to handle kernel paging request at virtual address aa55aacd
pgd =3D c0004000
[aa55aacd] *pgd=3D00000000
Internal error: Oops: 1 [#1]
Modules linked in:
CPU: 0
PC is at do_page_fault+0x38/0x214
LR is at do_translation_fault+0x2c/0xac
pc : [<c002b8dc>]    lr : [<c002bae4>]    Not tainted
sp : c03420b4  ip : 0055aa00  fp : c03420e8
r10: aa55aacd  r9 : c03421bc  r8 : c03421bc
r7 : 00000005  r6 : 00000005  r5 : aa55aa55  r4 : ffffffff
r3 : c0342000  r2 : c03421bc  r1 : 00000005  r0 : aa55aacd
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F  Table: 10324000  DAC: 00000017
Process kthread (pid: 5, stack limit =3D 0xc0340194)
Stack: (0xc03420b4 to 0xc0342000)
Backtrace:
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C03421BC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C03422FC  r5 =3D C03421F0
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C034244C  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0342330
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C034244C  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C034258C  r5 =3D C0342480
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078 8
[<c002cf4c>] m [<c0024960>] (__dabt_svc+0x40/0x60)
 r8 =3D C03426DC  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C03425C0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C03426DC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C034281C  r5 =3D C0342710
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_0alignment+0x0/054) from [<c002bbfn8>]
(do_DataAbo0000005  r6 =3D 00000005  r5 =3D C030 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C034296C  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C0342AAC  r5 =3D C03429A0
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C0342BFC  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0342AE0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C0342BFC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0 x0/0xa0) from [=3D AA55AACD  r7 =3D C002B8DC=
=20
r6 =3D C0342D3C  r5 =3D C0342C30
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C0342E8C  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0342D70
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C0342E8C  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C0342FCC  r5 =3D DC0342EC0
 r4 =3D1d0/0x354)
 r4 =3DC 00000078
[<cfrom [<c0024960>] (__dabt_svc+0x40/0x60)
 r8 =3D C034311C  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0343000
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C034311C  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C034325C  r5 =3D C0343150
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C03433AC  r7 =3D 000)00005  r6 =3D 0000xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C03433AC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C03434EC  r5 =3D C03433E0
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C034363C  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0343520
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_faublt+0x0/0xac) frc002bbf8>]
(do_DabtaAbort+0x3c/0xrt+0x0/0xa0) from ) r8 =3D AA55AACD  r7 =3D C002B8DC
 r6 =3D C034377C  r5 =3D C0343670
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C03438CC  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C03437B0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C03438CC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c00o24960>] (__dabtx60)
 r8 =3D AA55AoACD  r7 =3D C002Bc>] (do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C0343B5C  r7 =3D 00000005  r6 =3D 00000005  r5 =3D C0343A40
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C0343B5C  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C0343C9C  r5 =3D C0343B90
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>]
(do_DaftaAbort+0x3c/0xr6 =3D 00000005  r5 =3D C0 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bae4>]
(do_translation_fault+0x2c/0xac)
[<c002bab8>] (do_translation_fault+0x0/0xac) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
 r8 =3D AA55AACD  r7 =3D C0343DEC  r6 =3D 00000005  r5 =3D C024409C
 r4 =3D FFFFFFFF
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D AA55AACD  r7 =3D C002B8DC  r6 =3D C0343F2C  r5 =3D C0343E20
 r4 =3D FFFFFFFF
[<c002cba4>] (do_alignment_ldrstr+0x0/0x118) from [<c002d11c>]
(do_alignment+0x1d0/0x354)
 r4 =3D 00000078
[<c002cf4c>] (do_alignment+0x0/0x354) from [<c002bbf8>] (do_DataAbort+0x3c/=
0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344054  r6 =3D 00000017  r5 =3D C0343F60
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C034417C  r6 =3D 00000017  r5 =3D C0344088
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) f_rom [<c002bbf8>do_DataAbort+0x3c/0=
0xa0)
[<c002bb00017  r5 =3D C03441B0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03443CC  r6 =3D 00000017  r5 =3D C03442D8
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03444F4  r6 =3D 00000017  r5 =3D C0344400
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C034461C  r6 =3D 00000017  r5 =3D C0344528
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_pa ge_fault+0x0/0x from [<c002bbf8> ]
(do_DataAbort344744  r6 =3D 00000017  r5 =3D C030 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C034486C  r6 =3D 00000017  r5 =3D C0344778
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344994  r6 =3D 00000017  r5 =3D C03448A0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344ABC  r6 =3D 00000017  r5 =3D C03449C8
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344BE4  r6 =3D 00000017  r5 =3D C0344AF0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344D0C  r6 =3D 00000017  r5 =3D C0344C18
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0344E34  r6 =3D 00000017  r5 =3D C0344D40
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  /r7 =3D C0344F5C   from [<c002bbf8>/]
(do_DataAbort0000078  r7 =3D C0345084  r6 =3D 000000 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03451AC  r6 =3D 00000017  r5 =3D C03450B8
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03452D4  r6 =3D 00000017  r5 =3D C03451E0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03453FC  r6 =3D 00000017  r5 =3D C0345308
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x 214) from [<c00ort+0x3c/0xa0)
[ <c002bbbc>] (doC0345430
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C034564C  r6 =3D 00000017  r5 =3D C0345558
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0345774  r6 =3D 00000017  r5 =3D C0345680
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C034589C  r6 =3D 00000017  r5 =3D C03457A8
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c 002bbf8>] (do_D+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C03459C4  r6 =3D 00000017  r5 =3D C03458D0
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0345AEC  r6 =3D 00000017  r5 =3D C03459F8
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0345C14  r6 =3D 00000017  r5 =3D C0345B20
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000078  r7 =3D C0345D3C  r6 =3D 00000017  r5 =3D C0345C48
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+00x40/0x=
60)
 r8 078  r7 =3D C0345E6>4  r6 =3D 0000001xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D 00000034  r7 =3D C0345F8C  r6 =3D 00000017  r5 =3D C0345E98
 r4 =3D FFFFFFFF
[<c002b8a4>] (do_page_fault+0x0/0x214) from [<c002bbf8>]
(do_DataAbort+0x3c/0xa0)
[<c002bbbc>] (do_DataAbort+0x0/0xa0) from [<c0024960>] (__dabt_svc+0x40/0x6=
0)
 r8 =3D C03460CC  r7 =3D C03460CC  r6 =3D 00000093  r5 =3D C0345FC0
 r4 =3D FFFFFFFF
[<c003b664>] (scheduler_tick+0x0/0x2f8) from [<c0047f38>]
(update_process_times+0x114/0x130)
[<c0047e24>] (update_process_times+0x0/0x130) from [<c0029940>]
(timer_tick+0xc8/0xe4)
 r5 =3D C029BCB0  r4 =3D C03460CC
[<c0029878>] (timer_tick+0x0/0xe4) from [<c003a1f8>]
(omap_32k_timer_interrupt+0x5c/0xac)
 r6 =3D 00000093  r5 =3D C029BCB0  r4 =3D 02582194
[<c003a19c>] (omap_32k_timer_interrupto+0x0/0xac) from<c0025a08>]
(__do_oirq+0xa4/0xe8)
                                                                     =20
                >] (do_level) r8 =3D C03460CC  r7 =3D A0000013  r6 =3D
C03460CC  r5 =3D 00000036
 r4 =3D C029161C
[<c0025be8>] (do_level_IRQ+0x0/0xbc) from [<c0025cf8>] (asm_do_IRQ+0x54/0x1=
40)
 r6 =3D FFFFFFFF  r5 =3D FEFE0000  r4 =3D C0346000
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C03461EC  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C034630C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C034642C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  0r4 =3D 00000001
                                              )
[<c0025ca4>] (0asm_do_IRQ+0x0/ (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C034654C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C034666C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C034678C   r5 =3D
000000DE[<c0025a4c>] (do_simple_IRQ+0x0/0x70) f) r6 =3D 00002D18  r5 =3D
000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C03468AC  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe80)
[<c0025964>] r6 =3D C03469CC  r05 =3D 000000DE
  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C0346AEC  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C02 47834  r7 =3D C02pio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C0346D2C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [9<c0025a94>]
(dodo_simple_IRQ+0x0/0x70) from [<c0039348>] (g) r6 =3D 00002D18  r5 =3D
000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6 =3D C0346F6C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0xd1ec) from [<c000247834  r7 =3D C0293870=20
r6 =3D C034708C  r5 =3D 000000DE
 r4 =3D C029383C
[<c0025a4c>] (do_simple_IRQ+0x0/0x70) from [<c0039348>]
(gpio_irq_handler+0xd8/0xf4)
 r6 =3D 00002D18  r5 =3D 000000DF  r4 =3D 00000001
[<c0039270>] (gpio_irq_handler+0x0/0xf4) from [<c0025cf8>]
(asm_do_IRQ+0x54/0x140)
[<c0025ca4>] (asm_do_IRQ+0x0/0x140) from [<c00249a4>] (__irq_svc+0x24/0x80)
[<c0163ccc>] (ide_intr+0x0/0x1ec) from [<c0025a08>] (__do_irq+0xa4/0xe8)
[<c0025964>] (__do_irq+0x0/0xe8) from [<c0025a94>] (do_simple_IRQ+0x48/0x70=
)
 r8 =3D C0247834  r7 =3D C0293870  r6
################################################################

Thanks in Advance,
Bharat.

On 5/6/06, David Brownell <david-b@pacbell.net> wrote:
> On Friday 05 May 2006 8:15 am, Bharat Kumar Reddy wrote:
> >
> > Has anyone faced these problems before and are there any patch fixes fo=
r
> this ?
>
> Post any stack backtraces you get.  I saw similar rudeness on 2.6.17-curr=
ent
> but ISTR that 2.6.14-omap didn't have problems there.  It's not clear wha=
t
> the problems are; my symptoms pointed more at IDE layer confusions with
> respect
> to IRQ handling.
>
>
>
