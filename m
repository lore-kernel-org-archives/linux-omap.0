From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Thu, 19 Mar 2015 21:11:06 +0300
Message-ID: <550B113A.5060405@cogentembedded.com>
References: <1426718882-27187-1-git-send-email-tony@atomide.com> <550ACF61.5000909@cogentembedded.com> <550B0C3C.3080107@cogentembedded.com> <20150319175549.GI31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36760 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbbCSSLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 14:11:10 -0400
Received: by lbblx11 with SMTP id lx11so36759993lbb.3
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 11:11:08 -0700 (PDT)
In-Reply-To: <20150319175549.GI31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>

On 03/19/2015 08:55 PM, Tony Lindgren wrote:

>>>> --- a/drivers/usb/musb/musb_dsps.c
>>>> +++ b/drivers/usb/musb/musb_dsps.c
>>>> @@ -655,6 +655,36 @@ static int dsps_musb_reset(struct musb *musb)
>>>>       return !session_restart;
>>>>   }
>>>>
>>>> +/* Similar to am35x, dm81xx support only 32-bit read operation */
>>>> +static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
>>>> +{
>>>> +    void __iomem *fifo = hw_ep->fifo;
>>>> +    u32        val;
>>>> +    int        i;
>>>> +
>>>> +    /* Read for 32bit-aligned destination address */
>>>> +    if (likely((0x03 & (unsigned long)dst) == 0) && len >= 4) {
>>>> +        readsl(fifo, dst, len >> 2);
>>>> +        dst += len & ~0x03;
>>>> +        len &= 0x03;
>>>> +    }
>>>> +    /*
>>>> +     * Now read the remaining 1 to 3 byte or complete length if
>>>> +     * unaligned address.
>>>> +     */

>>>    This comment seems misplaced, it belongs before the next *if*.

>>>> +    if (len > 4) {
>>>> +        for (i = 0; i < (len >> 2); i++) {
>>>> +            *(u32 *)dst = musb_readl(fifo, 0);
>>>> +            dst += 4;
>>>> +        }

>>>     Not sure how this is different to using readsl().

>>     Ah, the default implementation of musb_readl() uses __raw_readl().
>> So you'd probably want to keep this loop, not readsl() call.

> Not sure I follow you here..

    I just wrongly thought readsl() uses readl() internally. readl() is 
supposed to swap bytes when needed (BE case), while __raw_readl() is not.

> Also include/asm-generic/io.h readsl()
> uses __raw_readl()?

    Looking at the arch/arm/include/asm/io.h, readsl() is equivalent to 
__raw_readsl() too. Forgot about this "asymmetry".

> It seems things work with what I posted, so a readsl() loop, then
> just read the remaining 1 to 3 bytes.

    In LE mode, there would have been no difference anyway.

> Regards,

> Tony

WBR, Sergei

