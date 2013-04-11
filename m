From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: gpio/omap v2: map irq_enable/disable to mask/unmask.
Date: Thu, 11 Apr 2013 21:24:21 +0530
Message-ID: <5166DCAD.1030409@ti.com>
References: <20130411131842.GA9331@blumentopf>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43619 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936107Ab3DKPw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Apr 2013 11:52:26 -0400
In-Reply-To: <20130411131842.GA9331@blumentopf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: jon-hunter@ti.com, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org

On Thursday 11 April 2013 06:48 PM, Andreas Fenkart wrote:
> Hi Santosh,
> 
> I submitted the following patch a while back.
> https://patchwork.kernel.org/patch/1886421/
> 
> As already said, the patch is straight forward, but without it,
> we probably will not see decent SDIO performance on am335x chips.
> 
> [why it is needed]
> 
Why part is clear for me.

> There are still open questions to gpio patch itself, see here
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg87217.html
> 
> So could we pls reopen that thread? It might be on the other side
> of your mailbox
> 
Your idea is reasonable and probably patch make lot of sense for
edge triggered interrupt.

Can you please repost the patch with the more comprehensive change-log
as discussed in the thread.

Regards,
Santosh

