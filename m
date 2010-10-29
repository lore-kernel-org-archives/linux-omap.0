From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 5/7] omap:mailbox-resolve multiple receiver problem
Date: Fri, 29 Oct 2010 07:10:11 -0500
Message-ID: <AANLkTi=YSMfqiyMWSKAP=BSsLOHiwsmGK5=-G32=ijAZ@mail.gmail.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-6-git-send-email-h-kanigeri2@ti.com>
	<4CC9F6AC.9030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51823 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896Ab0J2MKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 08:10:12 -0400
Received: by ywk9 with SMTP id 9so1904566ywk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Oct 2010 05:10:12 -0700 (PDT)
In-Reply-To: <4CC9F6AC.9030308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Gupta, Ramesh" <grgupta@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

Omar,


>> OMAP4 shares one interrupt line for all the mailbox instances.
>> The ISR is handling only the mailbox instance that was registered last.
>
> This shouldn't be needed, request_irq is being called with IRQF_SHARED flag
> and different device ids, so if a message arrives it fires an interrupt
> handler for each of the callers to request_irq and since the device id is
> actually a pointer to a mbox struct, the different users can be detected and
> signaled without looping through the "mboxes" list.
>
> Also using "mboxes" list, will try to check for all registered mailboxes
> during probe, which might not be the same as the actual users (the ones that
> have called omap_mbox_get) and then unnecesary check their irq statuses if
> an interrupt arrives.
>
> I think this patch can be dropped.
>

Agree, I will drop the patch and send the rebased patches.

Thank you,
Best regards,
Hari
