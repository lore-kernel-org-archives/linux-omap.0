From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH ] McBSP:Make the free variable update more readable
Date: Wed, 3 Nov 2010 12:18:18 +0200
Message-ID: <20101103121818.e86f56ba.jhnikula@gmail.com>
References: <1288778337-18815-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58698 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab0KCKSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 06:18:10 -0400
Received: by ewy7 with SMTP id 7so139962ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 03:18:09 -0700 (PDT)
In-Reply-To: <1288778337-18815-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com
Cc: linux-omap@vger.kernel.org

On Wed,  3 Nov 2010 15:28:57 +0530
shubhrajyoti@ti.com wrote:

> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> Using true/false instead of 1/0 to update the free variable.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
