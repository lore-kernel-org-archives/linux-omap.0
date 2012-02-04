From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 20:34:53 +0000
Message-ID: <20120204203453.GD17309@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51850 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2BDUfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 15:35:01 -0500
Content-Disposition: inline
In-Reply-To: <20120204190109.GL20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Feb 04, 2012 at 11:01:09AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 10:24]:
> > Does someone want to try building and running Linux on (eg) an OMAP34xx
> > platform before I post my next email message on this subject, and
> > maybe send me a bunch of patches required to fix stuff, to be applied
> > to my tree _and_ _then_ forwarded to Linus next Friday.
> > 
> > So, think of this as your last chance, and you'll get the picture about
> > how pissed off I am with the - yet again - current poor state of OMAP
> > in mainline, which seems to happen every merge window.
> > 
> > Consider this: when Linus started using a PowerPC platform, the PowerPC
> > people quickly realized that pushing patches upstream which broke stuff
> > was a really bad idea, because they got publically flamed for such
> > actions especially when stuff was not obviously tested.
> > 
> > This is no different... and this is _not_ my original email which I have
> > queued up with the real hot flames in over this.  This is the toned down
> > version.  The flames won't get sent if OMAP gets fixed quickly - and if
> > testing improves to stop this constant cycle of regressions at every
> > merge window.
> 
> Do you have the patches applied already queued up in arm-soc fixes
> branch?

It really doesn't make much difference - the only improvement I see in
the big collection of issues I have with OMAP this time around is one
build error is gone.  There's _far_ _far_ bigger problems in the OMAP
code this time.

I'm seriously considering requesting that all OMAP changes for the merge
window come through me rather than arm-soc, so that I can boot and build
test them before the merge window opens, and we can cut down on this
repetitive cycle of build (and boot) breakage at every merge window.

One problem isn't yours to solve (the requirement for regulators for
the SMSC network driver which has appeared.)

Another problem (some build errors for OMAP3) do seem to be solved, but
not the section mismatch warnings.  They're easy to verify before code
gets pushed anywhere upstream, especially if you're doing one giant OMAP
build - just enable CONFIG_DEBUG_SECTION_MISMATCH in your build
configuration.  Refuse patches which introduce section mismatches - at
least without an explanation backing up why they do.

My OMAP3 and OMAP4 configurations spit out these - I've not even tried
my OMAP2 configuration yet:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x15a4): Section mismatch in refe$
The function omap_mux_init_signals() references
the function __init omap_mux_init_signal().
This is often because omap_mux_init_signals lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xd1f0): Section mismatch in refe$
The function sdp3430_twl_gpio_setup() references
the function __init omap2_hsmmc_init().
This is often because sdp3430_twl_gpio_setup lacks a __init
annotation or the annotation of omap2_hsmmc_init is wrong.

WARNING: vmlinux.o(.text+0x27644): Section mismatch in reference from the funct$
The function omap_device_build_ss() references
the function __init early_platform_add_devices().
This is often because omap_device_build_ss lacks a __init
annotation or the annotation of early_platform_add_devices is wrong.

WARNING: vmlinux.o(.text+0x1c7a4): Section mismatch in reference from the function omap_secondary_startup() to the function .cpuinit.text:secondary_startup()
The function omap_secondary_startup() references
the function __cpuinit secondary_startup().
This is often because omap_secondary_startup lacks a __cpuinit 
annotation or the annotation of secondary_startup is wrong.

WARNING: vmlinux.o(.text+0x236d0): Section mismatch in reference from the function omap_4430sdp_display_init() to the function .init.text:omap_display_init()
The function omap_4430sdp_display_init() references
the function __init omap_display_init().
This is often because omap_4430sdp_display_init lacks a __init 
annotation or the annotation of omap_display_init is wrong.

WARNING: vmlinux.o(.text+0x2826c): Section mismatch in reference from the function omap_device_build_ss() to the function .init.text:early_platform_add_devices()
The function omap_device_build_ss() references
the function __init early_platform_add_devices().
This is often because omap_device_build_ss lacks a __init 
annotation or the annotation of early_platform_add_devices is wrong.

