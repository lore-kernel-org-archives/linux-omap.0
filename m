From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/26] ARM: OMAP: dmtimer: Add comments on OMAP1 clock
 framework
Date: Wed, 7 May 2014 15:07:07 -0700
Message-ID: <20140507220706.GD19102@atomide.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
 <1398375849-6017-3-git-send-email-joelf@ti.com>
 <20140507152004.GC9502@atomide.com>
 <536AAA31.6080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111AbaEGWHN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 18:07:13 -0400
Content-Disposition: inline
In-Reply-To: <536AAA31.6080905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

* Joel Fernandes <joelf@ti.com> [140507 14:49]:
> On 05/07/2014 10:20 AM, Tony Lindgren wrote:
> > * Joel Fernandes <joelf@ti.com> [140424 14:44]:
> >> OMAP1 doesn't support clock framework, add a comment where needed
> >> and correct a FIXME.
> > 
> > This is at least a wrong comment, the original comment seems right
> > to me.
> 
> Can you elaborate a bit more please on the wrongness of the comment?
> 
> I can change the comment to say "common clock" instead of "clock" if
> that's the only problem here.

The original comment is just fine, no need to patch it. We do have
clock framework support for omap1, it was the first ever Linux
clock framework that pretty much all other clock frameworks are
based on. Just drop this patch it's misleading.

Regards,

Tony
