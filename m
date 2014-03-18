From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Tue, 18 Mar 2014 14:23:17 +0200
Message-ID: <53283AB5.3080001@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il> <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il> <5326F893.3080607@ti.com> <53270510.1030301@compulab.co.il> <5327D9BE.80503@ti.com> <532801A7.6060702@compulab.co.il> <532805C2.9060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:43602 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbaCRMXs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 08:23:48 -0400
In-Reply-To: <532805C2.9060803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

I've activated HDMI output with omapfb. Thank you very much !

Some minor issue are observed:
* the colors are inverted.
* DRM seems to be loaded with no failures, however there is no output.


HPD connector pin is connected to HDMI_HPD/GPIO7_193.
In addition we have DVI output (uses TFP410 encoder to convert DPI to DVI).
TFP410 is not connected to I2C and its PD always on.

I tried to turn DVI support using omap4-panda-common.dtsi as the 
reference (with OMAP5 specific pinmux, of course),
however it fails. Does it supposed to work?

Please, could you share the .config you are using with uEvm?

Thank you in advance,

Dmitry


On 03/18/2014 10:37 AM, Tomi Valkeinen wrote:
> On 18/03/14 10:19, Dmitry Lifshitz wrote:
>> Hi Tomi,
>>
>> Thank you a lot for your assistance.
>>
>> Here are my relevant DT nodes:
>>
>> / {
>>          aliases {
>>                  display0 = &hdmi0;
>>          };
>>
>>          hdmi0: connector@0 {
>>                  compatible = "hdmi-connector";
>>                  label = "hdmi";
>>
>>                  type = "b";
>>
>>                  hdmi_connector_in: endpoint {
>>                          remote-endpoint = <&hdmi_out>;
>>                  };
>>          };
>> };
>>
>> &dss {
>>          status = "ok";
>> };
>>
>> &hdmi {
>>          status = "ok";
>>          vdda-supply = <&ldo4_reg>;
>>
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&dss_hdmi_pins>;
>>
>>          hdmi_out: endpoint {
>>                  remote-endpoint = <&hdmi_connector_in>;
>>          };
>> };
> The above looks fine.
>
>> I have the following kernel crash (caused by missing .detect callback):
> Yes, it seems the hdmi driver is missing detect, as there's no support
> in there for the detection at the moment. You can add the function to
> omap5.c, and return true always.
>
> How does the HPD work on your board? On uevm, the ESD/Level shifter chip
> handles HPD, which is the only supported way at the moment.
>
>> While using FBDEV I have the following issue:
>>
>> root@cm-debian:~# modprobe omapfb
>> [   27.524419] ------------[ cut here ]------------
>> [   27.529256] WARNING: CPU: 1 PID: 2087 at
>> /home/lifshitz/workroot/OMAP5-eewiki/omap5-kernel/mm/page_alloc.c:2492
>> __alloc_pages_nodemask+0x268/0x83c()
>> [   27.543164] Modules linked in: omapfb(+) cfbcopyarea cfbimgblt
>> cfbfillrect bnep rfcomm bluetooth 6lowpan_iphc phy_omap_usb2
>> connector_hdmi omapdss omap4_keypad matrix_keymap omap_ocp2scp
>> rtc_palmas spi_omap2_mcspi
>> [   27.563113] CPU: 1 PID: 2087 Comm: modprobe Tainted: G W
>> 3.14.0-rc4-cm-t54-test-suit+ #108
>> [   27.572677] [<c00280ac>] (unwind_backtrace) from [<c0024eb0>]
>> (show_stack+0x10/0x14)
>> [   27.580786] [<c0024eb0>] (show_stack) from [<c06fc434>]
>> (dump_stack+0x70/0x88)
>> [   27.588341] [<c06fc434>] (dump_stack) from [<c004d8e8>]
>> (warn_slowpath_common+0x70/0x88)
>> [   27.596815] [<c004d8e8>] (warn_slowpath_common) from [<c004d91c>]
>> (warn_slowpath_null+0x1c/0x24)
>> [   27.606004] [<c004d91c>] (warn_slowpath_null) from [<c01135ec>]
>> (__alloc_pages_nodemask+0x268/0x83c)
>> [   27.615562] [<c01135ec>] (__alloc_pages_nodemask) from [<c002cd78>]
>> (__dma_alloc_buffer.isra.16+0x2c/0xdc)
>> [   27.625661] [<c002cd78>] (__dma_alloc_buffer.isra.16) from
>> [<c002ce40>] (__alloc_remap_buffer.isra.19+0x18/0xcc)
>> [   27.636300] [<c002ce40>] (__alloc_remap_buffer.isra.19) from
>> [<c002d248>] (__dma_alloc+0x110/0x138)
>> [   27.645757] [<c002d248>] (__dma_alloc) from [<c002d3fc>]
>> (arm_dma_alloc+0xb0/0xd8)
>> [   27.653686] [<c002d3fc>] (arm_dma_alloc) from [<bf1b1f74>]
>> (omapfb_alloc_fbmem.isra.24+0xc8/0x158 [omapfb])
>> [   27.663911] [<bf1b1f74>] (omapfb_alloc_fbmem.isra.24 [omapfb]) from
>> [<bf1b7078>] (omapfb_alloc_fbmem_display.isra.25+0xec/0xfc [omapfb])
>> [   27.676759] [<bf1b7078>] (omapfb_alloc_fbmem_display.isra.25
>> [omapfb]) from [<bf1b21fc>] (omapfb_allocate_all_fbs+0xf4/0x174 [omapfb])
>> [   27.689419] [<bf1b21fc>] (omapfb_allocate_all_fbs [omapfb]) from
>> [<bf1b30f8>] (omapfb_create_framebuffers+0x1fc/0x524 [omapfb])
>> [   27.701432] [<bf1b30f8>] (omapfb_create_framebuffers [omapfb]) from
>> [<bf1b3fdc>] (omapfb_probe+0x28c/0x41c [omapfb])
>> [   27.712446] [<bf1b3fdc>] (omapfb_probe [omapfb]) from [<c03ab844>]
>> (platform_drv_probe+0x18/0x48)
>> [   27.721728] [<c03ab844>] (platform_drv_probe) from [<c03a9a4c>]
>> (really_probe+0x80/0x208)
>> [   27.730284] [<c03a9a4c>] (really_probe) from [<c03a9ce4>]
>> (driver_probe_device+0x30/0x48)
>> [   27.738834] [<c03a9ce4>] (driver_probe_device) from [<c03a9d88>]
>> (__driver_attach+0x8c/0x90)
>> [   27.747661] [<c03a9d88>] (__driver_attach) from [<c03a845c>]
>> (bus_for_each_dev+0x54/0x88)
>> [   27.756220] [<c03a845c>] (bus_for_each_dev) from [<c03a9338>]
>> (bus_add_driver+0xe4/0x1d8)
>> [   27.764778] [<c03a9338>] (bus_add_driver) from [<c03aa3e4>]
>> (driver_register+0x78/0xf4)
>> [   27.773148] [<c03aa3e4>] (driver_register) from [<c0008788>]
>> (do_one_initcall+0x44/0x174)
>> [   27.781703] [<c0008788>] (do_one_initcall) from [<c06f2934>]
>> (do_init_module+0x48/0x17c)
>> [   27.790172] [<c06f2934>] (do_init_module) from [<c00bad0c>]
>> (SyS_init_module+0x64/0x6c)
>> [   27.798546] [<c00bad0c>] (SyS_init_module) from [<c0020d80>]
>> (ret_fast_syscall+0x0/0x30)
>> [   27.807015] ---[ end trace 842d286115ab739d ]---
>> [   27.811849] omapfb omapfb: failed to allocate framebuffer
>> [   27.817490] omapfb omapfb: failed to allocate fbmem
>> [   27.822746] omapfb omapfb: failed to setup omapfb
>> [   27.827710] omapfb: probe of omapfb failed with error -12
> Hmm, do you have CMA enabled? Maybe something like:
>
> CONFIG_DMA_CMA=y
> CONFIG_CMA_SIZE_MBYTES=32
> CONFIG_CMA_SIZE_SEL_MBYTES=y
>
> And if you have omap5-uevm, you could first try that one to see if you
> get the branch working.
>
>   Tomi
>
>

