From: Nishanth Menon <nm@ti.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Tue, 2 Jul 2013 09:57:28 -0500
Message-ID: <20130702145727.GA4018@kahuna>
References: <51CC5105.4070301@ti.com>
 <20130627175623.GB21364@panicking>
 <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com>
 <20130627192413.GA14115@panicking>
 <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com>
 <20130628113314.GA25536@panicking>
 <51CD7783.8030907@ti.com>
 <20130628164751.GA1281@panicking>
 <51D2E6DA.6030000@ti.com>
 <51D2E88A.7050202@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51925 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab3GBO5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 10:57:30 -0400
Content-Disposition: inline
In-Reply-To: <51D2E88A.7050202@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Roger Quadros <rogerq@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On 16:49-20130702, Michael Trimarchi wrote:
> Last question:
> If one domain is in RET mode and not OFF mode what happen during SAR restore in OFF mode?
Without going to the depth of what TRM says already:
SAR comes into play only if device-off sequence was triggered. Depending
on which domain and what level of retention state was programmed,
device-off sequence may not even start. Note: Generically speaking, not
achieving device OFF may not mean other powerdomains cannot achieve OFF
and loose context. Specific example of USB tied on core domain, the
behavior could be different.

-- 
Regards,
Nishanth Menon
