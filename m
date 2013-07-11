From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 14:06:44 -0600
Message-ID: <51DF1054.9000207@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com> <51DEF078.1010408@wwwdotorg.org> <20130711193245.GB17212@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60779 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab3GKUGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 16:06:48 -0400
In-Reply-To: <20130711193245.GB17212@dhcp-172-17-186-34.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 01:32 PM, Thierry Reding wrote:
> On Thu, Jul 11, 2013 at 11:50:48AM -0600, Stephen Warren wrote:
>> On 07/11/2013 09:36 AM, Thierry Reding wrote:
>>> On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart
>>> wrote: [...]
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt 
>>>> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
>>>> index de0eaed..be09be4 100644 --- 
>>>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
>>>> +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
>>>> @@ -4,9 +4,9 @@ Required properties: - compatible: should be 
>>>> "atmel,tcb-pwm" - #pwm-cells: Should be 3.  The first cell 
>>>> specifies the per-chip index of the PWM to use, the second
>>>> cell is the period in nanoseconds and -  bit 0 in the third
>>>> cell is used to encode the polarity of PWM output. -  Set bit
>>>> 0 of the third cell in PWM specifier to 1 for inverse
>>>> polarity & -  set to 0 for normal polarity. +  the third cell
>>>> is used to encode the polarity of PWM output. Set the +
>>>> PWM_POLARITY_NORMAL flag for normal polarity or the
>>>> PWM_POLARITY_INVERSED +  flag for inverted polarity. PWM
>>>> flags are defined in <dt-bindings/pwm/pwm.h>. - tc-block: The
>>>> Timer Counter block to use as a PWM chip.
>>>> 
>>>> Example:
>>> 
>>> I'd prefer for the original text to stay in place and the
>>> reference to the dt-bindings/pwm/pwm.h file to go below that
>>> block.
>> 
>> I disagree here. The whole point of creating header files for
>> the constants in binding definitions was so that you wouldn't
>> have to duplicate all the values into the binding definitions.
>> Rather, you'd simply say "see <dt-bindings/xxx.h>".
> 
> But that's not something that this patch solves.

Well, if the comments I made on the patch re: that <linux/pwm.h>
should simply #include <dt-bindings/pwm/pwm.h> instead of duplicating
the constants, then yet this patch will solve that. There will be a
single place where the constants are defined.

> And it could be solved even in the absence of the header file
> defining the symbolic constants. If all the standard flags that
> dt-bindings/pwm/pwm.txt now specifies were to be listed in pwm.txt
> (they actually are) then referring to that document as the
> canonical source works equally well.

If that's all the happens, then there will still be duplication
between pwm.txt and <linux/pwm.h>.

> If we can take both of the above for granted, then sure, let's
> refer to the header from within the generic pwm.txt file and add a
> reference to that in bindings for drivers that use the standard
> flags.
> 
>>> Another issue might be that people without access to recent 
>>> versions of DTC won't be able to use the new #include feature,
>>> so keeping the documentation backwards compatible seems like a
>>> good idea.
>> 
>> The dtc source tree is duplicated into the kernel source tree, so
>> that isn't an issue for now.
>> 
>> Besides, the dtc version is an entirely unrelated issue to how
>> the documentation is written.
> 
> Well, not really. If the documentation specifies the binding in a
> way that the DTC can't handle that's still a problem. People will
> end up with a DTS that their DTC can't compile. I guess that can be
> resolved by adding a note to the upstream device tree repository
> about the minimum required version of DTC.

Yes, the separate repository would obviously require a version of dtc
that's able to compile the files there; i.e. a version equivalent to
what's already in the kernel tree (upstream 1.4.0 specifically).

Again, right now, all of the binding docs, the *.dts files, and the
dtc required to use them are part of the kernel; a single package, so
there's no scope for issues re: using dtc features that aren't
supported. If those components get separated later, obviously there
will be a requirement to install a specific version of dtc to use with
the separated *.dts and binding files.
