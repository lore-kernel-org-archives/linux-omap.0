From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Wed, 15 Feb 2017 14:27:11 -0800
Message-ID: <20170215222711.GQ21809@atomide.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com>
 <20170215183915.GU3897@atomide.com>
 <20170215191242.GP21809@atomide.com>
 <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170215 14:14]:
> On 02/15/2017 01:12 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [170215 10:40]:
> >> * Tony Lindgren <tony@atomide.com> [170214 11:39]:
> >>> * Tony Lindgren <tony@atomide.com> [170213 13:51]:
> >>>> Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
> >>>> resetting cpu1 because of a kexec boot issue I was seeing earlier in 2016
> >>>> on omap4 when doing kexec boot between two different kernel versions. The
> >>>> booted kernel ended up trying to use the old kernel start-up address unless
> >>>> cpu1 was reset before configuring the cpu1 start-up address.
> >>>>
> >>>> It seems the reset part was not correct but probably working around some
> >>>> other issue. I have not been able to reproduce this issue any longer despite
> >>>> testing with backported patches back to v4.6 kernel. So it is possible this
> >>>> issue was caused by other work in progress kexec patches I had applied. Or
> >>>> it is possible some other fixes have made the issue go way.
> >>>>
> >>>> The unconditional reset of cpu1 can cause issues booting some devices. For
> >>>> example, bootloader configured secure OS running on cpu1 will fail as the
> >>>> configuration is not preserved as reported by Andrew F. Davis <afd@ti.com>.
> >>>>
> >>>> Let's fix the issue by reverting the cpu1 reset parts. If it turns out we
> >>>> still need to reset cpu1 in some cases, we can add it back and do it
> >>>> conditionally.
> >>>
> >>> Actually with this I'm now seeing cpu1 not come up after a suspend/resume
> >>> cycle on duovero:
> >>>
> >>> [  118.257415] CPU1: shutdown
> >>> [  118.294616] Error taking CPU1 up: -2
> >>> [  118.299072] PM: noirq resume of devices complete after 3.723 msecs
> >>> [  118.303802] PM: early resume of devices complete after 3.723 msecs
> >>>
> >>> So this issue needs to be investigated more.
> >>
> >> And then today the omap4 suspend/resume issue is no longer reproducable..
> >> Go figure.
> >>
> >> But then doing more testing I noticed that also omap5 needs the reset.
> >> Without it we get the following on omap5-uevm doing a kexec boot. So clearly
> >> the reset cannot be just removed at least for omap4 and omap5.
> > 
> > And also the same issue happens doing kexec on beagle-x15 naturally if
> > the cpu1 reset is removed.
> > 
> 
> When a core actually powers up it idles in ROM code waiting for
> OMAP_AUX_CORE_BOOT_0 to be set. When we shutdown a core it is not really
> powered off, we just let it spin in omap4_cpu_die() or
> omap4_secondary_startup() waiting on OMAP_AUX_CORE_BOOT_0, just like if
> it were still trapped in ROM after a reset.
> 
> The issue with this fake startup idle loop is that, unlike the ROM based
> startup idle loop, these do *not* jump to the address we stored in
> OMAP_AUX_CORE_BOOT_1, they just make the assumption that they can safely
> jump to the kernel startup function.
> 
> So when we tell this core to boot, and it is not in the real ROM startup
> loop, it breaks stuff as it jumps to the old kernel's
> secondary_startup() even though we gave it the correct address in
> OMAP_AUX_CORE_BOOT_1.

Yes this is probably what's going on here. Note that the error I pasted
was booting the same kernel where that address should be correct though.
So there might be something else to it also.

> Reseting the core to put it back in the real ROM idle loop is wrong, the
> two idle loop functions above should be fixed to respect the address in
> OMAP_AUX_CORE_BOOT_1 and not to make assumptions, this should take care
> of the kexec failure in a sane way.

OK care to try to patch it as now you also have a reproducable test
case for kexec too?

Regards,

Tony
