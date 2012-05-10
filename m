From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/6] Re-map the CTIs IRQs from MPU to DEBUGSS
Date: Thu, 10 May 2012 11:45:25 +0530
Message-ID: <CAMQu2gyZScQv--7RdcA0ZDJvP6Bw98X0U6=expMjcnw2T_oddQ@mail.gmail.com>
References: <1336599336-10866-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56167 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755015Ab2EJGPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:15:47 -0400
Received: by qabj34 with SMTP id j34so107342qab.4
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:15:46 -0700 (PDT)
In-Reply-To: <1336599336-10866-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

On Thu, May 10, 2012 at 3:05 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> In order to use the CTI interrupts inconjunction with the DEBUGSS we need to
> re-map the CTI IRQs to the DEBUGSS HWMOD. This is based upon Benoit Cousson's
> patch [1].
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073319.html
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
