From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Tue, 08 May 2012 14:57:14 -0700
Message-ID: <87ipg6l4jp.fsf@ti.com>
References: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55333 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757141Ab2EHV47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:56:59 -0400
Received: by pbbrp8 with SMTP id rp8so12590035pbb.33
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 14:56:58 -0700 (PDT)
In-Reply-To: <1336490630-7272-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 8 May 2012 20:53:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Initially, we decided to make am33xx family of device to fall
> under omap3 class (cpu_is_omap34xx() = true), since it carries
> Cortex-A8 core. But while adding complete baseport support
> (like, clock, power and hwmod) support, it is observed that,
> we are creating more and more problems by treating am33xx device
> as omap3 family, as nothing matches between them
> (except cortex-A8 mpu).
>
> So,  after long discussion we have came to the conclusion that,
> we should not consider am33xx device as omap3 family, instead
> create separate class (SOC_OMAPAM33XX) under OMAP2PLUS.
> This means, for am33xx device, cpu_is_omap34xx() will return false,
> and only cpu_is_am33xx() will be true.

Not directly related to this patch, but does anyone have any objection
to dropping the OMAP from the SOC_ names for AM33xx and TI81XX?

I'll post a series shortly to do so.

Kevin

