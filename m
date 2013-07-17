From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Wed, 17 Jul 2013 11:11:19 -0600
Message-ID: <51E6D037.3020706@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2883016.87pKJk9n0R@avalon> <51E4C073.4020407@wwwdotorg.org> <2989497.8E7gzkcamn@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33017 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab3GQRL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 13:11:27 -0400
In-Reply-To: <2989497.8E7gzkcamn@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Grant Likely <grant.likely@linaro.org>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 07/17/2013 05:00 AM, Laurent Pinchart wrote:
> On Monday 15 July 2013 21:39:31 Stephen Warren wrote:
...
>> But then there's a problem where people assume that the common flags are
>> always available, and somewhere they aren't... Care is needed in the
>> choice of which common flags to define and/or how they're used.
> 
> Exactly. That's why I think listing the supported common flags in individual 
> bindings makes sense when some of the flags are not supported by all devices. 
> As the only PWM flags currently used are common to all PWM devices I can leave 
> this out now. I have no strong preference, I'll follow your opinion on this.

Yes, I guess separating the concept of defining common flags and which
devices use them is good. And then indeed individual devices need to
define which of the common flags they support. I'd still like to see the
*definition* of those common flags in some central place (i.e. pwm.txt
or a header that defines constants for it), and the other device
bindings simply reference that for the actual definitions.

