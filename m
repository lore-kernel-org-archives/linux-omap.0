From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1
 during boot
Date: Thu, 16 Feb 2017 08:10:10 -0800
Message-ID: <20170216161010.GU21809@atomide.com>
References: <20170213215013.19929-1-tony@atomide.com>
 <20170214193645.GM21809@atomide.com>
 <20170215183915.GU3897@atomide.com>
 <20170215191242.GP21809@atomide.com>
 <ca389104-df6f-b055-ec43-524d82cf1be7@ti.com>
 <20170215222711.GQ21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170215222711.GQ21809@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [170215 14:28]:
> * Andrew F. Davis <afd@ti.com> [170215 14:14]:
> > On 02/15/2017 01:12 PM, Tony Lindgren wrote:
> > > And also the same issue happens doing kexec on beagle-x15 naturally if
> > > the cpu1 reset is removed.
> > > 
> > 
> > When a core actually powers up it idles in ROM code waiting for
> > OMAP_AUX_CORE_BOOT_0 to be set. When we shutdown a core it is not really
> > powered off, we just let it spin in omap4_cpu_die() or
> > omap4_secondary_startup() waiting on OMAP_AUX_CORE_BOOT_0, just like if
> > it were still trapped in ROM after a reset.

OK so I debugged this a bit more. We have CPU1 in omap_do_wfi()
as we don't currently have omap5_secondary_startup() or any deeper
idle mode support beyond retention for omap5 or dra7 in the mainline
kernel.

> > The issue with this fake startup idle loop is that, unlike the ROM based
> > startup idle loop, these do *not* jump to the address we stored in
> > OMAP_AUX_CORE_BOOT_1, they just make the assumption that they can safely
> > jump to the kernel startup function.

This does not seem to be the case here.

> > So when we tell this core to boot, and it is not in the real ROM startup
> > loop, it breaks stuff as it jumps to the old kernel's
> > secondary_startup() even though we gave it the correct address in
> > OMAP_AUX_CORE_BOOT_1.

And this is not happening. I think this is what I was seeing earlier,
but it's not the omap5/dra7 issue.

What we have is cpu1 returning from previous kernel's omap_do_wfi()
in the kexec booted kernel's code and that's when things go wrong.

So if cpu1 was configured for idle for any reason, it will never gets
to omap5_secondary_startup without the reset currently.

The reason kexec and suspend/resume mostly works for omap4 without
cpu1 reset is that we usually enter off mode for cpu1 and the context
is lost and then we properly go through omap4_secondary_startup. Or
that's my theory so far for the occasional flakeyness I've been seeing :)

Any ideas what we should try to check to see if cpu1 is in idle
mode so we can do the reset if needed?

Regards,

Tony
