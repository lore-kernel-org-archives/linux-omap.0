From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [usb-next PATCH v11 5/8] usb: host: xhci-mtk: remove custom USB
 PHY handling
Date: Mon, 5 Mar 2018 16:31:29 +0800
Message-ID: <1520238689.8089.227.camel@mtkswgap22>
References: <20180303214309.25643-1-martin.blumenstingl@googlemail.com>
 <20180303214309.25643-6-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180303214309.25643-6-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, arnd@arndb.de, felipe.balbi@linux.intel.com, Peter.Chen@nxp.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, linux-usb@vger.kernel.org, yixun.lan@amlogic.com, jonathanh@nvidia.com, mathias.nyman@intel.com, narmstrong@baylibre.com, robh+dt@kernel.org, thierry.reding@gmail.com, linux@prisktech.co.nz, linux-amlogic@lists.infradead.org, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi, Martin

Tested-by: Sean Wang <sean.wang@mediatek.com>

I've tested the series with U2 storage and U3 ethernet devices on both
boards MT7623 BPI-R2 and MT7622 RFB1 using xhci-mtk driver, they are
still working well.

Below is related logs for test devices probing

----

# [   42.590356] usb 2-1: new SuperSpeed USB device number 2 using
xhci-mtk
[   42.719883] usb-storage 2-1:1.0: USB Mass Storage device detected
[   42.726339] scsi host2: usb-storage 2-1:1.0
[   43.815572] scsi 2:0:0:0: Direct-Access     Kingston DataTraveler 3.0
PMAP PQ: 0 ANSI: 6
[   44.792938] sd 2:0:0:0: [sda] 30728832 512-byte logical blocks: (15.7
GB/14.7 GiB)
[   44.800658] sd 2:0:0:0: [sda] Write Protect is off
[   44.805582] sd 2:0:0:0: [sda] No Caching mode page found
[   44.810888] sd 2:0:0:0: [sda] Assuming drive cache: write through

----

# [  134.270617] usb 2-1: new SuperSpeed USB device number 3 using
xhci-mtk
[  134.664163] ax88179_178a 2-1:1.0 eth1: register 'ax88179_178a' at
usb-1a1c0000.usb-1, ASIX AX88179 USB 3.0 Gigabit Ethernet,
00:11:6b:68:4c:9e


