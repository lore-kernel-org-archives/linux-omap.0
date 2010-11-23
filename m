From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: Trouble getting Logic OMAp35x modules to boot
Date: Tue, 23 Nov 2010 10:35:11 +0530
Message-ID: <AANLkTi=vF-b+T59wOmg+aUARvC5wkq8ZCfYJ0LNhZJx7@mail.gmail.com>
References: <4CEB2502.9000300@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44141 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812Ab0KWFFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 00:05:33 -0500
Received: by mail-ww0-f49.google.com with SMTP id 33so8584455wwc.30
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 21:05:32 -0800 (PST)
In-Reply-To: <4CEB2502.9000300@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Nov 23, 2010 at 7:50 AM, Peter Barada <peterb@logicpd.com> wrot=
e:
> I've pulled the latest linux-2.6.37-rc3 kernel from kernel.org, and u=
sing
> the arch/arm/configs/omap3plus_defconfig as .config, and turning on:
>
> CONFIG_MACH_OMAP35CONFIG_MACH_OMAP3530_LV_SOM=3Dy
> CONFIG_MACH_OMAP3_TORPEDO=3Dy
>
> to run on the Logic OMAP35x boards, it failed to boot (no output from=
 the
> serial console).
>
> I added:
>
> CONFIG_DEBUG_LL=3Dy
> CONFIG_EARLY_PRINTK=3Dy
>
> to turn on early debigging (and adding earlyprintk to the command lin=
e), and
> see all looks fine up to the end of:
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.37-rc3-svn12998 (peter@blitz) (gcc version 4.3.3 (S=
ourcery
> G++
> =A0Lite 2009q1-203) ) #5 SMP Mon Nov 22 17:09:07 EST 2010
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: Logic OMAP3 Torpedo board
> debug: ignoring loglevel setting.
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
> SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c05450a0, node_mem_map c0579000
> =A0Normal zone: 512 pages used for memmap
> =A0Normal zone: 0 pages reserved
> =A0Normal zone: 65024 pages, LIFO batch:15
> PERCPU: Embedded 7 pages/cpu @c077c000 s4928 r8192 d15552 u32768
> pcpu-alloc: s4928 r8192 d15552 u32768 alloc=3D8*4096
> pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages=
: 65024
> Kernel command line: display=3D15 console=3DttyS0,115200 root=3D/dev/=
nfs rw
> nfsroot=3D19
> 2.168.3.5:/opt/nfs-exports/ltib-omap,wsize=3D1500,rsize=3D1500 ip=3Dd=
hcp
> no_console_su

=2E..

> io scheduler noop registered
> io scheduler deadline registered
>
> where the output turns to trash on the serial console.
>
> 1) Is omap2plus_defconfig the default kernel configuration I should u=
se for
> the Logic OMAP35x boards?
> 2) If so, any suggestions on where/why the console serial port is goi=
ng
> south?
>

If you have CONFIG_SERIAL_OMAP enabled (which should be enabled with
the omap2plus_defconfig, then the serial port would now be ttyO0 instea=
d
of ttyS0. Try changing this.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
