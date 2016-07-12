From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH] backlight: Avoid double fbcon backlight
 handling
Date: Tue, 12 Jul 2016 14:21:19 +0200
Message-ID: <20160712122119.GR23520@phenom.ffwll.local>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org, Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hen>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 30, 2016 at 12:30:56PM +0100, Chris Wilson wrote:
> Backlights controlled by i915.ko and only associated with its connect=
ors
> and also only associated with the intel_drmfb fbcon, controlled by
> i915.ko. In this situation, we already handle adjusting the backlight
> when the fbcon is blanked/unblanked and do not require backlight tryi=
ng
> to do the same.
>=20
> Attempting to register with the fbdev as a client causes lockdep to w=
arn
> about a dependency cycle:

The fbdev notifier strikes again!

Last time I looked into this I think the proper solution would be to sp=
lit
the backlight part from the other fbdev notifier (which is used by fbco=
n
for reacting to fbdev device reg/unreg events).

I think that would fix this too, with the added bonus of slightly
untangling the fbcon locking mess. And it's also the one part of
untangling this mess which should be possible without any trouble - I'v=
e
simply never done it since entirely getting rid of the fbdev notifier f=
or
fbcon is a lot more work.
-Daniel

>=20
> [   18.983763] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.983763] [ INFO: possible circular locking dependency detected =
]
> [   18.983766] 4.7.0-rc5+ #524 Tainted: G           O
> [   18.983767] ------------------------------------------------------=
-
> [   18.983767] kworker/u8:0/6 is trying to acquire lock:
> [   18.983777]  (&dev->mode_config.mutex){+.+.+.}, at: [<ffffffff815a=
fde0>] drm_modeset_lock_all+0x40/0x120
> [   18.983777]
>                but task is already holding lock:
> [   18.983782]  ((fb_notifier_list).rwsem){++++.+}, at: [<ffffffff810=
ac195>] __blocking_notifier_call_chain+0x35/0x70
> [   18.983783]
>                which lock already depends on the new lock.
>=20
> [   18.983783]
>                the existing dependency chain (in reverse order) is:
> [   18.983785]
>                -> #1 ((fb_notifier_list).rwsem){++++.+}:
> [   18.983789]        [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.983792]        [<ffffffff819a55b4>] down_write+0x44/0x80
> [   18.983795]        [<ffffffff810abf91>] blocking_notifier_chain_re=
gister+0x21/0xb0
> [   18.983798]        [<ffffffff814c7448>] fb_register_client+0x18/0x=
20
> [   18.983800]        [<ffffffff814c6c86>] backlight_device_register+=
0x136/0x260
> [   18.983852]        [<ffffffffa0127eb2>] intel_backlight_device_reg=
ister+0xa2/0x160 [i915]
> [   18.983892]        [<ffffffffa00f46be>] intel_connector_register+0=
xe/0x10 [i915]
> [   18.983932]        [<ffffffffa0112bfb>] intel_dp_connector_registe=
r+0x1b/0x80 [i915]
> [   18.983936]        [<ffffffff8159dfea>] drm_connector_register+0x4=
a/0x80
> [   18.983938]        [<ffffffff8159fe44>] drm_connector_register_all=
+0x64/0xf0
> [   18.983940]        [<ffffffff815a2a64>] drm_modeset_register_all+0=
x174/0x1c0
> [   18.983942]        [<ffffffff81599b72>] drm_dev_register+0xc2/0xd0
> [   18.983976]        [<ffffffffa00621d7>] i915_driver_load+0x1547/0x=
2200 [i915]
> [   18.984010]        [<ffffffffa006d80f>] i915_pci_probe+0x4f/0x70 [=
i915]
> [   18.984014]        [<ffffffff814a2135>] local_pci_probe+0x45/0xa0
> [   18.984015]        [<ffffffff814a349b>] pci_device_probe+0xdb/0x13=
0
> [   18.984018]        [<ffffffff815c07e3>] driver_probe_device+0x223/=
0x440
> [   18.984020]        [<ffffffff815c0ad5>] __driver_attach+0xd5/0x100
> [   18.984022]        [<ffffffff815be386>] bus_for_each_dev+0x66/0xa0
> [   18.984023]        [<ffffffff815c002e>] driver_attach+0x1e/0x20
> [   18.984025]        [<ffffffff815bf9be>] bus_add_driver+0x1ee/0x280
> [   18.984028]        [<ffffffff815c1810>] driver_register+0x60/0xe0
> [   18.984030]        [<ffffffff814a1a10>] __pci_register_driver+0x60=
/0x70
> [   18.984063]        [<ffffffffa01a905b>] i915_init+0x5b/0x62 [i915]
> [   18.984067]        [<ffffffff8100042d>] do_one_initcall+0x3d/0x150
> [   18.984070]        [<ffffffff811a935b>] do_init_module+0x5f/0x1d9
> [   18.984073]        [<ffffffff81124416>] load_module+0x20e6/0x27e0
> [   18.984075]        [<ffffffff81124d63>] SYSC_finit_module+0xc3/0xf=
0
> [   18.984076]        [<ffffffff81124dae>] SyS_finit_module+0xe/0x10
> [   18.984079]        [<ffffffff819a83a9>] entry_SYSCALL_64_fastpath+=
0x1c/0xac
> [   18.984081]
>                -> #0 (&dev->mode_config.mutex){+.+.+.}:
> [   18.984083]        [<ffffffff810df0ac>] __lock_acquire+0x10fc/0x12=
60
> [   18.984085]        [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.984088]        [<ffffffff819a3097>] mutex_lock_nested+0x67/0x3=
c0
> [   18.984090]        [<ffffffff815afde0>] drm_modeset_lock_all+0x40/=
0x120
> [   18.984093]        [<ffffffff8158f79b>] drm_fb_helper_restore_fbde=
v_mode_unlocked+0x2b/0x80
> [   18.984095]        [<ffffffff8158f81d>] drm_fb_helper_set_par+0x2d=
/0x50
> [   18.984134]        [<ffffffffa0105f7a>] intel_fbdev_set_par+0x1a/0=
x60 [i915]
> [   18.984136]        [<ffffffff814c13c6>] fbcon_init+0x586/0x610
> [   18.984139]        [<ffffffff8154d16a>] visual_init+0xca/0x130
> [   18.984141]        [<ffffffff8154e611>] do_bind_con_driver+0x1c1/0=
x3a0
> [   18.984143]        [<ffffffff8154eaf6>] do_take_over_console+0x116=
/0x180
> [   18.984145]        [<ffffffff814bd3a7>] do_fbcon_takeover+0x57/0xb=
0
> [   18.984147]        [<ffffffff814c1e48>] fbcon_event_notify+0x658/0=
x750
> [   18.984150]        [<ffffffff810abcae>] notifier_call_chain+0x3e/0=
xb0
> [   18.984152]        [<ffffffff810ac1ad>] __blocking_notifier_call_c=
hain+0x4d/0x70
> [   18.984154]        [<ffffffff810ac1e6>] blocking_notifier_call_cha=
in+0x16/0x20
> [   18.984156]        [<ffffffff814c748b>] fb_notifier_call_chain+0x1=
b/0x20
> [   18.984158]        [<ffffffff814c86b1>] register_framebuffer+0x251=
/0x330
> [   18.984160]        [<ffffffff8158fa9f>] drm_fb_helper_initial_conf=
ig+0x25f/0x3f0
> [   18.984199]        [<ffffffffa0106b48>] intel_fbdev_initial_config=
+0x18/0x30 [i915]
> [   18.984201]        [<ffffffff810adfd8>] async_run_entry_fn+0x48/0x=
150
> [   18.984203]        [<ffffffff810a3947>] process_one_work+0x1e7/0x7=
50
> [   18.984205]        [<ffffffff810a3efb>] worker_thread+0x4b/0x4f0
> [   18.984207]        [<ffffffff810aad4f>] kthread+0xef/0x110
> [   18.984208]        [<ffffffff819a85ef>] ret_from_fork+0x1f/0x40
> [   18.984209]
>                other info that might help us debug this:
>=20
> [   18.984210]  Possible unsafe locking scenario:
>=20
> [   18.984210]        CPU0                    CPU1
> [   18.984211]        ----                    ----
> [   18.984212]   lock((fb_notifier_list).rwsem);
> [   18.984213]                                lock(&dev->mode_config.=
mutex);
> [   18.984215]                                lock((fb_notifier_list)=
=2Erwsem);
> [   18.984216]   lock(&dev->mode_config.mutex);
> [   18.984216]
>                 *** DEADLOCK ***
>=20
> [   18.984217] 6 locks held by kworker/u8:0/6:
> [   18.984220]  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff810a38=
c9>] process_one_work+0x169/0x750
> [   18.984223]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff810a38c9=
>] process_one_work+0x169/0x750
> [   18.984227]  #2:  (registration_lock){+.+.+.}, at: [<ffffffff814c8=
487>] register_framebuffer+0x27/0x330
> [   18.984231]  #3:  (console_lock){+.+.+.}, at: [<ffffffff814c86ce>]=
 register_framebuffer+0x26e/0x330
