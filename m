From: "naga rajan" <nagubk82@gmail.com>
Subject: Problem with DSP Gateway
Date: Sat, 25 Mar 2006 17:00:41 +0530
Message-ID: <7e6cc7550603250330t2a65070by751ae84dab21ff62@mail.gmail.com>
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

Hi all,

            While executing the DSP Gateway 3.3 version application in
kernel 2.6.12 in OSK5912, I am getting the following error.


# dspctl start demo_console.out

Warning: none of /sys/devices/platform/dsp.0/ifver,
/sys/devices/platform/dsp0/i

fver or /sys/devices/platform/dsp/ifver is found.

(DSP Gateway driver is too old or not loaded)

loading demo_console.out...<1>Unable to handle kernel paging request at
virtual

address e0010000



dspgw_task      : adr =3D 0x00c4pgd =3D c1924000

d4, size=3D   36

dspgw_version  [e0010000] *pgd=3D00000000 : adr =3D 0x000000, size=3D    8 =
 .

.. ignored.

Internal error: Oops: 805 [#5]

Modules linked in:

CPU: 0

PC is at .cfu_0fupi+0x10/0x50

LR is at intmem_write+0x8c/0xdc

pc : [<c0100878>]    lr : [<c003c8ac>]    Not tainted

sp : c1d3bed8  ip : 00000000  fp : c1d3bf1c

r10: e0010000  r9 : c024c65c  r8 : c1d3bf74

r7 : 00000008  r6 : 00000008  r5 : 00000008  r4 : beb06d4c

r3 : 00000000  r2 : 00000004  r1 : beb06d50  r0 : e0010000

Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user

Control: 5317F  Table: 11924000  DAC: 00000015

Process dspctl (pid: 762, stack limit =3D 0xc1d3a194)

Stack: (0xc1d3bed8 to 0xc1d3c000)

bec0:                                                       e0010000
00000008

bee0: beb06d4c 00000008 00000008 00000008 c003c8ac 00028000 00000000
c1d3bf74

bf00: beb06d4c 00000008 e0010000 c1c24580 c1d3bf48 c1d3bf20 c003ca58
c003c830

bf20: 00000008 00000000 beb06d4c c1c24580 c1d3a000 00000000 c1d3bf74
c1d3bf70

bf40: c1d3bf4c c00850a4 c003c9e8 c1c245a4 fffffff7 c1c24580 c1d3bf74
00010000

bf60: 4014bafc c1d3bfa4 c1d3bf74 c00851e0 c0084ff0 00010000 00000000
00000000

bf80: beb06ea4 4001df40 0000c574 00000004 c0022e04 c1d3a000 00000000
c1d3bfa8

bfa0: c0022c80 c00851a0 beb06ea4 c0029c18 00000005 beb06d4c 00000008
beb06d4c

bfc0: beb06ea4 4001df40 0000c574 00000003 4014e1d0 000089f4 4014bafc
beb06da8

bfe0: 00000000 beb06d44 00003f64 400ec830 60000010 00000005 00000000
00000000

Backtrace:

[<c003c820>] (intmem_write+0x0/0xdc) from [<c003ca58>]
(dsp_mem_write+0x80/0xb4)



[<c003c9d8>] (dsp_mem_write+0x0/0xb4) from [<c00850a4>]
(vfs_write+0xc4/0x13c)

[<c0084fe0>] (vfs_write+0x0/0x13c) from [<c00851e0>] (sys_write+0x50/0x74)

[<c0085190>] (sys_write+0x0/0x74) from [<c0022c80>]
(ret_fast_syscall+0x0/0x2c)

 r9 =3D C1D3A000  r8 =3D C0022E04  r7 =3D 00000004  r6 =3D 0000C574

 r5 =3D 4001DF40  r4 =3D BEB06EA4

Code: e2522004 4282c004 4a000026 e4b13004 (e4803004)

 Segmentation fault

#



Please provide a solution.





Thanks in advance,

B.Nagarajan,

SANDS
