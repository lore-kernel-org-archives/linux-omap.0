From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Thu, 21 Jun 2012 19:13:52 +0530
Message-ID: <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340286132-20634-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
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
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
> =A0drivers/usb/host/ehci-omap.c | =A0164 +---------------------------=
--------------
> =A01 file changed, 1 insertion(+), 163 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> index 17cfb8a..272e661 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -56,15 +56,6 @@
> =A0#define =A0 =A0 =A0 =A0EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT =A0 =A0=
 =A0 =A0 =A0 =A0 8
> =A0#define =A0 =A0 =A0 =A0EHCI_INSNREG05_ULPI_WRDATA_SHIFT =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00
>
> -/* Errata i693 */
> -static struct clk =A0 =A0 =A0*utmi_p1_fck;
> -static struct clk =A0 =A0 =A0*utmi_p2_fck;
> -static struct clk =A0 =A0 =A0*xclk60mhsp1_ck;
> -static struct clk =A0 =A0 =A0*xclk60mhsp2_ck;
> -static struct clk =A0 =A0 =A0*usbhost_p1_fck;
> -static struct clk =A0 =A0 =A0*usbhost_p2_fck;
> -static struct clk =A0 =A0 =A0*init_60m_fclk;
> -
> =A0/*----------------------------------------------------------------=
---------*/
>
> =A0static const struct hc_driver ehci_omap_hc_driver;
> @@ -80,40 +71,6 @@ static inline u32 ehci_read(void __iomem *base, u3=
2 reg)
> =A0 =A0 =A0 =A0return __raw_readl(base + reg);
> =A0}
>
> -/* Erratum i693 workaround sequence */
> -static void omap_ehci_erratum_i693(struct ehci_hcd *ehci)
> -{
> - =A0 =A0 =A0 int ret =3D 0;
> -
> - =A0 =A0 =A0 /* Switch to the internal 60 MHz clock */
> - =A0 =A0 =A0 ret =3D clk_set_parent(utmi_p1_fck, init_60m_fclk);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_err(ehci, "init_60m_fclk set paren=
t"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed error:%d\n", re=
t);
> -
> - =A0 =A0 =A0 ret =3D clk_set_parent(utmi_p2_fck, init_60m_fclk);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_err(ehci, "init_60m_fclk set paren=
t"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed error:%d\n", re=
t);
> -
> - =A0 =A0 =A0 clk_enable(usbhost_p1_fck);
> - =A0 =A0 =A0 clk_enable(usbhost_p2_fck);
> -
> - =A0 =A0 =A0 /* Wait 1ms and switch back to the external clock */
> - =A0 =A0 =A0 mdelay(1);
> - =A0 =A0 =A0 ret =3D clk_set_parent(utmi_p1_fck, xclk60mhsp1_ck);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_err(ehci, "xclk60mhsp1_ck set pare=
nt"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed error:%d\n", re=
t);
> -
> - =A0 =A0 =A0 ret =3D clk_set_parent(utmi_p2_fck, xclk60mhsp2_ck);
> - =A0 =A0 =A0 if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_err(ehci, "xclk60mhsp2_ck set pare=
nt"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed error:%d\n", re=
t);
> -
> - =A0 =A0 =A0 clk_disable(usbhost_p1_fck);
> - =A0 =A0 =A0 clk_disable(usbhost_p2_fck);
> -}
>
> =A0static void omap_ehci_soft_phy_reset(struct platform_device *pdev,=
 u8 port)
