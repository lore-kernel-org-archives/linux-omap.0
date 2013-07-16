From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Tue, 16 Jul 2013 03:10:45 +0200
Message-ID: <2883016.87pKJk9n0R@avalon>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2172485.AZTjvkLGcM@avalon> <51E015E1.2090906@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50820 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab3GPBKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 21:10:04 -0400
In-Reply-To: <51E015E1.2090906@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Stephen,

On Friday 12 July 2013 08:42:41 Stephen Warren wrote:
> On 07/12/2013 05:01 AM, Laurent Pinchart wrote:
> > On Thursday 11 July 2013 14:06:44 Stephen Warren wrote:
> >> On 07/11/2013 01:32 PM, Thierry Reding wrote:
> >>> On Thu, Jul 11, 2013 at 11:50:48AM -0600, Stephen Warren wrote:
> >>>> On 07/11/2013 09:36 AM, Thierry Reding wrote:
> >>>>> On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart
> >>>>> wrote: [...]
> >>>>> 
> >>>>>> diff --git
> >>>>>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> >>>>>> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> >>>>>> index de0eaed..be09be4 100644 ---
> >>>>>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> >>>>>> +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> >>>>>> @@ -4,9 +4,9 @@ Required properties: - compatible: should be
> >>>>>> "atmel,tcb-pwm" - #pwm-cells: Should be 3.  The first cell
> >>>>>> specifies the per-chip index of the PWM to use, the second
> >>>>>> cell is the period in nanoseconds and -  bit 0 in the third
> >>>>>> cell is used to encode the polarity of PWM output. -  Set bit
> >>>>>> 0 of the third cell in PWM specifier to 1 for inverse
> >>>>>> polarity & -  set to 0 for normal polarity. +  the third cell
> >>>>>> is used to encode the polarity of PWM output. Set the +
> >>>>>> PWM_POLARITY_NORMAL flag for normal polarity or the
> >>>>>> PWM_POLARITY_INVERSED +  flag for inverted polarity. PWM
> >>>>>> flags are defined in <dt-bindings/pwm/pwm.h>. - tc-block: The
> >>>>>> Timer Counter block to use as a PWM chip.
> >>>>> 
> >>>>>> Example:
> >>>>> I'd prefer for the original text to stay in place and the reference to
> >>>>> the dt-bindings/pwm/pwm.h file to go below that block.
> >>>> 
> >>>> I disagree here. The whole point of creating header files for the
> >>>> constants in binding definitions was so that you wouldn't have to
> >>>> duplicate all the values into the binding definitions. Rather, you'd
> >>>> simply say "see <dt-bindings/xxx.h>".
> >>> 
> >>> But that's not something that this patch solves.
> >> 
> >> Well, if the comments I made on the patch re: that <linux/pwm.h> should
> >> simply #include <dt-bindings/pwm/pwm.h> instead of duplicating the
> >> constants, then yet this patch will solve that. There will be a single
> >> place where the constants are defined.
> > 
> > As explained in another reply, this would require replacing the enum with
> > an unsigned int. I can write a patch if we agree on this.
> > 
> >>> And it could be solved even in the absence of the header file defining
> >>> the symbolic constants. If all the standard flags that
> >>> dt-bindings/pwm/pwm.txt now specifies were to be listed in pwm.txt (they
> >>> actually are) then referring to that document as the canonical source
> >>> works equally well.
> >> 
> >> If that's all the happens, then there will still be duplication
> >> between pwm.txt and <linux/pwm.h>.
> > 
> > I've explicitly mentioned the flags in individual DT bindings to ease
> > adding new flags in the future. At the moment the defined flags are
> > either all supported or not used at all by drivers. If we later add a new
> > flag supported by a subset of drivers only the driver bindings should
> > list supported flags for each driver.
> > 
> > I'm fine with removing the explicit mentions of individual flags right now
> > and adding it back when needed if you think that's better.
> 
> I think the values for any common system-wide flags should be defined
> once in some system-wide place, and the values for any HW-specific
> values should be defined only in the documentation for that specific HW.
> You could try and avoid conflicts by either:
> 
> a) Allocating system-wide flags from bit 0 up, and HW-specific flags
> from bit 31 down.
> 
> or:
> 
> b) Using 1 cell for standard flags, and a separate cell for any
> HW-specific flags. Drivers can quite easily adapt to adding extra cells
> to #pwm-cells, thus making adding a HW-specific cell later
> backwards-compatible.

I wasn't referring to HW-specific flags, but rather to system-wide flags that 
might not be supported by all drivers. If we later add new system-wide flags I 
think the individual DT bindings should explicitly document which flags they 
support.

-- 
Regards,

Laurent Pinchart

