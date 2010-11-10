From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6] omap:mailbox-fix checkpatch warnings
Date: Wed, 10 Nov 2010 19:49:39 +0300
Message-ID: <4CDACD23.7020609@ru.mvista.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com> <1289393121-7911-4-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52932 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975Ab0KJQvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 11:51:04 -0500
Received: by ewy7 with SMTP id 7so437426ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 08:51:02 -0800 (PST)
In-Reply-To: <1289393121-7911-4-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hello.

Hari Kanigeri wrote:

> Fix the checkpatch warnings observed in mailbox module

> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 9ce3570..ed960c1 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
[...]
> @@ -394,7 +394,8 @@ static int __init omap_mbox_init(void)
>  
>  	/* kfifo size sanity check: alignment and minimal size */
>  	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
> -	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
> +	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
> +						sizeof(mbox_msg_t));

    This line is over-indented a bit.

WBR, Sergei
