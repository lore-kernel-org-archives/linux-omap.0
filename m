From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 5/7] omap:mailbox-resolve multiple receiver problem
Date: Thu, 28 Oct 2010 17:18:20 -0500
Message-ID: <4CC9F6AC.9030308@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com> <1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39062 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab0J1WSc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Oct 2010 18:18:32 -0400
In-Reply-To: <1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Gupta, Ramesh" <grgupta@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

On 10/14/2010 9:13 PM, Kanigeri, Hari wrote:
> OMAP4 shares one interrupt line for all the mailbox instances.
> The ISR is handling only the mailbox instance that was registered last.

This shouldn't be needed, request_irq is being called with IRQF_SHARED 
flag and different device ids, so if a message arrives it fires an 
interrupt handler for each of the callers to request_irq and since the 
device id is actually a pointer to a mbox struct, the different users 
can be detected and signaled without looping through the "mboxes" list.

Also using "mboxes" list, will try to check for all registered mailboxes 
during probe, which might not be the same as the actual users (the ones 
that have called omap_mbox_get) and then unnecesary check their irq 
statuses if an interrupt arrives.

I think this patch can be dropped.

Regards,

Omar
