From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 15:33:55 -0400
Message-ID: <a0580c510809031233x452968f5g84311eb694cdde45@mail.gmail.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
	 <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com>
	 <20080903184804.GA1788@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:63174 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYICTd4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 15:33:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2064113waf.23
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 12:33:55 -0700 (PDT)
In-Reply-To: <20080903184804.GA1788@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 3, 2008 at 2:48 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> On Wed, Sep 03, 2008 at 11:33:51AM -0400, Eduardo Valentin wrote:
>> > @@ -159,7 +159,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
>> >  #ifdef CONFIG_ARCH_OMAP15XX
>> >  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>> >        {
>> > -               .virt_base      = OMAP1510_MCBSP1_BASE,
>> > +               .virt_base      = OMAP1510_MCBSP1_BASE, /* FIXME: virtual or physical */
>> AFAIK, OMAP1510_MCBSP1_BASE is physical. So, I'd say:
>> +               .virt_base      = IO_ADDRESS(OMAP1510_MCBSP1_BASE),
>>
>> Because, plat-omap/mcbsp.c expect .virt_base to be a virtual address.
>
> Ok, I'll fix these which you've confirmed in my version for mainline.
>
>> > @@ -701,6 +702,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>> >        omap_set_dma_dest_params(mcbsp->dma_tx_lch,
>> >                                 src_port,
>> >                                 OMAP_DMA_AMODE_CONSTANT,
>> > +                                /* FIXME: this is a virtual address */
>> >                                 mcbsp->io_base + OMAP_MCBSP_REG_DXR1,
>>
>> yes, that's true. This is expected to be virtual (mcbsp->io_base).
>
> Don't you mean that it is expected to be physical?
>

Well, correct me if I'm wrong, but I meant that the result of
 mcbsp->io_base + OMAP_MCBSP_REG_DXR1

is supposed to be virtual.

Because the mcbsp->io_base reference comes directly from virt_base field of platform_data.

At least it is what says line 895 of plat-omap/mcbsp.c.

And that's why we need to use IO_ADDRESS  while filling up platform_data,
as mentioned above.

> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
>

Cheers,

-- 
Eduardo Bezerra Valentin


