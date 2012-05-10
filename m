From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 1/2] omap: mailbox: enable mailbox irq per instance
Date: Thu, 10 May 2012 23:39:48 +0300
Message-ID: <CAK=WgbZ6t-8woKujtTG20fLqSFJPU2VKpW=E_V6hus1HQ+tDxQ@mail.gmail.com>
References: <1336680588-8572-1-git-send-email-jgutierrez@ti.com> <1336680588-8572-2-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36123 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab2EJUkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 16:40:09 -0400
Received: by yhmm54 with SMTP id m54so1910774yhm.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 13:40:09 -0700 (PDT)
In-Reply-To: <1336680588-8572-2-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

On Thu, May 10, 2012 at 11:09 PM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> The machine-specific omap2_mbox_startup is called only once
> to initialize the whole mbox module. Enabling mbox irq at
> startup is only enabling the irq of the very first mailbox
> instance created.
>
> The enable_irq function should be called every time a
> new mbox instance is created/opened, in the generic
> platform mailbox layer.
>
> Also, the notifier_block registration is called before
> enabling the mbox's irq to avoid possible race of receiving
> an interrupt without invoking the user's notifier callback.
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
