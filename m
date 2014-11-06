From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [RESEND PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in
 GPMC driver
Date: Thu, 06 Nov 2014 21:17:30 +0100
Message-ID: <545BD75A.5040708@collabora.co.uk>
References: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk> <1395209295-24399-3-git-send-email-javier.martinez@collabora.co.uk> <20141106185235.GD31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43277 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaKFURe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 15:17:34 -0500
In-Reply-To: <20141106185235.GD31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Beno??t Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Tony,

On 11/06/2014 07:52 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140318 23:12]:
>> The GPMC driver includes arch/arm/mach-omap2/common.h but
>> does not use anything on that header so it can be removed.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Probably meant Cc here? :) I'll apply this into omap-for-v3.19/gpmc,
> the rest will need to wait until omap3 is DT only.
> 

Ups, I don't know how your s-o-b ended there :)

Thanks a lot for picking such an old patch.

Best regards,
Javier
