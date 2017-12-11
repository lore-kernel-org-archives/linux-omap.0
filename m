From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7: Disable USB metastability workaround for
 USB2
Date: Mon, 11 Dec 2017 08:47:31 -0800
Message-ID: <20171211164731.GL24344@atomide.com>
References: <1509456360-2638-1-git-send-email-rogerq@ti.com>
 <87r2sau3fo.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r2sau3fo.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@kernel.org> [171204 11:43]:
> Roger Quadros <rogerq@ti.com> writes:
> 
> > The metastability workaround causes Erratic errors [1]
> > on the HighSpeed USB PHY which can cause upto 2 seconds
> > delay in enumerating to a USB host while in Gadget mode.
> >
> > Disable the Run/Stop metastability workaround to avoid this
> > ill effect. We are aware that this opens up the opportunity
> > for Run/Stop metastability, however this issue has never been
> > observed in TI releases so we think that Run/Stop metastability
> > is a lesser evil than the PHY Erratic errors. So disable it.
> >
> > [1] USB controller trace during gadget enumeration
> >     irq/90-dwc3-969   [000] d...    52.323145: dwc3_event: event (00000901): Erratic Error [U0]
> >     irq/90-dwc3-969   [000] d...    52.560646: dwc3_event: event (00000901): Erratic Error [U0]
> >     irq/90-dwc3-969   [000] d...    52.798144: dwc3_event: event (00000901): Erratic Error [U0]
> >
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> FWIW:
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux/intel.com>
> 
> I'm taking the dwc3 counterpart to v4.16

OK applying this into omap-for-v4.16/dt thanks.

Tony
