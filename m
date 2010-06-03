From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/9] OMAP2: Support for early device registration
Date: Thu, 03 Jun 2010 16:19:53 -0700
Message-ID: <87sk53k8km.fsf@deeprootsystems.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
	<1275143831-7629-2-git-send-email-thara@ti.com>
	<1275143831-7629-3-git-send-email-thara@ti.com>
	<1275143831-7629-4-git-send-email-thara@ti.com>
	<1275143831-7629-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63449 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0FCXT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:19:57 -0400
Received: by pvg16 with SMTP id 16so299872pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:19:55 -0700 (PDT)
In-Reply-To: <1275143831-7629-5-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 20\:07\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds a new API in the common boot up sequence to register
> early drivers and probe for early devices. This API can be used by any
> early device to register itself.
> This patch also adds support to register "earlytimer" drivers and
> probe for any associated devices that are registered as early devices.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Personally, I'd rather see the earlytimer registers/probes contained
in the timer code itself.

Kevin
