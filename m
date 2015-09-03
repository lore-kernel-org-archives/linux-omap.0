From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Thu, 3 Sep 2015 16:52:02 +0300
Message-ID: <55E85082.5040006@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
 <20150902144338.GG8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150902144338.GG8299-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:43, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Sep 02, 2015 at 05:24:20PM +0300, Roger Quadros wrote:
>> If the ID pin event is not available over extcon
>> then we rely on the OTG controller to provide us ID and VBUS
>> information.
>>
>> We still don't support any OTG features but just
>> dual-role operation.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/core.c | 217 ++++++++++++++++++++++++++++++++++++++++++++----
>>  drivers/usb/dwc3/core.h |   3 +
>>  2 files changed, 205 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 38b31df..632ee53 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -704,6 +704,63 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>>  	return 0;
>>  }
>>  
>> +/* Get OTG events and sync it to OTG fsm */
>> +static void dwc3_otg_fsm_sync(struct dwc3 *dwc)
>> +{
>> +	u32 reg;
>> +	int id, vbus;
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_OSTS);
>> +	dev_dbg(dwc->dev, "otgstatus 0x%x\n", reg);
>> +
>> +	id = !!(reg & DWC3_OSTS_CONIDSTS);
>> +	vbus = !!(reg & DWC3_OSTS_BSESVLD);
>> +
>> +	if (id != dwc->fsm->id || vbus != dwc->fsm->b_sess_vld) {
>> +		dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
>> +		dwc->fsm->id = id;
>> +		dwc->fsm->b_sess_vld = vbus;
>> +		usb_otg_sync_inputs(dwc->fsm);
>> +	}
> 
> this guy shouldn't try to filter events here. That's what the FSM should
> be doing.

OK. I'll remove the if condition.