WARNING: vmlinux.o(.devinit.text+0x1870): Section mismatch in reference from the function twl_probe() to the function .init.text:twl4030_power_init()
The function __devinit twl_probe() references
a function __init twl4030_power_init().
If twl4030_power_init is only used by twl_probe then
annotate twl4030_power_init with a matching annotation.

Another problem oopses the kernel at boot in the voltage domain code,
which I suspect this has never been boot tested on OMAP34xx CPUs:

omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (3.3.0-rc2+ #204)
PC is at omap_vp_init+0x5c/0x15c
LR is at omap_vp_init+0x58/0x15c
pc : [<c03db880>]    lr : [<c03db87c>]    psr: 60000013
sp : c181ff30  ip : c181ff68  fp : c181ff64
r10: c0407808  r9 : c040786c  r8 : c0407814
r7 : c0026868  r6 : c00264fc  r5 : c040ad6c  r4 : 00000000
r3 : 00000040  r2 : 000032c8  r1 : 0000fa00  r0 : 000032c8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xc181e2e8)
Stack: (0xc181ff30 to 0xc1820000)
ff20:                                     c0381d00 c02e9c6d c0383582 c040786c
ff40: c040ad6c c00264fc c0026868 c0407814 00000000 c03d9de4 c181ff8c c181ff68
ff60: c03db448 c03db830 c02e982c c03fdfb8 c03fe004 c0039988 00000013 00000000
ff80: c181ff9c c181ff90 c03d9df8 c03db390 c181ffdc c181ffa0 c0008798 c03d9df0
ffa0: c181ffc4 c181ffb0 c0055a44 c0187050 c0039988 c03fdfb8 c03fe004 c0039988
ffc0: 00000013 00000000 00000000 00000000 c181fff4 c181ffe0 c03d1284 c0008708
ffe0: 00000000 c03d1208 00000000 c181fff8 c0039988 c03d1214 1077ce40 01f7ee08
Backtrace: 
[<c03db824>] (omap_vp_init+0x0/0x15c) from [<c03db448>] (omap_voltage_late_init+
0xc4/0xfc)
[<c03db384>] (omap_voltage_late_init+0x0/0xfc) from [<c03d9df8>] (omap2_common_p
m_late_init+0x14/0x54)
 r8:00000000 r7:00000013 r6:c0039988 r5:c03fe004 r4:c03fdfb8
[<c03d9de4>] (omap2_common_pm_late_init+0x0/0x54) from [<c0008798>] (do_one_init
call+0x9c/0x164)
[<c00086fc>] (do_one_initcall+0x0/0x164) from [<c03d1284>] (kernel_init+0x7c/0x1
20)
[<c03d1208>] (kernel_init+0x0/0x120) from [<c0039988>] (do_exit+0x0/0x2cc)
 r5:c03d1208 r4:00000000
Code: e5ca300b e5900034 ebf69027 e5994024 (e5941000) 
---[ end trace aed617dddaf32c3d ]---
Kernel panic - not syncing: Attempted to kill init!

And OMAP4 doesn't build.  Fixing the build error in prm44xx.c (which is
virtually the same as the OMAP3 build error in its prm file) gets us to
a buildable state, but... it silently fails to boot.

arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)

