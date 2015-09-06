From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Sun, 6 Sep 2015 10:20:40 +0800
Message-ID: <20150906022040.GC4914@shlinux2>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
 <20150902144338.GG8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150902144338.GG8299@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 02, 2015 at 09:43:38AM -0500, Felipe Balbi wrote:
> Hi,
> 
> > +
> > +static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
> > +{
> > +	struct dwc3 *dwc = _dwc;
> > +	irqreturn_t ret = IRQ_NONE;
> > +	u32 reg;
> > +
> > +	spin_lock(&dwc->lock);
> 
> this seems unnecessary, we're already in hardirq with IRQs disabled.
> What sort of race could we have ? (in fact, this also needs change in
> dwc3/gadget.c).
> 

Is it possible the kernel process is accessing the content you will 
access?

-- 

Best Regards,
Peter Chen
