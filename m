From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap2plus: GPIO cleanup
Date: Thu, 12 May 2011 03:16:31 -0700
Message-ID: <20110512101630.GI31483@atomide.com>
References: <20110503103952.GP2092@atomide.com>
 <1304436129-7165-1-git-send-email-grinberg@compulab.co.il>
 <4DCA3D02.9070608@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52654 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754250Ab1ELKQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 06:16:36 -0400
Content-Disposition: inline
In-Reply-To: <4DCA3D02.9070608@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110511 00:35]:
> ping!
> 
> On 05/03/11 18:22, Igor Grinberg wrote:
> 
> > use gpio_request_<one|array>() instead of multiple gpiolib calls,
> > remove unneeded variables, etc.

Thanks that shrinks down the board files nicely. Applying to
devel-cleanup.

Regards,

Tony
