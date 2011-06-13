From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap3: cm-t35: add support for cm-t3730
Date: Mon, 13 Jun 2011 06:33:07 -0700
Message-ID: <20110613133307.GC3352@atomide.com>
References: <4DC27317.7020206@compulab.co.il>
 <1304839231-11329-1-git-send-email-grinberg@compulab.co.il>
 <20110531130447.GK11352@atomide.com>
 <4DE8E3B7.5020107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25977 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752553Ab1FMNdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 09:33:10 -0400
Content-Disposition: inline
In-Reply-To: <4DE8E3B7.5020107@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110603 06:33]:
> 
> I'm not sure I understand what are you trying to propose here...
> If you look once again on the code, there is currently only one if (cpu_is_..) {} else {}
> statement currently present.
> (I can remove the "if (cpu_is_omap3630())" - it indeed has no value)
>
> Indeed, there will be some other differences...
> Each time I submit a patch, I try to be as optimal as I can,
> but again I'm open for suggestions...
> (though I think it is optimal, e.g. 33 lines for a new running board...)

What I meant is that maybe you should do the detection first in some
get_revision function and populate the gpio pins there. Sort of like
this recent beagle patch:

https://patchwork.kernel.org/patch/859662/

That way adding support for other differences will be easier.

Regards,

Tony
