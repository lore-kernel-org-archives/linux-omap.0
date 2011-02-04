From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Remove unused audio macros in mcbsp.h
Date: Fri, 04 Feb 2011 15:45:44 +0200
Message-ID: <4D4C0308.9000501@nokia.com>
References: <1296810909-24737-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:20713 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab1BDNpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 08:45:49 -0500
In-Reply-To: <1296810909-24737-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

On 02/04/11 11:15, ext Kishon Vijay Abraham I wrote:
> Some macros defined in mcbsp.h related to audio, which are never being used
> is removed.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Charulatha V <charu@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
