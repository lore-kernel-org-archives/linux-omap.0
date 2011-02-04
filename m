From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: McBSP: Remove unused audio macros in mcbsp.h
Date: Fri, 4 Feb 2011 11:46:48 +0200
Message-ID: <20110204114648.e622937d.jhnikula@gmail.com>
References: <1296810909-24737-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44712 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab1BDJpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 04:45:01 -0500
Received: by fxm20 with SMTP id 20so2193442fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 01:45:00 -0800 (PST)
In-Reply-To: <1296810909-24737-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri,  4 Feb 2011 14:45:09 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Some macros defined in mcbsp.h related to audio, which are never being used
> is removed.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Charulatha V <charu@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
