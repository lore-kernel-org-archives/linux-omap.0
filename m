From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/13] mfd: omap-usb-host: Add device tree support and
 binding information
Date: Tue, 5 Feb 2013 16:11:41 +0000
Message-ID: <20130205161141.GD26842@e106331-lin.cambridge.arm.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-10-git-send-email-rogerq@ti.com>
 <20130205142049.GC26842@e106331-lin.cambridge.arm.com>
 <51111A41.4050607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56773 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab3BEQLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 11:11:47 -0500
In-Reply-To: <51111A41.4050607@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

> >> +
> >> +- single_ulpi_bypass: Must be present if the controller contains a single
> >> +  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
> > 
> > Again it would be nicer to have '-' rather than '_' here. It might be worth
> > prefixing this "ti,".
> 
> Is prefixing with "ti" really required? how does it better?

I thought single-ulpi-bypass sounded rather generic, but it probably is
specific enough as-is. I don't know enough about USB hardware to have strong
feelings either way.

[...]

> Thanks for the in-depth review :).

You're welcome.

Thanks,
Mark.

