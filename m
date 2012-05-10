From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 10 May 2012 11:51:54 +0530
Message-ID: <CAMQu2gwFOVA2v8YyHW_fA1vgrVTcD==G8BQY4AOUQaVyusKzSw@mail.gmail.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52283 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996Ab2EJGWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:22:16 -0400
Received: by qcsc20 with SMTP id c20so1114825qcs.18
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:22:15 -0700 (PDT)
In-Reply-To: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Thu, May 10, 2012 at 3:05 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> This patch is based upon Ming Lei's patch to add runtime PM support for OMAP4
> [1]. In Ming's original patch the CTI interrupts were being enabled during
> runtime when the PMU was used but they were only configured once during init.
> Therefore move the configuration of the CTI interrupts to the runtime PM
> functions.
>
You might want to give the reason why you need to move the re-confiuration
from init to to run-time PM functions so that the actual issue of
reset gets addressed.


> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074153.html
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Patch as such looks fine to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
