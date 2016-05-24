From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 24 May 2016 15:35:01 +0300
Message-ID: <57444A75.3050203@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com>
 <877feju7bi.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877feju7bi.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 24/05/16 12:35, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> Implementations might use different IRQs for
>> host, gadget and OTG so use named interrupt resources
>> to allow Device tree to specify the 3 interrupts.
>>
>> Following are the interrupt names
>>
>> Peripheral Interrupt - peripheral
>> HOST Interrupt - host
>> OTG Interrupt - otg
>>
>> We still maintain backward compatibility for a single named
>> interrupt for all 3 interrupts (e.g. for dwc3-pci) and
>> single unnamed interrupt for all 3 interrupts (e.g. old DT).
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> fails to apply, unfortunately:
> 
> checking file drivers/usb/dwc3/core.c
> Hunk #1 succeeded at 845 (offset 31 lines).
> checking file drivers/usb/dwc3/core.h
> Hunk #1 succeeded at 738 (offset 22 lines).
> Hunk #2 FAILED at 818.
> 1 out of 2 hunks FAILED
> checking file drivers/usb/dwc3/gadget.c
> Hunk #1 succeeded at 1710 with fuzz 2 (offset 105 lines).
> Hunk #2 FAILED at 1728.
> Hunk #3 FAILED at 1740.
> Hunk #4 succeeded at 2835 (offset 54 lines).
> 2 out of 4 hunks FAILED
> checking file drivers/usb/dwc3/host.c
> 
> I'll update my testing/next shortly, if you could rebase the remaining
> of these patches on that, I'd be glad.

No Problem Felipe. I'll rebase and re-send this series.

cheers,
-roger
