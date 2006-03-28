From: <Kiyotaka.Takahashi@nokia.com>
Subject: RE: DSP Gateway for OMAP5912
Date: Wed, 29 Mar 2006 01:32:19 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F5502107672@toebe101.NOE.Nokia.com>
References: <7e6cc7550603280236v64c1e9fatca40c3045045881e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7e6cc7550603280236v64c1e9fatca40c3045045881e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: nagubk82@gmail.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I'm using Linux 2.6.12 + OMAP patch from www.muru.com with DSP Gateway
3.3 on OSK5912. But I have not seen such problem so far... Did you try
the other sample program (e.g. task_test?, hellotimer, etc.)?=20

BR,
Kiyotaka

-----Original Message-----
From:
linux-omap-open-source-bounces+kiyotaka.takahashi=3Dnokia.com@linux.omap.=
c
om
[mailto:linux-omap-open-source-bounces+kiyotaka.takahashi=3Dnokia.com@lin=
u
x.omap.com] On Behalf Of ext naga rajan
Sent: Tuesday, March 28, 2006 7:37 PM
To: linux-omap-open-source@linux.omap.com
Subject: DSP Gateway for OMAP5912

Hi all,


         I like to proceed with DSP gateway for DSP applications
development. I like to know the exact kernel, DSP gateway version and
the
exact patches for kernel 2.6 series and for DSP gateway.I tried with
kernel
2.6.12 and DSP gateway 3.3. While executing the application, I m getting
the
following error


# dspctl start demo_console.out

loading demo_console.out...

dspgw_task      : adr =3D 0x00c440, size=3D   36

dspgw_version   : adr =3D 0x000000, size=3D    8  ... ignored.

Unable to handle kernel paging request at virtual address e0010000

pgd =3D c1d30000

[e0010000] *pgd=3D00000000

Internal error: Oops: 805 [#1]

Modules linked in:

CPU: 0

PC is at .cfu_0fupi+0x10/0x50

LR is at intmem_write+0x8c/0xdc

pc : [<c01009d8>]    lr : [<c003ca04>]    Not tainted

sp : c1cf7ed8  ip : 00000000  fp : c1cf7f1c

r10: e0010000  r9 : c024c6dc  r8 : c1cf7f74

r7 : 00000008  r6 : 00000008  r5 : 00000008  r4 : be913d5c

r3 : 00000000  r2 : 00000004  r1 : be913d60  r0 : e0010000

Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user

Control: 5317F  Table: 11D30000  DAC: 00000015

Process dspctl (pid: 723, stack limit =3D 0xc1cf6194)

Stack: (0xc1cf7ed8 to 0xc1cf8000)

7ec0:                                                       e0010000
00000008

7ee0: be913d5c 00000008 00000008 00000008 c003ca04 00028000 00000000
c1cf7f74

7f00: be913d5c 00000008 e0010000 c02ea760 c1cf7f48 c1cf7f20 c003cbb0
c003c988

7f20: 00000008 00000000 be913d5c c02ea760 c1cf6000 00000000 c1cf7f74
c1cf7f70

7f40: c1cf7f4c c00851fc c003cb40 c02ea784 fffffff7 c02ea760 c1cf7f74
00010000

7f60: 4014bafc c1cf7fa4 c1cf7f74 c0085338 c0085148 00010000 00000000
00000000

7f80: be913eb4 4001df40 0000c570 00000004 c0022e04 c1cf6000 00000000
c1cf7fa8

7fa0: c0022c80 c00852f8 be913eb4 c0029c18 00000005 be913d5c 00000008
be913d5c

7fc0: be913eb4 4001df40 0000c570 00000003 4014e1d0 000089f0 4014bafc
be913db8

7fe0: 00000000 be913d54 00003f64 400ec830 60000010 00000005 00000000
00000000

Backtrace:

[<c003c978>] (intmem_write+0x0/0xdc) from [<c003cbb0>]
(dsp_mem_write+0x80/0xb4)



[<c003cb30>] (dsp_mem_write+0x0/0xb4) from [<c00851fc>]
(vfs_write+0xc4/0x13c)

[<c0085138>] (vfs_write+0x0/0x13c) from [<c0085338>]
(sys_write+0x50/0x74)

[<c00852e8>] (sys_write+0x0/0x74) from [<c0022c80>]
(ret_fast_syscall+0x0/0x2c)

 r9 =3D C1CF6000  r8 =3D C0022E04  r7 =3D 00000004  r6 =3D 0000C570

 r5 =3D 4001DF40  r4 =3D BE913EB4

Code: e2522004 4282c004 4a000026 e4b13004 (e4803004)

 Segmentation fault



                                   I tried with patches mentioned in the
source forge.net. If you have succeeded this problem,I like to know the
details such as kernel.DSP gateway and patches you used. Please help me
in
this regard.



Thanks in advance,

B.Nagarajan,

SANDS.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
