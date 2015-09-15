From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Tue, 15 Sep 2015 17:46:26 +0300
Message-ID: <55F82F42.3030401@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
 <20150902144338.GG8299@saruman.tx.rr.com> <20150906022040.GC4914@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150906022040.GC4914@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/09/15 05:20, Peter Chen wrote:
> On Wed, Sep 02, 2015 at 09:43:38AM -0500, Felipe Balbi wrote:
>> Hi,
>>
>>> +
>>> +static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
>>> +{
>>> +	struct dwc3 *dwc = _dwc;
>>> +	irqreturn_t ret = IRQ_NONE;
>>> +	u32 reg;
>>> +
>>> +	spin_lock(&dwc->lock);
>>
>> this seems unnecessary, we're already in hardirq with IRQs disabled.
>> What sort of race could we have ? (in fact, this also needs change in
>> dwc3/gadget.c).
>>
> 
> Is it possible the kernel process is accessing the content you will 
> access?
> 
When kernel process accesses the data we'll never reach here
as we're protecting it with spinlock_irqsave(), spinunlock_irqrestore().

cheers,
-roger
