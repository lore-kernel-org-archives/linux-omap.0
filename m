From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Mon, 15 Jul 2013 21:39:31 -0600
Message-ID: <51E4C073.4020407@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2172485.AZTjvkLGcM@avalon> <51E015E1.2090906@wwwdotorg.org> <2883016.87pKJk9n0R@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34793 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3GPDjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 23:39:32 -0400
In-Reply-To: <2883016.87pKJk9n0R@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 07/15/2013 07:10 PM, Laurent Pinchart wrote:
> On Friday 12 July 2013 08:42:41 Stephen Warren wrote:
...
>> I think the values for any common system-wide flags should be defined
>> once in some system-wide place, and the values for any HW-specific
>> values should be defined only in the documentation for that specific HW.
>> You could try and avoid conflicts by either:
>>
>> a) Allocating system-wide flags from bit 0 up, and HW-specific flags
>> from bit 31 down.
>>
>> or:
>>
>> b) Using 1 cell for standard flags, and a separate cell for any
>> HW-specific flags. Drivers can quite easily adapt to adding extra cells
>> to #pwm-cells, thus making adding a HW-specific cell later
>> backwards-compatible.
> 
> I wasn't referring to HW-specific flags, but rather to system-wide flags that 
> might not be supported by all drivers. If we later add new system-wide flags I 
> think the individual DT bindings should explicitly document which flags they 
> support.

Shouldn't all system-wide flags be supported by all HW, perhaps being
implemented by the core subsystem rather than individual drivers to
ensure that? Consider the case of the GPIO active-low flag which is
actually implemented in SW, hence can work with any GPIO controller.

Perhaps that's not possible in all cases, in which case, yes, it does
make sense to define which of the common flags a particular HW module
supports.

But then there's a problem where people assume that the common flags are
always available, and somewhere they aren't... Care is needed in the
choice of which common flags to define and/or how they're used.
