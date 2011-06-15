From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
Date: Wed, 15 Jun 2011 16:18:09 -0700
Message-ID: <878vt23cr2.fsf@ti.com>
References: <1307491366-28793-1-git-send-email-khilman@ti.com>
	<20110614115056.GT3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50461 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab1FOXSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 19:18:15 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so1087149pzd.39
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 16:18:13 -0700 (PDT)
In-Reply-To: <20110614115056.GT3352@atomide.com> (Tony Lindgren's message of
	"Tue, 14 Jun 2011 04:50:56 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110607 16:58]:
>> OMAP1 needs this also since GPIO driver (common for all OMAPs) is
>> being converted to use generic IRQ chip.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Maybe queue this together with your GPIO patches?
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>

OK, will do.

Thanks,

Kevin
