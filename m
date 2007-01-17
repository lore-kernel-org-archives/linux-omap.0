From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: Re: [PATCH] MUSB HDRC: RMMOD fixing
Date: Wed, 17 Jan 2007 16:28:03 -0400
Message-ID: <1169065683.14795.12.camel@balbi>
References: <1169062794.14795.1.camel@balbi>
	<200701171157.26218.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200701171157.26218.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Dave,

Of course I still have a few patches to scrub out from my queue too;
> but this isn't one of them.
> 
> - Dave

If you check the source code itself, you'll see musb_writeb
duplicated...

could you clarify why we need that?

Here's the code I'm talking about:

static void musb_free(struct musb *musb)
{
	/* this has multiple entry modes. it handles fault cleanup after
	 * probe(), where things may be partially set up, as well as rmmod
	 * cleanup after everything's been de-activated.
	 */

#ifdef CONFIG_SYSFS
	device_remove_file(musb->controller, &dev_attr_mode);
	device_remove_file(musb->controller, &dev_attr_cable);
#endif

#ifdef CONFIG_USB_GADGET_MUSB_HDRC
	musb_gadget_cleanup(musb);
#endif

	if (musb->nIrq >= 0) {
		disable_irq_wake(musb->nIrq);
		free_irq(musb->nIrq, musb);
	}
	if (is_dma_capable() && musb->pDmaController) {
		struct dma_controller	*c = musb->pDmaController;

		(void) c->stop(c->pPrivateData);
		dma_controller_factory.destroy(c);
	}

	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
	musb_platform_exit(musb);
	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);

	if (musb->clock) {
		clk_disable(musb->clock);
		clk_put(musb->clock);
	}

#ifdef CONFIG_USB_MUSB_HDRC_HCD
	usb_put_hcd(musb_to_hcd(musb));
#else
	kfree(musb);
#endif
}




-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 8127 0839
