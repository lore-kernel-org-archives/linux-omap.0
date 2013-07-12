From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Fri, 12 Jul 2013 12:41:57 +0200
Message-ID: <3211864.2dENa1E110@avalon>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51DEEE15.7040801@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54168 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab3GLKlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 06:41:22 -0400
In-Reply-To: <51DEEE15.7040801@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Stephen,

On Thursday 11 July 2013 11:40:37 Stephen Warren wrote:
> On 07/11/2013 08:37 AM, Laurent Pinchart wrote:
> > Define PWM_POLARITY_NORMAL and PWM_POLARITY_INVERTED macros in
> > include/dt-bindings/pwm/pwm.h to be used by device tree sources.
> > 
> >  Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt |  6 +++---
> >  Documentation/devicetree/bindings/pwm/pwm-samsung.txt   |  5 +++--
> >  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  5 +++--
> >  Documentation/devicetree/bindings/pwm/pwm.txt           |  8 +++++---
> >  Documentation/devicetree/bindings/pwm/vt8500-pwm.txt    |  5 +++--
> >  arch/arm/boot/dts/am335x-evm.dts                        |  3 ++-
> >  arch/arm/boot/dts/am335x-evmsk.dts                      |  3 ++-
> >  arch/arm/boot/dts/wm8850-w70v2.dts                      |  3 ++-
> >  include/dt-bindings/pwm/pwm.h                           | 15 ++++++++++++
> >  include/linux/pwm.h                                     |  4 ++--
> 
> I think this needs to be separate patches; at least the new pwm.h should
> be introduced separately to the board-specific *.dts edits, and perhaps
> further split up?

What about splitting it in three patches that

- add the include/dt-bindings/pwm/pwm.h header, and update include/linux/pwm.h 
and Documentation/devicetree/bindings/pwm/pwm.txt

- update the rest of the documentation

- update the .dts files

> That way, the one patch that introduces <dt-bindings/pwm.h> would be
> available to be merged into any other tree that wanted to take patches
> to use the new defines.
> 
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > 
> >  enum pwm_polarity {
> > 
> > -	PWM_POLARITY_NORMAL,
> > -	PWM_POLARITY_INVERSED,
> > +	PWM_POLARITY_NORMAL = 0,
> > +	PWM_POLARITY_INVERSED = 1,
> > 
> >  };
> 
> Rather than manually editing that to ensure the enum matches the DT bindings
> header, the whole point of making a separate <dt-bindings/...> directory was
> that drivers could include the binding header files directly to avoid having
> to duplicate the constant definitions. Can't <linux/pwm.h> include <dt-
> bindings/pwm.h> and remove that enum?

We could do that, but we would then need to modify all drivers to replace 
enum_pwm_polarity with unsigned int. Thierry, what's your opinion on this ?

Replying to a comment from another e-mail, I know that the above change to 
include/linux/pwm.h is not strictly needed as the enum values are already 
correct. The point of specifying the enum values explicitly was to hint that 
the values matter and should not be changed. A comment in the source would 
probably be more appropriate though.

-- 
Regards,

Laurent Pinchart

