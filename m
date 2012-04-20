From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4+: hwmod: fix issue causing IPs not going back to
 Smart-Standby
Date: Fri, 20 Apr 2012 14:09:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204201409330.11306@utopia.booyaka.com>
References: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2DTUJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 16:09:45 -0400
In-Reply-To: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Djamil Elaidi <d-elaidi@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 20 Apr 2012, Djamil Elaidi wrote:

> If an IP is configured in Smart-Standby-Wakeup, when disabling wakeup feature the
> IP will not go back to Smart-Standby, but will remain in Smart-Standby-Wakeup.
> 
> Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>

Thanks, queued for 3.4-rc fixes.


- Paul
