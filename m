From: Tony Lindgren <tony@atomide.com>
Subject: Re: DSS DT support for 3.14 probably not possible
Date: Thu, 9 Jan 2014 07:51:58 -0800
Message-ID: <20140109155157.GA27801@atomide.com>
References: <52CE72C3.7020103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56880 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbaAIPwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 10:52:02 -0500
Content-Disposition: inline
In-Reply-To: <52CE72C3.7020103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140109 02:00]:
> Hi Tony,
> 
> Unfortunately I think the DSS DT series will miss 3.14 merge window.
> 
> The code feels quite fine, but I'm still in the process of writing the
> binding documentation and getting those reviewed. And that review could
> of course lead to some new changes.

OK
 
> So if we're going for DT-only boot for 3.14, I guess the only option is
> to create the quirk display platform data for all the boards...

We can't quite yet make things DT-only. So let's just add the display
quirk support as needed.

Regards,

Tony
