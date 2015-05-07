From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 0/7] Use DRM component API in tilcdc to connect to
 tda998x
Date: Thu, 7 May 2015 12:44:24 +0300
Message-ID: <554B33F8.1060106@ti.com>
References: <cover.1427877412.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VmFmRsvO9o5XdDaH6sWRvi9k5mn3gIlGk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46342 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbEGJoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2015 05:44:46 -0400
In-Reply-To: <cover.1427877412.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

--VmFmRsvO9o5XdDaH6sWRvi9k5mn3gIlGk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 01/04/15 11:49, Jyri Sarha wrote:
> Ok, let's do one more full review round. The mode filtering issue was
> the main reason for this new patch series version. However, I found
> couple other things to fix too after scrutinizing the patches once
> more.
>=20
> Changes since v3 version of the patch-set:
> * drm/tilcdc: Add support for external tda998x encoder
>  - Hijack external connectors helper functions
>  - Remove select of nonexistent DRM_TILCDC_INIT in tilcdc Kconfig
>  - Correct author mail address to tilcdc_exteral.h
> * drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
>  - Add a header file for tilcdc_slave_compat.dtb symbol declarations
>=20
> Changes since v2 version of the patch-set:
> - use obj-y in Makefle for tilcdc subdir in:
>   "drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT"
> - move to last:
>   "drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_end=
point"
>=20
> Changes since first version of the patch-set:
> - Rename DRM_TILCDC_INIT to DRM_TILCDC_SLAVE_COMPAT and make it visible=

> - Add separate:=20
>   drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_endp=
oint
> - Reduce info-level spam
> - Use component_master_add_with_match()
> - Be more explicit about tda998x being the only supported external enco=
der
>=20
> Remove tilcdc slave support and connect to tda998x trough its
> component DRM API. For dtb backward compatibility the code creates at
> boot time a DT overlay based on the earlier binding. The overlay
> conforms to the new graph based binding.
>=20
> The "drm/tilcdc: Decrement refcount of ep-node from
> of_graph_get_next_endpoint" should probably not be merged. The "of:
> Decrement refcount of previous endpoint in of_graph_get_next_endpoint"
> is eventually going to be merged and before that leaking of two
> of-node refcount increments each time the module is loaded is not that
> serious. The of-nodes live forever anyway.
>=20
> The merge of the dts patch can be delayed until the next merger
> window, when the other patches are already in. The
> DRM_TILCDC_SLAVE_COMPAT should keep the bbb HDMI operational until
> then.

I made a quick test on v4.1-rc2, and:

