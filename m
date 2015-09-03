From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 6/9] usb: dwc3: save/restore OTG registers during
 suspend/resume
Date: Thu, 3 Sep 2015 16:54:14 +0300
Message-ID: <55E85106.6090408@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-7-git-send-email-rogerq@ti.com>
 <20150902144432.GH8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902144432.GH8299@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:44, Felipe Balbi wrote:
> On Wed, Sep 02, 2015 at 05:24:21PM +0300, Roger Quadros wrote:
>> Without this we loose OTG controller register context and malfunction
>> after a system suspend-resume.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/core.c | 17 +++++++++++++++++
>>  drivers/usb/dwc3/core.h |  6 +++++-
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 632ee53..684010c 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -56,6 +56,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>>  	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>>  	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
>>  	reg |= DWC3_GCTL_PRTCAPDIR(mode);
>> +	dwc->current_mode = mode;
>>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>>  }
>>  
>> @@ -1443,6 +1444,14 @@ static int dwc3_suspend(struct device *dev)
>>  
>>  	spin_lock_irqsave(&dwc->lock, flags);
>>  
>> +	/* Save OTG state only if we're really using it */
>> +	if (dwc->current_mode == DWC3_GCTL_PRTCAP_OTG) {
>> +		dwc->ocfg = dwc3_readl(dwc->regs, DWC3_OCFG);
>> +		dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
>> +		dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
> 
> oevt is what you use to clear pending IRQs, which means that ...
> 
>> +		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
>> +	}
>> +
>>  	switch (dwc->dr_mode) {
>>  	case USB_DR_MODE_PERIPHERAL:
>>  	case USB_DR_MODE_OTG:
>> @@ -1486,6 +1495,14 @@ static int dwc3_resume(struct device *dev)
>>  	dwc3_event_buffers_setup(dwc);
>>  	dwc3_writel(dwc->regs, DWC3_GCTL, dwc->gctl);
>>  
>> +	/* Restore OTG state only if we're really using it */
>> +	if (dwc->current_mode == DWC3_GCTL_PRTCAP_OTG) {
>> +		dwc3_writel(dwc->regs, DWC3_OCFG, dwc->ocfg);
>> +		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
>> +		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
> 
> ... you could be clearing pending IRQs right here.

Good catch. So we can't really restore this register.
I'll remove this line.

> 
>> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
>> +	}
>> +
>>  	switch (dwc->dr_mode) {
>>  	case USB_DR_MODE_PERIPHERAL:
>>  	case USB_DR_MODE_OTG:
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 129ef37..1115ce0 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -737,6 +737,7 @@ struct dwc3_scratchpad_array {
>>   * @regs: base address for our registers
>>   * @regs_size: address space size
>>   * @oevten: otg interrupt enable mask copy
>> + * @current_mode: current mode of operation written to PRTCAPDIR
>>   * @nr_scratch: number of scratch buffers
>>   * @num_event_buffers: calculated number of event buffers
>>   * @u1u2: only used on revisions <1.83a for workaround
>> @@ -858,9 +859,12 @@ struct dwc3 {
>>  	/* used for suspend/resume */
>>  	u32			dcfg;
>>  	u32			gctl;
>> -
>> +	u32			ocfg;
>> +	u32			octl;
>> +	u32			oevt;
>>  	u32			oevten;
>>  
>> +	u32			current_mode;
>>  	u32			nr_scratch;
>>  	u32			num_event_buffers;
>>  	u32			u1u2;
>> -- 
>> 2.1.4
>>
> 

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6FEGAAoJENJaa9O+djCTE7gP/0rlQJPL1R11k8hJCM842zjT
SSxfdNQ9kkG008D88As8nLodL79agvD/XBot7iIrTGVFMG/tzzkwQb71gZoCOogb
K0eMMnLNyzLRapNpOe1OJqI1NjO8Yx1o7heoaGkGYERR7m6dwz1LmSPYEtaaveVq
5gb5NbUKfSq0Cs6wM+3+U8CQzAPLf7eRSZwiORkzyn7cWiZDsYHr9Bn35NA24r5v
0YMQvmTp7K/7pFENiFHmOWbKPoY6G8ebkInBSMXQfHcLPtL86l9e+VrlJrIZzBqQ
SJyoQw8JFU9c2ojtKeG9AYn8fSbCQpbsuIFAZtCVy2rK4xMiITmaSsjHF5+KpBt2
cE7eahicYAP3edLqT0R0hYfiI+JrVuOdkiW+W8UWPHrGt/nELQjQxZtIkTOI1b9B
FIxnZbIwp0veEE+vqXiTQizUPdZag0qPG1PZ5Bpu0867vfX6khY2MCNeYTDatzHT
dz9RwWIDH3/K5K7TOug/VZEiqvLY3BYMrMK+W3FreGfagwvYvlLyojsHifrA1x9z
1+zAjkml1kIIP5Jlf3VOYdLsN8mgeMyCNfi5USvVFnzPITAjtwm9+ai7xxxCjSxA
QTvmhQRjAxIPWWZgVuc/Z5PdqgHKFKpCLxG8IE9bqGBQnNSKueZHEhfUCxfPNKV6
ZkkhIq/s6hm6S/YM4WcS
=hUag
-----END PGP SIGNATURE-----
