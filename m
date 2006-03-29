From: "naga rajan" <nagubk82@gmail.com>
Subject: DSP Gateway Problem
Date: Wed, 29 Mar 2006 19:00:22 +0530
Message-ID: <7e6cc7550603290530s4313c15fn93433526166e5a62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

With reference to your mail, I patched the kernel 2.6.12 with "
patch-2.6.12-omap1" from www.muru.com and "patch-2.6.12-omap1-dspgw3.3" fro=
m
sourceforge.net for DSP gateway. I built the kernel image and mounted the
filesystem with demo programs for dspgateway3.3. While executing the
demo_console.out, I am getting the following error.
#dspctl start demo_console.out

loading demo_console.out...

dspgw_task : adr =3D 0x00c440, size=3D 36

dspgw_version : adr =3D 0x000000, size=3D 8 ... ignored.

*Unable to handle kernel paging request at virtual address e0010000*

pgd =3D c1dc8000

[e0010000] *pgd=3D00000000

Internal error: Oops: 805 [#1]

Modules linked in:

CPU: 0

PC is at .cfu_0fupi+0x10/0x50

LR is at intmem_write+0x8c/0xdc

pc : [<c01054f8>] lr : [<c0040c4c>] Not tainted

sp : c1da1ed8 ip : 00000000 fp : c1da1f1c

r10: e0010000 r9 : c02963b4 r8 : c1da1f74

r7 : 00000008 r6 : 00000008 r5 : 00000008 r4 : beb80d5c

r3 : 00000000 r2 : 00000004 r1 : beb80d60 r0 : e0010000

r3 : 00000000 r2 : 00000004 r1 : beb80d60 r0 : e0010000

Control: 5317F Table: 11DC8000 DAC: 00000015

Process dspctl (pid: 730, stack limit =3D 0xc1da0194)

Stack: (0xc1da1ed8 to 0xc1da2000)

1ec0: e0010000 00000008

1ee0: beb80d5c 00000008 00000008 00000008 c0040c4c 00028000 00000000
c1da1f74

1f00: beb80d5c 00000008 e0010000 c0336e40 c1da1f48 c1da1f20 c0040df8
c0040bd0

1f20: 00000008 00000000 beb80d5c c0336e40 c1da0000 00000000 c1da1f74
c1da1f70

1f40: c1da1f4c c0089620 c0040d88 c0336e64 fffffff7 c0336e40 c1da1f74
00010000

1f60: 4014bafc c1da1fa4 c1da1f74 c008975c c008956c 00010000 00000000
00000000

1f80: beb80eb4 4001df40 0000c570 00000004 c0026e04 c1da0000 00000000
c1da1fa8

1fa0: c0026c80 c008971c beb80eb4 c002dc18 00000005 beb80d5c 00000008
beb80d5c

1fc0: beb80eb4 4001df40 0000c570 00000003 4014e1d0 000089f0 4014bafc
beb80db8

1fe0: 00000000 beb80d54 00003f64 400ec830 60000010 00000005 00000000
00000000

Backtrace:

[<c0040bc0>] (intmem_write+0x0/0xdc) from [<c0040df8>]

(dsp_mem_write+0x80/0xb4)

[<c0040d78>] (dsp_mem_write+0x0/0xb4) from [<c0089620>]
(vfs_write+0xc4/0x13c)

[<c008955c>] (vfs_write+0x0/0x13c) from [<c008975c>] (sys_write+0x50/0x74)

[<c008970c>] (sys_write+0x0/0x74) from [<c0026c80>]

(ret_fast_syscall+0x0/0x2c)

r9 =3D C1DA0000 r8 =3D C0026E04 r7 =3D 00000004 r6 =3D 0000C570

r5 =3D 4001DF40 r4 =3D BEB80EB4

Code: e2522004 4282c004 4a000026 e4b13004 (e4803004)
Segmentation fault


                I also tried with other programs given in dspgateway,but th=
e
result is same ending with an error. I like to know the exact patch for the
kernel that you have succeeded. Please provide a solution.

Thanks in advance,

Nagaraj,

SANDS Instrumentation
