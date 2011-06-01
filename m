From: Matthias Scheer <scheer@in.tum.de>
Subject: Re: [PATCH] OMAP2: CONFIG_TOUCHSCREEN_ADS7846 XOR CONFIG_MTD_NAND_OMAP2
 breaks build
Date: Wed, 01 Jun 2011 23:42:36 +0200
Message-ID: <4DE6B24C.7030900@in.tum.de>
References: <loom.20110506T210326-622@post.gmane.org> <20110531130715.GL11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:40029 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758541Ab1FAVxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 17:53:23 -0400
In-Reply-To: <20110531130715.GL11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 31.05.2011 15:07, Tony Lindgren wrote:
> Care to check if this is still needed for v3.0-rc1? If so, please
> add proper patch description and Signed-off-by.

Just tried and successfully built stock 3.0-rc1 kernels with both 
configuration combinations. Patch no longer needed.

Cheers,
Matthias
