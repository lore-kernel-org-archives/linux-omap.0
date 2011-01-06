From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Current OMAP build failures
Date: Thu, 6 Jan 2011 11:03:36 +0000
Message-ID: <20110106110336.GC31708@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39046 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1AFLDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 06:03:44 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

I've observed the following issues while building 2.6.37 + my devel
branch.  I don't believe any of them to be due to anything in my tree,
so would be in 2.6.37 as well.

=3D=3D=3D omap1 =3D=3D=3D
arch/arm/plat-omap/built-in.o: In function `omap2_i2c_add_bus':
arch/arm/plat-omap/i2c.c:169: undefined reference to `omap2_i2c_mux_pin=
s'

$ grep omap2_i2c_mux_pins arch/arm/*omap* -r
arch/arm/mach-omap2/i2c.c:void __init omap2_i2c_mux_pins(int bus_id)
arch/arm/plat-omap/i2c.c:       omap2_i2c_mux_pins(bus_id);
arch/arm/plat-omap/include/plat/i2c.h:void __init omap2_i2c_mux_pins(in=
t bus_id);

So, OMAP1 doesn't provide this symbol.

=3D=3D=3D omap2 =3D=3D=3D
arch/arm/plat-omap/devices.c:253: warning: =E2=96=A0omap_init_wdt=E2=96=
=A0 defined but not used
arch/arm/mach-omap2/irq.c:64: warning: =E2=96=A0intc_context=E2=96=A0 d=
efined but not used
arch/arm/mach-omap2/prcm.c:122: warning: =E2=96=A0prcm_context=E2=96=A0=
 defined but not used

Missing __maybe_unused or something else?

It also comes with three section mismatches:

WARNING: vmlinux.o(.text+0x1f4c4): Section mismatch in reference from t=
he function omap_early_device_register() to the function .init.text:ear=
ly_platform_add_devices()
The function omap_early_device_register() references
the function __init early_platform_add_devices().
This is often because omap_early_device_register lacks a __init
annotation or the annotation of early_platform_add_devices is wrong.

As early_platform_add_devices() is marked __init, so too should be
omap_early_device_register().

WARNING: vmlinux.o(.text+0x1f6bc): Section mismatch in reference from t=
he function omap_device_build_ss() to the function .init.text:early_pla=
tform_add_devices()
The function omap_device_build_ss() references
the function __init early_platform_add_devices().
This is often because omap_device_build_ss lacks a __init
annotation or the annotation of early_platform_add_devices is wrong.

This looks like omap_early_device_register() has been inlined into
omap_device_build_ss(), and it doesn't look like it can be marked
__init.

Rather than passing an 'is_early_device' into this function, split
out the common code into a separate function which takes a function
pointer to the registration function.  Then you can have two additional
functions, one marked __init which uses omap_early_device_register()
and one not marked __init using omap_device_register().

This also means that we get the init-section type checking further up
the chain.

WARNING: vmlinux.o(.data+0x6bd4): Section mismatch in reference from th=
e variable h4_config to the (unknown reference) .init.data:(unknown)
The variable h4_config references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the varia=
ble:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Maybe it shouldn't be marked __initdata?

=3D=3D=3D omap3 =3D=3D=3D
WARNING: vmlinux.o(.text+0x1b780): Section mismatch in reference from t=
he function sdp3430_twl_gpio_setup() to the function .init.text:omap2_h=
smmc_init()
The function sdp3430_twl_gpio_setup() references
the function __init omap2_hsmmc_init().
This is often because sdp3430_twl_gpio_setup lacks a __init
annotation or the annotation of omap2_hsmmc_init is wrong.

Missing __init on sdp3430_twl_gpio_setup ?

WARNING: vmlinux.o(.text+0x1f714): Section mismatch in reference from t=
he function omap_early_device_register() to the function .init.text:ear=
ly_platform_add_devices()
The function omap_early_device_register() references
the function __init early_platform_add_devices().
This is often because omap_early_device_register lacks a __init
annotation or the annotation of early_platform_add_devices is wrong.

As before.

WARNING: vmlinux.o(.text+0x1f90c): Section mismatch in reference from t=
he function omap_device_build_ss() to the function .init.text:early_pla=
tform_add_devices()
The function omap_device_build_ss() references
the function __init early_platform_add_devices().
This is often because omap_device_build_ss lacks a __init
annotation or the annotation of early_platform_add_devices is wrong.

As before.

WARNING: vmlinux.o(.data+0x20670): Section mismatch in reference from t=
he variable twl_driver to the function .init.text:twl_probe()
The variable twl_driver references
the function __init twl_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the varia=
ble:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

twl_probe shouldn't be __init ?

=3D=3D=3D omap4 =3D=3D=3D
Nothing apparantly new over omap3.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
