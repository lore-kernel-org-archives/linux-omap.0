From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 08:08:43 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CE5123.9050702@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ivaylo Dimitrov
> Sent: Thursday, January 09, 2014 1:05 PM
> To: Hiremath, Vaibhav; Valkeinen, Tomi; Tony Lindgren; Ivaylo Dimitrov
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> fbdev@vger.kernel.org
> Subject: Re: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> 
> 
> On 09.01.2014 07:06, Hiremath, Vaibhav wrote:
> > Tomi,
> >
> > I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
> > Did you see this on OMAP?
> >
> > I am using "omapfb_vram=10M@0xA0000000", and I believe it is correct way
> of usage.
> >
> > Thanks,
> > Vaibhav
> >
> 
> AFAIK underflow interrupts could come from badly calculated DSS core clock or
> bad HW resizer setup and should be unrelated to the memory allocation. It
> might be something similar to the problem I have on N900
> - see https://lkml.org/lkml/2014/1/6/173
> 

I can see the difference when I really "omapfb_vram" command line argument.

Without omapfb_vram in bootargs 
-------------------------------------------
bootargs=console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait mem=128M 
consoleblank=0 clocksource=gp_timer consoleblank=0 earlyprintk omapfb.debug=y omapdss.debug=y

I do not get UNDERFLOW during boot.

With omapfb_vram in the bootargs
---------------------------------------------
bootargs=console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait mem=128M 
consoleblank=0 clocksource=gp_timer consoleblank=0 earlyprintk omapfb_vram=10M@0xA0000000 
omapfb.debug=y omapdss.debug=y

I always get UNDERFLOW during boot itself.

> Is it possible to upload the video you have problems with, so me to test it on
> N900? So far I didn't see any underflow issues on it (N900 is OMAP3, in case
> you're not aware), no matter the resolution of the videos I played(up to 720p),
> however I didn't test the part that allocates the memory on a pre-defined
> address. Though I don't think that should matter.

No, that's what is causing issue to me. Can you try predefined address flow?
Just to highlight, I get UNDERFLOW during boot itself, immediately when it gets mapped to userspace.

Boot LOG:

[    1.443021] OMAPFB: omapfb_probe
[    1.446137] OMAPFB: create 3 framebuffers
[    1.446178] OMAPFB: fb_infos allocated
[    1.446198] OMAPFB: allocating 1536000 bytes for fb 0
[    1.451044] OMAPFB: allocated VRAM paddr a0000000, vaddr ca000000
[    1.451069] OMAPFB: region0 phys a0000000 virt ca000000 size=1536000
[    1.451086] OMAPFB: region1 phys 00000000 virt   (null) size=0
[    1.451100] OMAPFB: region2 phys 00000000 virt   (null) size=0
[    1.451109] OMAPFB: fbmems allocated
[    1.451363] OMAPFB: check_fb_var 0
[    1.451386] OMAPFB: max frame size 1536000, line size 3200
[    1.451401] OMAPFB: xres = 800, yres = 480, vxres = 800, vyres = 480
[    1.451414] OMAPFB: set_fb_fix
[    1.460278] OMAPFB: fb_infos initialized
[    1.465325] OMAPFB: set_par(0)
[    1.465384] OMAPFB: set_fb_fix
[    1.465393] OMAPFB: apply_changes, fb 0, ovl 0
[    1.465443] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 800, outh 480
[    1.465450] OMAPFB: paddr a0000000
[    1.465592] OMAPFB: pan_display(0)
[    1.465600] OMAPFB: setcmap
[    1.465607] OMAPFB: setcmap
[    1.474504] Console: switching to colour frame buffer device 100x30
[    1.474528] OMAPFB: pan_display(0)
[    1.474534] OMAPFB: setcmap
[    1.482185] OMAPFB: setcmap
[    1.484808] OMAPFB: framebuffers registered
[    1.484839] OMAPFB: apply_changes, fb 0, ovl 0
[    1.484857] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 800, outh 480
[    1.484870] OMAPFB: paddr a0000000
[    1.484919] OMAPFB: apply_changes, fb 1, ovl 1
[    1.485010] OMAPFB: apply_changes, fb 2, ovl 2
[    1.485111] OMAPFB: create_framebuffers done
[    1.485128] OMAPFB: mgr->apply'ed
[    1.489793] OMAPFB: create sysfs for fbs
[    1.489816] OMAPFB: create sysfs for fbs

....

[    4.822549] Freeing unused kernel memory: 440K (c0919000 - c0987000)
[    5.276615] OMAPFB: pan_display(0)
[    5.276625] OMAPFB: setcmap
[    5.276635] OMAPFB: setcmap
[    5.293518] OMAPFB: user mmap region start a0000000, len 1536000, off 0
[    5.300171] omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay

...

[   20.499076] OMAPFB: pan_display(0)
[   20.499085] OMAPFB: setcmap
[   20.499093] OMAPFB: setcmap
[   20.544419] OMAPFB: check_var(0)
[   20.544631] OMAPFB: check_fb_var 0
[   20.544644] OMAPFB: max frame size 1536000, line size 3200
[   20.544651] OMAPFB: xres = 800, yres = 480, vxres = 800, vyres = 480
[   20.544699] OMAPFB: set_par(0)
[   20.544706] OMAPFB: set_fb_fix
[   20.544712] OMAPFB: apply_changes, fb 0, ovl 0
[   20.544762] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 800, outh 480
[   20.544767] OMAPFB: paddr a0000000
[   20.544798] OMAPFB: pan_display(0)
[   20.544802] OMAPFB: setcmap
[   20.544859] OMAPFB: pan_display(0)
[   20.544865] OMAPFB: setcmap
[   20.544872] OMAPFB: setcmap
[   20.553841] OMAPFB: setcmap
[   23.002160] OMAPFB: user mmap region start a0000000, len 1536000, off 0

Thanks,
Vaibhav
