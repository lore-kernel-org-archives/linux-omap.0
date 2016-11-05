From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] rtc: omap: Fix selecting external osc
Date: Sat, 5 Nov 2016 03:35:41 +0100
Message-ID: <20161105023541.udo27ehloo22mtlq@piout.net>
References: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCKYNX7Y3IMBB7UK6XAAKGQEI5FMHBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1477547846-5335-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 27/10/2016 at 11:27:25 +0530, Keerthy wrote :
> From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> 
> RTC can be clocked from an external 32KHz oscillator, or from the
> Peripheral PLL. The RTC has an internal oscillator buffer to support
> direct operation with a crystal.
> 
>             ----------------------------------------
>             |       Device          ---------       |
>             |                       |       |       |
>             |                       | RTCSS |       |
>             |       ---------       |       |       |
>     OSC     |<------| RTC   |       |       |       |
>             |------>| OSC   |---    |       |       |
>             |       --------   |    |       |       |
>             |                   ----|clk    |       |
>             |       --------   |    |       |       |
>             |       | PRCM  |---    |       |       |
>             |       --------        --------        |
>             ----------------------------------------
> 
> The RTC functional clock is sourced by default from the clock derived
> from the Peripheral PLL. In order to select source as external osc clk
> the following changes needs to be done:
> - Enable the RTC OSC (RTC_OSC_REG[4]OSC32K_GZ = 0)
> - Enable the clock mux(RTC_OSC_REG[6]K32CLK_EN = 1)
> - Select the external clock source (RTC_OSC_REG[3]32KCLK_SEL = 1)
> 
> Fixes: 399cf0f63f6f2 ("rtc: omap: Add external clock enabling support")
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
> 
> Boot tested and checked for rtc ticking on am335x-boneblack, am335x-bone
> am437x-gp-evm, dra7-evm, dra72-evm.
> 
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
Both applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
