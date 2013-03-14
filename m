From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: hw_breakpoint: Enable debug powerdown only if system supports 'has_ossr'
Date: Thu, 14 Mar 2013 10:38:43 -0700
Message-ID: <87txodnaos.fsf@linaro.org>
References: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43181 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab3CNRir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 13:38:47 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so2552484pbc.39
        for <linux-omap@vger.kernel.org>; Thu, 14 Mar 2013 10:38:47 -0700 (PDT)
In-Reply-To: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com> (Lokesh
	Vutla's message of "Wed, 13 Mar 2013 12:22:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: will.deacon@arm.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Commit {9a6eb31 ARM: hw_breakpoint: Debug powerdown support for self-hosted
> debug} introduces debug powerdown support for self-hosted debug.
> While merging the patch 'has_ossr' check was removed which
> was needed for hardwares which doesn't support self-hosted debug.
> Pandaboard (A9) is one such hardware and Dietmar's orginial
> patch did mention this issue.
> Without that check on Panda with CPUIDLE enabled, a flood of
> below messages thrown.
>
> [ 3.597930] hw-breakpoint: CPU 0 failed to disable vector catch
> [ 3.597991] hw-breakpoint: CPU 1 failed to disable vector catch
>
> So restore that check back to avoid the mentioned issue.
>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

I just noticed this on my Panda boards with CPUidle enabled, and
$SUBJECT patch fixes it.

FWIW,

Tested-by: Kevin Hilman <khilman@linaro.org>

I agree that this should get queued for v3.9-rc.

Kevin


