From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Tue, 18 Mar 2014 10:19:51 +0200
Message-ID: <532801A7.6060702@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il> <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il> <5326F893.3080607@ti.com> <53270510.1030301@compulab.co.il> <5327D9BE.80503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:45475 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbaCRIUW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 04:20:22 -0400
In-Reply-To: <5327D9BE.80503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

Thank you a lot for your assistance.

Here are my relevant DT nodes:

/ {
         aliases {
                 display0 = &hdmi0;
         };

         hdmi0: connector@0 {
                 compatible = "hdmi-connector";
                 label = "hdmi";

                 type = "b";

                 hdmi_connector_in: endpoint {
                         remote-endpoint = <&hdmi_out>;
                 };
         };
};

&dss {
         status = "ok";
};

&hdmi {
         status = "ok";
         vdda-supply = <&ldo4_reg>;

         pinctrl-names = "default";
         pinctrl-0 = <&dss_hdmi_pins>;

         hdmi_out: endpoint {
                 remote-endpoint = <&hdmi_connector_in>;
         };
};

I have the following kernel crash (caused by missing .detect callback):

[   10.885320] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[   10.893825] pgd = ed787240
[   10.896670] [00000000] *pgd=00000000
[   10.900427] Internal error: Oops: 80000205 [#1] SMP ARM
[   10.905883] Modules linked in: phy_omap_usb2 omapdrm(+) 
drm_kms_helper connector_hdmi omap4_keypad matrix_keymap omapdss 
fb_sys_fops omap_ocp2scp rtc_palmas spi_omap2_mcspi
[   10.922032] CPU: 1 PID: 333 Comm: modprobe Tainted: G W    
3.14.0-rc4-cm-t54-test-suit+ #111
[   10.931486] task: ece1e040 ti: ecea2000 task.ti: ecea2000
[   10.937122] PC is at 0x0
[   10.939771] LR is at hdmic_detect+0x14/0x18 [connector_hdmi]
[   10.945681] pc : [<00000000>]    lr : [<bf1531c4>]    psr: a0000013
[   10.945681] sp : ecea3d50  ip : bf173158  fp : 00000000
[   10.957664] r10: 00000800  r9 : 00000800  r8 : 00000004
[   10.963118] r7 : bf17317c  r6 : ecdf0400  r5 : ed6d4000  r4 : ed6d402c
[   10.969932] r3 : 00000000  r2 : bf15c7cc  r1 : bf0437d0  r0 : bf059470
[   10.976754] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment user
[   10.984207] Control: 30c5387d  Table: ad787240  DAC: 55555555
[   10.990209] Process modprobe (pid: 333, stack limit = 0xecea2248)
[   10.996574] Stack: (0xecea3d50 to 0xecea4000)
[   11.001123] 3d40:                                     bf1531b0 
bf16a134 bf16a118 bf158abc
[   11.009664] 3d60: 00000004 c0b5ae60 00000000 00000001 ece4ae00 
00000000 00000800 00000800
[   11.018203] 3d80: bf17a000 00000020 00000000 bf15b7b8 00000020 
ece4ae00 ece4ae00 ecdf0400
[   11.026751] 3da0: ed69b940 bf175978 00000000 bf16bfa4 0000081f 
ecdf0400 ed69b940 00000000
[   11.035288] 3dc0: 00000000 bf167bbc 00000000 00000000 00000000 
ecdf0400 00000000 00000000
[   11.043828] 3de0: 00000000 c03afef8 c0a876a0 bf17586c ecdf0400 
c03b179c c08dffd4 c01d641c
[   11.052365] 3e00: c03b1818 c0978eac c0a876b0 bf175978 c0a876b0 
c03cc6c4 c03cc6ac c0b5af2c
[   11.060902] 3e20: bf175978 c03ca8cc c0a876b0 bf175978 c0a876e4 
00000000 c0020f04 c03cab64
[   11.069442] 3e40: 00000000 c0a876b0 bf175978 c03cac08 bf175978 
00000000 c03cab7c c03c92dc
[   11.077983] 3e60: edcd45dc eddcb234 bf175978 ece13480 c0ab8d48 
c03ca1b8 bf1740d4 c0020f04
[   11.086524] 3e80: bf175978 bf175978 00000000 ecea2000 00000000 
c03cb264 c03cbd54 c0a7e510
[   11.095067] 3ea0: ecea2000 c0008788 000000d0 f02aefff 00000000 
c0158bc0 c0003020 f02af000
[   11.103608] 3ec0: 00000000 bf175b24 c0a93b14 00000000 00000001 
bf175b24 00000000 00000000
[   11.112156] 3ee0: 00000001 c00dc9ec c00dcdbc fffffffb 00000000 
c072932c c0a92348 00000000
[   11.120702] 3f00: c0a92348 00000000 bf175b24 c0072830 00000000 
bd94362e 00000000 bf175b24
[   11.129244] 3f20: 00400100 ecea2000 00000080 c0020f04 ecea2000 
00000000 00000000 c07137b4
[   11.137785] 3f40: 0001dfea b6d5b000 b6fa7114 0001dfea b6d5b000 
c00bad0c f0290000 0001dfea
[   11.146323] 3f60: f02a29bc f02a2821 f02ab674 0000ecf0 00010510 
00000000 00000000 00000000
[   11.154860] 3f80: 00000027 00000028 0000001c 00000020 00000012 
00000000 b87d23f8 00060000
[   11.163409] 3fa0: b87d2280 c0020d80 b87d23f8 00060000 b6d5b000 
0001dfea b6fa7114 b6d5b000
[   11.171954] 3fc0: b87d23f8 00060000 b87d2280 00000080 b87d4c60 
0001dfea b6fa7114 00000000
[   11.180494] 3fe0: 00000000 bee169cc b6f9e190 b6f02e04 60000010 
b6d5b000 00000000 00000000
[   11.189071] [<bf1531c4>] (hdmic_detect [connector_hdmi]) from 
[<bf16a134>] (omap_connector_detect+0x1c/0x58 [omapdrm])
[   11.200274] [<bf16a134>] (omap_connector_detect [omapdrm]) from 
[<bf158abc>] (drm_helper_probe_single_connector_modes+0x2b0/0x33c 
[drm_kms_helper])
[   11.214089] [<bf158abc>] (drm_helper_probe_single_connector_modes 
[drm_kms_helper]) from [<bf15b7b8>] 
(drm_fb_helper_initial_config+0x5c/0xac [drm_kms_helper])
[   11.229011] [<bf15b7b8>] (drm_fb_helper_initial_config 
[drm_kms_helper]) from [<bf16bfa4>] (omap_fbdev_init+0x90/0xc4 [omapdrm])
[   11.241126] [<bf16bfa4>] (omap_fbdev_init [omapdrm]) from 
[<bf167bbc>] (dev_load+0xcc/0x148 [omapdrm])
[   11.250861] [<bf167bbc>] (dev_load [omapdrm]) from [<c03afef8>] 
(drm_dev_register+0x78/0x138)
[   11.259776] [<c03afef8>] (drm_dev_register) from [<c03b179c>] 
(drm_get_platform_dev+0x50/0xa4)
[   11.268785] [<c03b179c>] (drm_get_platform_dev) from [<c03cc6c4>] 
(platform_drv_probe+0x18/0x48)
[   11.277968] [<c03cc6c4>] (platform_drv_probe) from [<c03ca8cc>] 
(really_probe+0x80/0x208)
[   11.286516] [<c03ca8cc>] (really_probe) from [<c03cab64>] 
(driver_probe_device+0x30/0x48)
[   11.295071] [<c03cab64>] (driver_probe_device) from [<c03cac08>] 
(__driver_attach+0x8c/0x90)
[   11.303881] [<c03cac08>] (__driver_attach) from [<c03c92dc>] 
(bus_for_each_dev+0x54/0x88)
[   11.312422] [<c03c92dc>] (bus_for_each_dev) from [<c03ca1b8>] 
(bus_add_driver+0xe4/0x1d8)
[   11.320957] [<c03ca1b8>] (bus_add_driver) from [<c03cb264>] 
(driver_register+0x78/0xf4)
[   11.329323] [<c03cb264>] (driver_register) from [<c0008788>] 
(do_one_initcall+0x44/0x174)
[   11.337876] [<c0008788>] (do_one_initcall) from [<c07137b4>] 
(do_init_module+0x48/0x17c)
[   11.346331] [<c07137b4>] (do_init_module) from [<c00bad0c>] 
(SyS_init_module+0x64/0x6c)
[   11.354690] [<c00bad0c>] (SyS_init_module) from [<c0020d80>] 
(ret_fast_syscall+0x0/0x30)

While using FBDEV I have the following issue:

root@cm-debian:~# modprobe omapfb
[   27.524419] ------------[ cut here ]------------
[   27.529256] WARNING: CPU: 1 PID: 2087 at 
/home/lifshitz/workroot/OMAP5-eewiki/omap5-kernel/mm/page_alloc.c:2492 
__alloc_pages_nodemask+0x268/0x83c()
[   27.543164] Modules linked in: omapfb(+) cfbcopyarea cfbimgblt 
cfbfillrect bnep rfcomm bluetooth 6lowpan_iphc phy_omap_usb2 
connector_hdmi omapdss omap4_keypad matrix_keymap omap_ocp2scp 
rtc_palmas spi_omap2_mcspi
[   27.563113] CPU: 1 PID: 2087 Comm: modprobe Tainted: G W    
3.14.0-rc4-cm-t54-test-suit+ #108
[   27.572677] [<c00280ac>] (unwind_backtrace) from [<c0024eb0>] 
(show_stack+0x10/0x14)
[   27.580786] [<c0024eb0>] (show_stack) from [<c06fc434>] 
(dump_stack+0x70/0x88)
[   27.588341] [<c06fc434>] (dump_stack) from [<c004d8e8>] 
(warn_slowpath_common+0x70/0x88)
[   27.596815] [<c004d8e8>] (warn_slowpath_common) from [<c004d91c>] 
(warn_slowpath_null+0x1c/0x24)
[   27.606004] [<c004d91c>] (warn_slowpath_null) from [<c01135ec>] 
(__alloc_pages_nodemask+0x268/0x83c)
[   27.615562] [<c01135ec>] (__alloc_pages_nodemask) from [<c002cd78>] 
(__dma_alloc_buffer.isra.16+0x2c/0xdc)
[   27.625661] [<c002cd78>] (__dma_alloc_buffer.isra.16) from 
[<c002ce40>] (__alloc_remap_buffer.isra.19+0x18/0xcc)
[   27.636300] [<c002ce40>] (__alloc_remap_buffer.isra.19) from 
[<c002d248>] (__dma_alloc+0x110/0x138)
[   27.645757] [<c002d248>] (__dma_alloc) from [<c002d3fc>] 
(arm_dma_alloc+0xb0/0xd8)
[   27.653686] [<c002d3fc>] (arm_dma_alloc) from [<bf1b1f74>] 
(omapfb_alloc_fbmem.isra.24+0xc8/0x158 [omapfb])
[   27.663911] [<bf1b1f74>] (omapfb_alloc_fbmem.isra.24 [omapfb]) from 
[<bf1b7078>] (omapfb_alloc_fbmem_display.isra.25+0xec/0xfc [omapfb])
[   27.676759] [<bf1b7078>] (omapfb_alloc_fbmem_display.isra.25 
[omapfb]) from [<bf1b21fc>] (omapfb_allocate_all_fbs+0xf4/0x174 [omapfb])
[   27.689419] [<bf1b21fc>] (omapfb_allocate_all_fbs [omapfb]) from 
[<bf1b30f8>] (omapfb_create_framebuffers+0x1fc/0x524 [omapfb])
[   27.701432] [<bf1b30f8>] (omapfb_create_framebuffers [omapfb]) from 
[<bf1b3fdc>] (omapfb_probe+0x28c/0x41c [omapfb])
[   27.712446] [<bf1b3fdc>] (omapfb_probe [omapfb]) from [<c03ab844>] 
(platform_drv_probe+0x18/0x48)
[   27.721728] [<c03ab844>] (platform_drv_probe) from [<c03a9a4c>] 
(really_probe+0x80/0x208)
[   27.730284] [<c03a9a4c>] (really_probe) from [<c03a9ce4>] 
(driver_probe_device+0x30/0x48)
[   27.738834] [<c03a9ce4>] (driver_probe_device) from [<c03a9d88>] 
(__driver_attach+0x8c/0x90)
[   27.747661] [<c03a9d88>] (__driver_attach) from [<c03a845c>] 
(bus_for_each_dev+0x54/0x88)
[   27.756220] [<c03a845c>] (bus_for_each_dev) from [<c03a9338>] 
(bus_add_driver+0xe4/0x1d8)
[   27.764778] [<c03a9338>] (bus_add_driver) from [<c03aa3e4>] 
(driver_register+0x78/0xf4)
[   27.773148] [<c03aa3e4>] (driver_register) from [<c0008788>] 
(do_one_initcall+0x44/0x174)
[   27.781703] [<c0008788>] (do_one_initcall) from [<c06f2934>] 
(do_init_module+0x48/0x17c)
[   27.790172] [<c06f2934>] (do_init_module) from [<c00bad0c>] 
(SyS_init_module+0x64/0x6c)
[   27.798546] [<c00bad0c>] (SyS_init_module) from [<c0020d80>] 
(ret_fast_syscall+0x0/0x30)
[   27.807015] ---[ end trace 842d286115ab739d ]---
[   27.811849] omapfb omapfb: failed to allocate framebuffer
[   27.817490] omapfb omapfb: failed to allocate fbmem
[   27.822746] omapfb omapfb: failed to setup omapfb
[   27.827710] omapfb: probe of omapfb failed with error -12


Regards,

Dmitry


On 03/18/2014 07:29 AM, Tomi Valkeinen wrote:
> On 17/03/14 16:22, Dmitry Lifshitz wrote:
>> Hi Tomi,
>>
>> Unfortunately, I have a lack of experience with DT DSS stuff.
>>
>> How should I define the endpoints and the connector in my case?
>> Please, could you provide some reference.
> See Documentation/devicetree/bindings/media/video-interfaces.txt for a
> description of the ports and endpoints.
>
> If your board is similar to uevm except you don't have the tpd12s015,
> then you just need to remove the tpd12s015 from the .dts file, and
> connect the OMAP's HDMI output directly to the connector.
>
>> Regarding omapfb, is it sufficient to turn it on in the Kernel config?
> Yes.
>
>   Tomi
>
>

