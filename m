From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/2] musb: add musb support for AM35x
Date: Fri, 26 Mar 2010 22:29:10 +0300
Message-ID: <4BAD0B06.60901@ru.mvista.com>
References: <1267017527-17591-1-git-send-email-ajay.gupta@ti.com> <4B9A560B.7010908@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044DD3311F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63384 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0CZT3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 15:29:51 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD3311F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Gupta, Ajay Kumar wrote:

>>> AM35x has musb interface and uses CPPI4.1 DMA engine.
>>> Current patch supports only PIO mode and there are on-going
>>> discussions on location of CPPI4.1 DMA.
>>>
>>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>>>  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
>>> @@ -140,7 +140,7 @@ config USB_MUSB_HDRC_HCD
>>>  config MUSB_PIO_ONLY
>>>  	bool 'Disable DMA (always use PIO)'
>>>  	depends on USB_MUSB_HDRC
>>> -	default y if USB_TUSB6010
>>> +	default USB_TUSB6010 || MACH_OMAP3517EVM
>>>  	help
>>>  	  All data is copied between memory and FIFO by the CPU.
>>>  	  DMA controllers are ignored.
>>> diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
>>> index 85710cc..9263033 100644
>>> --- a/drivers/usb/musb/Makefile
>>> +++ b/drivers/usb/musb/Makefile
>>> @@ -19,7 +19,11 @@ ifeq ($(CONFIG_ARCH_OMAP2430),y)
>>>  endif
>>>
>>>  ifeq ($(CONFIG_ARCH_OMAP3430),y)
>>> +   ifeq ($(CONFIG_MACH_OMAP3517EVM),y)
>>> +	musb_hdrc-objs  += am3517.o
>>>
>>>       
>>    Isn't there some ARCH-level option for AM3517 SoC? Depending on the
>> board type doesn't really scale well...
>>     
>
> AM3517 is actually based on OMAP3 but musb is different. Unfortunately there
> is no seperate *_ARCH_* defines for AM3517 alone.
>   

   I would really consider adding such... in the current situation the 
thing won't scale with addition of some new AM35x boards.

>>> +static inline void phy_on(void)
>>> +{
>>> +	u32 devconf2;
>>> +
>>> +	/*
>>> +	 * Start the on-chip PHY and its PLL.
>>> +	 */
>>> +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>>> +
>>> +	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN |
>>> +			CONF2_OTGMODE | CONF2_REFFREQ | CONF2_PHY_GPIOMODE);
>>>
>>>       
>>    Shouldn't you manipulate CONF2_OTGMODE in the board code instead? I
>> suspect value of 0 doesn't fit the host-only configuration (without
>> cable connected, MUSB will think it's a B-device, and the driver will
>> fail to initialize IIRC).
>>     

   It will fail to power the port to be precise, so that when you 
finally connect a device, it won't get detected. Note that the comments 
in musb_core.c twice say that the driver expects ID pin to be *forcibly 
grounded* for the host-only mode while CONF2_OTGMODE's value of 0 will 
leave it floating.

> I didn't see any issue in Host/Device only and OTG mode configurations
> On AM3517? Did you see any issue on DA8xx?
>   

   Certainly still seeing it with OTGMODE=0 setting in the host mode -- 
see above.

>>> +/**
>>> + * musb_platform_enable - enable interrupts
>>> + */
>>> +void musb_platform_enable(struct musb *musb)
>>> +{
>>> +	void __iomem *reg_base = musb->ctrl_base;
>>> +	u32 epmask, coremask;
>>> +
>>> +	/* Workaround: setup IRQs through both register sets. */
>>> +	epmask = ((musb->epmask & AM3517_TX_EP_MASK) << USB_INTR_TX_SHIFT) |
>>> +	       ((musb->epmask & AM3517_RX_EP_MASK) << USB_INTR_RX_SHIFT);
>>> +	coremask = (0x01ff << USB_INTR_USB_SHIFT);
>>> +
>>> +	musb_writel(reg_base, EP_INTR_MASK_SET_REG, epmask);
>>> +	musb_writel(reg_base, CORE_INTR_MASK_SET_REG, coremask);
>>>
>>>       
>>    Hm, and I thought all CPPI 4.1 based controllers have the same
>> register layout... alas, I was wrong.
>>     
>
> There are changes as AM3517 supports 15Rx/Tx endpoints.
>   

   Yeah, I need to accomodate cppi41_dma.c to the changes by 
externalizing the code accessing the acceleration registers...

>>> +	case OTG_STATE_A_WAIT_VFALL:
>>> +		/*
>>> +		 * Wait till VBUS falls below SessionEnd (~0.2 V); the 1.3
>>> +		 * RTL seems to mis-handle session "start" otherwise (or in
>>> +		 * our case "recover"), in routine "VBUS was valid by the time
>>> +		 * VBUSERR got reported during enumeration" cases.
>>> +		 */
>>>
>>>       
>>    I wonder if all this still true for RTL 1.8 on which DA8xx (and
>> probably AM3517) MUSB is based...
>>     
>
> Need to check on this..though I didn't see any issue in my testing.
>   

   There should be no issues AFAIU, just the code can be made shorter I 
guess...

>>> +void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
>>> +{
>>>
>>>       
>>    I wonder how DaVinci gets about without musb_platfrom_try_idle()...
>>     
>
> Hmm..
>   

   davinci.c should also define musb_platfrom_try_idle() AFAIU... it 
should be no different from DA8xx in this respect.

>>> +	if (ret != IRQ_HANDLED) {
>>> +		if (epintr || usbintr)
>>> +			/*
>>> +			 * We sometimes get unhandled IRQs in the peripheral
>>> +			 * mode from EP0 and SOF...
>>> +			 */
>>> +			DBG(2, "Unhandled USB IRQ %08x-%08x\n",
>>> +					 epintr, usbintr);
>>>
>>>       
>>    This check shouldn't be needed any more -- EP0 spurious interrupts
>> have been all chased down...
>>     
>
> Ok fine.
>   

   However, I seem to have found a new case of unhandled interrupts 
today: when I disconnect a device, all I get is this message:

da8xx_interrupt 405: Unhandled USB IRQ 00280000

The driver failed to sense the disconnect, it's only reported when I 
re-inserted a device... that's something new. Felipe, are you reading this?

>>> +	musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;
>>>
>>>       
>>    Hm... that line kept causing a stream of kernel messages for me,
>> until I removed it. Doesn't it for you?
>>     
>
> No I didn't get any error messages.. what messages were you getting ?
>   

   Cannot reproduce them anymore and don't remember which message it was 
-- perhaps this:

musb_bus_suspend 2221: trying to suspend as a_wait_vrise is_active=1

Then it probably got fixed by:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=89368d3d11a5b2eff83ad8e752be67f77a372bad

Look at the below commit however -- it removed such code from omap2430.c:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f7f9d63eac12b345d6243d1d608b7944a05be921

>> +int musb_platform_exit(struct musb *musb) {  
>>     
> [...]
>   
>> +	phy_off();
>> +
>> +	usb_nop_xceiv_unregister();
>> +
>> +	return 0;  
>>     
>>>   You forgot the calls to clk_disable() for both your clocks...
>>>       

   ... and clk_put() call for the functional clock.

> Ok fine..need to correct.
>
> Thanks,
> Ajay
WBR, Sergei


