From: Nahamo <w.mohanrao@gmail.com>
Subject: Re: OMAP 3430SDP i2c boot crash
Date: Fri, 16 Apr 2010 11:07:25 +0000 (UTC)
Message-ID: <loom.20100416T130220-732@post.gmane.org>
References: <1271406087.2690.286.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60304 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757309Ab0DPPPJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 11:15:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1O2nG4-0004bV-CP
	for linux-omap@vger.kernel.org; Fri, 16 Apr 2010 17:15:06 +0200
Received: from 121.241.186.82.static-pune.vsnl.net.in ([121.241.186.82.static-pune.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 17:15:04 +0200
Received: from w.mohanrao by 121.241.186.82.static-pune.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 17:15:04 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen <at> nokia.com> writes:

> 
> Hi,
> 
> I haven't been able to boot my OMAP 3430SDP board with mainstream kernel
> for a while, with the omap_3430sdp_defconfig. Anyone else having
> problems? I don't get anything on the console after "Uncompressing
> Linux... done, booting the kernel.", and Trace32 shows the log below.
> 
>  Tomi
> 
> 
___address________|0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABC
DEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF
>  SD:0000:C0424B00 |hsusb2_clk 0x1700 -> 0x0003.<7>mux: Setting signal 
etk_d12.hsusb2_dir 0x1700 ->
> 0x010b.<7>mux: Setting signal etk_d13.hsusb2_nxt
>  SD:0000:C0424B80 | 0x1700 -> 0x010b.<7>mux: Setting signal 
etk_d14.hsusb2_data0 0x1700 ->
> 0x010b.<7>mux: Setting signal etk_d15.hsusb2_data1 0x170
>  SD:0000:C0424C00 |0 -> 0x010b.<7>mux: Setting signal mcspi1_cs3.hsusb2_data2 
0x1708 ->
> 0x010b.<7>mux: Setting signal mcspi2_cs1.hsusb2_data3 0x170
>  SD:0000:C0424C80 |8 -> 0x010b.<7>mux: Setting signal 
mcspi2_simo.hsusb2_data4 0x1700 ->
> 0x010b.<7>mux: Setting signal mcspi2_somi.hsusb2_data5 0x1
>  SD:0000:C0424D00 |700 -> 0x010b.<7>mux: Setting signal 
mcspi2_cs0.hsusb2_data6 0x1708 ->
> 0x010b.<7>mux: Setting signal mcspi2_clk.hsusb2_data7 0x1
>  SD:0000:C0424D80 |700 -> 0x010b.<6>OMAP DMA hardware revision 4.0.<4>bio: 
create slab <bio-0> at
> 0.<5>SCSI subsystem initialized.<6>usbcore: regis
>  SD:0000:C0424E00 |tered new interface driver usbfs.<6>usbcore: registered 
new interface driver
> hub.<6>usbcore: registered new device driver usb.<1
>  SD:0000:C0424E80 |>Unhandled fault: alignment exception (0x801) at 
0xfa070009.<0>Internal error: :
> 801 [#1].<0>last sysfs file: .<4>Modules linked
>  SD:0000:C0424F00 | in:.<4>CPU: 0    Not tainted  (2.6.34-rc4-00014-g7591eef 
#937).<4>PC is at
> omap_i2c_unidle+0x4c/0x140.<4>LR is at omap2_dflt_cl
>  SD:0000:C0424F80 |k_enable+0xd8/0xe8.<4>pc : [<c024b8e8>]    lr : 
[<c0041ca4>]    psr: 60000013.<4>sp :
> c7c19e60  ip : 00000009  fp : c7c19e74.<4>
>  SD:0000:C0425000 |r10: 00000000  r9 : 00000000  r8 : c03fa908.<4>r7 : 
c03fac48  r6 : c03fa900  r5 : c7ca0e00  r4
> : c7ca0e00.<4>r3 : 00000009  r2 :
>  SD:0000:C0425080 | fa070000  r1 : 00000000  r0 : 00000000.<4>Flags: nZCv  
IRQs on  FIQs on  Mode SVC_32  ISA ARM 
> Segment kernel.<4>Control: 10c53
>  SD:0000:C0425100 |87f  Table: 80004019  DAC: 00000017.<0>Process swapper 
(pid: 1, stack limit =
> 0xc7c182e8).<0>Stack: (0xc7c19e60 to 0xc7c1a000).<
>  SD:0000:C0425180 |0>9e60: c03f521c c7ca0e00 c7c19eac c7c19e78 c02f7e9c 
c024b8a8 00000000
> c0416110.<0>9e80: c7c19e9c c7c19e90 c00fe430 c03fa908 c03
>  SD:0000:C0425200 |fa908 c041bac0 c7ca3cc0 c0416110.<0>9ea0: c7c19ebc 
c7c19eb0 c01e8d60 c02f7cf8
> c7c19edc c7c19ec0 c01e7d38 c01e8d4c.<0>9ec0: c03fa
>  SD:0000:C0425280 |908 c03fa93c c041bac0 c7ca3cc0 c7c19efc c7c19ee0 c01e7e58 
c01e7c7c.<0>9ee0:
> 00000000 c01e7df0 c041bac0 c7ca3cc0 c7c19f24 c7c19f0
>  SD:0000:C0425300 |0 c01e7514 c01e7dfc.<0>9f00: c7c04af8 c7c445f0 c0194238 
c0026ba4 c041bac0
> c041bac0 c7c19f34 c7c19f28.<0>9f20: c01e7b84 c01e74d0
>  SD:0000:C0425380 |c7c19f64 c7c19f38 c01e6df4 c01e7b70 c03c051a 
00000000.<0>9f40: c0026ba4 00000000
> c041bac0 00000000 00000000 00000000 c7c19f8c c7
>  SD:0000:C0425400 |c19f68.<0>9f60: c01e8194 c01e6d58 c0026ba4 00000000 
c0020018 00000000 00000000
> 00000000.<0>9f80: c7c19f9c c7c19f90 c01e9204 c01e
>  SD:0000:C0425480 |80f0 c7c19fac c7c19fa0 c002002c c01e91c4.<0>9fa0: c7c19fdc 
c7c19fb0 c0031374
> c0020024 00000000 00000000 c7c19fdc c7c19fc8.<0>9fc
>  SD:0000:C0425500 |0: c0026ba4 00000000 00000000 00000000 c7c19ff4 c7c19fe0 
c00085f4
> c003131c.<0>9fe0: 00000000 00000000 00000000 c7c19ff8 c0060304
>  SD:0000:C0425580 | c0008568 28050809 01004804.<4>Backtrace: .<4>[<c024b89c>]
> (omap_i2c_unidle+0x0/0x140) from [<c02f7e9c>] (omap_i2c_probe+0x1b0/0
>  SD:0000:C0425600 |x3a4).<4> r5:c7ca0e00 r4:c03f521c.<4>[<c02f7cec>] 
(omap_i2c_probe+0x0/0x3a4)
> from [<c01e8d60>] (platform_drv_probe+0x20/0x24).<4
>  SD:0000:C0425680 |> r8:c0416110 r7:c7ca3cc0 r6:c041bac0 r5:c03fa908 
r4:c03fa908.<4>[<c01e8d40>]
> (platform_drv_probe+0x0/0x24) from [<c01e7d38>] (d
>  SD:0000:C0425700 |river_probe_device+0xc8/0x180).<4>[<c01e7c70>]
> (driver_probe_device+0x0/0x180) from [<c01e7e58>] 
(__driver_attach+0x68/0x8c).<4>
>  SD:0000:C0425780 | r7:c7ca3cc0 r6:c041bac0 r5:c03fa93c r4:c03fa908.<4>
[<c01e7df0>]
> (__driver_attach+0x0/0x8c) from [<c01e7514>] (bus_for_each_dev+
>  SD:0000:C0425800 |0x50/0x84).<4> r7:c7ca3cc0 r6:c041bac0 r5:c01e7df0
> r4:00000000.<4>[<c01e74c4>] (bus_for_each_dev+0x0/0x84) from [<c01e7b84>] (dr
>  SD:0000:C0425880 |iver_attach+0x20/0x28).<4> r6:c041bac0 r5:c041bac0
> r4:c0026ba4.<4>[<c01e7b64>] (driver_attach+0x0/0x28) from [<c01e6df4>] (bus_a
>  SD:0000:C0425900 |dd_driver+0xa8/0x230).<4>[<c01e6d4c>] 
(bus_add_driver+0x0/0x230) from
> [<c01e8194>] (driver_register+0xb0/0x138).<4>[<c01e80e4>]
>  SD:0000:C0425980 |(driver_register+0x0/0x138) from [<c01e9204>]
> (platform_driver_register+0x4c/0x60).<4> r9:00000000 r8:00000000 r7:00000000 
r6:c0
>  SD:0000:C0425A00 |020018 r5:00000000.<4>r4:c0026ba4.<4>[<c01e91b8>]
> (platform_driver_register+0x0/0x60) from [<c002002c>] (omap_i2c_init_driver+0x
>  SD:0000:C0425A80 |14/0x1c).<4>[<c0020018>] (omap_i2c_init_driver+0x0/0x1c) 
from [<c0031374>]
> (do_one_initcall+0x64/0x1bc).<4>[<c0031310>] (do_one_
>  SD:0000:C0425B00 |initcall+0x0/0x1bc) from [<c00085f4>] 
(kernel_init+0x98/0x14c).<4>
> r7:00000000 r6:00000000 r5:00000000 r4:c0026ba4.<4>[<c000855c
>  SD:0000:C0425B80 |>] (kernel_init+0x0/0x14c) from [<c0060304>] 
(do_exit+0x0/0x59c).<4>
> r5:00000000 r4:00000000.<0>Code: e5942004 e3a0c009 e1a0331c
>  SD:0000:C0425C00 | e3a01000 (e18210b3) .<4>---[ end trace 1b75b31a2719ed1c ]-
--.<0>Kernel panic - not
> syncing: Attempted to kill init!............
>  SD:0000:C0425C80 
|...............................................................................
.................................................
>  SD:0000:C0425D00 
|...............................................................................
.................................................
>  SD:0000:C0425D80 
|...............................................................................
.................................................
>  SD:0000:C0425E00 
|...............................................................................
.................................................
>  SD:0000:C0425E80 
|...............................................................................
.................................................
>  SD:0000:C0425F00 
|...............................................................................
.................................................
>  SD:0000:C0425F80 
|...............................................................................
.................................................
>  SD:0000:C0426000 
|...............................................................................
.................................................
>  SD:0000:C0426080 
|...............................................................................
.................................................
>  SD:0000:C0426100 
|...............................................................................
.................................................
>  SD:0000:C0426180 
|...............................................................................
.................................................
>  SD:0000:C0426200 
|...............................................................................
.................................................
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Hi Tomi,
i am also getting exactly the same error.
Thanks 
Nahamo





