From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/6] Generic twl4030 power script for 3430 based boards.
Date: Thu, 16 Oct 2008 16:09:47 -0700
Message-ID: <200810161609.47835.david-b@pacbell.net>
References: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-5-git-send-email-peter.de-schrijver@nokia.com> <1224077854-23481-6-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:23964 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756362AbYJPXJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 19:09:49 -0400
In-Reply-To: <1224077854-23481-6-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 15 October 2008, Peter 'p2' De Schrijver wrote:
> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl4030-generic-scripts.h
> @@ -0,0 +1,8 @@
> +#ifndef __TWL4030_GENERIC_SCRIPTS_H
> +#define __TWL4030_GENERIC_SCRIPTS_H
> +
> +#include <linux/i2c/twl4030.h>
> +
> +extern struct twl4030_power_data generic3430_t2scripts_data;
> +
> +#endif

I'd still put this decl into arch/arm/mach-omap2/pm.h, which
is already a bit of a grab-bag of PM hooks.  As you noted,
having a header for a single declaration isn't the Best Way.

- Dave

