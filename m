From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Thu, 3 Sep 2015 15:21:48 +0300
Message-ID: <55E83B5C.7050001@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
 <20150902143149.GD8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902143149.GD8299@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:31, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Sep 02, 2015 at 05:24:16PM +0300, Roger Quadros wrote:
>> Register with the USB OTG core. Since we don't support
>> OTG yet we just work as a dual-role device even
>> if device tree says "otg".
>>
>> Use extcon framework to get VBUS/ID cable events and
>> kick the OTG state machine.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/core.c          | 174 ++++++++++++++++++++++++++++++++++++++-
>>  drivers/usb/dwc3/core.h          |   7 ++
>>  drivers/usb/dwc3/platform_data.h |   1 +
>>  3 files changed, 181 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 064123e..2e36a9b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -704,6 +704,152 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>>  	return 0;
>>  }
>>  
>> +/* --------------------- Dual-Role management ------------------------------- */
>> +
>> +static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
>> +{
>> +	int id, vbus;
>> +
>> +	/* get ID */
>> +	id = extcon_get_cable_state(dwc->edev, "USB-HOST");
>> +	/* Host means ID == 0 */
>> +	id = !id;
>> +
>> +	/* get VBUS */
>> +	vbus = extcon_get_cable_state(dwc->edev, "USB");
>> +	dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
> 
> tracepoint please. We don't want this driver to use dev_(v)?db anymore.
> Ditto to all others.

OK.

> 
>> +
>> +	dwc->fsm->id = id;
>> +	dwc->fsm->b_sess_vld = vbus;
>> +	usb_otg_sync_inputs(dwc->fsm);
>> +}
>> +
>> +static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
>> +{
>> +	struct device *dev = usb_otg_fsm_to_dev(fsm);
>> +	struct dwc3 *dwc = dev_get_drvdata(dev);
> 
> how about adding a usb_otg_get_drvdata(fsm) ?

You meant for otg core? That can be done.

> 
>> +	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
>> +	if (on) {
>> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +		/* start the HCD */
>> +		usb_otg_start_host(fsm, true);
>> +	} else {
>> +		/* stop the HCD */
>> +		usb_otg_start_host(fsm, false);
>> +	}
> 
> This can be simplified.
> 
> 	if (on)
> 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> 
> 	usb_otg_start_host(fsm, on);

Indeed.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
>> +{
>> +	struct device *dev = usb_otg_fsm_to_dev(fsm);
>> +	struct dwc3 *dwc = dev_get_drvdata(dev);
>> +
>> +	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
>> +	if (on) {
>> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +		dwc3_event_buffers_setup(dwc);
>> +
>> +		/* start the UDC */
>> +		usb_otg_start_gadget(fsm, true);
>> +	} else {
>> +		/* stop the UDC */
>> +		usb_otg_start_gadget(fsm, false);
>> +	}
> 
> likewise:
> 
> 	if (on) {
> 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> 		dwc3_event_buffers_setup(dwc);
> 	}
> 
> 	usb_otg_start_gadget(fsm, on);

OK.
> 
>> +	return 0;
>> +}
>> +
>> +static struct otg_fsm_ops dwc3_drd_ops = {
>> +	.start_host = dwc3_drd_start_host,
>> +	.start_gadget = dwc3_drd_start_gadget,
>> +};
>> +
>> +static int dwc3_drd_notifier(struct notifier_block *nb,
>> +			     unsigned long event, void *ptr)
>> +{
>> +	struct dwc3 *dwc = container_of(nb, struct dwc3, otg_nb);
>> +
>> +	dwc3_drd_fsm_sync(dwc);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int dwc3_drd_init(struct dwc3 *dwc)
>> +{
>> +	int ret, id, vbus;
>> +	struct usb_otg_caps *otgcaps = &dwc->otg_config.otg_caps;
>> +
>> +	otgcaps->otg_rev = 0;
>> +	otgcaps->hnp_support = false;
>> +	otgcaps->srp_support = false;
>> +	otgcaps->adp_support = false;
>> +	dwc->otg_config.fsm_ops = &dwc3_drd_ops;
>> +
>> +	if (!dwc->edev) {
>> +		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	dwc->otg_nb.notifier_call = dwc3_drd_notifier;
>> +	ret = extcon_register_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
>> +	if (ret < 0) {
>> +		dev_err(dwc->dev, "Couldn't register USB cable notifier\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>> +				       &dwc->otg_nb);
>> +	if (ret < 0) {
>> +		dev_err(dwc->dev, "Couldn't register USB-HOST cable notifier\n");
>> +		ret = -ENODEV;
>> +		goto extcon_fail;
>> +	}
>> +
>> +	/* sanity check id & vbus states */
>> +	id = extcon_get_cable_state(dwc->edev, "USB-HOST");
>> +	vbus = extcon_get_cable_state(dwc->edev, "USB");
>> +	if (id < 0 || vbus < 0) {
>> +		dev_err(dwc->dev, "Invalid USB cable state. id %d, vbus %d\n",
>> +			id, vbus);
>> +		ret = -ENODEV;
>> +		goto fail;
>> +	}
>> +
>> +	/* register as DRD device with OTG core */
>> +	dwc->fsm = usb_otg_register(dwc->dev, &dwc->otg_config);
>> +	if (IS_ERR(dwc->fsm)) {
>> +		ret = PTR_ERR(dwc->fsm);
>> +		if (ret == -ENOTSUPP)
>> +			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
>> +		else
>> +			dev_err(dwc->dev, "Failed to register with OTG core\n");
> 
> do you need to cope with EPROBE_DEFER ?

Yes, we should.

> 
>> +
>> +		goto fail;
>> +	}
>> +
>> +	dwc3_drd_fsm_sync(dwc);
>> +
>> +	return 0;
>> +fail:
>> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
>> +extcon_fail:
>> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
>> +
>> +	return ret;
>> +}
>> +
>> +static void dwc3_drd_exit(struct dwc3 *dwc)
>> +{
>> +	usb_otg_unregister(dwc->dev);
>> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
>> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
>> +}
>> +
>> +/* -------------------------------------------------------------------------- */
>> +
>>  static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  {
>>  	struct device *dev = dwc->dev;
>> @@ -727,13 +873,21 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  		}
>>  		break;
>>  	case USB_DR_MODE_OTG:
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>> +		ret = dwc3_drd_init(dwc);
>> +		if (ret) {

So here if ret is -EPROBE_DEFER, we return.

>> +			dev_err(dev, "limiting to peripheral only\n");
>> +			dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
>> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +			goto gadget_init;
>> +		}
>> +
>>  		ret = dwc3_host_init(dwc);
>>  		if (ret) {
>>  			dev_err(dev, "failed to initialize host\n");
>>  			return ret;
>>  		}
>>  
>> +gadget_init:
>>  		ret = dwc3_gadget_init(dwc);
>>  		if (ret) {
>>  			dev_err(dev, "failed to initialize gadget\n");
>> @@ -760,6 +914,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>>  	case USB_DR_MODE_OTG:
>>  		dwc3_host_exit(dwc);
>>  		dwc3_gadget_exit(dwc);
>> +		dwc3_drd_exit(dwc);
>>  		break;
>>  	default:
>>  		/* do nothing */
>> @@ -843,6 +998,16 @@ static int dwc3_probe(struct platform_device *pdev)
>>  	hird_threshold = 12;
>>  
>>  	if (node) {
>> +		if (of_property_read_bool(node, "extcon"))
>> +			dwc->edev = extcon_get_edev_by_phandle(dev, 0);
>> +		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
>> +			dwc->edev = extcon_get_edev_by_phandle(dev->parent, 0);
> 
> why do you need to check the parent ? Why isn't that done on the glue
> layer ?

On DRA7-evm, the extcon device is defined in the glue layer node. But
we need the device both at the glue layer and at the core layer.
We do get the extcon device in dwc3-omap.c

Any suggestion how to pass the extcon device from glue layer to core.c?
Or should I add the extcon property to dwc3 USB node as well in the DT?

> 
>> +
>> +		if (IS_ERR(dwc->edev)) {
>> +			dev_vdbg(dev, "couldn't get extcon device\n");
> 
> dev_err() ??

Is it ok to print it even in EPROBE_DEFER case?

> 
>> +			return -EPROBE_DEFER;
> 
> this could make us reschedule probe forever.

Good catch, we must return PTR_ERR(dwc->edev).

> 
>> +		}
>> +
>>  		dwc->maximum_speed = of_usb_get_maximum_speed(node);
>>  		dwc->has_lpm_erratum = of_property_read_bool(node,
>>  				"snps,has-lpm-erratum");
>> @@ -887,6 +1052,13 @@ static int dwc3_probe(struct platform_device *pdev)
>>  		of_property_read_string(node, "snps,hsphy_interface",
>>  					&dwc->hsphy_interface);
>>  	} else if (pdata) {
>> +		if (pdata->extcon) {
>> +			dwc->edev = extcon_get_extcon_dev(pdata->extcon);
>> +			if (!dwc->edev) {
>> +				dev_vdbg(dev, "couldn't get extcon device\n");
>> +				return -EPROBE_DEFER;
> 
> ditto

OK.

> 
>> +			}
>> +		}
>>  		dwc->maximum_speed = pdata->maximum_speed;
>>  		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
>>  		if (pdata->lpm_nyet_threshold)
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 0447788..5ca2b25 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -31,8 +31,10 @@
>>  #include <linux/usb/gadget.h>
>>  #include <linux/usb/otg.h>
>>  #include <linux/ulpi/interface.h>
>> +#include <linux/usb/otg-fsm.h>
>>  
>>  #include <linux/phy/phy.h>
>> +#include <linux/extcon.h>
>>  
>>  #define DWC3_MSG_MAX	500
>>  
>> @@ -753,6 +755,11 @@ struct dwc3 {
>>  
>>  	struct ulpi		*ulpi;
>>  
>> +	struct extcon_dev	*edev;	/* USB cable events ID & VBUS */
>> +	struct notifier_block	otg_nb;	/* notifier for USB cable events */
>> +	struct otg_fsm		*fsm;
>> +	struct usb_otg_config	otg_config;
>> +
>>  	void __iomem		*regs;
>>  	size_t			regs_size;
>>  
>> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
>> index d3614ec..b3b245c 100644
>> --- a/drivers/usb/dwc3/platform_data.h
>> +++ b/drivers/usb/dwc3/platform_data.h
>> @@ -47,4 +47,5 @@ struct dwc3_platform_data {
>>  	unsigned tx_de_emphasis:2;
>>  
>>  	const char *hsphy_interface;
>> +	const char *extcon;	/* extcon name for USB cable events ID/VBUS */
>>  };
>> -- 
>> 2.1.4
>>
> 

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6DtcAAoJENJaa9O+djCTWYcP/j/nseHR49Z1I8ftXv8urDGl
mMjMTzhlMxB7CYCtiqGpQ8Dytr9R7Ahm1llUVC4v6vYC5csJW1IcKxp/LOnaYmOL
d6EVFCSGM5JdEN83JoPfz/BD8qR/pWMmgzAGo60CkESev3E+/KxtcTl8md8CyOJj
DimMFsAmMxiVD2uABaW64Y96sG/lr8+b2AOksa6P1Os5n3GylNNegNHLSVMfx0b8
6lTn5uOa70fFZJTQDfF5idzgTrIT9irvP/GZ6RY1d6xLat4Hos1SWCjrDCHfgvHF
z3z39uW336/dpB56eomUSzctq0gVzzxG8lOIuVPXAJWEmwlx2FbV3M6viul56AGH
vtgWEB2LloLZxuXz60lnj3y8MSccUfMii+KILKtJVVjD7TW1BziW31juq+QZs+T2
yTT3YWuJVXpzob9jbzAenyU2ogDoS3vNA9cMRGOdr8cKg33z70rU/mfPcKlQKgWN
Ngve174czk9ZZgrF+l2r/m3SOqSbTDRqkxarP+KFrzNEn/hFPprSx8Encqg7Xr0t
EzUNQC64LmTxpzJwXzRuMuCqcu+plhuvSK93ymU5LkNqe+Bv5WtJaqXuxRCQ9rrY
Mn34QMFaKLz+9mLRvwGEp70MRafy44eJ5qslyj+0glL9mOB3AV7nyAArzeEJgY4/
vyyf4sA7JD9OL6NpkgVh
=ZhiZ
-----END PGP SIGNATURE-----
