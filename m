From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Thu, 7 Apr 2016 14:45:20 +0300
Message-ID: <57064850.3060405@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/04/16 11:52, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Roger Quadros
>> Sent: Tuesday, April 05, 2016 11:05 PM
>>
>> It provides APIs for the following tasks
>>
>> - Registering an OTG/dual-role capable controller
>> - Registering Host and Gadget controllers to OTG core
>> - Providing inputs to and kicking the OTG state machine
>>
>> Provide a dual-role device (DRD) state machine.
>> DRD mode is a reduced functionality OTG mode. In this mode
>> we don't support SRP, HNP and dynamic role-swap.
>>
>> In DRD operation, the controller mode (Host or Peripheral)
>> is decided based on the ID pin status. Once a cable plug (Type-A
>> or Type-B) is attached the controller selects the state
>> and doesn't change till the cable in unplugged and a different
>> cable type is inserted.
>>
>> As we don't need most of the complex OTG states and OTG timers
>> we implement a lean DRD state machine in usb-otg.c.
>> The DRD state machine is only interested in 2 hardware inputs
>> 'id' and 'b_sess_vld'.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
> 
> I tried to implement this framework on my environment,
> and it seemed work if I added a local hack to this patch :)

Great. Thanks for testing :).

> 
> < snip >
>> +	/* HCD will be started by OTG fsm when needed */
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (otg->primary_hcd.hcd) {
>> +		/* probably a shared HCD ? */
>> +		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>> +			dev_err(otg_dev, "otg: primary host already registered\n");
> 
> My environment is arm64 / r8a7795, renesas_usbhs (as a gadget), EHCI and OHCI.
> In this case, OHCI driver is also a primary_hcd. So, this error happened.
> To avoid this, I assumes that the OHCI hcd is as shared_hcd like a patch below:
> 
> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> index 41e762a..4d7f043 100644
> --- a/drivers/usb/common/usb-otg.c
> +++ b/drivers/usb/common/usb-otg.c
> @@ -825,11 +825,16 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  	if (otg->primary_hcd.hcd) {
>  		/* probably a shared HCD ? */
>  		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> +			if (hcd->driver->flags & HCD_USB11) {
> +				dev_info(otg_dev, "this assumes usb 1.1 hc is as shared_hcd\n");
> +				goto check_shared_hcd;
> +			}
>  			dev_err(otg_dev, "otg: primary host already registered\n");
>  			goto err;
>  		}
>  
>  		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
> +check_shared_hcd:
>  			if (otg->shared_hcd.hcd) {
>  				dev_err(otg_dev, "otg: shared host already registered\n");
>  				goto err;
> 
> What do you think this local hack?

Is it guaranteed that EHCI hcd registers before OHCI hcd?
If not we need to improve the code still.
We will also need to remove the constraint that primary_hcd must be registered
first in usb_otg_register_hcd(). I think that constraint is no longer
needed anyways.

If EHCI & OHCI HCDs register before OTG driver then things will break unless
we fix usb_otg_hcd_wait_add(). We need to add this HCD_USB11 check there to
populate wait->shared_hcd.


> I also wonder if array of hcd may be good for both xHCI and EHCI/OHCI.
> For example of xHCI:
>  - otg->hcds[0] = primary_hcd
>  - otg->hcds[1] = shared_hcd
> 
> For example of EHCI/OHCI:
>  - otg->hcds[0] = primary_hcd of EHCI
>  - otg->hcds[1] = primary_hcd of OHCI

The bigger problem is that how do we know in the OHCI/EHCI case that we need to wait
for both of them before starting the OTG FSM? 
Some systems might use just OHCI or just EHCI.

There is no guarantee that OTG driver registers before the HCDs so this piece
of information must come from the HCD itself. i.e. whether it needs a companion or not.

cheers,
-roger
