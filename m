From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 9/9] usb: dwc3: core: don't break during suspend/resume
 while we're dual-role
Date: Thu, 3 Sep 2015 17:02:21 +0300
Message-ID: <55E852ED.8060006@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-10-git-send-email-rogerq@ti.com>
 <20150902144812.GJ8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902144812.GJ8299@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:48, Felipe Balbi wrote:
> On Wed, Sep 02, 2015 at 05:24:24PM +0300, Roger Quadros wrote:
>> We can't rely just on dr_mode to decide if we're in host or gadget
>> mode when we're configured as otg/dual-role. So while dr_mode is
>> OTG, we find out from  the otg state machine if we're in host
>> or gadget mode and take the necessary actions during suspend/resume.
>>
>> Also make sure that we disable OTG irq and events during system suspend
>> so that we don't lockup the system during system suspend/resume.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/core.c | 27 +++++++++------------------
>>  1 file changed, 9 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 654aebf..25891e3 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1455,18 +1455,15 @@ static int dwc3_suspend(struct device *dev)
>>  		dwc->octl = dwc3_readl(dwc->regs, DWC3_OCTL);
>>  		dwc->oevt = dwc3_readl(dwc->regs, DWC3_OEVT);
>>  		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
>> +		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
>> +		disable_irq(dwc->otg_irq);
> 
> you don't need disable_irq() here. In fact, it causes problems since
> you're calling it with IRQs disabled.

OK. will remove it.

> 
>>  	}
>>  
>> -	switch (dwc->dr_mode) {
>> -	case USB_DR_MODE_PERIPHERAL:
>> -	case USB_DR_MODE_OTG:
>> +	if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
>> +	    ((dwc->dr_mode == USB_DR_MODE_OTG) && (dwc->fsm->protocol == PROTO_GADGET)))
>>  		dwc3_gadget_suspend(dwc);
>> -		/* FALLTHROUGH */
>> -	case USB_DR_MODE_HOST:
>> -	default:
>> -		dwc3_event_buffers_cleanup(dwc);
>> -		break;
>> -	}
>> +
>> +	dwc3_event_buffers_cleanup(dwc);
>>  
>>  	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>> @@ -1506,18 +1503,12 @@ static int dwc3_resume(struct device *dev)
>>  		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
>>  		dwc3_writel(dwc->regs, DWC3_OEVT, dwc->oevt);
>>  		dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
>> +		enable_irq(dwc->otg_irq);
>>  	}
>>  
>> -	switch (dwc->dr_mode) {
>> -	case USB_DR_MODE_PERIPHERAL:
>> -	case USB_DR_MODE_OTG:
>> +	if (dwc->dr_mode == USB_DR_MODE_PERIPHERAL ||
>> +	    ((dwc->dr_mode == USB_DR_MODE_OTG) && (dwc->fsm->protocol == PROTO_GADGET)))
>>  		dwc3_gadget_resume(dwc);
>> -		/* FALLTHROUGH */
>> -	case USB_DR_MODE_HOST:
>> -	default:
>> -		/* do nothing */
>> -		break;
>> -	}
>>  
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>>  
>> -- 
>> 2.1.4
>>
> 

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6FLtAAoJENJaa9O+djCTxnMQANGOTEBjO8E9v32qfrgwL6X+
VyTeGBHhfwv7/u7xOM0im6tfXXaLtjj16mEY8fePC+oXO2Vv3RDxi0HTiF6sePnT
odt8nTOYGq7arPAKrtL8BK/8xyJRDjijXWGdQDAgPT1D5V2y8Ib4AbkM2j5IkL+/
75EGybhxIPNGNEV2eS/OBn2BPWSzn/r6rFMJiuYPY2yoPQqwG1ovdt+K+tvMybvZ
sYdQxu4UPN1z1pKplmCQxmPut9SyCqIAeHXdWGT6kJsleBsv2WNM1ZdM/y4zZmMw
gpyNOs+HYqdd/llfEYFrSRnSM2io2GyKZ73xM+DVfY8ot7Vf/h4x41Dz4V19jqtC
3IoyPzNb+inbsRKs0GhTw3yD9N8b7xRbVF+qZPIvDvn7QGLF2pY8cDiqZE1LiOs2
VpKBRoC0wdmdQ/bjRMt516jFmJiQ2RbR2SenGffIr+PrCb1EQ7Fmwtoya5FPgIz/
nMdL7g1MGHUzWvzXTYO+RH4bHV9cDL66qekOL7PR1yEyAAo09vLc+ds/4z85MGQ6
2JYKYb4Mdtv2EAOzIqNR3+FzcCawpZbhm8bBFz14Kj12pgjwl5A3o+fYaZ4Q07OK
ZfFRAUG4RKFNVcjb7hhiBPdN+mb34/50YreFcNj/MOYwklXwUAmgiTFH7cjO9SA7
XZpbfSRwT4Ec4WWqTeeR
=unNn
-----END PGP SIGNATURE-----