> 
>> +}
>> +
>> +static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
>> +{
>> +	struct dwc3 *dwc = _dwc;
>> +	unsigned long flags;
>> +	irqreturn_t ret = IRQ_NONE;
> 
> this IRQ will be disabled pretty quickly. You *always* return IRQ_NONE
> 
>> +	spin_lock_irqsave(&dwc->lock, flags);
> 
> if you cache current OSTS in dwc3, you can use that instead and change
> this to a spin_lock() instead of disabling IRQs here. This device's IRQs
> are already masked anyway.

OK.

> 
>> +	dwc3_otg_fsm_sync(dwc);
>> +	/* unmask interrupts */
>> +	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
>> +{
>> +	struct dwc3 *dwc = _dwc;
>> +	irqreturn_t ret = IRQ_NONE;
>> +	u32 reg;
>> +
>> +	spin_lock(&dwc->lock);
> 
> this seems unnecessary, we're already in hardirq with IRQs disabled.
> What sort of race could we have ? (in fact, this also needs change in
> dwc3/gadget.c).

You're right. Will fix at both places.
> 
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_OEVT);
>> +	if (reg) {
>> +		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
>> +		/* mask interrupts till processed */
>> +		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
>> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
>> +		ret = IRQ_WAKE_THREAD;
>> +	}
>> +
>> +	spin_unlock(&dwc->lock);
>> +
>> +	return ret;
>> +}
>> +
>>  /* --------------------- Dual-Role management ------------------------------- */
>>  
>>  static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
>> @@ -728,15 +785,44 @@ static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
>>  {
>>  	struct device *dev = usb_otg_fsm_to_dev(fsm);
>>  	struct dwc3 *dwc = dev_get_drvdata(dev);
>> +	u32 reg;
>>  
>>  	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
>> +	if (dwc->edev) {
>> +		if (on) {
>> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +			/* start the HCD */
>> +			usb_otg_start_host(fsm, true);
>> +		} else {
>> +			/* stop the HCD */
>> +			usb_otg_start_host(fsm, false);
>> +		}
> 
> 		if (on)
> 			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> 		usb_otg_start_host(fsm, on);
> 

OK.

>> +
>> +		return 0;
>> +	}
>> +
>> +	/* switch OTG core */
>>  	if (on) {
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +		/* OCTL.PeriMode = 0 */
>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		reg &= ~DWC3_OCTL_PERIMODE;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>> +		/* unconditionally turn on VBUS */
>> +		reg |= DWC3_OCTL_PRTPWRCTL;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>  		/* start the HCD */
>>  		usb_otg_start_host(fsm, true);
>>  	} else {
>>  		/* stop the HCD */
>>  		usb_otg_start_host(fsm, false);
>> +		/* turn off VBUS */
>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		reg &= ~DWC3_OCTL_PRTPWRCTL;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>> +		/* OCTL.PeriMode = 1 */
>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		reg |= DWC3_OCTL_PERIMODE;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>  	}
> 
> it looks like you're not really following the fluxchart from SNPS
> documentation, see Figure 11-4 on section 11.1.4.5

Did you mean that I'm ignoring all OTG bits (HNP/SRP/ADP)?

> 
>> @@ -746,15 +832,48 @@ static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
>>  {
>>  	struct device *dev = usb_otg_fsm_to_dev(fsm);
>>  	struct dwc3 *dwc = dev_get_drvdata(dev);
>> +	u32 reg;
>>  
>>  	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
>> -	if (on) {
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +	if (on)
>>  		dwc3_event_buffers_setup(dwc);
>>  
>> +	if (dwc->edev) {
>> +		if (on) {
>> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +			usb_otg_start_gadget(fsm, true);
>> +		} else {
>> +			usb_otg_start_gadget(fsm, false);
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* switch OTG core */
>> +	if (on) {
>> +		/* OCTL.PeriMode = 1 */
>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		reg |= DWC3_OCTL_PERIMODE;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>> +		/* GUSB2PHYCFG0.SusPHY = 1 */
>> +		if (!dwc->dis_u2_susphy_quirk) {
>> +			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
>> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +		}
>>  		/* start the UDC */
>>  		usb_otg_start_gadget(fsm, true);
>>  	} else {
>> +		/* GUSB2PHYCFG0.SusPHY=0 */
>> +		if (!dwc->dis_u2_susphy_quirk) {
>> +			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +		}
>> +		/* OCTL.PeriMode = 1 */
>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		reg |= DWC3_OCTL_PERIMODE;
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>  		/* stop the UDC */
>>  		usb_otg_start_gadget(fsm, false);
>>  	}
>> @@ -777,10 +896,30 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>>  	return NOTIFY_DONE;
>>  }
>>  

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6FCCAAoJENJaa9O+djCTbaYQAME771phZpgr2Xtj1ejnPE8H
Bl84Sam/gWjy4+mqCUw+mQaCuF8M24ExVugHypQ0fF+9w6UMNrDrg+g+kZtQusCt
BTFkvS7g/6LJHEJowIoRZc5y/5bhnLa4Udcw5pYdhZHG7yIUsTs98WePROdOPk6z
i6OXA/wPC9ZJxeavew42HDmNj2IjJppU7bLDo+uMj/vz35dElq/B5w5mAXhshJ9A
R2IbxDevP4SiBYPfx1uFYKO5v9YVHnB3wk+3i3MjKuwO2CqfAVjzt9qWpM1iNThx
hOh+9vOenvttn7WHXP0scZAdBjmp3kKRAlfSELaAowy79X/3QRseZ75yJA8/tz+y
GT0x69fDQDxu0ffC961CY8p0a0F3ByVAqXBmsrCXPj0KxfutOkB8xE1BXY6+oUg/
ciqe0geXabmD9mu+3z8AXWOsFBnyFzsgSa2Dx5CRJ4/w5jhYOIg9/l8GGDlP6p1R
kHfiGYC2OzyxM4IgKYvc5p/VbAA4Ub5aQsWBdMYahAbs+l1xQ7zUEALf5S8c0KHK
k8jJo+oo+ghWzm6ikMfn96Ko/0vQuKG+uZZtzBDVp0uHBEW135GmZV5PCOh89M2k
yMuZQnbcTpEaANvWYJDkH3Can6Afcuki/i9kOK8bDib4Exo3IBijZNsLzpUzeS0m
vnsEqLL9IDRJR54ibQOC
=5n96
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
