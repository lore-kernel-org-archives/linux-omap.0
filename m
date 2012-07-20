From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH RESEND] OMAP: USB : Fix the EHCI enumeration and core
 retention issue
Date: Fri, 20 Jul 2012 15:15:16 +0530
Message-ID: <CAP05o4+vTA9xR67mZpWk2HZH9YwUSzv-F3AEXnYS4+KyAakNUQ@mail.gmail.com>
References: <1342777415-25888-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44321 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753225Ab2GTJpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 05:45:19 -0400
Received: by lboj14 with SMTP id j14so4184843lbo.7
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 02:45:16 -0700 (PDT)
In-Reply-To: <1342777415-25888-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Russ Dill <russ.dill@gmail.com>, gregkh@linuxfoundation.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com

On Fri, Jul 20, 2012 at 3:13 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
> the usb hub and device detection fails in beagle XM
> causeing NFS not functional. This affects the core retention too.
> The same commit logic needs to be revisted adhering to hwmod and
> device tree framework.
> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>
> This patch is validated on BeagleXM with NFS support over
> usb ethernet and USB mass storage and other device detection.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |  167 +-----------------------------------------
>  1 file changed, 1 insertion(+), 166 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index ec21f4a..3ee5ed3 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -56,15 +56,6 @@
>  #define        EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT             8
>  #define        EHCI_INSNREG05_ULPI_WRDATA_SHIFT                0
>
> -/* Errata i693 */
> -static struct clk      *utmi_p1_fck;
> -static struct clk      *utmi_p2_fck;
> -static struct clk      *xclk60mhsp1_ck;
> -static struct clk      *xclk60mhsp2_ck;
> -static struct clk      *usbhost_p1_fck;
> -static struct clk      *usbhost_p2_fck;
> -static struct clk      *init_60m_fclk;
> -
>  /*-------------------------------------------------------------------------*/
>
>  static const struct hc_driver ehci_omap_hc_driver;
> @@ -80,40 +71,6 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
>         return __raw_readl(base + reg);
>  }
>
> -/* Erratum i693 workaround sequence */
> -static void omap_ehci_erratum_i693(struct ehci_hcd *ehci)
> -{
> -       int ret = 0;
> -
> -       /* Switch to the internal 60 MHz clock */
> -       ret = clk_set_parent(utmi_p1_fck, init_60m_fclk);
> -       if (ret != 0)
> -               ehci_err(ehci, "init_60m_fclk set parent"
> -                       "failed error:%d\n", ret);
> -
> -       ret = clk_set_parent(utmi_p2_fck, init_60m_fclk);
> -       if (ret != 0)
> -               ehci_err(ehci, "init_60m_fclk set parent"
> -                       "failed error:%d\n", ret);
> -
> -       clk_enable(usbhost_p1_fck);
> -       clk_enable(usbhost_p2_fck);
> -
> -       /* Wait 1ms and switch back to the external clock */
> -       mdelay(1);
> -       ret = clk_set_parent(utmi_p1_fck, xclk60mhsp1_ck);
> -       if (ret != 0)
> -               ehci_err(ehci, "xclk60mhsp1_ck set parent"
> -                       "failed error:%d\n", ret);
> -
> -       ret = clk_set_parent(utmi_p2_fck, xclk60mhsp2_ck);
> -       if (ret != 0)
> -               ehci_err(ehci, "xclk60mhsp2_ck set parent"
> -                       "failed error:%d\n", ret);
> -
> -       clk_disable(usbhost_p1_fck);
> -       clk_disable(usbhost_p2_fck);
> -}
>
>  static void omap_ehci_soft_phy_reset(struct usb_hcd *hcd, u8 port)
>  {
> @@ -195,50 +152,6 @@ static int omap_ehci_init(struct usb_hcd *hcd)
>         return rc;
>  }
>
> -static int omap_ehci_hub_control(
> -       struct usb_hcd  *hcd,
> -       u16             typeReq,
> -       u16             wValue,
> -       u16             wIndex,
> -       char            *buf,
> -       u16             wLength
> -)
> -{
> -       struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -       u32 __iomem *status_reg = &ehci->regs->port_status[
> -                               (wIndex & 0xff) - 1];
> -       u32             temp;
> -       unsigned long   flags;
> -       int             retval = 0;
> -
> -       spin_lock_irqsave(&ehci->lock, flags);
> -
> -       if (typeReq == SetPortFeature && wValue == USB_PORT_FEAT_SUSPEND) {
> -               temp = ehci_readl(ehci, status_reg);
> -               if ((temp & PORT_PE) == 0 || (temp & PORT_RESET) != 0) {
> -                       retval = -EPIPE;
> -                       goto done;
> -               }
> -
> -               temp &= ~PORT_WKCONN_E;
> -               temp |= PORT_WKDISC_E | PORT_WKOC_E;
> -               ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
> -
> -               omap_ehci_erratum_i693(ehci);
> -
> -               set_bit((wIndex & 0xff) - 1, &ehci->suspended_ports);
> -               goto done;
> -       }
> -
> -       spin_unlock_irqrestore(&ehci->lock, flags);
> -
> -       /* Handle the hub control events here */
> -       return ehci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
> -done:
> -       spin_unlock_irqrestore(&ehci->lock, flags);
> -       return retval;
> -}
> -
>  static void disable_put_regulator(
>                 struct ehci_hcd_omap_platform_data *pdata)
>  {
> @@ -351,79 +264,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>                 goto err_pm_runtime;
>         }
>
> -       /* get clocks */
> -       utmi_p1_fck = clk_get(dev, "utmi_p1_gfclk");
> -       if (IS_ERR(utmi_p1_fck)) {
> -               ret = PTR_ERR(utmi_p1_fck);
> -               dev_err(dev, "utmi_p1_gfclk failed error:%d\n", ret);
> -               goto err_add_hcd;
> -       }
> -
> -       xclk60mhsp1_ck = clk_get(dev, "xclk60mhsp1_ck");
> -       if (IS_ERR(xclk60mhsp1_ck)) {
> -               ret = PTR_ERR(xclk60mhsp1_ck);
> -               dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
> -               goto err_utmi_p1_fck;
> -       }
> -
> -       utmi_p2_fck = clk_get(dev, "utmi_p2_gfclk");
> -       if (IS_ERR(utmi_p2_fck)) {
> -               ret = PTR_ERR(utmi_p2_fck);
> -               dev_err(dev, "utmi_p2_gfclk failed error:%d\n", ret);
> -               goto err_xclk60mhsp1_ck;
> -       }
> -
> -       xclk60mhsp2_ck = clk_get(dev, "xclk60mhsp2_ck");
> -       if (IS_ERR(xclk60mhsp2_ck)) {
> -               ret = PTR_ERR(xclk60mhsp2_ck);
> -               dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
> -               goto err_utmi_p2_fck;
> -       }
> -
> -       usbhost_p1_fck = clk_get(dev, "usb_host_hs_utmi_p1_clk");
> -       if (IS_ERR(usbhost_p1_fck)) {
> -               ret = PTR_ERR(usbhost_p1_fck);
> -               dev_err(dev, "usbhost_p1_fck failed error:%d\n", ret);
> -               goto err_xclk60mhsp2_ck;
> -       }
> -
> -       usbhost_p2_fck = clk_get(dev, "usb_host_hs_utmi_p2_clk");
> -       if (IS_ERR(usbhost_p2_fck)) {
> -               ret = PTR_ERR(usbhost_p2_fck);
> -               dev_err(dev, "usbhost_p2_fck failed error:%d\n", ret);
> -               goto err_usbhost_p1_fck;
> -       }
> -
> -       init_60m_fclk = clk_get(dev, "init_60m_fclk");
> -       if (IS_ERR(init_60m_fclk)) {
> -               ret = PTR_ERR(init_60m_fclk);
> -               dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
> -               goto err_usbhost_p2_fck;
> -       }
>
>         return 0;
>
> -err_usbhost_p2_fck:
> -       clk_put(usbhost_p2_fck);
> -
> -err_usbhost_p1_fck:
> -       clk_put(usbhost_p1_fck);
> -
> -err_xclk60mhsp2_ck:
> -       clk_put(xclk60mhsp2_ck);
> -
> -err_utmi_p2_fck:
> -       clk_put(utmi_p2_fck);
> -
> -err_xclk60mhsp1_ck:
> -       clk_put(xclk60mhsp1_ck);
> -
> -err_utmi_p1_fck:
> -       clk_put(utmi_p1_fck);
> -
> -err_add_hcd:
> -       usb_remove_hcd(hcd);
> -
>  err_pm_runtime:
>         disable_put_regulator(pdata);
>         pm_runtime_put_sync(dev);
> @@ -454,14 +297,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
>         iounmap(hcd->regs);
>         usb_put_hcd(hcd);
>
> -       clk_put(utmi_p1_fck);
> -       clk_put(utmi_p2_fck);
> -       clk_put(xclk60mhsp1_ck);
> -       clk_put(xclk60mhsp2_ck);
> -       clk_put(usbhost_p1_fck);
> -       clk_put(usbhost_p2_fck);
> -       clk_put(init_60m_fclk);
> -
>         pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
>
> @@ -532,7 +367,7 @@ static const struct hc_driver ehci_omap_hc_driver = {
>          * root hub support
>          */
>         .hub_status_data        = ehci_hub_status_data,
> -       .hub_control            = omap_ehci_hub_control,
> +       .hub_control            = ehci_hub_control,
>         .bus_suspend            = ehci_bus_suspend,
>         .bus_resume             = ehci_bus_resume,
>
> --
> 1.7.9.5
>

Hi Greg
     this patch is rebased on your usb-next branch on top this commit id:

commit e387ef5c47ddeaeaa3cbdc54424cdb7a28dae2c0
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Thu Jul 19 12:39:14 2012 +0200

    usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams

    Most Logitech UVC webcams (both early models that don't advertise UVC
    compatibility and newer UVC-advertised devices) require the RESET_RESUME
    quirk. Instead of listing each and every model, match the devices based
    on the UVC interface information.

    Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Acked-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


please let me know is this fine with you?

regards
keshava
