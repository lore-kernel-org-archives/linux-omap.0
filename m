From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [rtc-linux] [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off
 to rtc driver
Date: Wed, 28 Nov 2012 11:12:26 +0000
Message-ID: <20121128111226.GX3332@n2100.arm.linux.org.uk>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-2-git-send-email-anilkumar@ti.com>
 <20121127154239.0efad6d5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121127154239.0efad6d5.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 27, 2012 at 03:42:39PM -0800, Andrew Morton wrote:
> > +	/* Do not allow to execute any other task */
> > +	spin_lock_irqsave(&lock, flags);
> > +	while (1);
> 
> I suspect this doesn't do what you want it to do.
> 
> Firstly, please provide adequate code comments here so that code
> readers do not also need to be mind readers.
> 
> If you want to stop this CPU dead in its tracks (why?) then
> 
> 	local_irq_disable();
> 	while (1)
> 		;		/* Note correct code layout */
> 
> will do it.  But it means that the NMI watchdog (if present) will come
> along and whack the machine in the head a few seconds later.  And this
> does nothing to stop other CPUs.
> 
> But not being a mind reader, I'm really at a loss to suggest what
> should be done here.  

It's hooking into the pm_power_off hook, which is called from kernel/sys.c
via arch code.  We will have already stopped all other CPUs at this point.

Why there's that while (1) there I don't know; when pm_power_off is not
hooked, we don't do anything like that - and what will happen in that
case is we'll return all the way back to sys_reboot(), which will call
do_exit(0) on us.

I don't see a problem with that, and I don't see why we need to spin
(without any power saving too) waiting for some event.  If we've called
sys_reboot with LINUX_REBOOT_CMD_POWER_OFF, we'd better have already
killed most of userspace off by that time anyway.