[   15.199584] [drm] Initialized drm 1.1.0 20060810
[   15.319496] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:616
[   15.328339] in_atomic(): 1, irqs_disabled(): 128, pid: 130, name: insm=
od
[   15.335336] 3 locks held by insmod/130:
[   15.339339]  #0:  (&dev->mutex){......}, at: [<c044d8d0>]
__driver_attach+0x50/0xa0
[   15.347389]  #1:  (&dev->mutex){......}, at: [<c044d8e0>]
__driver_attach+0x60/0xa0
[   15.355420]  #2:  (devtree_lock){......}, at: [<c05e2888>]
of_get_next_child+0x20/0x4c
[   15.363731] irq event stamp: 5750
[   15.367189] hardirqs last  enabled at (5749): [<c0719f14>]
_raw_spin_unlock_irqrestore+0x38/0x64
[   15.376377] hardirqs last disabled at (5750): [<c0719730>]
_raw_spin_lock_irqsave+0x24/0x6c
[   15.385104] softirqs last  enabled at (5200): [<c004b7c8>]
__do_softirq+0x318/0x710
[   15.393111] softirqs last disabled at (5147): [<c004bf1c>]
irq_exit+0xc4/0x138
[   15.400668] CPU: 0 PID: 130 Comm: insmod Not tainted
4.1.0-rc2-00007-g877542591d33-dirty #22
[   15.409477] Hardware name: Generic AM33XX (Flattened Device Tree)
[   15.415837] Backtrace:
[   15.418403] [<c00140a8>] (dump_backtrace) from [<c0014244>]
(show_stack+0x18/0x1c)
[   15.426306]  r6:c08d04b0 r5:dd652000 r4:00000000 r3:00000000
[   15.432257] [<c001422c>] (show_stack) from [<c0711b44>]
(dump_stack+0x94/0xc8)
[   15.439810] [<c0711ab0>] (dump_stack) from [<c0070768>]
(___might_sleep+0x18c/0x294)
[   15.447893]  r5:00000268 r4:00000000
[   15.451643] [<c00705dc>] (___might_sleep) from [<c00708d4>]
(__might_sleep+0x64/0xa4)
[   15.459816]  r7:dd119280 r6:00000000 r5:00000268 r4:c08d04b0
[   15.465759] [<c0070870>] (__might_sleep) from [<c0715934>]
(mutex_lock_nested+0x2c/0x430)
[   15.474295]  r7:dd119280 r6:c0ae7c40 r5:c0203d0c r4:00000000
[   15.480239] [<c0715908>] (mutex_lock_nested) from [<c0203d0c>]
(kernfs_remove+0x20/0x38)
[   15.488684]  r10:bf111da0 r9:bf111dd0 r8:dfa3a044 r7:dd119280
r6:c0ae7c40 r5:dd11a510
[   15.496897]  r4:c0a7a7e8
[   15.499552] [<c0203cec>] (kernfs_remove) from [<c0205ed0>]
(sysfs_remove_dir+0x4c/0x84)
[   15.507907]  r5:dfa3a044 r4:dd11a510
[   15.511658] [<c0205e84>] (sysfs_remove_dir) from [<c03b0514>]
(kobject_del+0x1c/0x4c)
[   15.519831]  r5:dd11a510 r4:dfa3a044
[   15.523580] [<c03b04f8>] (kobject_del) from [<c03b05b4>]
(kobject_release+0x70/0x1b8)
[   15.531753]  r5:c0ac320c r4:dfa3a060
[   15.535502] [<c03b0544>] (kobject_release) from [<c03b0754>]
(kobject_put+0x58/0x88)
[   15.543585]  r8:dd653cac r7:dfa3a018 r6:a00c0013 r5:dfa3a018 r4:dfa3a0=
44
[   15.550627] [<c03b06fc>] (kobject_put) from [<c05e5d00>]
(of_node_put+0x1c/0x20)
[   15.558347]  r4:00000000
[   15.561000] [<c05e5ce4>] (of_node_put) from [<c05e2850>]
(__of_get_next_child+0x50/0x68)
[   15.569451] [<c05e2800>] (__of_get_next_child) from [<c05e2898>]
(of_get_next_child+0x30/0x4c)
[   15.578440]  r5:dfa39f60 r4:c0ac31ec
[   15.582190] [<c05e2868>] (of_get_next_child) from [<c05e2abc>]
(of_graph_get_next_endpoint+0x54/0x138)
[   15.591905]  r7:dd158c10 r6:dfa39d2c r5:dfa3a018 r4:dfa39f60
[   15.597877] [<c05e2a68>] (of_graph_get_next_endpoint) from
[<bf10f63c>] (tilcdc_get_external_components+0x7c/0xe8 [tilcdc])
[   15.609497]  r7:dd158c10 r6:00000001 r5:dfa3a018 r4:dfa3270c
[   15.615459] [<bf10f5c0>] (tilcdc_get_external_components [tilcdc])
from [<bf11047c>] (tilcdc_pdev_probe+0x38/0x8c [tilcdc])
[   15.627078]  r10:0000000a r8:bf111bd0 r7:bf111bd0 r6:fffffdfb
r5:dd158c10 r4:dd158c00
[   15.635309] [<bf110444>] (tilcdc_pdev_probe [tilcdc]) from
[<c044f6cc>] (platform_drv_probe+0x50/0xac)
[   15.645024]  r5:dd158c10 r4:ffffffed
[   15.648773] [<c044f67c>] (platform_drv_probe) from [<c044d644>]
(driver_probe_device+0x1ac/0x3e8)
[   15.658035]  r7:00000000 r6:c0ae8dc8 r5:dd158c10 r4:c12e735c
[   15.663976] [<c044d498>] (driver_probe_device) from [<c044d91c>]
(__driver_attach+0x9c/0xa0)
[   15.672784]  r10:00000000 r8:bf115048 r7:00000000 r6:dd158c44
r5:bf111bd0 r4:dd158c10
[   15.681012] [<c044d880>] (__driver_attach) from [<c044b964>]
(bus_for_each_dev+0x5c/0x90)
[   15.689548]  r6:c044d880 r5:bf111bd0 r4:00000000 r3:dd13909c
[   15.695493] [<c044b908>] (bus_for_each_dev) from [<c044cfc4>]
(driver_attach+0x20/0x28)
[   15.703848]  r6:c0aa9368 r5:dd5bebc0 r4:bf111bd0
[   15.708695] [<c044cfa4>] (driver_attach) from [<c044cb98>]
(bus_add_driver+0xf0/0x210)
[   15.716965] [<c044caa8>] (bus_add_driver) from [<c044e7e8>]
(driver_register+0x80/0xfc)
[   15.725319]  r7:00000001 r6:dd79d6c0 r5:c0a29bd8 r4:bf111bd0
[   15.731261] [<c044e768>] (driver_register) from [<c044f554>]
(__platform_driver_register+0x50/0x64)
[   15.740703]  r5:c0a29bd8 r4:c0a29bd8
[   15.744462] [<c044f504>] (__platform_driver_register) from
[<bf115084>] (tilcdc_drm_init+0x3c/0x54 [tilcdc])
[   15.754738] [<bf115048>] (tilcdc_drm_init [tilcdc]) from [<c0009828>]
(do_one_initcall+0xb4/0x1f8)
[   15.764096] [<c0009774>] (do_one_initcall) from [<c070fad8>]
(do_init_module+0x64/0x1b4)
[   15.772542]  r10:bf111e18 r9:bf111dd0 r8:00000124 r7:00000001
r6:dd79d640 r5:c0ae03a8
[   15.780754]  r4:bf111dd0
[   15.783414] [<c070fa74>] (do_init_module) from [<c00dcfbc>]
(load_module+0x19a8/0x22e8)
[   15.791768]  r6:dd5bfd40 r5:c0ae03a8 r4:c0adf52e
[   15.796614] [<c00db614>] (load_module) from [<c00dda04>]
(SyS_init_module+0x108/0x18c)
[   15.804878]  r10:00000000 r9:dd652000 r8:000a3008 r7:e0b9547a
r6:00000000 r5:000af492
[   15.813091]  r4:0000c47a
[   15.815750] [<c00dd8fc>] (SyS_init_module) from [<c0010580>]
(ret_fast_syscall+0x0/0x4c)
[   15.824195]  r8:c0010744 r7:00000080 r6:000001fa r5:bee24e8f r4:0000c4=
7a
[   15.831943] ERROR: Bad of_node_put() on
/ocp/lcdc@4830e000/port/endpoint@0
[   15.839139] CPU: 0 PID: 130 Comm: insmod Not tainted
4.1.0-rc2-00007-g877542591d33-dirty #22
[   15.847948] Hardware name: Generic AM33XX (Flattened Device Tree)
[   15.854308] Backtrace:
[   15.856878] [<c00140a8>] (dump_backtrace) from [<c0014244>]
(show_stack+0x18/0x1c)
[   15.864780]  r6:dfa3a044 r5:dd652000 r4:00000000 r3:00000000
[   15.870726] [<c001422c>] (show_stack) from [<c0711b44>]
(dump_stack+0x94/0xc8)
[   15.878276] [<c0711ab0>] (dump_stack) from [<c05e647c>]
(of_node_release+0x94/0x9c)
[   15.886268]  r5:c0ac320c r4:dfa3a094
[   15.890019] [<c05e63e8>] (of_node_release) from [<c03b05dc>]
(kobject_release+0x98/0x1b8)
[   15.898554]  r6:c0ae7c40 r5:c0ac320c r4:dfa3a060 r3:c05e63e8
[   15.904496] [<c03b0544>] (kobject_release) from [<c03b0754>]
(kobject_put+0x58/0x88)
[   15.912578]  r8:dd653cac r7:dfa3a018 r6:a00c0013 r5:dfa3a018 r4:dfa3a0=
44
[   15.919616] [<c03b06fc>] (kobject_put) from [<c05e5d00>]
(of_node_put+0x1c/0x20)
[   15.927335]  r4:00000000
[   15.929990] [<c05e5ce4>] (of_node_put) from [<c05e2850>]
(__of_get_next_child+0x50/0x68)
[   15.938440] [<c05e2800>] (__of_get_next_child) from [<c05e2898>]
(of_get_next_child+0x30/0x4c)
[   15.947429]  r5:dfa39f60 r4:c0ac31ec
[   15.951179] [<c05e2868>] (of_get_next_child) from [<c05e2abc>]
(of_graph_get_next_endpoint+0x54/0x138)
[   15.960894]  r7:dd158c10 r6:dfa39d2c r5:dfa3a018 r4:dfa39f60
[   15.966859] [<c05e2a68>] (of_graph_get_next_endpoint) from
[<bf10f63c>] (tilcdc_get_external_components+0x7c/0xe8 [tilcdc])
[   15.978479]  r7:dd158c10 r6:00000001 r5:dfa3a018 r4:dfa3270c
[   15.984439] [<bf10f5c0>] (tilcdc_get_external_components [tilcdc])
from [<bf11047c>] (tilcdc_pdev_probe+0x38/0x8c [tilcdc])
[   15.996058]  r10:0000000a r8:bf111bd0 r7:bf111bd0 r6:fffffdfb
r5:dd158c10 r4:dd158c00
[   16.004290] [<bf110444>] (tilcdc_pdev_probe [tilcdc]) from
[<c044f6cc>] (platform_drv_probe+0x50/0xac)
[   16.014005]  r5:dd158c10 r4:ffffffed
[   16.017755] [<c044f67c>] (platform_drv_probe) from [<c044d644>]
(driver_probe_device+0x1ac/0x3e8)
[   16.027016]  r7:00000000 r6:c0ae8dc8 r5:dd158c10 r4:c12e735c
[   16.032957] [<c044d498>] (driver_probe_device) from [<c044d91c>]
(__driver_attach+0x9c/0xa0)
[   16.041764]  r10:00000000 r8:bf115048 r7:00000000 r6:dd158c44
r5:bf111bd0 r4:dd158c10
[   16.049987] [<c044d880>] (__driver_attach) from [<c044b964>]
(bus_for_each_dev+0x5c/0x90)
[   16.058524]  r6:c044d880 r5:bf111bd0 r4:00000000 r3:dd13909c
[   16.064467] [<c044b908>] (bus_for_each_dev) from [<c044cfc4>]
(driver_attach+0x20/0x28)
[   16.072822]  r6:c0aa9368 r5:dd5bebc0 r4:bf111bd0
[   16.077670] [<c044cfa4>] (driver_attach) from [<c044cb98>]
(bus_add_driver+0xf0/0x210)
[   16.085939] [<c044caa8>] (bus_add_driver) from [<c044e7e8>]
(driver_register+0x80/0xfc)
[   16.094294]  r7:00000001 r6:dd79d6c0 r5:c0a29bd8 r4:bf111bd0
[   16.100235] [<c044e768>] (driver_register) from [<c044f554>]
(__platform_driver_register+0x50/0x64)
[   16.109678]  r5:c0a29bd8 r4:c0a29bd8
[   16.113437] [<c044f504>] (__platform_driver_register) from
[<bf115084>] (tilcdc_drm_init+0x3c/0x54 [tilcdc])
[   16.123710] [<bf115048>] (tilcdc_drm_init [tilcdc]) from [<c0009828>]
(do_one_initcall+0xb4/0x1f8)
[   16.133068] [<c0009774>] (do_one_initcall) from [<c070fad8>]
(do_init_module+0x64/0x1b4)
[   16.141513]  r10:bf111e18 r9:bf111dd0 r8:00000124 r7:00000001
r6:dd79d640 r5:c0ae03a8
[   16.149726]  r4:bf111dd0
[   16.152382] [<c070fa74>] (do_init_module) from [<c00dcfbc>]
(load_module+0x19a8/0x22e8)
[   16.160737]  r6:dd5bfd40 r5:c0ae03a8 r4:c0adf52e
[   16.165582] [<c00db614>] (load_module) from [<c00dda04>]
(SyS_init_module+0x108/0x18c)
[   16.173846]  r10:00000000 r9:dd652000 r8:000a3008 r7:e0b9547a
r6:00000000 r5:000af492
[   16.182059]  r4:0000c47a
[   16.184715] [<c00dd8fc>] (SyS_init_module) from [<c0010580>]
(ret_fast_syscall+0x0/0x4c)
[   16.193161]  r8:c0010744 r7:00000080 r6:000001fa r5:bee24e8f r4:0000c4=
7a
[   16.239460] ------------[ cut here ]------------
[   16.244338] WARNING: CPU: 0 PID: 130 at include/linux/kref.h:47
kobject_get+0x98/0xb8()
[   16.252705] Modules linked in: tilcdc(+) tda998x drm_kms_helper drm
[   16.259309] CPU: 0 PID: 130 Comm: insmod Not tainted
4.1.0-rc2-00007-g877542591d33-dirty #22
[   16.268129] Hardware name: Generic AM33XX (Flattened Device Tree)
[   16.274498] Backtrace:
[   16.277070] [<c00140a8>] (dump_backtrace) from [<c0014244>]
(show_stack+0x18/0x1c)
[   16.284972]  r6:0000002f r5:dd652000 r4:00000000 r3:00000000
[   16.290926] [<c001422c>] (show_stack) from [<c0711b44>]
(dump_stack+0x94/0xc8)
[   16.298474] [<c0711ab0>] (dump_stack) from [<c0046a54>]
(warn_slowpath_common+0x84/0xc0)
[   16.306919]  r5:c03b0a34 r4:00000000
[   16.310668] [<c00469d0>] (warn_slowpath_common) from [<c0046ab4>]
(warn_slowpath_null+0x24/0x2c)
[   16.319839]  r8:00000000 r7:00000000 r6:a0010013 r5:c0adfa5d r4:dfa3a0=
44
[   16.326876] [<c0046a90>] (warn_slowpath_null) from [<c03b0a34>]
(kobject_get+0x98/0xb8)
[   16.335245] [<c03b099c>] (kobject_get) from [<c05e5d20>]
(of_node_get+0x1c/0x24)
[   16.342964]  r5:00000000 r4:dfa3a018
[   16.346715] [<c05e5d04>] (of_node_get) from [<c05e2830>]
(__of_get_next_child+0x30/0x68)
[   16.355160]  r4:dfa3a018 r3:dd5b8640
[   16.358909] [<c05e2800>] (__of_get_next_child) from [<c05e2898>]
(of_get_next_child+0x30/0x4c)
[   16.367898]  r5:dfa39f60 r4:c0ac31ec
[   16.371648] [<c05e2868>] (of_get_next_child) from [<c05e2abc>]
(of_graph_get_next_endpoint+0x54/0x138)
[   16.381363]  r7:00000000 r6:dfa39d2c r5:00000000 r4:dfa39f60
[   16.387343] [<c05e2a68>] (of_graph_get_next_endpoint) from
[<bf10f63c>] (tilcdc_get_external_components+0x7c/0xe8 [tilcdc])
[   16.398963]  r7:dd158c10 r6:00000000 r5:00000000 r4:dd507000
[   16.404925] [<bf10f5c0>] (tilcdc_get_external_components [tilcdc])
from [<bf10fd84>] (tilcdc_load+0x50/0x648 [tilcdc])
[   16.416091]  r10:0000000a r8:dd158c00 r7:00000000 r6:dfa39d2c
r5:dd677f00 r4:dd507000
[   16.424542] [<bf10fd34>] (tilcdc_load [tilcdc]) from [<bf074060>]
(drm_dev_register+0xac/0x10c [drm])
[   16.434171]  r10:0000000a r9:bf111dd0 r8:00000000 r7:dd119290
r6:00000000 r5:00000000
[   16.442384]  r4:dd507000
[   16.445187] [<bf073fb4>] (drm_dev_register [drm]) from [<bf075b4c>]
(drm_platform_init+0x48/0xd8 [drm])
[   16.454993]  r6:bf111a8c r5:dd507000 r4:dd158c00 r3:00000000
[   16.461011] [<bf075b04>] (drm_platform_init [drm]) from [<bf10fa3c>]
(tilcdc_bind+0x18/0x20 [tilcdc])
[   16.470636]  r6:dd119240 r5:00000001 r4:dd119298
[   16.475499] [<bf10fa24>] (tilcdc_bind [tilcdc]) from [<c0448af4>]
(try_to_bring_up_master.part.1+0xd0/0x10c)
[   16.485766] [<c0448a24>] (try_to_bring_up_master.part.1) from
[<c0448bdc>] (component_master_add_with_match+0xac/0x110)
[   16.497022]  r8:dd158c10 r7:c0aa9040 r6:bf1109c0 r5:00000000
r4:dd119240 r3:c0aa9084
[   16.505160] [<c0448b30>] (component_master_add_with_match) from
[<bf110498>] (tilcdc_pdev_probe+0x54/0x8c [tilcdc])
[   16.516054]  r8:bf111bd0 r7:bf111bd0 r6:fffffdfb r5:dd158c10
r4:dd158c00 r3:dd652000
[   16.524195] [<bf110444>] (tilcdc_pdev_probe [tilcdc]) from
[<c044f6cc>] (platform_drv_probe+0x50/0xac)
[   16.533910]  r5:dd158c10 r4:ffffffed
[   16.537659] [<c044f67c>] (platform_drv_probe) from [<c044d644>]
(driver_probe_device+0x1ac/0x3e8)
[   16.546921]  r7:00000000 r6:c0ae8dc8 r5:dd158c10 r4:c12e735c
[   16.552862] [<c044d498>] (driver_probe_device) from [<c044d91c>]
(__driver_attach+0x9c/0xa0)
[   16.561670]  r10:00000000 r8:bf115048 r7:00000000 r6:dd158c44
r5:bf111bd0 r4:dd158c10
[   16.569893] [<c044d880>] (__driver_attach) from [<c044b964>]
(bus_for_each_dev+0x5c/0x90)
[   16.578428]  r6:c044d880 r5:bf111bd0 r4:00000000 r3:dd13909c
[   16.584374] [<c044b908>] (bus_for_each_dev) from [<c044cfc4>]
(driver_attach+0x20/0x28)
[   16.592728]  r6:c0aa9368 r5:dd5bebc0 r4:bf111bd0
[   16.597575] [<c044cfa4>] (driver_attach) from [<c044cb98>]
(bus_add_driver+0xf0/0x210)
[   16.605845] [<c044caa8>] (bus_add_driver) from [<c044e7e8>]
(driver_register+0x80/0xfc)
[   16.614199]  r7:00000001 r6:dd79d6c0 r5:c0a29bd8 r4:bf111bd0
[   16.620141] [<c044e768>] (driver_register) from [<c044f554>]
(__platform_driver_register+0x50/0x64)
[   16.629584]  r5:c0a29bd8 r4:c0a29bd8
[   16.633343] [<c044f504>] (__platform_driver_register) from
[<bf115084>] (tilcdc_drm_init+0x3c/0x54 [tilcdc])
[   16.643618] [<bf115048>] (tilcdc_drm_init [tilcdc]) from [<c0009828>]
(do_one_initcall+0xb4/0x1f8)
[   16.652978] [<c0009774>] (do_one_initcall) from [<c070fad8>]
(do_init_module+0x64/0x1b4)
[   16.661424]  r10:bf111e18 r9:bf111dd0 r8:00000124 r7:00000001
r6:dd79d640 r5:c0ae03a8
[   16.669636]  r4:bf111dd0
[   16.672295] [<c070fa74>] (do_init_module) from [<c00dcfbc>]
(load_module+0x19a8/0x22e8)
[   16.680650]  r6:dd5bfd40 r5:c0ae03a8 r4:c0adf52e
[   16.685496] [<c00db614>] (load_module) from [<c00dda04>]
(SyS_init_module+0x108/0x18c)
[   16.693760]  r10:00000000 r9:dd652000 r8:000a3008 r7:e0b9547a
r6:00000000 r5:000af492
[   16.701973]  r4:0000c47a
[   16.704631] [<c00dd8fc>] (SyS_init_module) from [<c0010580>]
(ret_fast_syscall+0x0/0x4c)
[   16.713077]  r8:c0010744 r7:00000080 r6:000001fa r5:bee24e8f r4:0000c4=
7a
[   16.720111] ---[ end trace 74558956458632df ]---
[   16.726493] ERROR: Bad of_node_put() on
/ocp/lcdc@4830e000/port/endpoint@0
[   16.733799] CPU: 0 PID: 130 Comm: insmod Tainted: G        W
4.1.0-rc2-00007-g877542591d33-dirty #22
[   16.743914] Hardware name: Generic AM33XX (Flattened Device Tree)
[   16.750305] Backtrace:
[   16.752884] [<c00140a8>] (dump_backtrace) from [<c0014244>]
(show_stack+0x18/0x1c)
[   16.760815]  r6:dfa3a044 r5:dd652000 r4:00000000 r3:00000000
[   16.766771] [<c001422c>] (show_stack) from [<c0711b44>]
(dump_stack+0x94/0xc8)
[   16.774354] [<c0711ab0>] (dump_stack) from [<c05e647c>]
(of_node_release+0x94/0x9c)
[   16.782376]  r5:c0ac320c r4:dfa3a094
[   16.786130] [<c05e63e8>] (of_node_release) from [<c03b05dc>]
(kobject_release+0x98/0x1b8)
[   16.794693]  r6:c0ae7c40 r5:c0ac320c r4:dfa3a060 r3:c05e63e8
[   16.800666] [<c03b0544>] (kobject_release) from [<c03b0754>]
(kobject_put+0x58/0x88)
[   16.808775]  r8:00000000 r7:dd158c10 r6:00000000 r5:dfa3a018 r4:dfa3a0=
44
[   16.815818] [<c03b06fc>] (kobject_put) from [<c05e5d00>]
(of_node_put+0x1c/0x20)
[   16.823564]  r4:dfa3270c
[   16.826251] [<c05e5ce4>] (of_node_put) from [<bf10f5f4>]
(tilcdc_get_external_components+0x34/0xe8 [tilcdc])
[   16.836568] [<bf10f5c0>] (tilcdc_get_external_components [tilcdc])
from [<bf10fd84>] (tilcdc_load+0x50/0x648 [tilcdc])
[   16.847762]  r10:0000000a r8:dd158c00 r7:00000000 r6:dfa39d2c
r5:dd677f00 r4:dd507000
[   16.856196] [<bf10fd34>] (tilcdc_load [tilcdc]) from [<bf074060>]
(drm_dev_register+0xac/0x10c [drm])
[   16.865870]  r10:0000000a r9:bf111dd0 r8:00000000 r7:dd119290
r6:00000000 r5:00000000
[   16.874117]  r4:dd507000
[   16.876911] [<bf073fb4>] (drm_dev_register [drm]) from [<bf075b4c>]
(drm_platform_init+0x48/0xd8 [drm])
[   16.886757]  r6:bf111a8c r5:dd507000 r4:dd158c00 r3:00000000
[   16.892812] [<bf075b04>] (drm_platform_init [drm]) from [<bf10fa3c>]
(tilcdc_bind+0x18/0x20 [tilcdc])
[   16.902468]  r6:dd119240 r5:00000001 r4:dd119298
[   16.907338] [<bf10fa24>] (tilcdc_bind [tilcdc]) from [<c0448af4>]
(try_to_bring_up_master.part.1+0xd0/0x10c)
[   16.917636] [<c0448a24>] (try_to_bring_up_master.part.1) from
[<c0448bdc>] (component_master_add_with_match+0xac/0x110)
[   16.928922]  r8:dd158c10 r7:c0aa9040 r6:bf1109c0 r5:00000000
r4:dd119240 r3:c0aa9084
[   16.937067] [<c0448b30>] (component_master_add_with_match) from
[<bf110498>] (tilcdc_pdev_probe+0x54/0x8c [tilcdc])
[   16.947988]  r8:bf111bd0 r7:bf111bd0 r6:fffffdfb r5:dd158c10
r4:dd158c00 r3:dd652000
[   16.956161] [<bf110444>] (tilcdc_pdev_probe [tilcdc]) from
[<c044f6cc>] (platform_drv_probe+0x50/0xac)
[   16.965902]  r5:dd158c10 r4:ffffffed
[   16.969680] [<c044f67c>] (platform_drv_probe) from [<c044d644>]
(driver_probe_device+0x1ac/0x3e8)
[   16.978967]  r7:00000000 r6:c0ae8dc8 r5:dd158c10 r4:c12e735c
[   16.984913] [<c044d498>] (driver_probe_device) from [<c044d91c>]
(__driver_attach+0x9c/0xa0)
[   16.993746]  r10:00000000 r8:bf115048 r7:00000000 r6:dd158c44
r5:bf111bd0 r4:dd158c10
[   17.002001] [<c044d880>] (__driver_attach) from [<c044b964>]
(bus_for_each_dev+0x5c/0x90)
[   17.010575]  r6:c044d880 r5:bf111bd0 r4:00000000 r3:dd13909c
[   17.016525] [<c044b908>] (bus_for_each_dev) from [<c044cfc4>]
(driver_attach+0x20/0x28)
[   17.024908]  r6:c0aa9368 r5:dd5bebc0 r4:bf111bd0
[   17.029786] [<c044cfa4>] (driver_attach) from [<c044cb98>]
(bus_add_driver+0xf0/0x210)
[   17.038057] [<c044caa8>] (bus_add_driver) from [<c044e7e8>]
(driver_register+0x80/0xfc)
[   17.046437]  r7:00000001 r6:dd79d6c0 r5:c0a29bd8 r4:bf111bd0
[   17.052424] [<c044e768>] (driver_register) from [<c044f554>]
(__platform_driver_register+0x50/0x64)
[   17.061894]  r5:c0a29bd8 r4:c0a29bd8
[   17.065660] [<c044f504>] (__platform_driver_register) from
[<bf115084>] (tilcdc_drm_init+0x3c/0x54 [tilcdc])
[   17.075964] [<bf115048>] (tilcdc_drm_init [tilcdc]) from [<c0009828>]
(do_one_initcall+0xb4/0x1f8)
[   17.085355] [<c0009774>] (do_one_initcall) from [<c070fad8>]
(do_init_module+0x64/0x1b4)
[   17.093829]  r10:bf111e18 r9:bf111dd0 r8:00000124 r7:00000001
r6:dd79d640 r5:c0ae03a8
[   17.102074]  r4:bf111dd0
[   17.104733] [<c070fa74>] (do_init_module) from [<c00dcfbc>]
(load_module+0x19a8/0x22e8)
[   17.113115]  r6:dd5bfd40 r5:c0ae03a8 r4:c0adf52e
[   17.117965] [<c00db614>] (load_module) from [<c00dda04>]
(SyS_init_module+0x108/0x18c)
[   17.126256]  r10:00000000 r9:dd652000 r8:000a3008 r7:e0b9547a
r6:00000000 r5:000af492
[   17.134498]  r4:0000c47a
[   17.137158] [<c00dd8fc>] (SyS_init_module) from [<c0010580>]
(ret_fast_syscall+0x0/0x4c)
[   17.145629]  r8:c0010744 r7:00000080 r6:000001fa r5:bee24e8f r4:0000c4=
7a
[   17.155286] tda998x 0-0070: Falling back to first CRTC
[   17.323479] tda998x 0-0070: found TDA19988
[   17.331525] tilcdc 4830e000.lcdc: bound 0-0070 (ops tda998x_ops
[tda998x])
[   17.338858] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
=2E
[   17.345777] [drm] No driver support for vblank timestamp query.
[   17.443556] tilcdc 4830e000.lcdc: fb0:  frame buffer device
[   17.449541] tilcdc 4830e000.lcdc: registered panic notifier
[   17.455462] [drm] Initialized tilcdc 1.0.0 20121205 on minor 0
#


