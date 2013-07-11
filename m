From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 11:50:48 -0600
Message-ID: <51DEF078.1010408@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:38529 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab3GKRux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 13:50:53 -0400
In-Reply-To: <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 09:36 AM, Thierry Reding wrote:
> On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart wrote: 
> [...]
>> diff --git
>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
>> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt index
>> de0eaed..be09be4 100644 ---
>> a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt +++
>> b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt @@ -4,9
>> +4,9 @@ Required properties: - compatible: should be
>> "atmel,tcb-pwm" - #pwm-cells: Should be 3.  The first cell
>> specifies the per-chip index of the PWM to use, the second cell
>> is the period in nanoseconds and -  bit 0 in the third cell is
>> used to encode the polarity of PWM output. -  Set bit 0 of the
>> third cell in PWM specifier to 1 for inverse polarity & -  set to
>> 0 for normal polarity. +  the third cell is used to encode the
>> polarity of PWM output. Set the +  PWM_POLARITY_NORMAL flag for
>> normal polarity or the PWM_POLARITY_INVERSED +  flag for inverted
>> polarity. PWM flags are defined in <dt-bindings/pwm/pwm.h>. -
>> tc-block: The Timer Counter block to use as a PWM chip.
>> 
>> Example:
> 
> I'd prefer for the original text to stay in place and the reference
> to the dt-bindings/pwm/pwm.h file to go below that block.

I disagree here. The whole point of creating header files for the
constants in binding definitions was so that you wouldn't have to
duplicate all the values into the binding definitions. Rather, you'd
simply say "see <dt-bindings/xxx.h>".

A comment on the original patch:

You're creating <dt-bindings/pwm/pwm.h>. That filename sounds entirely
generic, as if the values are defining something PWM-wide rather than
specific to individual PWM bindings. As such, I think the text in each
individual binding should simply say something like:

-----
the third cell encodes standard PWM flags, as defined in
<dt-bindings/pwm/pwm.h>.
-----

Similarly, pwm.txt should mention that standard flags exist, and refer
to that same file for definitions.

> The reason is that perhaps somebody will look at an older version
> of a given DT (with the numerical value) and not have access to the
> include and therefore not know which flag was being set by just
> looking at the documentation.

It's pretty trivial to find the header that defines the values; just
grab the latest source. If you're looking at an old version of the
.dts file, it's almost certain that's within the context of an old
Linux kernel soruce tree, in which case you trivially have access to
the old version of the binding document that spelled out the values.

> I'm also not sure about what the plans are with respect to
> shipping device trees in a separate repository and if they are,
> whether that repository would ship the includes as well.

It would have to. That separate repository would be upstream for
<dt-bindings/> files, which would be imported into the kernel
periodically as drivers wanted to make use of any new headers/values
defined there.

> Another issue might be that people without access to recent
> versions of DTC won't be able to use the new #include feature, so
> keeping the documentation backwards compatible seems like a good
> idea.

The dtc source tree is duplicated into the kernel source tree, so that
isn't an issue for now.

Besides, the dtc version is an entirely unrelated issue to how the
documentation is written.

> Perhaps the include file should even only be mentioned in the
> general PWM binding documentation.

I wondered about that too. It's slightly indirect in that you'd read
foo-pwm.txt which would say something like:

-----
the third cell encodes standard PWM flags, as defined by the core PWM
binding in pwm.txt in this directory.
-----

and pwm.txt would say:

-----
The PWM specifier should include a flags cell to contain standard PWM
flags. Values for that cell are defined in <dt-bindings/pwm/pwm.h>.
-----

Which is somewhat like following a lot of symlinks. Still, I agree
that's arguably the correct thing to do.
