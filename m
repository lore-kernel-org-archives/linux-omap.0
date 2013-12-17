From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/7] usb: dwc3: pm_runtime implementation
Date: Tue, 17 Dec 2013 15:31:40 -0800
Message-ID: <20131217233140.GA21267@psi-dev26.jf.intel.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386884325-11440-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w-kwok2-l0cyMroinI0@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 12, 2013 at 03:38:38PM -0600, Felipe Balbi wrote:
> hi all,
> 
> these patches add pm_runtime support for all glue layers.
> 
> I plan to add pm_runtime support for dwc3 after these
> patches are merged upstream.
> 
> Please test.

At first time I failed to notice you were removing #ifdef's around pm
callback functions. Instead of saying DWC3 will start to have warnings
when CONFIG_PM is not selected, I'd say your patch set is now a
dependence of my RFC :)
https://lkml.org/lkml/2013/12/13/4

Br, David Cohen

> 
> Felipe Balbi (7):
>   usb: dwc3: keystone: add basic PM support
>   usb: dwc3: omap: add basic pm_runtime support
>   usb: dwc3: pci: add pm_runtime support
>   usb: dwc3: omap: fix pm_runtime usage
>   usb: dwc3: omap: fix order of pm_runtime vs child removal
>   usb: dwc3: exynos: remove DEV_PM_OPS hackery
>   usb: dwc3: exynos: add pm_runtime support
> 
>  drivers/usb/dwc3/dwc3-exynos.c   | 73 +++++++++++++++++++++++-------
>  drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/dwc3/dwc3-omap.c     | 45 +++++++++++++++----
>  drivers/usb/dwc3/dwc3-pci.c      | 66 ++++++++++++++++++++-------
>  4 files changed, 239 insertions(+), 42 deletions(-)
> 
> -- 
> 1.8.4.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
