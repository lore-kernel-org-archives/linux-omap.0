From: Dimitar Dimitrov <dinuxbg@gmail.com>
Subject: Re: [RFC PATCH] OMAPDSS: DISPC: Fix IRQ unregister race
Date: Fri, 7 Sep 2012 17:42:11 +0300
Message-ID: <201209071742.11735.dinuxbg@gmail.com>
References: <1346613123-24053-1-git-send-email-dinuxbg@gmail.com> <1346938614.2737.68.camel@deskari>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43424 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab2IGOnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 10:43:16 -0400
In-Reply-To: <1346938614.2737.68.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Thursday 06 September 2012 16:36:54 Tomi Valkeinen wrote:
> Hi,
> 
> On Sun, 2012-09-02 at 22:12 +0300, Dimitar Dimitrov wrote:
> > Very rare kernel crashes are reported on a custom OMAP4 board. Kernel
> > panics due to corrupted completion structure while executing
> > 
> > dispc_irq_wait_handler(). Excerpt from kernel log:
> >   Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
> >   Unable to handle kernel paging request at virtual address 00400130
> >   ...
> >   PC is at 0xebf205bc
> >   LR is at __wake_up_common+0x54/0x94
> >   ...
> >   (__wake_up_common+0x0/0x94)
> >   (complete+0x0/0x60)
> >   (dispc_irq_wait_handler.36902+0x0/0x14)
> >   (omap_dispc_irq_handler+0x0/0x354)
> >   (handle_irq_event_percpu+0x0/0x188)
> >   (handle_irq_event+0x0/0x64)
> >   (handle_fasteoi_irq+0x0/0x10c)
> >   (generic_handle_irq+0x0/0x48)
> >   (asm_do_IRQ+0x0/0xc0)
> > 
> > DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
> > unregister_isr() and DISPC IRQ might be running in parallel on different
> > CPUs. So there is a chance that a callback is executed even though it
> > has been unregistered. As omap_dispc_wait_for_irq_timeout() declares a
> > completion on stack, the dispc_irq_wait_handler() callback might try to
> > access a completion structure that is invalid. This leads to crashes and
> > hangs.
> > 
> > Solution is to divide unregister calls into two sets:
> >   1. Non-strict unregistering of callbacks. Callbacks could safely be
> >   
> >      executed after unregistering them. This is the case with unregister
> >      calls from the IRQ handler itself.
> >   
> >   2. Strict (synchronized) unregistering. Callbacks are not allowed
> >   
> >      after unregistering. This is the case with completion waiting.
> > 
> > The above solution should satisfy one of the original intentions of the
> > driver: callbacks should be able to unregister themselves.
> 
> I think it'd be better to create a new function for the nosync version,
> and keep the old name for the sync version. The reason for this is to
> minimize the amount of changes, as I think this one needs to be applied
> to stable kernel trees also.
My intention was to force all callers to pick sides. In case of rebase issues 
we get link errors instead of rare and subtle run-time races. Still, if you 
think we should leave the old name untouched then I'll change my 
patch.

> 
> Also, I think we need similar one for dsi.c, as it has the same kind of
> irq handling. But with a quick glance only sync version is needed there.
Thanks, I missed that. I'll try to fix and send again.

> 
> However, I'm not quite sure about this approach. The fix makes sense,
> but it makes me think if the irq handling is designed the wrong way.
> 
> While debugging and fixing this, did you think some other irq handling
> approach would be saner?
I tried but could not come up with better approach. The main difficulty is 
that there are two contradicting requirements:
 1. Some callbacks unregister other callbacks, including themselves, from 
DISPC IRQ context.
 2. Some functions expect that once a callback is unregistered it is never 
executed.

Hence it is natural to split callers into two sets. I'm open for suggestions.
> 
>  Tomi

Thanks,
Dimitar
