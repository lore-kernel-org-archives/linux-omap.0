From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 11:40:37 -0600
Message-ID: <51DEEE15.7040801@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35124 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352Ab3GKRkp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 13:40:45 -0400
In-Reply-To: <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 07/11/2013 08:37 AM, Laurent Pinchart wrote:
> Define PWM_POLARITY_NORMAL and PWM_POLARITY_INVERTED macros in
> include/dt-bindings/pwm/pwm.h to be used by device tree sources.

>  Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt |  6 +++---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt   |  5 +++--
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  5 +++--
>  Documentation/devicetree/bindings/pwm/pwm.txt           |  8 +++++---
>  Documentation/devicetree/bindings/pwm/vt8500-pwm.txt    |  5 +++--
>  arch/arm/boot/dts/am335x-evm.dts                        |  3 ++-
>  arch/arm/boot/dts/am335x-evmsk.dts                      |  3 ++-
>  arch/arm/boot/dts/wm8850-w70v2.dts                      |  3 ++-
>  include/dt-bindings/pwm/pwm.h                           | 15 +++++++++++++++
>  include/linux/pwm.h                                     |  4 ++--

I think this needs to be separate patches; at least the new pwm.h should
be introduced separately to the board-specific *.dts edits, and perhaps
further split up?

That way, the one patch that introduces <dt-bindings/pwm.h> would be
available to be merged into any other tree that wanted to take patches
to use the new defines.

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h

>  enum pwm_polarity {
> -	PWM_POLARITY_NORMAL,
> -	PWM_POLARITY_INVERSED,
> +	PWM_POLARITY_NORMAL = 0,
> +	PWM_POLARITY_INVERSED = 1,
>  };

Rather than manually editing that to ensure the enum matches the DT
bindings header, the whole point of making a separate <dt-bindings/...>
directory was that drivers could include the binding header files
directly to avoid having to duplicate the constant definitions. Can't
<linux/pwm.h> include <dt-bindings/pwm.h> and remove that enum?

