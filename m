From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Mon, 17 Jul 2017 03:17:10 -0700
Message-ID: <20170717101709.GI10026@atomide.com>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717101258.llyly7kwfnwtoftr@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170717 03:13]:
> Hi,
> 
> On Mon, Jul 17, 2017 at 02:29:04AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:19]:
> > >  * Switch from simple-audio-card to audio-graph-card
> > 
> > Gave this a quick try against v4.13-rc1 with SND_AUDIO_GRAPH_CARD
> > enabled as a loadable module. However loading it oopses for me,
> > see below. Maybe some dependencies are missing?
> 
> It works for me on top of v4.13-rc1 (my kernel is monolithic).
> Looking at the stacktrace it seems to be a bug in audio graph
> card and not in the codec driver.

OK I do also have:

CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

Tony

> > 8< --------------------
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747
> > in_atomic(): 1, irqs_disabled(): 128, pid: 1590, name: modprobe
> > INFO: lockdep is turned off.
> > irq event stamp: 0
> > hardirqs last  enabled at (0): [<  (null)>]   (null)
> > hardirqs last disabled at (0): [<c0137464>] copy_process.part.5+0x2c4/0x1ac8
> > softirqs last  enabled at (0): [<c0137464>] copy_process.part.5+0x2c4/0x1ac8
> > softirqs last disabled at (0): [<  (null)>]   (null)
> > CPU: 0 PID: 1590 Comm: modprobe Tainted: G        W       4.13.0-rc1+ #126
> > Hardware name: Generic OMAP4 (Flattened Device Tree)
> > [<c0111524>] (unwind_backtrace) from [<c010d1fc>] (show_stack+0x10/0x14)
> > [<c010d1fc>] (show_stack) from [<c086375c>] (dump_stack+0xac/0xe0)
> > [<c086375c>] (dump_stack) from [<c0168c2c>] (___might_sleep+0x228/0x2ac)
> > [<c0168c2c>] (___might_sleep) from [<c087a86c>] (__mutex_lock+0x28/0x9fc)
> > [<c087a86c>] (__mutex_lock) from [<c087b25c>] (mutex_lock_nested+0x1c/0x24)
> > [<c087b25c>] (mutex_lock_nested) from [<c03532fc>] (kernfs_remove+0x18/0x30)
> > [<c03532fc>] (kernfs_remove) from [<c0867abc>] (kobject_del+0x14/0x44)
> > [<c0867abc>] (kobject_del) from [<c0867948>] (kobject_put+0x114/0x224)
> > [<c0867948>] (kobject_put) from [<c06c8e74>] (of_get_next_parent+0x2c/0x4c)
> > [<c06c8e74>] (of_get_next_parent) from [<c06ccd24>] (of_graph_get_port_parent+0x10/0x70)
> > [<c06ccd24>] (of_graph_get_port_parent) from [<bf4685e8>] (asoc_simple_card_parse_graph_dai+0x98/0xe0 [snd_soc_simple_card_utils])
> > [<bf4685e8>] (asoc_simple_card_parse_graph_dai [snd_soc_simple_card_utils]) from [<bf8e5330>] (asoc_graph_card_probe+0x200/0x444 [snd_soc_audio_graph_card])
> > [<bf8e5330>] (asoc_graph_card_probe [snd_soc_audio_graph_card]) from [<c05aa2b8>] (platform_drv_probe+0x50/0xb0)
> > [<c05aa2b8>] (platform_drv_probe) from [<c05a8088>] (driver_probe_device+0x33c/0x478)
> > [<c05a8088>] (driver_probe_device) from [<c05a82ac>] (__driver_attach+0xe8/0x110)
> > [<c05a82ac>] (__driver_attach) from [<c05a61c8>] (bus_for_each_dev+0x6c/0xa0)
> > [<c05a61c8>] (bus_for_each_dev) from [<c05a7354>] (bus_add_driver+0x198/0x270)
> > [<c05a7354>] (bus_add_driver) from [<c05a92c8>] (driver_register+0x78/0xf4)
> > [<c05a92c8>] (driver_register) from [<c010189c>] (do_one_initcall+0x3c/0x170)
> > [<c010189c>] (do_one_initcall) from [<c01edc24>] (do_init_module+0x5c/0x1e0)
> > [<c01edc24>] (do_init_module) from [<c01ec904>] (load_module+0x1270/0x14ec)
> > [<c01ec904>] (load_module) from [<c01ece08>] (SyS_finit_module+0xa8/0xec)
> > [<c01ece08>] (SyS_finit_module) from [<c0108440>] (ret_fast_syscall+0x0/0x1c)
> > OF: ERROR: Bad of_node_put() on /ocp/spi@48098000/pmic@0/audio-codec/port@0/endpoint