> =A0{
> @@ -145,50 +102,6 @@ static void omap_ehci_soft_phy_reset(struct plat=
form_device *pdev, u8 port)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static int omap_ehci_hub_control(
> - =A0 =A0 =A0 struct usb_hcd =A0*hcd,
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 typeReq,
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 wValue,
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 wIndex,
> - =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0*buf,
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 wLength
> -)
> -{
> - =A0 =A0 =A0 struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> - =A0 =A0 =A0 u32 __iomem *status_reg =3D &ehci->regs->port_status[
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (wIndex=
 & 0xff) - 1];
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 temp;
> - =A0 =A0 =A0 unsigned long =A0 flags;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 retval =3D 0;
> -
> - =A0 =A0 =A0 spin_lock_irqsave(&ehci->lock, flags);
> -
> - =A0 =A0 =A0 if (typeReq =3D=3D SetPortFeature && wValue =3D=3D USB_=
PORT_FEAT_SUSPEND) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D ehci_readl(ehci, status_reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp & PORT_PE) =3D=3D 0 || (temp =
& PORT_RESET) !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EPIPE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~PORT_WKCONN_E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D PORT_WKDISC_E | PORT_WKOC_E;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_writel(ehci, temp | PORT_SUSPEND, =
status_reg);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ehci_erratum_i693(ehci);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit((wIndex & 0xff) - 1, &ehci->sus=
pended_ports);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 spin_unlock_irqrestore(&ehci->lock, flags);
> -
> - =A0 =A0 =A0 /* Handle the hub control events here */
> - =A0 =A0 =A0 return ehci_hub_control(hcd, typeReq, wValue, wIndex, b=
uf, wLength);
> -done:
> - =A0 =A0 =A0 spin_unlock_irqrestore(&ehci->lock, flags);
> - =A0 =A0 =A0 return retval;
> -}
> -
> =A0static void disable_put_regulator(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ehci_hcd_omap_platform_data *pd=
ata)
> =A0{
> @@ -353,76 +266,9 @@ static int ehci_hcd_omap_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0/* root ports should always stay powered */
> =A0 =A0 =A0 =A0ehci_port_power(omap_ehci, 1);
>
> - =A0 =A0 =A0 /* get clocks */
> - =A0 =A0 =A0 utmi_p1_fck =3D clk_get(dev, "utmi_p1_gfclk");
> - =A0 =A0 =A0 if (IS_ERR(utmi_p1_fck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(utmi_p1_fck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p1_gfclk failed erro=
r:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_hcd;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 xclk60mhsp1_ck =3D clk_get(dev, "xclk60mhsp1_ck");
> - =A0 =A0 =A0 if (IS_ERR(xclk60mhsp1_ck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(xclk60mhsp1_ck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp1_ck failed err=
or:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p1_fck;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 utmi_p2_fck =3D clk_get(dev, "utmi_p2_gfclk");
> - =A0 =A0 =A0 if (IS_ERR(utmi_p2_fck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(utmi_p2_fck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "utmi_p2_gfclk failed erro=
r:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp1_ck;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 xclk60mhsp2_ck =3D clk_get(dev, "xclk60mhsp2_ck");
> - =A0 =A0 =A0 if (IS_ERR(xclk60mhsp2_ck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(xclk60mhsp2_ck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "xclk60mhsp2_ck failed err=
or:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_utmi_p2_fck;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 usbhost_p1_fck =3D clk_get(dev, "usb_host_hs_utmi_p1_cl=
k");
> - =A0 =A0 =A0 if (IS_ERR(usbhost_p1_fck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(usbhost_p1_fck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p1_fck failed err=
or:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_xclk60mhsp2_ck;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 usbhost_p2_fck =3D clk_get(dev, "usb_host_hs_utmi_p2_cl=
k");
> - =A0 =A0 =A0 if (IS_ERR(usbhost_p2_fck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(usbhost_p2_fck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbhost_p2_fck failed err=
or:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p1_fck;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 init_60m_fclk =3D clk_get(dev, "init_60m_fclk");
> - =A0 =A0 =A0 if (IS_ERR(init_60m_fclk)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(init_60m_fclk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "init_60m_fclk failed erro=
r:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbhost_p2_fck;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
>
> -err_usbhost_p2_fck:
> - =A0 =A0 =A0 clk_put(usbhost_p2_fck);
> -
> -err_usbhost_p1_fck:
> - =A0 =A0 =A0 clk_put(usbhost_p1_fck);
> -
> -err_xclk60mhsp2_ck:
> - =A0 =A0 =A0 clk_put(xclk60mhsp2_ck);
> -
> -err_utmi_p2_fck:
> - =A0 =A0 =A0 clk_put(utmi_p2_fck);
> -
> -err_xclk60mhsp1_ck:
> - =A0 =A0 =A0 clk_put(xclk60mhsp1_ck);
> -
> -err_utmi_p1_fck:
> - =A0 =A0 =A0 clk_put(utmi_p1_fck);
> -
> =A0err_add_hcd:
> =A0 =A0 =A0 =A0disable_put_regulator(pdata);
> =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
> @@ -452,14 +298,6 @@ static int ehci_hcd_omap_remove(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0iounmap(hcd->regs);
> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
>
> - =A0 =A0 =A0 clk_put(utmi_p1_fck);
> - =A0 =A0 =A0 clk_put(utmi_p2_fck);
> - =A0 =A0 =A0 clk_put(xclk60mhsp1_ck);
> - =A0 =A0 =A0 clk_put(xclk60mhsp2_ck);
> - =A0 =A0 =A0 clk_put(usbhost_p1_fck);
> - =A0 =A0 =A0 clk_put(usbhost_p2_fck);
> - =A0 =A0 =A0 clk_put(init_60m_fclk);
> -
> =A0 =A0 =A0 =A0pm_runtime_put_sync(dev);
> =A0 =A0 =A0 =A0pm_runtime_disable(dev);
>
> @@ -530,7 +368,7 @@ static const struct hc_driver ehci_omap_hc_driver=
 =3D {
> =A0 =A0 =A0 =A0 * root hub support
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0.hub_status_data =A0 =A0 =A0 =A0=3D ehci_hub_status_da=
ta,
> - =A0 =A0 =A0 .hub_control =A0 =A0 =A0 =A0 =A0 =A0=3D omap_ehci_hub_c=
ontrol,
> + =A0 =A0 =A0 .hub_control =A0 =A0 =A0 =A0 =A0 =A0=3D ehci_hub_contro=
l,
> =A0 =A0 =A0 =A0.bus_suspend =A0 =A0 =A0 =A0 =A0 =A0=3D ehci_bus_suspe=
nd,
> =A0 =A0 =A0 =A0.bus_resume =A0 =A0 =A0 =A0 =A0 =A0 =3D ehci_bus_resum=
e,
>
> --
> 1.7.9.5
>

hi kevin

here is pm count log on beagle XM with the above patch:

 cat ./debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:3,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
neon_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:1254,INA:0,ON:1255,RET-LOGIC-OFF:0,RET-MEMBANK=
1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (3)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
core_l4_clkdm->core_pwrdm (25)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)


regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
