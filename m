From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Wed, 27 May 2015 15:19:10 -0700
Message-ID: <7h7frtmzoh.fsf@deeprootsystems.com>
References: <20150527215545.GA30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34693 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbE0WTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2015 18:19:13 -0400
Received: by pabru16 with SMTP id ru16so7834477pab.1
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2015 15:19:13 -0700 (PDT)
In-Reply-To: <20150527215545.GA30984@atomide.com> (Tony Lindgren's message of
	"Wed, 27 May 2015 14:55:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, tyler.baker@linaro.org

[ fix email for Dave Martin, +Tyler ]

Tony Lindgren <tony@atomide.com> writes:

> The power management related assembly needs to interact with
> ARM mode bootrom code, so we need to keep most of the related
> assembly in ARM mode.
>
> Currently we are entering into and ARM mode assembly function
> from thumb2 mode, so we need to make sure we switch to ARM
> mode. And we need to do that again after the cache flush.
>
> ---
>
> Kevin told me about this earlier today.. 


And for full boot log/panics, see the kernelci.org thumb2 kernel boots
that fail: http://kernelci.org/boot/?THUMB2_KERNEL&fail

> Anybody got better ideas for a fix here?

FWIW, a quick test of this patch makes my omap3-beagle-xm pass a simple
boot test, but it fails with off idle.

Kevin