--VmFmRsvO9o5XdDaH6sWRvi9k5mn3gIlGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSzP4AAoJEPo9qoy8lh71zBMP/A/HfVgVlYCbdlE6fXxf7YG8
6OskQVQnQLhWKNXAL3dUxvmv+HN8/GQaazg+gNrYOubjtCpjVy62QpOH0gLPvFok
eNr1/EwUZTTIHCLkl1wKZfJUGM3t6l2SnXjfdE0Qrx9gww2MZWUzxvo5a+ZZX1Z8
A2wg3rvFPQQEBWU1r5GY02BmXOITyLl8LUavaFPqwOEDrkJnEtlp4mlVNwMLd0ff
usUDZYQMCm+qf8OF7kG77hgf7v9lYzogfOATXatcwhsJYO9Ut8qPjU5IhySU1H6J
/RVxwDjOD/GoAaI01yuaxXGuyAHyo56mecd//nfX9VN0IcSStxf4pX6CINI83EXu
J4LV0W1rqQHlpoIB87m9XegUsUHjONqXKFfC5UZm+HtxZN1bB3LYAPSHd6/NLeVR
Hxvtpfl4VH2YQcnzM3hGO8WDc01BKGgD1yRYFR9Kk4lm1fJwAJiCqx4NzxydmEGV
pggWkXP7pUUIDPinZgtuykYumUUOFa3Rbxm2yZmjmVVXBZXB/KeDRWiabL25W/mx
rOHelINnseB1HhmUUlXZocjvvWGdjqwfVXRHbFbOCAAhT50KROdbie+kn2G+xz4V
3v3TEUy4oUrmL/ugeJJOmrL9WliprhBgLGFpNyoBPLBd03RMhGrUVnzsuh8hCPez
7nKUv4e0demXoLrGb+L4
=GhIh
-----END PGP SIGNATURE-----

--VmFmRsvO9o5XdDaH6sWRvi9k5mn3gIlGk--
