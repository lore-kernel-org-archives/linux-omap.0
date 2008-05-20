From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Wed, 21 May 2008 08:18:05 +0900
Message-ID: <9c9fda240805201618y43d65160h246ea69a43785515@mail.gmail.com>
References: <alpine.DEB.1.00.0805201220090.9463@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:22040 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbYETXSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 19:18:06 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1955866wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2008 16:18:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805201220090.9463@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, lethal@linux-sh.org

On Wed, May 21, 2008 at 3:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Simplify the IRQ register/IRQ register bit calculations in
> mach-omap2/irq.c.
>
> Test-booted on 3430SDP.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>
> ---
>
> size:
>   text    data     bss     dec     hex filename
> 3341347  170992  109008 3621347  3741e3 vmlinux.3430sdp
> 3341315  170992  109008 3621315  3741c3 vmlinux.3430sdp.patched
>
> ---
>
>  arch/arm/mach-omap2/irq.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
>
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index ac062ee..f610825 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -27,6 +27,9 @@
>  #define INTC_MIR_CLEAR0        0x0088
>  #define INTC_MIR_SET0  0x008c
>
> +/* Number of IRQ state bits in each MIR register */
> +#define IRQ_BITS_PER_REG       32
> +
>  /*
>  * OMAP2 has a number of different interrupt controllers, each interrupt
>  * controller is identified as its own "bank". Register definitions are
> @@ -67,24 +70,18 @@ static void omap_ack_irq(unsigned int irq)
>
>  static void omap_mask_irq(unsigned int irq)
>  {
> -       int offset = (irq >> 5) << 5;
> +       int offset = irq & (~(IRQ_BITS_PER_REG - 1));
>
> -       if (irq >= 64)
> -               irq %= 64;
> -       else if (irq >= 32)
> -               irq %= 32;
> +       irq %= IRQ_BITS_PER_REG;

Is it the right conversion?
If the irq is greater then 32 and less then or equal to  64 it's
result is different.
E.g, If irq is 63 then original irq is 63, but new code is 31

And if this code is right, how about to use mask instead of modulo op?
irq &= (IRQ_BITS_PER_REG - 1);

Thank you,
Kyungmin Park
