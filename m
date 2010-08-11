From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 4/6] TI816X: Create board support for TI816X_EVM
Date: Wed, 11 Aug 2010 11:15:53 -0700
Message-ID: <87bp992exy.fsf@deeprootsystems.com>
References: <1281546672-11517-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54093 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab0HKSP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:15:56 -0400
Received: by pwi7 with SMTP id 7so19270pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 11:15:56 -0700 (PDT)
In-Reply-To: <1281546672-11517-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Wed, 11 Aug 2010 22:41:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimal support for TI816X EVM to enable kernel boot.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

[...]

> +static void __init ti8168_evm_init_irq(void)
> +{
> +	/* Timer1 is reserved on TI816X so skip to first available */

reserved for what?  DSP?  

If it is totally unavailable for use by Linux, then the timer init
should probably request the timer so other users requesting any timer
would not be given a reserved timer.

Kevin
