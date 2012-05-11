From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct dpll_data
Date: Fri, 11 May 2012 12:01:00 +0530
Message-ID: <CAMQu2gxdOo1R7gNZoxf6qzb2Ncv6yiDorFeX40=T14q2n8nWpg@mail.gmail.com>
References: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56981 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758627Ab2EKGbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 02:31:23 -0400
Received: by qaeb19 with SMTP id b19so1206029qae.11
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 23:31:21 -0700 (PDT)
In-Reply-To: <1336716163-2960-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, R Sricharan <r.sricharan@ti.com>

On Fri, May 11, 2012 at 11:32 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> There are certain fields inside 'struct dpll_data' which are
> included under ARCH_OMAP3 and ARCH_OMAP4 option, which makes it
> difficult to use it for new devices like, am33xx, ti81xx, etc...
>
> So remove the ifdef completely, this will add few fields to the struct
> unused, but it improves readability and maintainability of the code.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> ---
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
