From: "Ramirez Luna, Omar" <omar.ramirez-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
	from dt
Date: Tue, 10 Apr 2012 19:16:56 -0500
Message-ID: <CAB-zwWjSSsR0XMrntkEmHDtgJ_zDxgJh6KX=TsSKggd9mCgsVQ@mail.gmail.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
	<1323863746-18145-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1323863746-18145-5-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 14, 2011 at 5:55 AM, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> wrote:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
...
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/bo=
ard-generic.c
> index 63b5416..a508ed5 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -69,7 +69,6 @@ static void __init omap_generic_init(void)
> =A0 =A0 =A0 =A0if (node)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_domain_add_simple(node, 0);
>
> - =A0 =A0 =A0 omap_serial_init();
> =A0 =A0 =A0 =A0omap_sdrc_init(NULL, NULL);
>
> =A0 =A0 =A0 =A0of_platform_populate(NULL, omap_dt_match_table, NULL, NULL=
);
> --
> 1.7.1

I'm fairly new to DT and I'm trying to boot it with pandaboard and
k3.3, however above hunk deletes omap serial initialization, which
causes a panic on boot, because pdata is NULL:

static void serial_omap_start_tx(struct uart_port *port)
{
...
                if (pdata->set_noidle)

Perhaps because this change skips the following path:

omap_serial_init->omap_serial_board_init->omap_serial_init_port

Where pdata is built in omap_device_build.

I'm just trying to confirm that I'm not alone or doing some silly
thing before getting in depth with the code.

Here it is the panic:

[    2.024688] Unable to handle kernel NULL pointer dereference at
virtual address 00000028
[    2.031005] pgd =3D ed6f0000
[    2.036315] [00000028] *pgd=3Daf339831, *pte=3D00000000, *ppte=3D00000000
[    2.042907] Internal error: Oops: 17 [#1] SMP
[    2.046630] Modules linked in:
[    2.046630] CPU: 0    Not tainted  (3.3.0-00002-gda19af1-dirty #11)
[    2.046630] PC is at serial_omap_start_tx+0x1cc/0x218
[    2.046630] LR is at serial_omap_start_tx+0x1b8/0x218
[    2.067840] pc : [<c02b3a54>]    lr : [<c02b3a40>]    psr: 60000193
[    2.067840] sp : c21cbe70  ip : 00000001  fp : a0000113
[    2.073699] r10: ef107000  r9 : ed684600  r8 : 0000001c
[    2.085327] r7 : 00000002  r6 : 00000007  r5 : 00000000  r4 : ed684600
[    2.086029] r3 : ef1281c0  r2 : fa020000  r1 : 00000004  r0 : c02b3a40
[    2.086029] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[    2.101684] Control: 10c53c7d  Table: ad6f004a  DAC: 00000015
[    2.101684] Process S10udev (pid: 497, stack limit =3D 0xc21ca2f8)
[    2.116973] Stack: (0xc21cbe70 to 0xc21cc000)
[    2.123443] be60:                                     a0000113
c0475b74 00000002 00000000
[    2.126007] be80: c02ac7e0 ef107000 ed684600 20000113 00000000
c02ac830 00000000 ed690ad0
[    2.139099] bea0: ed6e981c c02ae348 c02ae288 ef107000 c21ca000
0000001c ed6e9800 ef1074fc
[    2.145385] bec0: c049cab4 ef1dcd80 ed6e9800 c0296aa8 60000113
c02925e8 ef107194 ef107120
[    2.152191] bee0: ef0003c0 00000000 ef1281c0 c0076214 ef1071b4
ef1071b4 ef1074b4 ef1dcd80
[    2.159790] bf00: ef107000 b6f5c000 0000001c c21ca000 00000400
00000000 c02968c8 c0292638
[    2.159790] bf20: c06e3ea0 0000001c c02968c8 ef168b80 c21cbf80
00000000 ef1281c0 ef1dcd80
[    2.175811] bf40: 0000001c b6f5c000 c21cbf80 00000000 00000000
00000000 00000000 c010841c
[    2.188476] bf60: c0014400 ef1281c0 ef1dcd80 b6f5c000 0000001c
00000004 00000000 c0108570
[    2.195068] bf80: 00000000 00000000 0000001c 00000000 0000001c
b6f345c8 0000001c c00144a8
[    2.195068] bfa0: c21ca000 c00142e0 0000001c b6f345c8 00000001
b6f5c000 0000001c 00000000
[    2.210723] bfc0: 0000001c b6f345c8 0000001c 00000004 b6f5c000
00000000 00000001 00000000
[    2.210723] bfe0: 00000000 be988948 b6e5ae98 b6eb7adc 60000110
00000001 89389af9 fef855e7
[    2.226379] [<c02b3a54>] (serial_omap_start_tx+0x1cc/0x218) from
[<c02ac830>] (uart_start+0x68/0x6c)
[    2.241973] [<c02ac830>] (uart_start+0x68/0x6c) from [<c02ae348>]
(uart_write+0xc0/0xe4)
[    2.241973] [<c02ae348>] (uart_write+0xc0/0xe4) from [<c0296aa8>]
(n_tty_write+0x1e0/0x42c)
[    2.257629] [<c0296aa8>] (n_tty_write+0x1e0/0x42c) from
[<c0292638>] (tty_write+0x140/0x23c)
[    2.270446] [<c0292638>] (tty_write+0x140/0x23c) from [<c010841c>]
(vfs_write+0xb0/0x134)
[    2.278594] [<c010841c>] (vfs_write+0xb0/0x134) from [<c0108570>]
(sys_write+0x40/0x70)
[    2.281311] [<c0108570>] (sys_write+0x40/0x70) from [<c00142e0>]
(ret_fast_syscall+0x0/0x3c)

Regards,

Omar