> [   18.984234]  #4:  (&fb_info->lock){+.+.+.}, at: [<ffffffff814c78dd=
>] lock_fb_info+0x1d/0x40
> [   18.984238]  #5:  ((fb_notifier_list).rwsem){++++.+}, at: [<ffffff=
ff810ac195>] __blocking_notifier_call_chain+0x35/0x70
> [   18.984238]
>                stack backtrace:
> [   18.984241] CPU: 2 PID: 6 Comm: kworker/u8:0 Tainted: G           =
O    4.7.0-rc5+ #524
> [   18.984242] Hardware name: Intel Corp. Broxton P/NOTEBOOK, BIOS AP=
LKRVPA.X64.0138.B33.1606250842 06/25/2016
> [   18.984244] Workqueue: events_unbound async_run_entry_fn
> [   18.984248]  0000000000000000 ffff8800758577f0 ffffffff814507a5 ff=
ffffff828b9900
> [   18.984250]  ffffffff828b9900 ffff880075857830 ffffffff810dc6fa ff=
ff880075857880
> [   18.984252]  ffff88007584d688 0000000000000005 0000000000000006 ff=
ff88007584d6b0
> [   18.984253] Call Trace:
> [   18.984257]  [<ffffffff814507a5>] dump_stack+0x67/0x92
> [   18.984259]  [<ffffffff810dc6fa>] print_circular_bug+0x1aa/0x200
> [   18.984261]  [<ffffffff810df0ac>] __lock_acquire+0x10fc/0x1260
> [   18.984264]  [<ffffffff810df611>] lock_acquire+0xb1/0x200
> [   18.984266]  [<ffffffff815afde0>] ? drm_modeset_lock_all+0x40/0x12=
0
> [   18.984267]  [<ffffffff815afde0>] ? drm_modeset_lock_all+0x40/0x12=
0
> [   18.984269]  [<ffffffff819a3097>] mutex_lock_nested+0x67/0x3c0
> [   18.984271]  [<ffffffff815afde0>] ? drm_modeset_lock_all+0x40/0x12=
0
> [   18.984273]  [<ffffffff810fa85f>] ? rcu_read_lock_sched_held+0x7f/=
0x90
> [   18.984276]  [<ffffffff81208218>] ? kmem_cache_alloc_trace+0x248/0=
x2b0
> [   18.984277]  [<ffffffff815afdc5>] ? drm_modeset_lock_all+0x25/0x12=
0
> [   18.984279]  [<ffffffff815afde0>] drm_modeset_lock_all+0x40/0x120
> [   18.984281]  [<ffffffff8158f79b>] drm_fb_helper_restore_fbdev_mode=
_unlocked+0x2b/0x80
> [   18.984283]  [<ffffffff8158f81d>] drm_fb_helper_set_par+0x2d/0x50
> [   18.984322]  [<ffffffffa0105f7a>] intel_fbdev_set_par+0x1a/0x60 [i=
915]
> [   18.984324]  [<ffffffff814c13c6>] fbcon_init+0x586/0x610
> [   18.984326]  [<ffffffff8154d16a>] visual_init+0xca/0x130
> [   18.984328]  [<ffffffff8154e611>] do_bind_con_driver+0x1c1/0x3a0
> [   18.984330]  [<ffffffff8154eaf6>] do_take_over_console+0x116/0x180
> [   18.984332]  [<ffffffff814bd3a7>] do_fbcon_takeover+0x57/0xb0
> [   18.984334]  [<ffffffff814c1e48>] fbcon_event_notify+0x658/0x750
> [   18.984336]  [<ffffffff810abcae>] notifier_call_chain+0x3e/0xb0
> [   18.984338]  [<ffffffff810ac1ad>] __blocking_notifier_call_chain+0=
x4d/0x70
> [   18.984340]  [<ffffffff810ac1e6>] blocking_notifier_call_chain+0x1=
6/0x20
> [   18.984342]  [<ffffffff814c748b>] fb_notifier_call_chain+0x1b/0x20
> [   18.984344]  [<ffffffff814c86b1>] register_framebuffer+0x251/0x330
> [   18.984347]  [<ffffffff815b7e8d>] ? vga_switcheroo_client_fb_set+0=
x5d/0x70
> [   18.984349]  [<ffffffff8158fa9f>] drm_fb_helper_initial_config+0x2=
5f/0x3f0
> [   18.984388]  [<ffffffffa0106b48>] intel_fbdev_initial_config+0x18/=
0x30 [i915]
> [   18.984389]  [<ffffffff810adfd8>] async_run_entry_fn+0x48/0x150
> [   18.984391]  [<ffffffff810a3947>] process_one_work+0x1e7/0x750
> [   18.984392]  [<ffffffff810a38c9>] ? process_one_work+0x169/0x750
> [   18.984394]  [<ffffffff810a3efb>] worker_thread+0x4b/0x4f0
> [   18.984396]  [<ffffffff810a3eb0>] ? process_one_work+0x750/0x750
> [   18.984398]  [<ffffffff810aad4f>] kthread+0xef/0x110
> [   18.984401]  [<ffffffff819a85ef>] ret_from_fork+0x1f/0x40
> [   18.984402]  [<ffffffff810aac60>] ? kthread_stop+0x2e0/0x2e0
>=20
> Reported-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: "Bruno Pr=E9mont" <bonbons@linux-vserver.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Daniel Drake <dsd@laptop.org>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Milo Kim <milo.kim@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/acpi/acpi_video.c                            |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c       |  3 ++-
>  drivers/gpu/drm/bridge/parade-ps8622.c               |  3 ++-
>  drivers/gpu/drm/gma500/cdv_device.c                  |  3 ++-
>  drivers/gpu/drm/gma500/mdfld_device.c                |  3 ++-
>  drivers/gpu/drm/gma500/oaktrail_device.c             |  3 ++-
>  drivers/gpu/drm/gma500/psb_device.c                  |  3 ++-
>  drivers/gpu/drm/i915/intel_panel.c                   |  3 ++-
>  drivers/gpu/drm/nouveau/nouveau_backlight.c          |  6 ++++--
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c      |  3 ++-
>  .../gpu/drm/omapdrm/displays/panel-sony-acx565akm.c  |  3 ++-
>  drivers/gpu/drm/radeon/atombios_encoders.c           |  3 ++-
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c      |  3 ++-
>  drivers/gpu/drm/shmobile/shmob_drm_backlight.c       |  3 ++-
>  drivers/hid/hid-picolcd_backlight.c                  |  3 ++-
>  drivers/macintosh/via-pmu-backlight.c                |  3 ++-
>  drivers/platform/x86/acer-wmi.c                      |  3 ++-
>  drivers/platform/x86/apple-gmux.c                    |  3 ++-
>  drivers/platform/x86/asus-laptop.c                   |  3 ++-
>  drivers/platform/x86/asus-wmi.c                      |  3 ++-
>  drivers/platform/x86/classmate-laptop.c              |  3 ++-
>  drivers/platform/x86/compal-laptop.c                 |  3 ++-
>  drivers/platform/x86/dell-laptop.c                   |  3 ++-
>  drivers/platform/x86/eeepc-laptop.c                  |  3 ++-
>  drivers/platform/x86/fujitsu-laptop.c                |  3 ++-
>  drivers/platform/x86/ideapad-laptop.c                |  3 ++-
>  drivers/platform/x86/intel_oaktrail.c                |  3 ++-
>  drivers/platform/x86/msi-laptop.c                    |  3 ++-
>  drivers/platform/x86/msi-wmi.c                       |  3 ++-
>  drivers/platform/x86/panasonic-laptop.c              |  3 ++-
>  drivers/platform/x86/samsung-laptop.c                |  3 ++-
>  drivers/platform/x86/samsung-q10.c                   |  3 ++-
>  drivers/platform/x86/sony-laptop.c                   |  3 ++-
>  drivers/platform/x86/thinkpad_acpi.c                 |  3 ++-
>  drivers/platform/x86/toshiba_acpi.c                  |  3 ++-
>  drivers/staging/fbtft/fb_ssd1351.c                   |  3 ++-
>  drivers/staging/fbtft/fb_watterott.c                 |  3 ++-
>  drivers/staging/fbtft/fbtft-core.c                   |  3 ++-
>  drivers/staging/olpc_dcon/olpc_dcon.c                |  3 ++-
>  drivers/usb/misc/appledisplay.c                      |  3 ++-
>  drivers/video/backlight/88pm860x_bl.c                |  3 ++-
>  drivers/video/backlight/aat2870_bl.c                 |  3 ++-
>  drivers/video/backlight/adp5520_bl.c                 |  3 ++-
>  drivers/video/backlight/adp8860_bl.c                 |  3 ++-
>  drivers/video/backlight/adp8870_bl.c                 |  3 ++-
>  drivers/video/backlight/ams369fg06.c                 |  3 ++-
>  drivers/video/backlight/apple_bl.c                   |  3 ++-
>  drivers/video/backlight/as3711_bl.c                  |  3 ++-
>  drivers/video/backlight/backlight.c                  | 20 ++++++++++=
+++-------
>  drivers/video/backlight/bd6107.c                     |  3 ++-
>  drivers/video/backlight/corgi_lcd.c                  |  3 ++-
>  drivers/video/backlight/cr_bllcd.c                   |  3 ++-
>  drivers/video/backlight/da903x_bl.c                  |  3 ++-
>  drivers/video/backlight/da9052_bl.c                  |  3 ++-
>  drivers/video/backlight/ep93xx_bl.c                  |  3 ++-
>  drivers/video/backlight/generic_bl.c                 |  3 ++-
>  drivers/video/backlight/gpio_backlight.c             |  3 ++-
>  drivers/video/backlight/hp680_bl.c                   |  3 ++-
>  drivers/video/backlight/ipaq_micro_bl.c              |  3 ++-
>  drivers/video/backlight/jornada720_bl.c              |  3 ++-
>  drivers/video/backlight/kb3886_bl.c                  |  3 ++-
>  drivers/video/backlight/ld9040.c                     |  3 ++-
>  drivers/video/backlight/lm3533_bl.c                  |  3 ++-
>  drivers/video/backlight/lm3630a_bl.c                 |  6 ++++--
>  drivers/video/backlight/lm3639_bl.c                  |  3 ++-
>  drivers/video/backlight/locomolcd.c                  |  3 ++-
>  drivers/video/backlight/lp855x_bl.c                  |  3 ++-
>  drivers/video/backlight/lp8788_bl.c                  |  3 ++-
>  drivers/video/backlight/lv5207lp.c                   |  3 ++-
>  drivers/video/backlight/max8925_bl.c                 |  3 ++-
>  drivers/video/backlight/omap1_bl.c                   |  3 ++-
>  drivers/video/backlight/ot200_bl.c                   |  3 ++-
>  drivers/video/backlight/pandora_bl.c                 |  3 ++-
>  drivers/video/backlight/pcf50633-backlight.c         |  3 ++-
>  drivers/video/backlight/pm8941-wled.c                |  3 ++-
>  drivers/video/backlight/pwm_bl.c                     |  3 ++-
>  drivers/video/backlight/s6e63m0.c                    |  3 ++-
>  drivers/video/backlight/sky81452-backlight.c         |  3 ++-
>  drivers/video/backlight/tosa_bl.c                    |  3 ++-
>  drivers/video/backlight/tps65217_bl.c                |  3 ++-
>  drivers/video/backlight/wm831x_bl.c                  |  3 ++-
>  drivers/video/fbdev/atmel_lcdfb.c                    |  3 ++-
>  drivers/video/fbdev/aty/aty128fb.c                   |  3 ++-
>  drivers/video/fbdev/aty/atyfb_base.c                 |  3 ++-
>  drivers/video/fbdev/aty/radeon_backlight.c           |  3 ++-
>  drivers/video/fbdev/bf537-lq035.c                    |  3 ++-
>  drivers/video/fbdev/bf54x-lq043fb.c                  |  3 ++-
>  drivers/video/fbdev/bfin-t350mcqb-fb.c               |  3 ++-
>  drivers/video/fbdev/exynos/s6e8ax0.c                 |  3 ++-
>  drivers/video/fbdev/mx3fb.c                          |  3 ++-
>  drivers/video/fbdev/nvidia/nv_backlight.c            |  3 ++-
>  .../video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c |  3 ++-
>  .../omap2/omapfb/displays/panel-sony-acx565akm.c     |  3 ++-
>  drivers/video/fbdev/riva/fbdev.c                     |  3 ++-
>  drivers/video/fbdev/sh_mobile_lcdcfb.c               |  3 ++-
>  drivers/video/fbdev/ssd1307fb.c                      |  3 ++-
>  include/linux/backlight.h                            |  7 +++++--
>  97 files changed, 212 insertions(+), 106 deletions(-)
>=20
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index c1d138e128cb..49e0acb70c17 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1693,7 +1693,8 @@ static void acpi_video_dev_register_backlight(s=
truct acpi_video_device *device)
>  						      parent,
>  						      device,
>  						      &acpi_backlight_ops,
> -						      &props);
> +						      &props,
> +						      BACKLIGHT_REGISTER_FB_CLIENT);
>  	kfree(name);
>  	if (IS_ERR(device->backlight)) {
>  		device->backlight =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers=
/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 48b6bd671cda..b6ae67a75a25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -198,7 +198,8 @@ void amdgpu_atombios_encoder_init_backlight(struc=
t amdgpu_encoder *amdgpu_encode
>  	snprintf(bl_name, sizeof(bl_name),
>  		 "amdgpu_bl%d", dev->primary->index);
>  	bd =3D backlight_device_register(bl_name, drm_connector->kdev,
> -				       pdata, &amdgpu_atombios_encoder_backlight_ops, &props);
> +				       pdata, &amdgpu_atombios_encoder_backlight_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		DRM_ERROR("Backlight registration failed\n");
>  		goto error;
> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm=
/bridge/parade-ps8622.c
> index 5cd8dd7e5904..14dea711b474 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -608,7 +608,8 @@ static int ps8622_probe(struct i2c_client *client=
,
>  	if (!of_find_property(dev->of_node, "use-external-pwm", NULL)) {
>  		ps8622->bl =3D backlight_device_register("ps8622-backlight",
>  				dev, ps8622, &ps8622_backlight_ops,
> -				NULL);
> +				NULL,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(ps8622->bl)) {
>  			DRM_ERROR("failed to register backlight\n");
>  			ret =3D PTR_ERR(ps8622->bl);
> diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gm=
a500/cdv_device.c
> index 8745971a7680..d2b4d645b4db 100644
> --- a/drivers/gpu/drm/gma500/cdv_device.c
> +++ b/drivers/gpu/drm/gma500/cdv_device.c
> @@ -163,7 +163,8 @@ static int cdv_backlight_init(struct drm_device *=
dev)
>  	props.type =3D BACKLIGHT_PLATFORM;
> =20
>  	cdv_backlight_device =3D backlight_device_register("psb-bl",
> -					NULL, (void *)dev, &cdv_ops, &props);
> +					NULL, (void *)dev, &cdv_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(cdv_backlight_device))
>  		return PTR_ERR(cdv_backlight_device);
> =20
> diff --git a/drivers/gpu/drm/gma500/mdfld_device.c b/drivers/gpu/drm/=
gma500/mdfld_device.c
> index e2ab858122f9..2e24ecccfd39 100644
> --- a/drivers/gpu/drm/gma500/mdfld_device.c
> +++ b/drivers/gpu/drm/gma500/mdfld_device.c
> @@ -130,7 +130,8 @@ static int mdfld_backlight_init(struct drm_device=
 *dev)
>  	props.max_brightness =3D BRIGHTNESS_MAX_LEVEL;
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	mdfld_backlight_device =3D backlight_device_register("mdfld-bl",
> -				NULL, (void *)dev, &mdfld_ops, &props);
> +				NULL, (void *)dev, &mdfld_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(mdfld_backlight_device))
>  		return PTR_ERR(mdfld_backlight_device);
> diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/d=
rm/gma500/oaktrail_device.c
> index ba30b43a3412..034553a524ac 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_device.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_device.c
> @@ -155,7 +155,8 @@ static int oaktrail_backlight_init(struct drm_dev=
ice *dev)
>  	props.type =3D BACKLIGHT_PLATFORM;
> =20
>  	oaktrail_backlight_device =3D backlight_device_register("oaktrail-b=
l",
> -				NULL, (void *)dev, &oaktrail_ops, &props);
> +				NULL, (void *)dev, &oaktrail_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(oaktrail_backlight_device))
>  		return PTR_ERR(oaktrail_backlight_device);
> diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gm=
a500/psb_device.c
> index dc0f8527570c..0c1385d64839 100644
> --- a/drivers/gpu/drm/gma500/psb_device.c
> +++ b/drivers/gpu/drm/gma500/psb_device.c
> @@ -131,7 +131,8 @@ static int psb_backlight_init(struct drm_device *=
dev)
>  	props.type =3D BACKLIGHT_PLATFORM;
> =20
>  	psb_backlight_device =3D backlight_device_register("psb-bl",
> -					NULL, (void *)dev, &psb_ops, &props);
> +					NULL, (void *)dev, &psb_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(psb_backlight_device))
>  		return PTR_ERR(psb_backlight_device);
> =20
> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i91=
5/intel_panel.c
> index 3c0b97f0bfae..acf6395b9f33 100644
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -1201,7 +1201,8 @@ int intel_backlight_device_register(struct inte=
l_connector *connector)
>  		backlight_device_register("intel_backlight",
>  					  connector->base.kdev,
>  					  connector,
> -					  &intel_backlight_device_ops, &props);
> +					  &intel_backlight_device_ops, &props,
> +					  0);
> =20
>  	if (IS_ERR(panel->backlight.device)) {
>  		DRM_ERROR("Failed to register backlight: %ld\n",
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gp=
u/drm/nouveau/nouveau_backlight.c
> index f5101be806cb..5fd7e7498f13 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -82,7 +82,8 @@ nv40_backlight_init(struct drm_connector *connector=
)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 31;
>  	bd =3D backlight_device_register("nv_backlight", connector->kdev, d=
rm,
> -				       &nv40_bl_ops, &props);
> +				       &nv40_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
>  	drm->backlight =3D bd;
> @@ -204,7 +205,8 @@ nv50_backlight_init(struct drm_connector *connect=
or)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 100;
>  	bd =3D backlight_device_register("nv_backlight", connector->kdev,
> -				       nv_encoder, ops, &props);
> +				       nv_encoder, ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/driver=
s/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 1b0cf2d8224b..10511bdd9936 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -1260,7 +1260,8 @@ static int dsicm_probe(struct platform_device *=
pdev)
> =20
>  		props.type =3D BACKLIGHT_RAW;
>  		bldev =3D backlight_device_register(dev_name(dev),
> -				dev, ddata, &dsicm_bl_ops, &props);
> +				dev, ddata, &dsicm_bl_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(bldev)) {
>  			r =3D PTR_ERR(bldev);
>  			goto err_bl;
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c =
b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> index 157c512205d1..9f3622910511 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> @@ -817,7 +817,8 @@ static int acx565akm_probe(struct spi_device *spi=
)
>  	props.type =3D BACKLIGHT_RAW;
> =20
>  	bldev =3D backlight_device_register("acx565akm", &ddata->spi->dev,
> -			ddata, &acx565akm_bl_ops, &props);
> +			ddata, &acx565akm_bl_ops, &props,
> +			BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bldev)) {
>  		r =3D PTR_ERR(bldev);
>  		goto err_reg_bl;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu=
/drm/radeon/atombios_encoders.c
> index 587cae4e73c9..3676ba6e16ee 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -214,7 +214,8 @@ void radeon_atom_backlight_init(struct radeon_enc=
oder *radeon_encoder,
>  	snprintf(bl_name, sizeof(bl_name),
>  		 "radeon_bl%d", dev->primary->index);
>  	bd =3D backlight_device_register(bl_name, drm_connector->kdev,
> -				       pdata, &radeon_atom_backlight_ops, &props);
> +				       pdata, &radeon_atom_backlight_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		DRM_ERROR("Backlight registration failed\n");
>  		goto error;
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/driver=
s/gpu/drm/radeon/radeon_legacy_encoders.c
> index 868c3ba2efaa..27908624c818 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> @@ -393,7 +393,8 @@ void radeon_legacy_backlight_init(struct radeon_e=
ncoder *radeon_encoder,
>  	snprintf(bl_name, sizeof(bl_name),
>  		 "radeon_bl%d", dev->primary->index);
>  	bd =3D backlight_device_register(bl_name, drm_connector->kdev,
> -				       pdata, &radeon_backlight_ops, &props);
> +				       pdata, &radeon_backlight_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		DRM_ERROR("Backlight registration failed\n");
>  		goto error;
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c b/drivers=
/gpu/drm/shmobile/shmob_drm_backlight.c
> index 33dd41afea0e..1ff10faed3a7 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> @@ -68,7 +68,8 @@ int shmob_drm_backlight_init(struct shmob_drm_conne=
ctor *scon)
>  		return 0;
> =20
>  	backlight =3D backlight_device_register(bdata->name, dev->dev, scon=
,
> -					      &shmob_drm_backlight_ops, NULL);
> +					      &shmob_drm_backlight_ops, NULL,
> +					      BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(backlight)) {
>  		dev_err(dev->dev, "unable to register backlight device: %ld\n",
>  			PTR_ERR(backlight));
> diff --git a/drivers/hid/hid-picolcd_backlight.c b/drivers/hid/hid-pi=
colcd_backlight.c
> index 808807ad388f..06597f50c32b 100644
> --- a/drivers/hid/hid-picolcd_backlight.c
> +++ b/drivers/hid/hid-picolcd_backlight.c
> @@ -77,7 +77,8 @@ int picolcd_init_backlight(struct picolcd_data *dat=
a, struct hid_report *report)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 0xff;
>  	bdev =3D backlight_device_register(dev_name(dev), dev, data,
> -			&picolcd_blops, &props);
> +			&picolcd_blops, &props,
> +			BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bdev)) {
>  		dev_err(dev, "failed to register backlight\n");
>  		return PTR_ERR(bdev);
> diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintos=
h/via-pmu-backlight.c
> index 6f68537c93ce..da0fb2e87f75 100644
> --- a/drivers/macintosh/via-pmu-backlight.c
> +++ b/drivers/macintosh/via-pmu-backlight.c
> @@ -160,7 +160,8 @@ void __init pmu_backlight_init()
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, NULL, NULL, &pmu_backlight_d=
ata,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		printk(KERN_ERR "PMU Backlight registration failed\n");
>  		return;
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index 79d64ea00bfb..0b17c5146175 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1419,7 +1419,8 @@ static int acer_backlight_init(struct device *d=
ev)
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D max_brightness;
>  	bd =3D backlight_device_register("acer-wmi", dev, NULL, &acer_bl_op=
s,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		pr_err("Could not register Acer backlight device\n");
>  		acer_backlight_device =3D NULL;
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86=
/apple-gmux.c
> index 4034d2d4c507..e041bbe14df5 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -698,7 +698,8 @@ static int gmux_probe(struct pnp_dev *pnp, const =
struct pnp_device_id *id)
>  		props.max_brightness =3D GMUX_MAX_BRIGHTNESS;
> =20
>  	bdev =3D backlight_device_register("gmux_backlight", &pnp->dev,
> -					 gmux_data, &gmux_bl_ops, &props);
> +					 gmux_data, &gmux_bl_ops, &props,
> +					 BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bdev)) {
>  		ret =3D PTR_ERR(bdev);
>  		goto err_release;
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x8=
6/asus-laptop.c
> index 15f131146501..98f26cff9c96 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -831,7 +831,8 @@ static int asus_backlight_init(struct asus_laptop=
 *asus)
> =20
>  	bd =3D backlight_device_register(ASUS_LAPTOP_FILE,
>  				       &asus->platform_device->dev, asus,
> -				       &asusbl_ops, &props);
> +				       &asusbl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		pr_err("Could not register asus backlight device\n");
>  		asus->backlight_device =3D NULL;
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/a=
sus-wmi.c
> index a26dca3640ea..ca897bc94626 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1565,7 +1565,8 @@ static int asus_wmi_backlight_init(struct asus_=
wmi *asus)
>  	props.max_brightness =3D max;
>  	bd =3D backlight_device_register(asus->driver->name,
>  				       &asus->platform_device->dev, asus,
> -				       &asus_wmi_bl_ops, &props);
> +				       &asus_wmi_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		pr_err("Could not register backlight device\n");
>  		return PTR_ERR(bd);
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platfo=
rm/x86/classmate-laptop.c
> index 55cf10bc7817..60cf7a0c7170 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -970,7 +970,8 @@ static int cmpc_ipml_add(struct acpi_device *acpi=
)
>  	props.max_brightness =3D 7;
>  	ipml->bd =3D backlight_device_register("cmpc_bl", &acpi->dev,
>  					     acpi->handle, &cmpc_bl_ops,
> -					     &props);
> +					     &props,
> +					     BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(ipml->bd)) {
>  		retval =3D PTR_ERR(ipml->bd);
>  		goto out_bd;
> diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/=
x86/compal-laptop.c
> index e1c2b6d4b24a..9a675d3b6fe5 100644
> --- a/drivers/platform/x86/compal-laptop.c
> +++ b/drivers/platform/x86/compal-laptop.c
> @@ -1008,7 +1008,8 @@ static int __init compal_init(void)
>  		compalbl_device =3D backlight_device_register(DRIVER_NAME,
>  							    NULL, NULL,
>  							    &compalbl_ops,
> -							    &props);
> +							    &props,
> +							    BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(compalbl_device))
>  			return PTR_ERR(compalbl_device);
>  	}
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x8=
6/dell-laptop.c
> index 2c2f02b2e08a..57712a970f8d 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2035,7 +2035,8 @@ static int __init dell_init(void)
>  								  &platform_device->dev,
>  								  NULL,
>  								  &dell_ops,
> -								  &props);
> +								  &props,
> +								  BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  		if (IS_ERR(dell_backlight_device)) {
>  			ret =3D PTR_ERR(dell_backlight_device);
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index 8cdf315f9730..da8ada2ba429 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1159,7 +1159,8 @@ static int eeepc_backlight_init(struct eeepc_la=
ptop *eeepc)
>  	props.max_brightness =3D 15;
>  	bd =3D backlight_device_register(EEEPC_LAPTOP_FILE,
>  				       &eeepc->platform_device->dev, eeepc,
> -				       &eeepcbl_ops, &props);
> +				       &eeepcbl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		pr_err("Could not register eeepc backlight device\n");
>  		eeepc->backlight_device =3D NULL;
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform=
/x86/fujitsu-laptop.c
> index ce41bc34288d..b54e7ea2e968 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -1167,7 +1167,8 @@ static int __init fujitsu_init(void)
>  		fujitsu->bl_device =3D backlight_device_register("fujitsu-laptop",
>  							       NULL, NULL,
>  							       &fujitsubl_ops,
> -							       &props);
> +							       &props,
> +							       BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(fujitsu->bl_device)) {
>  			ret =3D PTR_ERR(fujitsu->bl_device);
>  			fujitsu->bl_device =3D NULL;
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform=
/x86/ideapad-laptop.c
> index d1a091b93192..99de02efd971 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -726,7 +726,8 @@ static int ideapad_backlight_init(struct ideapad_=
private *priv)
>  					      &priv->platform_device->dev,
>  					      priv,
>  					      &ideapad_backlight_ops,
> -					      &props);
> +					      &props,
> +					      BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(blightdev)) {
>  		pr_err("Could not register backlight device\n");
>  		return PTR_ERR(blightdev);
> diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform=
/x86/intel_oaktrail.c
> index 6aa33c4a809f..303e8e27a0b9 100644
> --- a/drivers/platform/x86/intel_oaktrail.c
> +++ b/drivers/platform/x86/intel_oaktrail.c
> @@ -253,7 +253,8 @@ static int oaktrail_backlight_init(void)
>  	bd =3D backlight_device_register(DRIVER_NAME,
>  				       &oaktrail_device->dev, NULL,
>  				       &oaktrail_bl_ops,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(bd)) {
>  		oaktrail_bl_device =3D NULL;
> diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86=
/msi-laptop.c
> index 42317704629d..81990bdab229 100644
> --- a/drivers/platform/x86/msi-laptop.c
> +++ b/drivers/platform/x86/msi-laptop.c
> @@ -1078,7 +1078,8 @@ static int __init msi_init(void)
>  		props.max_brightness =3D MSI_LCD_LEVEL_MAX - 1;
>  		msibl_device =3D backlight_device_register("msi-laptop-bl", NULL,
>  							 NULL, &msibl_ops,
> -							 &props);
> +							 &props,
> +							 BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(msibl_device))
>  			return PTR_ERR(msibl_device);
>  	}
> diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/ms=
i-wmi.c
> index 978e6d640572..5174572a7859 100644
> --- a/drivers/platform/x86/msi-wmi.c
> +++ b/drivers/platform/x86/msi-wmi.c
> @@ -247,7 +247,8 @@ static int __init msi_wmi_backlight_setup(void)
>  	props.max_brightness =3D ARRAY_SIZE(backlight_map) - 1;
>  	backlight =3D backlight_device_register(DRV_NAME, NULL, NULL,
>  					      &msi_backlight_ops,
> -					      &props);
> +					      &props,
> +					      BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(backlight))
>  		return PTR_ERR(backlight);
> =20
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platfo=
rm/x86/panasonic-laptop.c
> index 3f870972247c..00679814d8c3 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -618,7 +618,8 @@ static int acpi_pcc_hotkey_add(struct acpi_device=
 *device)
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D pcc->sinf[SINF_AC_MAX_BRIGHT];
>  	pcc->backlight =3D backlight_device_register("panasonic", NULL, pcc=
,
> -						   &pcc_backlight_ops, &props);
> +						   &pcc_backlight_ops, &props,
> +						   BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(pcc->backlight)) {
>  		result =3D PTR_ERR(pcc->backlight);
>  		goto out_input;
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform=
/x86/samsung-laptop.c
> index 8c146e2b6727..09868706dfd6 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1200,7 +1200,8 @@ static int __init samsung_backlight_init(struct=
 samsung_laptop *samsung)
>  	bd =3D backlight_device_register("samsung",
>  				       &samsung->platform_device->dev,
>  				       samsung, &backlight_ops,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/platform/x86/samsung-q10.c b/drivers/platform/x8=
6/samsung-q10.c
> index e6aac725a0af..cc25d0416236 100644
> --- a/drivers/platform/x86/samsung-q10.c
> +++ b/drivers/platform/x86/samsung-q10.c
> @@ -60,7 +60,8 @@ static int samsungq10_probe(struct platform_device =
*pdev)
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D SAMSUNGQ10_BL_MAX_INTENSITY;
>  	bd =3D backlight_device_register("samsung", &pdev->dev, NULL,
> -				       &samsungq10_bl_ops, &props);
> +				       &samsungq10_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x8=
6/sony-laptop.c
> index 1dba3598cfcb..a20f30621e5f 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -3158,7 +3158,8 @@ static void sony_nc_backlight_setup(void)
>  	props.max_brightness =3D max_brightness;
>  	sony_bl_props.dev =3D backlight_device_register("sony", NULL,
>  						      &sony_bl_props,
> -						      ops, &props);
> +						      ops, &props,
> +						      BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(sony_bl_props.dev)) {
>  		pr_warn("unable to register backlight device\n");
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/=
x86/thinkpad_acpi.c
> index b65ce7519411..987ef89b11da 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6821,7 +6821,8 @@ static int __init brightness_init(struct ibm_in=
it_struct *iibm)
>  	ibm_backlight_device =3D backlight_device_register(TPACPI_BACKLIGHT=
_DEV_NAME,
>  							 NULL, NULL,
>  							 &ibm_backlight_data,
> -							 &props);
> +							 &props,
> +							 BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(ibm_backlight_device)) {
>  		int rc =3D PTR_ERR(ibm_backlight_device);
>  		ibm_backlight_device =3D NULL;
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x=
86/toshiba_acpi.c
> index 01e12d221a8b..6b0f23360094 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2840,7 +2840,8 @@ static int toshiba_acpi_setup_backlight(struct =
toshiba_acpi_dev *dev)
>  						       &dev->acpi_dev->dev,
>  						       dev,
>  						       &toshiba_backlight_data,
> -						       &props);
> +						       &props,
> +						       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(dev->backlight_dev)) {
>  		ret =3D PTR_ERR(dev->backlight_dev);
>  		pr_err("Could not register toshiba backlight device\n");
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbt=
ft/fb_ssd1351.c
> index cef33e439f46..6a194faf6448 100644
> --- a/drivers/staging/fbtft/fb_ssd1351.c
> +++ b/drivers/staging/fbtft/fb_ssd1351.c
> @@ -210,7 +210,8 @@ static void register_onboard_backlight(struct fbt=
ft_par *par)
>  	bl_props.power =3D FB_BLANK_POWERDOWN;
> =20
>  	bd =3D backlight_device_register(dev_driver_string(par->info->devic=
e),
> -				par->info->device, par, &bl_ops, &bl_props);
> +				par->info->device, par, &bl_ops, &bl_props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(par->info->device,
>  			"cannot register backlight device (%ld)\n",
> diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/f=
btft/fb_watterott.c
> index f8cb610a7b69..b24913688014 100644
> --- a/drivers/staging/fbtft/fb_watterott.c
> +++ b/drivers/staging/fbtft/fb_watterott.c
> @@ -259,7 +259,8 @@ static void register_chip_backlight(struct fbtft_=
par *par)
>  	bl_props.brightness =3D DEFAULT_BRIGHTNESS;
> =20
>  	bd =3D backlight_device_register(dev_driver_string(par->info->devic=
e),
> -				par->info->device, par, &bl_ops, &bl_props);
> +				par->info->device, par, &bl_ops, &bl_props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(par->info->device,
>  			"cannot register backlight device (%ld)\n",
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbt=
ft/fbtft-core.c
> index 0c1a77cafe14..61c67b079b90 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -299,7 +299,8 @@ void fbtft_register_backlight(struct fbtft_par *p=
ar)
>  		bl_props.state |=3D BL_CORE_DRIVER1;
> =20
>  	bd =3D backlight_device_register(dev_driver_string(par->info->devic=
e),
> -				par->info->device, par, &fbtft_bl_ops, &bl_props);
> +				par->info->device, par, &fbtft_bl_ops, &bl_props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(par->info->device,
>  			"cannot register backlight device (%ld)\n",
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/=
olpc_dcon/olpc_dcon.c
> index f45b2ef05f48..385c7adeaa26 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -643,7 +643,8 @@ static int dcon_probe(struct i2c_client *client, =
const struct i2c_device_id *id)
>  	/* Add the backlight device for the DCON */
>  	dcon_bl_props.brightness =3D dcon->bl_val;
>  	dcon->bl_dev =3D backlight_device_register("dcon-bl", &dcon_device-=
>dev,
> -		dcon, &dcon_bl_ops, &dcon_bl_props);
> +		dcon, &dcon_bl_ops, &dcon_bl_props,
> +		BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(dcon->bl_dev)) {
>  		dev_err(&client->dev, "cannot register backlight dev (%ld)\n",
>  				PTR_ERR(dcon->bl_dev));
> diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/apple=
display.c
> index a0a3827b4aff..97c0829711a8 100644
> --- a/drivers/usb/misc/appledisplay.c
> +++ b/drivers/usb/misc/appledisplay.c
> @@ -293,7 +293,8 @@ static int appledisplay_probe(struct usb_interfac=
e *iface,
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 0xff;
>  	pdata->bd =3D backlight_device_register(bl_name, NULL, pdata,
> -					      &appledisplay_bl_data, &props);
> +					      &appledisplay_bl_data, &props,
> +					      BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(pdata->bd)) {
>  		dev_err(&iface->dev, "Backlight registration failed\n");
>  		retval =3D PTR_ERR(pdata->bd);
> diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/ba=
cklight/88pm860x_bl.c
> index 6d8dc2c77520..e0d8212aebc0 100644
> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -242,7 +242,8 @@ static int pm860x_backlight_probe(struct platform=
_device *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D MAX_BRIGHTNESS;
>  	bl =3D devm_backlight_device_register(&pdev->dev, name, &pdev->dev,=
 data,
> -					&pm860x_backlight_ops, &props);
> +					&pm860x_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/bac=
klight/aat2870_bl.c
> index 50774e657700..a4cbc33bd6c2 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
> @@ -152,7 +152,8 @@ static int aat2870_bl_probe(struct platform_devic=
e *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	bd =3D devm_backlight_device_register(&pdev->dev, "aat2870-backligh=
t",
>  					&pdev->dev, aat2870_bl, &aat2870_bl_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(&pdev->dev,
>  			"Failed allocate memory for backlight device\n");
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/bac=
klight/adp5520_bl.c
> index dd88ba1d71ce..03093fbee414 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -315,7 +315,8 @@ static int adp5520_bl_probe(struct platform_devic=
e *pdev)
>  	props.max_brightness =3D ADP5020_MAX_BRIGHTNESS;
>  	bl =3D devm_backlight_device_register(&pdev->dev, pdev->name,
>  					data->master, data, &adp5520_bl_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/bac=
klight/adp8860_bl.c
> index 510e559c060e..88982ed257d9 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -718,7 +718,8 @@ static int adp8860_probe(struct i2c_client *clien=
t,
> =20
>  	bl =3D devm_backlight_device_register(&client->dev,
>  				dev_driver_string(&client->dev),
> -				&client->dev, data, &adp8860_bl_ops, &props);
> +				&client->dev, data, &adp8860_bl_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&client->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/bac=
klight/adp8870_bl.c
> index 21acac90fd77..5284f7f3cdd3 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -894,7 +894,8 @@ static int adp8870_probe(struct i2c_client *clien=
t,
>  	props.max_brightness =3D props.brightness =3D ADP8870_MAX_BRIGHTNES=
S;
>  	bl =3D devm_backlight_device_register(&client->dev,
>  				dev_driver_string(&client->dev),
> -				&client->dev, data, &adp8870_bl_ops, &props);
> +				&client->dev, data, &adp8870_bl_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&client->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/bac=
klight/ams369fg06.c
> index 5cca8ce45d4d..1bd656141c1e 100644
> --- a/drivers/video/backlight/ams369fg06.c
> +++ b/drivers/video/backlight/ams369fg06.c
> @@ -484,7 +484,8 @@ static int ams369fg06_probe(struct spi_device *sp=
i)
> =20
>  	bd =3D devm_backlight_device_register(&spi->dev, "ams369fg06-bl",
>  					&spi->dev, lcd,
> -					&ams369fg06_backlight_ops, &props);
> +					&ams369fg06_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backl=
ight/apple_bl.c
> index d84329676689..ee2e92d58512 100644
> --- a/drivers/video/backlight/apple_bl.c
> +++ b/drivers/video/backlight/apple_bl.c
> @@ -182,7 +182,8 @@ static int apple_bl_add(struct acpi_device *dev)
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D 15;
>  	apple_backlight_device =3D backlight_device_register("apple_backlig=
ht",
> -				  NULL, NULL, &hw_data->backlight_ops, &props);
> +				  NULL, NULL, &hw_data->backlight_ops, &props,
> +				  BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(apple_backlight_device)) {
>  		release_region(hw_data->iostart, hw_data->iolen);
> diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/back=
light/as3711_bl.c
> index 734a9158946b..5f3a40bc8a85 100644
> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -244,7 +244,8 @@ static int as3711_bl_register(struct platform_dev=
ice *pdev,
>  				       su->type =3D=3D AS3711_BL_SU1 ?
>  				       "as3711-su1" : "as3711-su2",
>  				       &pdev->dev, su,
> -				       &as3711_bl_ops, &props);
> +				       &as3711_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/back=
light/backlight.c
> index 288318ad21dd..1a25273576e8 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -319,13 +319,15 @@ EXPORT_SYMBOL(backlight_force_update);
>   * @devdata: an optional pointer to be stored for private driver use=
=2E The
>   *   methods may retrieve it by using bl_get_data(bd).
>   * @ops: the backlight operations structure.
> + * @flags: bitmask to control backlight registration
>   *
>   * Creates and registers new backlight device. Returns either an
>   * ERR_PTR() or a pointer to the newly allocated device.
>   */
>  struct backlight_device *backlight_device_register(const char *name,
>  	struct device *parent, void *devdata, const struct backlight_ops *o=
ps,
> -	const struct backlight_properties *props)
> +	const struct backlight_properties *props,
> +	unsigned long flags)
>  {
>  	struct backlight_device *new_bd;
>  	int rc;
> @@ -363,10 +365,12 @@ struct backlight_device *backlight_device_regis=
ter(const char *name,
>  		return ERR_PTR(rc);
>  	}
> =20
> -	rc =3D backlight_register_fb(new_bd);
> -	if (rc) {
> -		device_unregister(&new_bd->dev);
> -		return ERR_PTR(rc);
> +	if (flags & BACKLIGHT_REGISTER_FB_CLIENT) {
> +		rc =3D backlight_register_fb(new_bd);
> +		if (rc) {
> +			device_unregister(&new_bd->dev);
> +			return ERR_PTR(rc);
> +		}
>  	}
> =20
>  	new_bd->ops =3D ops;
> @@ -494,6 +498,7 @@ EXPORT_SYMBOL(backlight_unregister_notifier);
>   * @devdata: an optional pointer to be stored for private driver use
>   * @ops: the backlight operations structure
>   * @props: the backlight properties
> + * @flags: bitmask to control backlight registration
>   *
>   * @return a struct backlight on success, or an ERR_PTR on error
>   *
> @@ -504,7 +509,8 @@ EXPORT_SYMBOL(backlight_unregister_notifier);
>  struct backlight_device *devm_backlight_device_register(struct devic=
e *dev,
>  	const char *name, struct device *parent, void *devdata,
>  	const struct backlight_ops *ops,
> -	const struct backlight_properties *props)
> +	const struct backlight_properties *props,
> +	unsigned long flags)
>  {
>  	struct backlight_device **ptr, *backlight;
> =20
> @@ -514,7 +520,7 @@ struct backlight_device *devm_backlight_device_re=
gister(struct device *dev,
>  		return ERR_PTR(-ENOMEM);
> =20
>  	backlight =3D backlight_device_register(name, parent, devdata, ops,
> -						props);
> +						props, flags);
>  	if (!IS_ERR(backlight)) {
>  		*ptr =3D backlight;
>  		devres_add(dev, ptr);
> diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlig=
ht/bd6107.c
> index fdb2f7e2c6b5..a8ecd7a2f2a4 100644
> --- a/drivers/video/backlight/bd6107.c
> +++ b/drivers/video/backlight/bd6107.c
> @@ -163,7 +163,8 @@ static int bd6107_probe(struct i2c_client *client=
,
>  	backlight =3D devm_backlight_device_register(&client->dev,
>  					      dev_name(&client->dev),
>  					      &bd->client->dev, bd,
> -					      &bd6107_backlight_ops, &props);
> +					      &bd6107_backlight_ops, &props,
> +					      BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(backlight)) {
>  		dev_err(&client->dev, "failed to register backlight\n");
>  		return PTR_ERR(backlight);
> diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/back=
light/corgi_lcd.c
> index d7c239ea3d09..006e171256a0 100644
> --- a/drivers/video/backlight/corgi_lcd.c
> +++ b/drivers/video/backlight/corgi_lcd.c
> @@ -562,7 +562,8 @@ static int corgi_lcd_probe(struct spi_device *spi=
)
>  	props.max_brightness =3D pdata->max_intensity;
>  	lcd->bl_dev =3D devm_backlight_device_register(&spi->dev, "corgi_bl=
",
>  						&spi->dev, lcd, &corgi_bl_ops,
> -						&props);
> +						&props,
> +						BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(lcd->bl_dev))
>  		return PTR_ERR(lcd->bl_dev);
> =20
> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backl=
ight/cr_bllcd.c
> index 3e3880fc8c8e..cf7c5d35dd63 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -197,7 +197,8 @@ static int cr_backlight_probe(struct platform_dev=
ice *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	bdp =3D devm_backlight_device_register(&pdev->dev, "cr-backlight",
>  					&pdev->dev, NULL, &cr_backlight_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bdp)) {
>  		pci_dev_put(lpc_dev);
>  		return PTR_ERR(bdp);
> diff --git a/drivers/video/backlight/da903x_bl.c b/drivers/video/back=
light/da903x_bl.c
> index f793738f06fb..d6019aebfa42 100644
> --- a/drivers/video/backlight/da903x_bl.c
> +++ b/drivers/video/backlight/da903x_bl.c
> @@ -146,7 +146,8 @@ static int da903x_backlight_probe(struct platform=
_device *pdev)
>  	props.max_brightness =3D max_brightness;
>  	bl =3D devm_backlight_device_register(&pdev->dev, pdev->name,
>  					data->da903x_dev, data,
> -					&da903x_backlight_ops, &props);
> +					&da903x_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/back=
light/da9052_bl.c
> index fd2be417aa64..96738c2e8a09 100644
> --- a/drivers/video/backlight/da9052_bl.c
> +++ b/drivers/video/backlight/da9052_bl.c
> @@ -127,7 +127,8 @@ static int da9052_backlight_probe(struct platform=
_device *pdev)
> =20
>  	bl =3D devm_backlight_device_register(&pdev->dev, pdev->name,
>  					wleds->da9052->dev, wleds,
> -					&da9052_backlight_ops, &props);
> +					&da9052_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "Failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/back=
light/ep93xx_bl.c
> index 0067931821c6..7fe2549969a1 100644
> --- a/drivers/video/backlight/ep93xx_bl.c
> +++ b/drivers/video/backlight/ep93xx_bl.c
> @@ -93,7 +93,8 @@ static int ep93xxbl_probe(struct platform_device *d=
ev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D EP93XX_MAX_BRIGHT;
>  	bl =3D devm_backlight_device_register(&dev->dev, dev->name, &dev->d=
ev,
> -					ep93xxbl, &ep93xxbl_ops, &props);
> +					ep93xxbl, &ep93xxbl_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl))
>  		return PTR_ERR(bl);
> =20
> diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/bac=
klight/generic_bl.c
> index 67dfb939a514..717318e12f87 100644
> --- a/drivers/video/backlight/generic_bl.c
> +++ b/drivers/video/backlight/generic_bl.c
> @@ -76,7 +76,8 @@ static int genericbl_probe(struct platform_device *=
pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D machinfo->max_intensity;
>  	bd =3D devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
> -					NULL, &genericbl_ops, &props);
> +					NULL, &genericbl_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video=
/backlight/gpio_backlight.c
> index 18134416b154..d0b6f5155f86 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -132,7 +132,8 @@ static int gpio_backlight_probe(struct platform_d=
evice *pdev)
>  	props.max_brightness =3D 1;
>  	bl =3D devm_backlight_device_register(&pdev->dev, dev_name(&pdev->d=
ev),
>  					&pdev->dev, gbl, &gpio_backlight_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backl=
ight/hp680_bl.c
> index 8ea42b8d9bc8..a75b2d0d489a 100644
> --- a/drivers/video/backlight/hp680_bl.c
> +++ b/drivers/video/backlight/hp680_bl.c
> @@ -111,7 +111,8 @@ static int hp680bl_probe(struct platform_device *=
pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D HP680_MAX_INTENSITY;
>  	bd =3D devm_backlight_device_register(&pdev->dev, "hp680-bl", &pdev=
->dev,
> -					NULL, &hp680bl_ops, &props);
> +					NULL, &hp680bl_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/=
backlight/ipaq_micro_bl.c
> index 347dc11d4ceb..834ccc8a7291 100644
> --- a/drivers/video/backlight/ipaq_micro_bl.c
> +++ b/drivers/video/backlight/ipaq_micro_bl.c
> @@ -60,7 +60,8 @@ static int micro_backlight_probe(struct platform_de=
vice *pdev)
> =20
>  	bd =3D devm_backlight_device_register(&pdev->dev, "ipaq-micro-backl=
ight",
>  					    &pdev->dev, micro, &micro_bl_ops,
> -					    &micro_bl_props);
> +					    &micro_bl_props,
> +					    BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/=
backlight/jornada720_bl.c
> index 7e6ff5346892..e173c5b60e9e 100644
> --- a/drivers/video/backlight/jornada720_bl.c
> +++ b/drivers/video/backlight/jornada720_bl.c
> @@ -118,7 +118,8 @@ static int jornada_bl_probe(struct platform_devic=
e *pdev)
> =20
>  	bd =3D devm_backlight_device_register(&pdev->dev, S1D_DEVICENAME,
>  					&pdev->dev, NULL, &jornada_bl_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		ret =3D PTR_ERR(bd);
>  		dev_err(&pdev->dev, "failed to register device, err=3D%x\n", ret);
> diff --git a/drivers/video/backlight/kb3886_bl.c b/drivers/video/back=
light/kb3886_bl.c
> index 84a110a719cb..eb619c4a7a39 100644
> --- a/drivers/video/backlight/kb3886_bl.c
> +++ b/drivers/video/backlight/kb3886_bl.c
> @@ -153,7 +153,8 @@ static int kb3886bl_probe(struct platform_device =
*pdev)
>  	kb3886_backlight_device =3D devm_backlight_device_register(&pdev->d=
ev,
>  							"kb3886-bl", &pdev->dev,
>  							NULL, &kb3886bl_ops,
> -							&props);
> +							&props,
> +							BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(kb3886_backlight_device))
>  		return PTR_ERR(kb3886_backlight_device);
> =20
> diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlig=
ht/ld9040.c
> index 677f8abba27c..c28e91fec54f 100644
> --- a/drivers/video/backlight/ld9040.c
> +++ b/drivers/video/backlight/ld9040.c
> @@ -722,7 +722,8 @@ static int ld9040_probe(struct spi_device *spi)
>  	props.max_brightness =3D MAX_BRIGHTNESS;
> =20
>  	bd =3D devm_backlight_device_register(&spi->dev, "ld9040-bl", &spi-=
>dev,
> -					lcd, &ld9040_backlight_ops, &props);
> +					lcd, &ld9040_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/back=
light/lm3533_bl.c
> index 0e2337f367b6..f6345a2cd076 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -312,7 +312,8 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
>  	props.brightness =3D pdata->default_brightness;
>  	bd =3D devm_backlight_device_register(&pdev->dev, pdata->name,
>  					pdev->dev.parent, bl, &lm3533_bl_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(&pdev->dev, "failed to register backlight device\n");
>  		return PTR_ERR(bd);
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/bac=
klight/lm3630a_bl.c
> index 60d6c2ac87aa..a62a09510fe3 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -338,7 +338,8 @@ static int lm3630a_backlight_register(struct lm36=
30a_chip *pchip)
>  		pchip->bleda =3D
>  		    devm_backlight_device_register(pchip->dev, "lm3630a_leda",
>  						   pchip->dev, pchip,
> -						   &lm3630a_bank_a_ops, &props);
> +						   &lm3630a_bank_a_ops, &props,
> +						   BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(pchip->bleda))
>  			return PTR_ERR(pchip->bleda);
>  	}
> @@ -350,7 +351,8 @@ static int lm3630a_backlight_register(struct lm36=
30a_chip *pchip)
>  		pchip->bledb =3D
>  		    devm_backlight_device_register(pchip->dev, "lm3630a_ledb",
>  						   pchip->dev, pchip,
> -						   &lm3630a_bank_b_ops, &props);
> +						   &lm3630a_bank_b_ops, &props,
> +						   BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(pchip->bledb))
>  			return PTR_ERR(pchip->bledb);
>  	}
> diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/back=
light/lm3639_bl.c
> index cd50df5807ea..4aaf0c3f9eee 100644
> --- a/drivers/video/backlight/lm3639_bl.c
> +++ b/drivers/video/backlight/lm3639_bl.c
> @@ -349,7 +349,8 @@ static int lm3639_probe(struct i2c_client *client=
,
>  	pchip->bled =3D
>  	    devm_backlight_device_register(pchip->dev, "lm3639_bled",
>  					   pchip->dev, pchip, &lm3639_bled_ops,
> -					   &props);
> +					   &props,
> +					   BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(pchip->bled)) {
>  		dev_err(&client->dev, "fail : backlight register\n");
>  		ret =3D PTR_ERR(pchip->bled);
> diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/back=
light/locomolcd.c
> index 6c3ec4259a60..126a4df5fd12 100644
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -200,7 +200,8 @@ static int locomolcd_probe(struct locomo_dev *lde=
v)
>  	props.max_brightness =3D 4;
>  	locomolcd_bl_device =3D backlight_device_register("locomo-bl",
>  							&ldev->dev, NULL,
> -							&locomobl_data, &props);
> +							&locomobl_data, &props,
> +							BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(locomolcd_bl_device))
>  		return PTR_ERR(locomolcd_bl_device);
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/back=
light/lp855x_bl.c
> index e5b14f52628f..6ef51c6540a6 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -299,7 +299,8 @@ static int lp855x_backlight_register(struct lp855=
x *lp)
>  	props.brightness =3D pdata->initial_brightness;
> =20
>  	bl =3D devm_backlight_device_register(lp->dev, name, lp->dev, lp,
> -				       &lp855x_bl_ops, &props);
> +				       &lp855x_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl))
>  		return PTR_ERR(bl);
> =20
> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/back=
light/lp8788_bl.c
> index cf869ec90cce..734677bef739 100644
> --- a/drivers/video/backlight/lp8788_bl.c
> +++ b/drivers/video/backlight/lp8788_bl.c
> @@ -214,7 +214,8 @@ static int lp8788_backlight_register(struct lp878=
8_bl *bl)
>  		name =3D pdata->name;
> =20
>  	bl_dev =3D backlight_device_register(name, bl->lp->dev, bl,
> -				       &lp8788_bl_ops, &props);
> +				       &lp8788_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl_dev))
>  		return PTR_ERR(bl_dev);
> =20
> diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backl=
ight/lv5207lp.c
> index 8ab7297b118a..ebd41edcd936 100644
> --- a/drivers/video/backlight/lv5207lp.c
> +++ b/drivers/video/backlight/lv5207lp.c
> @@ -120,7 +120,8 @@ static int lv5207lp_probe(struct i2c_client *clie=
nt,
> =20
>  	backlight =3D devm_backlight_device_register(&client->dev,
>  				dev_name(&client->dev), &lv->client->dev,
> -				lv, &lv5207lp_backlight_ops, &props);
> +				lv, &lv5207lp_backlight_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(backlight)) {
>  		dev_err(&client->dev, "failed to register backlight\n");
>  		return PTR_ERR(backlight);
> diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/bac=
klight/max8925_bl.c
> index 7b738d60ecc2..aa1d39ab9977 100644
> --- a/drivers/video/backlight/max8925_bl.c
> +++ b/drivers/video/backlight/max8925_bl.c
> @@ -165,7 +165,8 @@ static int max8925_backlight_probe(struct platfor=
m_device *pdev)
>  	props.max_brightness =3D MAX_BRIGHTNESS;
>  	bl =3D devm_backlight_device_register(&pdev->dev, "max8925-backligh=
t",
>  					&pdev->dev, data,
> -					&max8925_backlight_ops, &props);
> +					&max8925_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backl=
ight/omap1_bl.c
> index 546d94df21d5..c587a4ec89a2 100644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -148,7 +148,8 @@ static int omapbl_probe(struct platform_device *p=
dev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D OMAPBL_MAX_INTENSITY;
>  	dev =3D devm_backlight_device_register(&pdev->dev, "omap-bl", &pdev=
->dev,
> -					bl, &omapbl_ops, &props);
> +					bl, &omapbl_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
> =20
> diff --git a/drivers/video/backlight/ot200_bl.c b/drivers/video/backl=
ight/ot200_bl.c
> index 3acdb9f646ed..36d71b32b9cd 100644
> --- a/drivers/video/backlight/ot200_bl.c
> +++ b/drivers/video/backlight/ot200_bl.c
> @@ -120,7 +120,8 @@ static int ot200_backlight_probe(struct platform_=
device *pdev)
> =20
>  	bl =3D devm_backlight_device_register(&pdev->dev, dev_name(&pdev->d=
ev),
>  					&pdev->dev, data, &ot200_backlight_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		retval =3D PTR_ERR(bl);
> diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/bac=
klight/pandora_bl.c
> index 5d8bb8b20183..b654543ea895 100644
> --- a/drivers/video/backlight/pandora_bl.c
> +++ b/drivers/video/backlight/pandora_bl.c
> @@ -115,7 +115,8 @@ static int pandora_backlight_probe(struct platfor=
m_device *pdev)
>  	props.max_brightness =3D MAX_USER_VALUE;
>  	props.type =3D BACKLIGHT_RAW;
>  	bl =3D devm_backlight_device_register(&pdev->dev, pdev->name, &pdev=
->dev,
> -					NULL, &pandora_backlight_ops, &props);
> +					NULL, &pandora_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/v=
ideo/backlight/pcf50633-backlight.c
> index 85bd573b6d15..8f3dd6b22088 100644
> --- a/drivers/video/backlight/pcf50633-backlight.c
> +++ b/drivers/video/backlight/pcf50633-backlight.c
> @@ -129,7 +129,8 @@ static int pcf50633_bl_probe(struct platform_devi=
ce *pdev)
> =20
>  	pcf_bl->bl =3D devm_backlight_device_register(&pdev->dev, pdev->nam=
e,
>  						&pdev->dev, pcf_bl,
> -						&pcf50633_bl_ops, &bl_props);
> +						&pcf50633_bl_ops, &bl_props,
> +						BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	if (IS_ERR(pcf_bl->bl))
>  		return PTR_ERR(pcf_bl->bl);
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/ba=
cklight/pm8941-wled.c
> index 0b6d21955d91..85035f2f784f 100644
> --- a/drivers/video/backlight/pm8941-wled.c
> +++ b/drivers/video/backlight/pm8941-wled.c
> @@ -408,7 +408,8 @@ static int pm8941_wled_probe(struct platform_devi=
ce *pdev)
>  	props.max_brightness =3D PM8941_WLED_REG_VAL_MAX;
>  	bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,
> -					    &pm8941_wled_ops, &props);
> +					    &pm8941_wled_ops, &props,
> +					    BACKLIGHT_REGISTER_FB_CLIENT);
>  	return PTR_ERR_OR_ZERO(bl);
>  };
> =20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index b2b366bb0f97..98655fce462c 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -330,7 +330,8 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D data->max_brightness;
>  	bl =3D backlight_device_register(dev_name(&pdev->dev), &pdev->dev, =
pb,
> -				       &pwm_backlight_ops, &props);
> +				       &pwm_backlight_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		ret =3D PTR_ERR(bl);
> diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backli=
ght/s6e63m0.c
> index 3c4a22a3063a..60bc88075e68 100644
> --- a/drivers/video/backlight/s6e63m0.c
> +++ b/drivers/video/backlight/s6e63m0.c
> @@ -748,7 +748,8 @@ static int s6e63m0_probe(struct spi_device *spi)
> =20
>  	bd =3D devm_backlight_device_register(&spi->dev, "s6e63m0bl-bl",
>  					&spi->dev, lcd, &s6e63m0_backlight_ops,
> -					&props);
> +					&props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd))
>  		return PTR_ERR(bd);
> =20
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/v=
ideo/backlight/sky81452-backlight.c
> index d414c7a3acf5..9abdbcf71fef 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -294,7 +294,8 @@ static int sky81452_bl_probe(struct platform_devi=
ce *pdev)
>  	props.max_brightness =3D SKY81452_MAX_BRIGHTNESS,
>  	name =3D pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
>  	bd =3D devm_backlight_device_register(dev, name, dev, regmap,
> -						&sky81452_bl_ops, &props);
> +						&sky81452_bl_ops, &props,
> +						BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		dev_err(dev, "failed to register. err=3D%ld\n", PTR_ERR(bd));
>  		return PTR_ERR(bd);
> diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backli=
ght/tosa_bl.c
> index 83742d806391..755a61727ca1 100644
> --- a/drivers/video/backlight/tosa_bl.c
> +++ b/drivers/video/backlight/tosa_bl.c
> @@ -107,7 +107,8 @@ static int tosa_bl_probe(struct i2c_client *clien=
t,
>  	props.max_brightness =3D 512 - 1;
>  	data->bl =3D devm_backlight_device_register(&client->dev, "tosa-bl"=
,
>  						&client->dev, data, &bl_ops,
> -						&props);
> +						&props,
> +						BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(data->bl)) {
>  		ret =3D PTR_ERR(data->bl);
>  		goto err_reg;
> diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/ba=
cklight/tps65217_bl.c
> index fd524ad860a5..0ac55b9a773c 100644
> --- a/drivers/video/backlight/tps65217_bl.c
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -306,7 +306,8 @@ static int tps65217_bl_probe(struct platform_devi=
ce *pdev)
> =20
>  	tps65217_bl->bl =3D devm_backlight_device_register(&pdev->dev, pdev=
->name,
>  						tps65217_bl->dev, tps65217_bl,
> -						&tps65217_bl_ops, &bl_props);
> +						&tps65217_bl_ops, &bl_props,
> +						BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(tps65217_bl->bl)) {
>  		dev_err(tps65217_bl->dev,
>  			"registration of backlight device failed: %d\n", rc);
> diff --git a/drivers/video/backlight/wm831x_bl.c b/drivers/video/back=
light/wm831x_bl.c
> index 6eab0d6c262a..8b92a277f83b 100644
> --- a/drivers/video/backlight/wm831x_bl.c
> +++ b/drivers/video/backlight/wm831x_bl.c
> @@ -197,7 +197,8 @@ static int wm831x_backlight_probe(struct platform=
_device *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D max_isel;
>  	bl =3D devm_backlight_device_register(&pdev->dev, "wm831x", &pdev->=
dev,
> -					data, &wm831x_backlight_ops, &props);
> +					data, &wm831x_backlight_ops, &props,
> +					BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		return PTR_ERR(bl);
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/=
atmel_lcdfb.c
> index 669ecc755fa9..d6c46d670622 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -244,7 +244,8 @@ static void init_backlight(struct atmel_lcdfb_inf=
o *sinfo)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 0xff;
>  	bl =3D backlight_device_register("backlight", &sinfo->pdev->dev, si=
nfo,
> -				       &atmel_lcdc_bl_ops, &props);
> +				       &atmel_lcdc_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(&sinfo->pdev->dev, "error %ld on backlight register\n",
>  				PTR_ERR(bl));
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev=
/aty/aty128fb.c
> index 0a4626886b00..dae8734870c9 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -1871,7 +1871,8 @@ static void aty128_bl_init(struct aty128fb_par =
*par)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, info->dev, par, &aty128_bl_d=
ata,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		info->bl_dev =3D NULL;
>  		printk(KERN_WARNING "aty128: Backlight registration failed\n");
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbd=
ev/aty/atyfb_base.c
> index f34ed47fcaf8..918ec8f946aa 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -2242,7 +2242,8 @@ static void aty_bl_init(struct atyfb_par *par)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, info->dev, par, &aty_bl_data=
,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		info->bl_dev =3D NULL;
>  		printk(KERN_WARNING "aty: Backlight registration failed\n");
> diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/vid=
eo/fbdev/aty/radeon_backlight.c
> index 301d6d6aeead..a8c9ef618e42 100644
> --- a/drivers/video/fbdev/aty/radeon_backlight.c
> +++ b/drivers/video/fbdev/aty/radeon_backlight.c
> @@ -155,7 +155,8 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo=
)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, rinfo->info->dev, pdata,
> -				       &radeon_bl_data, &props);
> +				       &radeon_bl_data, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		rinfo->info->bl_dev =3D NULL;
>  		printk("radeonfb: Backlight registration failed\n");
> diff --git a/drivers/video/fbdev/bf537-lq035.c b/drivers/video/fbdev/=
bf537-lq035.c
> index ef29fb425122..77b6f98d2182 100644
> --- a/drivers/video/fbdev/bf537-lq035.c
> +++ b/drivers/video/fbdev/bf537-lq035.c
> @@ -765,7 +765,8 @@ static int bfin_lq035_probe(struct platform_devic=
e *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D MAX_BRIGHENESS;
>  	bl_dev =3D backlight_device_register("bf537-bl", NULL, NULL,
> -					   &bfin_lq035fb_bl_ops, &props);
> +					   &bfin_lq035fb_bl_ops, &props,
> +					   BACKLIGHT_REGISTER_FB_CLIENT);
> =20
>  	lcd_dev =3D lcd_device_register(KBUILD_MODNAME, &pdev->dev, NULL,
>  				      &bfin_lcd_ops);
> diff --git a/drivers/video/fbdev/bf54x-lq043fb.c b/drivers/video/fbde=
v/bf54x-lq043fb.c
> index 8f1f97c75619..4001f3c9c40c 100644
> --- a/drivers/video/fbdev/bf54x-lq043fb.c
> +++ b/drivers/video/fbdev/bf54x-lq043fb.c
> @@ -652,7 +652,8 @@ static int bfin_bf54x_probe(struct platform_devic=
e *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 255;
>  	bl_dev =3D backlight_device_register("bf54x-bl", NULL, NULL,
> -					   &bfin_lq043fb_bl_ops, &props);
> +					   &bfin_lq043fb_bl_ops, &props,
> +					   BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl_dev)) {
>  		printk(KERN_ERR DRIVER_NAME
>  			": unable to register backlight.\n");
> diff --git a/drivers/video/fbdev/bfin-t350mcqb-fb.c b/drivers/video/f=
bdev/bfin-t350mcqb-fb.c
> index e5ee4d9677f7..6c1c64f48432 100644
> --- a/drivers/video/fbdev/bfin-t350mcqb-fb.c
> +++ b/drivers/video/fbdev/bfin-t350mcqb-fb.c
> @@ -549,7 +549,8 @@ static int bfin_t350mcqb_probe(struct platform_de=
vice *pdev)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D 255;
>  	bl_dev =3D backlight_device_register("bf52x-bl", NULL, NULL,
> -					   &bfin_lq043fb_bl_ops, &props);
> +					   &bfin_lq043fb_bl_ops, &props,
> +					   BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl_dev)) {
>  		printk(KERN_ERR DRIVER_NAME
>  			": unable to register backlight.\n");
> diff --git a/drivers/video/fbdev/exynos/s6e8ax0.c b/drivers/video/fbd=
ev/exynos/s6e8ax0.c
> index de2f3e793786..a78c6effab97 100644
> --- a/drivers/video/fbdev/exynos/s6e8ax0.c
> +++ b/drivers/video/fbdev/exynos/s6e8ax0.c
> @@ -796,7 +796,8 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_dev=
ice *dsim_dev)
>  	}
> =20
>  	lcd->bd =3D devm_backlight_device_register(lcd->dev, "s6e8ax0-bl",
> -				lcd->dev, lcd, &s6e8ax0_backlight_ops, NULL);
> +				lcd->dev, lcd, &s6e8ax0_backlight_ops, NULL,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(lcd->bd)) {
>  		dev_err(lcd->dev, "failed to register backlight ops.\n");
>  		return PTR_ERR(lcd->bd);
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.=
c
> index f91b1db262b0..c13c365e6622 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -319,7 +319,8 @@ static void mx3fb_init_backlight(struct mx3fb_dat=
a *fbd)
>  	sdc_set_brightness(fbd, fbd->backlight_level);
> =20
>  	bl =3D backlight_device_register("mx3fb-bl", fbd->dev, fbd,
> -				       &mx3fb_lcdc_bl_ops, &props);
> +				       &mx3fb_lcdc_bl_ops, &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(fbd->dev, "error %ld on backlight register\n",
>  				PTR_ERR(bl));
> diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/vide=
o/fbdev/nvidia/nv_backlight.c
> index 5c151b2ea683..fdb91547b02f 100644
> --- a/drivers/video/fbdev/nvidia/nv_backlight.c
> +++ b/drivers/video/fbdev/nvidia/nv_backlight.c
> @@ -108,7 +108,8 @@ void nvidia_bl_init(struct nvidia_par *par)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, info->dev, par, &nvidia_bl_o=
ps,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		info->bl_dev =3D NULL;
>  		printk(KERN_WARNING "nvidia: Backlight registration failed\n");
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c=
 b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> index b58012b82b6f..2c5fccf81391 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> @@ -1259,7 +1259,8 @@ static int dsicm_probe(struct platform_device *=
pdev)
> =20
>  		props.type =3D BACKLIGHT_RAW;
>  		bldev =3D backlight_device_register(dev_name(dev),
> -				dev, ddata, &dsicm_bl_ops, &props);
> +				dev, ddata, &dsicm_bl_ops, &props,
> +				BACKLIGHT_REGISTER_FB_CLIENT);
>  		if (IS_ERR(bldev)) {
>  			r =3D PTR_ERR(bldev);
>  			goto err_bl;
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx=
565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565a=
km.c
> index 468560a6daae..8d7821e8bb0a 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.=
c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.=
c
> @@ -816,7 +816,8 @@ static int acx565akm_probe(struct spi_device *spi=
)
>  	props.type =3D BACKLIGHT_RAW;
> =20
>  	bldev =3D backlight_device_register("acx565akm", &ddata->spi->dev,
> -			ddata, &acx565akm_bl_ops, &props);
> +			ddata, &acx565akm_bl_ops, &props,
> +			BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bldev)) {
>  		r =3D PTR_ERR(bldev);
>  		goto err_reg_bl;
> diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/r=
iva/fbdev.c
> index 2ef26ad99341..6dc05da50609 100644
> --- a/drivers/video/fbdev/riva/fbdev.c
> +++ b/drivers/video/fbdev/riva/fbdev.c
> @@ -343,7 +343,8 @@ static void riva_bl_init(struct riva_par *par)
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D FB_BACKLIGHT_LEVELS - 1;
>  	bd =3D backlight_device_register(name, info->dev, par, &riva_bl_ops=
,
> -				       &props);
> +				       &props,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bd)) {
>  		info->bl_dev =3D NULL;
>  		printk(KERN_WARNING "riva: Backlight registration failed\n");
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/f=
bdev/sh_mobile_lcdcfb.c
> index 82c0a8caa9b8..2000ed98b380 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -2314,7 +2314,8 @@ static struct backlight_device *sh_mobile_lcdc_=
bl_probe(struct device *parent,
>  	struct backlight_device *bl;
> =20
>  	bl =3D backlight_device_register(ch->cfg->bl_info.name, parent, ch,
> -				       &sh_mobile_lcdc_bl_ops, NULL);
> +				       &sh_mobile_lcdc_bl_ops, NULL,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		dev_err(parent, "unable to register backlight device: %ld\n",
>  			PTR_ERR(bl));
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ss=
d1307fb.c
> index a9c45c89b15e..a8a7ba4acde6 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -673,7 +673,8 @@ static int ssd1307fb_probe(struct i2c_client *cli=
ent,
> =20
>  	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
>  	bl =3D backlight_device_register(bl_name, &client->dev, par,
> -				       &ssd1307fb_bl_ops, NULL);
> +				       &ssd1307fb_bl_ops, NULL,
> +				       BACKLIGHT_REGISTER_FB_CLIENT);
>  	if (IS_ERR(bl)) {
>  		ret =3D PTR_ERR(bl);
>  		dev_err(&client->dev, "unable to register backlight device: %d\n",
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 5f2fd61ef4fb..79af3ccabeca 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -129,13 +129,16 @@ static inline int backlight_update_status(struc=
t backlight_device *bd)
>  	return ret;
>  }
> =20
> +#define BACKLIGHT_REGISTER_FB_CLIENT 0x1
>  extern struct backlight_device *backlight_device_register(const char=
 *name,
>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
> -	const struct backlight_properties *props);
> +	const struct backlight_properties *props,
> +	unsigned long flags);
>  extern struct backlight_device *devm_backlight_device_register(
>  	struct device *dev, const char *name, struct device *parent,
>  	void *devdata, const struct backlight_ops *ops,
> -	const struct backlight_properties *props);
> +	const struct backlight_properties *props,
> +	unsigned long flags);
>  extern void backlight_device_unregister(struct backlight_device *bd)=
;
>  extern void devm_backlight_device_unregister(struct device *dev,
>  					struct backlight_device *bd);
> --=20
> 2.8.1
>=20
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
