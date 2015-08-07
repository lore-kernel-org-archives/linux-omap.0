From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 18:20:44 +0200
Message-ID: <55C4DADC.9070004@linutronix.de>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <20150807132241.GN7576@n2100.arm.linux.org.uk> <55C4B5AE.10309@linutronix.de> <20150807135727.GP7576@n2100.arm.linux.org.uk> <55C4CA00.3060206@hurleysoftware.com> <20150807152939.GQ7576@n2100.arm.linux.org.uk> <55C4D7AF.8060305@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C4D7AF.8060305@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 06:07 PM, Peter Hurley wrote:
>> If we look at what 8250-dma.c is doing:
>>
>>                 if (dma->rx_running) {
>>                         dmaengine_pause(dma->rxchan);
>>
>> It's 8250-dma.c which is silently _ignoring_ the return code, failing
>> to check that the operation it requested worked.  Maybe this should be
>> WARN_ON(dmaengine_pause(dma->rxchan)) or at least it should print a
>> message?
> 
> Thanks for the suggestion; I'll hold on to that and push it after we add
> the 8250 omap dma pause in mainline.

I have a patch ready with WARN_ON_ONCE() for 8250-omap and 8250-dma.
This warning would trigger on am335x/edma until v4.2-rc1 and omap-dma
based version is open. I could post it if you want me to.
Besides that those two, there are four other drivers ignoring the
return code dmaengine_pause().

Sebastian