At least enabling DEBUG_LL gets this reason:

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
<1>pgd = c0004000                                                               
<1>[00000000] *pgd=00000000                                                     
<0>Internal error: Oops: 5 [#1] SMP                                             
<d>Modules linked in:                                                           
CPU: 1    Not tainted  (3.3.0-rc2+ #271)                                        
PC is at irq_domain_add+0x1c/0x134                                              
LR is at twl_probe+0xd0/0x370                                                   
pc : [<c007bad0>]    lr : [<c029baac>]    psr: 00000113                         
sp : df843c48  ip : df843c68  fp : df843c64                                     
r10: c02b93e4  r9 : 00000000  r8 : c029b9dc                                     
r7 : df9d8a00  r6 : c03bef90  r5 : 00000000  r4 : c03f5240                      
r3 : 00000000  r2 : c03f5240  r1 : 00000015  r0 : c03f5240                      
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel             
Control: 10c5387d  Table: 8000404a  DAC: 00000015                               
<0>Process swapper/0 (pid: 1, stack limit = 0xdf8422f0)                         
<0>Stack: (0xdf843c48 to 0xdf844000)                                            
<0>3c40:                   00000014 00000170 00000014 c03bef90 df843c9c df843c68
<0>3c60: c029baac c007bac0 00000000 df9d8a20 00000001 c03cd238 c02b93e4 df9d8a20
<0>3c80: df9d8a04 df9d8a00 c029b9dc df8cae08 df843cc4 df843ca0 c01eee70 c029b9e8
<0>3ca0: c01d1df0 df9d8a20 df9d8a20 df9d8a20 c03cd238 df8f0070 df843ce4 df843cc8
<0>3cc0: c01d1f34 c01eedcc df9d8a20 c03cd238 df9d8a20 df843d18 df843cfc df843ce8
<0>3ce0: c01d205c c01d1ea0 c03cd238 df9d8a20 df843d14 df843d00 c01d2148 c01d2018
<0>3d00: 00000000 c01d2104 df843d3c df843d18 c01d0840 c01d2110 df82aa6c df87cd38
<0>3d20: df9d8a20 c03cd978 df9d8a54 df9d8a28 df843d5c df843d40 c01d21f8 c01d07f4
<0>3d40: df843d64 df9d8a20 c03cd978 df9d8a20 df843d7c df843d60 c01d1430 c01d2184
<0>3d60: df843d7c df9d8a20 df9d8a20 00000000 df843db4 df843d80 c01cffb0 c01d1408
<0>3d80: c01d89d8 c01d98b8 df9d8a20 df9d8a00 df843db4 df9d8a20 df9d8a00 df8f0048
<0>3da0: df9d8a04 df9d8a00 df843dcc df843db8 c01d0150 c01cfd1c df843dd0 df9d8a20
<0>3dc0: df843dfc df843dd0 c01ef8d4 c01d013c df8f0048 df8f0048 df8f0070 df8f0048
<0>3de0: df8a6300 df8f0070 00000000 c03cd970 df843e24 df843e00 c01efc88 c01ef7c8
<0>3e00: df843e24 00000000 df8f0048 df843e2c df8cae00 df8a4c54 df843e4c df843e28
<0>3e20: c01efe9c c01efb54 00000010 00000001 c01d1b58 df8f0070 df8f0000 00000000
<0>3e40: df843e84 df843e50 c029ce1c c01efdf4 00000004 00000000 00000190 df843e68
<0>3e60: df8cae08 df8cae08 c03cdb2c c03cdb2c c03ccd00 00000000 df843e94 df843e88
<0>3e80: c01d3484 c029cb30 df843eb4 df843e98 c01d1f34 c01d3470 df8cae08 c03cdb2c
<0>3ea0: c03cdb2c df843ef0 df843ecc df843eb8 c01d205c c01d1ea0 df8cae08 df8cae3c
<0>3ec0: df843eec df843ed0 c01d20e0 c01d2018 c01d2074 00000000 c01d2074 c03cdb2c
<0>3ee0: df843f14 df843ef0 c01d08d8 c01d2080 df82a258 df8a4bb4 c0394f28 c03cdb2c
<0>3f00: c03cdb2c df880b80 df843f24 df843f18 c01d1d80 c01d088c df843f54 df843f28
<0>3f20: c01d115c c01d1d6c c0344ca3 df843f38 c0394f28 c0395180 c03cdb2c 00000013
<0>3f40: 00000000 c0386258 df843f7c df843f58 c01d278c c01d10b4 c00b8bcc c0394f28
<0>3f60: c0395180 c00384c8 00000013 00000000 df843f8c df843f80 c01d37e4 c01d26d0
<0>3f80: df843f9c df843f90 c038626c c01d37a4 df843fdc df843fa0 c00087b8 c0386264
<0>3fa0: 00000000 00000000 df843fc4 df843fb8 c005442c c0394f28 c0395180 c00384c8
<0>3fc0: 00000013 00000000 00000000 00000000 df843ff4 df843fe0 c036c2f4 c0008728
<0>3fe0: 00000000 c036c264 00000000 df843ff8 c00384c8 c036c270 55555555 5555595d
Backtrace:                                                                      
[<c007bab4>] (irq_domain_add+0x0/0x134) from [<c029baac>] (twl_probe+0xd0/0x370)
 r6:c03bef90 r5:00000014 r4:00000170                                            
[<c029b9dc>] (twl_probe+0x0/0x370) from [<c01eee70>] (i2c_device_probe+0xb0/0xe4
)                                                                               
[<c01eedc0>] (i2c_device_probe+0x0/0xe4) from [<c01d1f34>] (really_probe+0xa0/0x
178)                                                                            
 r8:df8f0070 r7:c03cd238 r6:df9d8a20 r5:df9d8a20 r4:df9d8a20                    
[<c01d1e94>] (really_probe+0x0/0x178) from [<c01d205c>] (driver_probe_device+0x5
0/0x68)                                                                         
 r7:df843d18 r6:df9d8a20 r5:c03cd238 r4:df9d8a20                                
[<c01d200c>] (driver_probe_device+0x0/0x68) from [<c01d2148>] (__device_attach+0
x44/0x48)                                                                       
 r5:df9d8a20 r4:c03cd238                                                        
[<c01d2104>] (__device_attach+0x0/0x48) from [<c01d0840>] (bus_for_each_drv+0x58
/0x98)                                                                          
 r5:c01d2104 r4:00000000                                                        
[<c01d07e8>] (bus_for_each_drv+0x0/0x98) from [<c01d21f8>] (device_attach+0x80/0
xac)                                                                            
 r7:df9d8a28 r6:df9d8a54 r5:c03cd978 r4:df9d8a20                                
[<c01d2178>] (device_attach+0x0/0xac) from [<c01d1430>] (bus_probe_device+0x34/0
xa4)                                                                            
 r6:df9d8a20 r5:c03cd978 r4:df9d8a20                                            
[<c01d13fc>] (bus_probe_device+0x0/0xa4) from [<c01cffb0>] (device_add+0x2a0/0x4
20)                                                                             
 r6:00000000 r5:df9d8a20 r4:df9d8a20                                            
[<c01cfd10>] (device_add+0x0/0x420) from [<c01d0150>] (device_register+0x20/0x24
)                                                                               
 r8:df9d8a00 r7:df9d8a04 r6:df8f0048 r5:df9d8a00 r4:df9d8a20                    
[<c01d0130>] (device_register+0x0/0x24) from [<c01ef8d4>] (i2c_new_device+0x118/
0x180)                                                                          
 r4:df9d8a20                                                                    
[<c01ef7bc>] (i2c_new_device+0x0/0x180) from [<c01efc88>] (i2c_register_adapter+
0x140/0x204)                                                                    
 r8:c03cd970 r7:00000000 r6:df8f0070 r5:df8a6300 r4:df8f0048                    
[<c01efb48>] (i2c_register_adapter+0x0/0x204) from [<c01efe9c>] (i2c_add_numbere
d_adapter+0xb4/0xcc)                                                            
 r8:df8a4c54 r7:df8cae00 r6:df843e2c r5:df8f0048 r4:00000000                    
[<c01efde8>] (i2c_add_numbered_adapter+0x0/0xcc) from [<c029ce1c>] (omap_i2c_pro
be+0x2f8/0x3b4)                                                                 
 r6:00000000 r5:df8f0000 r4:df8f0070                                            
[<c029cb24>] (omap_i2c_probe+0x0/0x3b4) from [<c01d3484>] (platform_drv_probe+0x
20/0x24)                                                                        
[<c01d3464>] (platform_drv_probe+0x0/0x24) from [<c01d1f34>] (really_probe+0xa0/
0x178)                                                                          
[<c01d1e94>] (really_probe+0x0/0x178) from [<c01d205c>] (driver_probe_device+0x5
0/0x68)                                                                         
 r7:df843ef0 r6:c03cdb2c r5:c03cdb2c r4:df8cae08                                
[<c01d200c>] (driver_probe_device+0x0/0x68) from [<c01d20e0>] (__driver_attach+0
x6c/0x90)                                                                       
 r5:df8cae3c r4:df8cae08                                                        
[<c01d2074>] (__driver_attach+0x0/0x90) from [<c01d08d8>] (bus_for_each_dev+0x58
/0x98)                                                                          
 r6:c03cdb2c r5:c01d2074 r4:00000000                                            
[<c01d0880>] (bus_for_each_dev+0x0/0x98) from [<c01d1d80>] (driver_attach+0x20/0
x28)                                                                            
 r7:df880b80 r6:c03cdb2c r5:c03cdb2c r4:c0394f28                                
[<c01d1d60>] (driver_attach+0x0/0x28) from [<c01d115c>] (bus_add_driver+0xb4/0x2
30)                                                                             
[<c01d10a8>] (bus_add_driver+0x0/0x230) from [<c01d278c>] (driver_register+0xc8/
0x154)                                                                          
[<c01d26c4>] (driver_register+0x0/0x154) from [<c01d37e4>] (platform_driver_regi
ster+0x4c/0x60)                                                                 
 r8:00000000 r7:00000013 r6:c00384c8 r5:c0395180 r4:c0394f28                    
[<c01d3798>] (platform_driver_register+0x0/0x60) from [<c038626c>] (omap_i2c_ini
t_driver+0x14/0x1c)                                                             
[<c0386258>] (omap_i2c_init_driver+0x0/0x1c) from [<c00087b8>] (do_one_initcall+
0x9c/0x164)                                                                     
[<c000871c>] (do_one_initcall+0x0/0x164) from [<c036c2f4>] (kernel_init+0x90/0x1
38)                                                                             
[<c036c264>] (kernel_init+0x0/0x138) from [<c00384c8>] (do_exit+0x0/0x2ec)      
 r5:c036c264 r4:00000000                                                        
<0>Code: e24dd004 e5903014 e1a04000 e5905010 (e5933000)                         
<4>---[ end trace 1b75b31a2719ed1c ]---                                         
<0>Kernel panic - not syncing: Attempted to kill init!                          
<2>CPU0: stopping                                                               
Backtrace:                                                                      
[<c0017cb0>] (dump_backtrace+0x0/0x10c) from [<c02a02b0>] (dump_stack+0x18/0x1c)
 r7:fa24010c r6:c0399f38 r5:00000000 r4:c03d2bb4                                
[<c02a0298>] (dump_stack+0x0/0x1c) from [<c0018ee8>] (handle_IPI+0xf4/0x17c)    
[<c0018df4>] (handle_IPI+0x0/0x17c) from [<c0008698>] (gic_handle_irq+0xa8/0xb8)
 r5:c03ad900 r4:c00151e4                                                        
[<c00085f0>] (gic_handle_irq+0x0/0xb8) from [<c0013b40>] (__irq_svc+0x40/0x60)  
Exception stack(0xc0399f38 to 0xc0399f80)                                       
9f20:                                                       c03d2cd8 a0000193   
9f40: fa242000 00000000 c0398000 c03b1114 c03d2998 c03ad890 c02a5ca4 411fc092   
9f60: 00000000 c0399f8c c0399f90 c0399f80 c00151e0 c00151e4 60000113 ffffffff   
 r8:c02a5ca4 r7:c0399f6c r6:ffffffff r5:60000113 r4:c00151e4                    
[<c00151b8>] (default_idle+0x0/0x34) from [<c0015868>] (cpu_idle+0xa8/0xf4)     
[<c00157c0>] (cpu_idle+0x0/0xf4) from [<c0299030>] (rest_init+0x60/0x78)        
 r8:8000406a r7:c03d28c0 r6:c03d28cc r5:c03d293c r4:c03adf54                    
[<c0298fd0>] (rest_init+0x0/0x78) from [<c036c8d4>] (start_kernel+0x2a8/0x30c)  
[<c036c62c>] (start_kernel+0x0/0x30c) from [<80008044>] (0x80008044)            
 r7:c03b1104 r6:c03908d8 r5:c03ad8bc r4:10c5387d                                

So, a slight improvement, but overall no material forward progress in
terms of things booting.

And, compared to my previous testing, the OMAP state is worse than ever
as this time, even with your first round of fixes, all my OMAP platforms
are pretty broken.
