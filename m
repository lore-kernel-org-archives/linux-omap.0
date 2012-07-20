From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC 4/4] ARM: OMAP3: PM: Use .power_on/.power_down to clean omap_sram_idle
Date: Fri, 20 Jul 2012 13:00:01 +0530
Message-ID: <CAMQu2gyk=h2Mt1RfJ83xSVN4dtTLt2Za15OEKBTq_4WaCOkGFA@mail.gmail.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54498 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566Ab2GTHaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 03:30:23 -0400
Received: by qabj40 with SMTP id j40so57078qab.15
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 00:30:21 -0700 (PDT)
In-Reply-To: <1342764284-8143-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, t-kristo@ti.com

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> With .power_on/.power_down hooks now available within the powerdomain
> framework, its possible to clean a lot of mpu/core power_on/power_down
> related code within omap_sram_idle into respective callbacks for these
> powerdomains.
>
> This should atleast also optimise the core domain context save
> in CPUidle when attempting deeper C states, to prevent a core
> domain context save when a device in core is still active.
> The current code in such cases does a blind context save and
> tries to put core domain down, even while devices are active.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Looks more modular now. Thanks Rajendra and this series is
a good step towards decoupling CORE IDLE with CPUIDLE.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