On Sat, 2018-03-03 at 22:43 +0100, Martin Blumenstingl wrote:
> The new PHY wrapper is now wired up in the core HCD code. This means
> that PHYs are now controlled (initialized, enabled, disabled, exited)
> without requiring any host-driver specific code.
> Remove the custom USB PHY handling from the xhci-mtk driver as the core
> HCD code now handles this.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/usb/host/xhci-mtk.c | 98 +--------------------------------------------
>  1 file changed, 2 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b0ab4d5e2751..7334da9e9779 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -14,7 +14,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -352,62 +351,6 @@ static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
>  
>  static struct hc_driver __read_mostly xhci_mtk_hc_driver;
>  
> -static int xhci_mtk_phy_init(struct xhci_hcd_mtk *mtk)
> -{
> -	int i;
> -	int ret;
> -
> -	for (i = 0; i < mtk->num_phys; i++) {
> -		ret = phy_init(mtk->phys[i]);
> -		if (ret)
> -			goto exit_phy;
> -	}
> -	return 0;
> -
> -exit_phy:
> -	for (; i > 0; i--)
> -		phy_exit(mtk->phys[i - 1]);
> -
> -	return ret;
> -}
> -
> -static int xhci_mtk_phy_exit(struct xhci_hcd_mtk *mtk)
> -{
> -	int i;
> -
> -	for (i = 0; i < mtk->num_phys; i++)
> -		phy_exit(mtk->phys[i]);
> -
> -	return 0;
> -}
> -
> -static int xhci_mtk_phy_power_on(struct xhci_hcd_mtk *mtk)
> -{
> -	int i;
> -	int ret;
> -
> -	for (i = 0; i < mtk->num_phys; i++) {
> -		ret = phy_power_on(mtk->phys[i]);
> -		if (ret)
> -			goto power_off_phy;
> -	}
> -	return 0;
> -
> -power_off_phy:
> -	for (; i > 0; i--)
> -		phy_power_off(mtk->phys[i - 1]);
> -
> -	return ret;
> -}
> -
> -static void xhci_mtk_phy_power_off(struct xhci_hcd_mtk *mtk)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < mtk->num_phys; i++)
> -		phy_power_off(mtk->phys[i]);
> -}
> -
>  static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
>  {
>  	int ret;
> @@ -488,8 +431,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  	struct xhci_hcd *xhci;
>  	struct resource *res;
>  	struct usb_hcd *hcd;
> -	struct phy *phy;
> -	int phy_num;
>  	int ret = -ENODEV;
>  	int irq;
>  
> @@ -529,16 +470,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	mtk->num_phys = of_count_phandle_with_args(node,
> -			"phys", "#phy-cells");
> -	if (mtk->num_phys > 0) {
> -		mtk->phys = devm_kcalloc(dev, mtk->num_phys,
> -					sizeof(*mtk->phys), GFP_KERNEL);
> -		if (!mtk->phys)
> -			return -ENOMEM;
> -	} else {
> -		mtk->num_phys = 0;
> -	}
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  	device_enable_async_suspend(dev);
> @@ -596,23 +527,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  		mtk->has_ippc = false;
>  	}
>  
> -	for (phy_num = 0; phy_num < mtk->num_phys; phy_num++) {
> -		phy = devm_of_phy_get_by_index(dev, node, phy_num);
> -		if (IS_ERR(phy)) {
> -			ret = PTR_ERR(phy);
> -			goto put_usb2_hcd;
> -		}
> -		mtk->phys[phy_num] = phy;
> -	}
> -
> -	ret = xhci_mtk_phy_init(mtk);
> -	if (ret)
> -		goto put_usb2_hcd;
> -
> -	ret = xhci_mtk_phy_power_on(mtk);
> -	if (ret)
> -		goto exit_phys;
> -
>  	device_init_wakeup(dev, true);
>  
>  	xhci = hcd_to_xhci(hcd);
> @@ -630,7 +544,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  			dev_name(dev), hcd);
>  	if (!xhci->shared_hcd) {
>  		ret = -ENOMEM;
> -		goto power_off_phys;
> +		goto disable_device_wakeup;
>  	}
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> @@ -653,13 +567,9 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>  	xhci_mtk_sch_exit(mtk);
>  	usb_put_hcd(xhci->shared_hcd);
>  
> -power_off_phys:
> -	xhci_mtk_phy_power_off(mtk);
> +disable_device_wakeup:
>  	device_init_wakeup(dev, false);
>  
> -exit_phys:
> -	xhci_mtk_phy_exit(mtk);
> -
>  put_usb2_hcd:
>  	usb_put_hcd(hcd);
>  
> @@ -682,8 +592,6 @@ static int xhci_mtk_remove(struct platform_device *dev)
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  
>  	usb_remove_hcd(xhci->shared_hcd);
> -	xhci_mtk_phy_power_off(mtk);
> -	xhci_mtk_phy_exit(mtk);
>  	device_init_wakeup(&dev->dev, false);
>  
>  	usb_remove_hcd(hcd);
> @@ -718,7 +626,6 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
>  	del_timer_sync(&xhci->shared_hcd->rh_timer);
>  
>  	xhci_mtk_host_disable(mtk);
> -	xhci_mtk_phy_power_off(mtk);
>  	xhci_mtk_clks_disable(mtk);
>  	usb_wakeup_set(mtk, true);
>  	return 0;
> @@ -732,7 +639,6 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
>  
>  	usb_wakeup_set(mtk, false);
>  	xhci_mtk_clks_enable(mtk);
> -	xhci_mtk_phy_power_on(mtk);
>  	xhci_mtk_host_enable(mtk);
>  
>  	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
