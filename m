From: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Subject: Re: AM335x USB DMA seems broken on ISOC URBs
Date: Sat, 18 Jan 2014 16:12:24 +0100
Message-ID: <52DA99D8.8010003@zonque.org>
References: <20131222055945.GA7194@localhost> <20140117162723.GB3843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140117162723.GB3843@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ezequiel,

On 01/17/2014 05:27 PM, Ezequiel Garcia wrote:
> On Sun, Dec 22, 2013 at 02:59:45AM -0300, Ezequiel Garcia wrote:
>> Hello,
>>
>> While doing some experiments with the stk1160 driver (for "Easycap" TV video
>> capture devices), ran into problems using v3.13-rc4. The problem is that the
>> stk1160 IRQ handler receives no URBs at all.
>>
>> When configuring with CONFIG_MUSB_PIO_ONLY this looks solved, but the
>> bandwidth requirements are too large for PIO (it's a raw video device) and the
>> video can't get captured.
>>
>> Interesting enough, using an old backported for v3.2 stk1160 driver, this same
>> setup works with TI PSP v3.2 kernel. So, I guess it's some software bug in
>> either the cppi41 dmaengine or the musb.
>>
>> I tried to compare the PSP to the mainline drivers but they seems *very*
>> different and really beyond my understanding.
>>
>> Any ideas on how can I help debugging this?
>>
> 
> Ping? It would be good to hunt thig bug down. The TI PSP provided USB driver
> works fine so at least that's a starting point...
> 

Did you try this with a different type of peripheral hardware, a USB
audio device for example? You could also check whether the packets are
actually received by the DMA driver but dropped before the USB subsys
gets to see them for whatever reason.

Let me know if you find anything - I hope to find some time to do
similar tests on AM33xx based hardware.


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
