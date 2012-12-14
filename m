From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Fri, 14 Dec 2012 15:58:06 -0800
Message-ID: <CA+Bv8XbshAbjyVLH1ZH18Y4nv7k7nb7kym5gjk+ARjUnkFe3dw@mail.gmail.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
	<509AD478.1050904@ti.com>
	<509B666F.6080507@compulab.co.il>
	<509BDAF5.1010703@ti.com>
	<79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60781 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945950Ab2LNX6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 18:58:07 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2839918qcr.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 15:58:06 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Thu, Nov 8, 2012 at 9:08 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> No we do not have 32k_counter block in AM335x.
>
> If you are referring to 32Khz clock availability alone, then yes, we need to
> get persistent clock and we use RTC 32Khz clock source for it.
> But please note that this is not a 32k_counter block which OMAP family of
> devices has.
>
> The way AM335x works is, we have timers (0-7), timer0 being secure timer.
> We use timer1 and timer2 for clockevent and clocksource and they are driven
> by 26MHz OSC clock currently. So when you go into Low power state, OSC is turned off and you need persistent clock for time keeping, right?
>
> And only persistent clock available is RTC 32khz crystal clock, being RTC is
> in wakeup domain.

RTC domain.
