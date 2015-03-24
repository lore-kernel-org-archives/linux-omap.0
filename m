From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 0/7] Use DRM component API in tilcdc to connect to
 tda998x
Date: Tue, 24 Mar 2015 16:28:09 +0200
Message-ID: <55117479.5090701@ti.com>
References: <cover.1426668480.git.jsarha@ti.com> <55115DA8.1000704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41179 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbCXO2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 10:28:31 -0400
In-Reply-To: <55115DA8.1000704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

On 03/24/15 14:50, Tomi Valkeinen wrote:
> Hi,
>
> On 18/03/15 11:06, Jyri Sarha wrote:
>> I think the patches 1-5 are ready for merging. See the details below.
>
> I applied these on top of v4.0-rc3, booted up BBB, and loaded the modules. After doing that and waiting a few secs:
>
> # ./s-bbb.sh
> [   15.237139] sysrq: SysRq : Changing Loglevel
> [   15.241646] sysrq: Loglevel set to 9
> [   15.319762] [drm] Initialized drm 1.1.0 20060810
> [   15.588122] tda998x 0-0070: found TDA19988
> [   15.594824] tilcdc 4830e000.lcdc: bound 0-0070 (ops tda998x_ops [tda998x])
> [   15.602034] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   15.609011] [drm] No driver support for vblank timestamp query.
> [   15.700798] tilcdc 4830e000.lcdc: fb0:  frame buffer device
> [   15.706757] tilcdc 4830e000.lcdc: registered panic notifier
> [   15.712659] [drm] Initialized tilcdc 1.0.0 20121205 on minor 0
> #
> # [   25.789364] ------------[ cut here ]------------
> [   25.794315] WARNING: CPU: 0 PID: 50 at drivers/gpu/drm/tilcdc/tilcdc_crtc.c:269 tilcdc_crtc_mode_set+0x5ec/0x648 [tilcdc]()
> [   25.805999] Modules linked in: tilcdc tda998x drm_kms_helper drm
> [   25.812325] CPU: 0 PID: 50 Comm: kworker/0:2 Not tainted 4.0.0-rc3-00007-g5fbf26ebaf12 #7
> [   25.820893] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   25.827359] Workqueue: events output_poll_execute [drm_kms_helper]
> [   25.833819] Backtrace:
> [   25.836439] [<c0013550>] (dump_backtrace) from [<c0013764>] (show_stack+0x18/0x1c)
> [   25.844380]  r6:c09d4228 r5:c09d4228 r4:00000000 r3:dd3604c0
> [   25.850338] [<c001374c>] (show_stack) from [<c066bbc0>] (dump_stack+0xa4/0xd4)
> [   25.857927] [<c066bb1c>] (dump_stack) from [<c0044d28>] (warn_slowpath_common+0x84/0xc0)
> [   25.866401]  r6:0000010d r5:bf0a010c r4:00000000 r3:dd3604c0
> [   25.872348] [<c0044ca4>] (warn_slowpath_common) from [<c0044e08>] (warn_slowpath_null+0x24/0x2c)
> [   25.881543]  r8:dd500000 r7:0000000f r6:bf0a25f0 r5:dd6b1400 r4:dd4e6800
> [   25.888617] [<c0044de4>] (warn_slowpath_null) from [<bf0a010c>] (tilcdc_crtc_mode_set+0x5ec/0x648 [tilcdc])
> [   25.898849] [<bf09fb20>] (tilcdc_crtc_mode_set [tilcdc]) from [<bf06d874>] (drm_crtc_helper_set_mode+0x2b0/0x4f0 [drm_kms_helper])
> [   25.911132]  r10:dd4e6bf0 r9:dd4e6800 r8:dd4e2e80 r7:dd6b1400 r6:00000001 r5:dd500000
> [   25.919372]  r4:bf09fb20
> [   25.922061] [<bf06d5c4>] (drm_crtc_helper_set_mode [drm_kms_helper]) from [<bf06e450>] (drm_crtc_helper_set_config+0x768/0x9c8 [drm_kms_helper])
> [   25.935612]  r10:00000000 r9:dd73d980 r8:dd4e6bf0 r7:bf031808 r6:dd4e6be4 r5:dd4e6bd8
> [   25.943827]  r4:dd500000
> [   25.946758] [<bf06dce8>] (drm_crtc_helper_set_config [drm_kms_helper]) from [<bf00dcfc>] (drm_mode_set_config_internal+0x6c/0xf4 [drm])
> [   25.959518]  r10:00000001 r9:00000000 r8:dd4b4b40 r7:dd500000 r6:00000001 r5:00000028
> [   25.967767]  r4:dd4b46c0
> [   25.970558] [<bf00dc90>] (drm_mode_set_config_internal [drm]) from [<bf077a88>] (restore_fbdev_mode+0xe0/0x100 [drm_kms_helper])
> [   25.982672]  r7:dd73d980 r6:00000001 r5:00000028 r4:00000000
> [   25.988698] [<bf0779a8>] (restore_fbdev_mode [drm_kms_helper]) from [<bf0799cc>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x24/0x64 [drm_kms_helper])
> [   26.002884]  r9:dd4e6be4 r8:bf031808 r7:dd4e6800 r6:dd4e6800 r5:dd4b46c0 r4:dd4b4b40
> [   26.011104] [<bf0799a8>] (drm_fb_helper_restore_fb>   Tomi
>
>
dev_mode_unlocked [drm_kms_helper]) from [<bf079a2c>] 
(drm_fb_helper_set_par+0x20/0x3c [drm_kms_helper])
> [   26.025562]  r6:dd4e6800 r5:dd4b46c0 r4:00000000 r3:00000000
> [   26.031556] [<bf079a0c>] (drm_fb_helper_set_par [drm_kms_helper]) from [<bf079968>] (drm_fb_helper_hotplug_event+0x90/0xd0 [drm_kms_helper])
> [   26.044753]  r4:dd4b4b40 r3:00000000
> [   26.048557] [<bf0798d8>] (drm_fb_helper_hotplug_event [drm_kms_helper]) from [<bf07a7c4>] (drm_fbdev_cma_hotplug_event+0x18/0x1c [drm_kms_helper])
> [   26.062289]  r7:dd4e6a40 r6:00000001 r5:dd4e6c38 r4:dd4e6800
> [   26.068300] [<bf07a7ac>] (drm_fbdev_cma_hotplug_event [drm_kms_helper]) from [<bf0a217c>] (tilcdc_fb_output_poll_changed+0x18/0x1c [tilcdc])
> [   26.081521] [<bf0a2164>] (tilcdc_fb_output_poll_changed [tilcdc]) from [<bf06f388>] (drm_kms_helper_hotplug_event+0x2c/0x30 [drm_kms_helper])
> [   26.094840] [<bf06f35c>] (drm_kms_helper_hotplug_event [drm_kms_helper]) from [<bf06f448>] (output_poll_execute+0x6c/0x18c [drm_kms_helper])
> [   26.108027]  r4:dd4e6bd8 r3:00000000
> [   26.111809] [<bf06f3dc>] (output_poll_execute [drm_kms_helper]) from [<c005c704>] (process_one_work+0x1e8/0x560)
> [   26.122456]  r10:dfa1b700 r9:00000000 r8:c0a0c0b8 r>   Tomi
>
>
7:dd51deb0 r6:dfa157c0 r5:dd4b4d40
> [   26.130696]  r4:dd4e6c38
> [   26.133353] [<c005c51c>] (process_one_work) from [<c005d42c>] (worker_thread+0x160/0x4c4)
> [   26.141914]  r10:dfa157c0 r9:00000008 r8:dd4b4d58 r7:dd4b4d40 r6:c005d304 r5:dfa157f0
> [   26.150153]  r4:dfa157c0
> [   26.152812] [<c005d2cc>] (worker_thread) from [<c0061e38>] (kthread+0xf0/0x110)
> [   26.160465]  r10:00000000 r9:00000000 r8:00000000 r7:c005d2cc r6:dd4b4d40 r5:dd509cc0
> [   26.168704]  r4:00000000
> [   26.171362] [<c0061d48>] (kthread) from [<c000f6d0>] (ret_from_fork+0x14/0x24)
> [   26.178925]  r7:00000000 r6:00000000 r5:c0061d48 r4:dd509cc0
> [   26.184898] ---[ end trace e86278b011364fe4 ]---
> [   26.189766] [drm:drm_crtc_helper_set_config [drm_kms_helper]] *ERROR* failed to set mode on [CRTC:18]
>
> Also running modetest spams with similar warnings.
>

I tried first with 3.19 and then with 4.0-rc5, checked the boot and then 
the modetest, but I could not reproduce the trace above.

In my config I just have CONFIG_DRM=m and CONFIG_DRM_I2C_NXP_TDA998X=m 
on top of plain omap2plus_defconfig. Should I take something else?

Anyway, I doubt this has anything to do with my patches. Could you give 
it one more try without my patches?

Best regards,
Jyri
