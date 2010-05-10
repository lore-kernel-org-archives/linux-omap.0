From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: GPIO: Replace CONFIG_ARCH_OMAP34XX with CONFIG_ARCH_OMAP3
Date: Mon, 10 May 2010 09:51:32 -0700
Message-ID: <87632vk8dn.fsf@deeprootsystems.com>
References: <1273143736-28784-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:59694 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0EJQvn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:51:43 -0400
Received: by qyk13 with SMTP id 13so6434433qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:51:42 -0700 (PDT)
In-Reply-To: <1273143736-28784-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Thu\,  6 May 2010 16\:32\:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> CONFIG_ARCH_OMAP34XX is not defined any more. Replace it with
> CONFIG_ARCH_OMAP3.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
> ---
>
> This patch is generated against pm branch.

Thanks, will add to PM-related GPIO patches submitted for 2.6.35.

Kevin

