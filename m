From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Tue, 3 May 2016 17:30:33 +0530
Message-ID: <572892E1.90600@ti.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
 <570C04C1.40201@hurleysoftware.com> <570D2A46.2050106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570D2A46.2050106@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 04/12/2016 10:33 PM, Sebastian Andrzej Siewior wrote:
> On 04/11/2016 10:10 PM, Peter Hurley wrote:
>> On 04/11/2016 11:31 AM, Sebastian Andrzej Siewior wrote:
>>> On 04/11/2016 07:53 PM, Peter Hurley wrote:
>>>> On 04/11/2016 01:18 AM, John Ogness wrote:
>>>>> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>>> On 03/31/2016 01:41 AM, John Ogness wrote:

[...]

>> *am335x*
> 
> I am not sure if the limitations are based on the DMA engine or the
> 
>> - requires write to tx fifo to trigger tx dma (ie. OMAP_DMA_TX_KICK
>>   workaround necessitating completely different tx dma completion handler)
> 
> This one for instance I don't see on BeagleBoard xM / omap36xx and
> DRA7x. Both (not affected) use SDMA instead EDMA. It would be
> interesting to see if DRA7x is affected once it uses EDMA.
> 

8250 UART DMA works fine with EDMA as the DMA engine.
As per my testing, am335x + EDMA, am437x + EDMA, dra7xx + EDMA and
dra72x + EDMA require OMAP_DMA_TX_KICK quirk. However when using SDMA
OMAP_DMA_TX_KICK is not needed (I tested on dra7xx platform). So, it can
be concluded that when using EDMA with 8250 UART tx kick is needed.



-- 
Regards
Vignesh
