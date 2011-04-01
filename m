From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info
 reordering
Date: Fri, 01 Apr 2011 14:37:45 +0300
Message-ID: <1301657865.1988.485.camel@cumari>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50239 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752148Ab1DALhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 07:37:07 -0400
Received: by mail-wy0-f180.google.com with SMTP id 26so4239310wyj.39
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 04:37:06 -0700 (PDT)
In-Reply-To: <1301640748-17161-1-git-send-email-coelho@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, 2011-04-01 at 09:52 +0300, Luciano Coelho wrote:
> The order in which the MMC cards are defined in the the 4430sdp board
> file seems to have been mistakenly reorderded as part of an unrelated
> patch.  In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where only
> the dev_name was supposed to be changed, the mmc order was changed as
> well.  This caused the external SD card reader not to be recognized,
> at least on Blaze.
> 
> This patch reverts this change so that the external SD card is
> recognized again.
> 
> Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---

Please drop this patch.  The problem was not in the order the MMCs were
mounted, but something wrong with my bootloader settings where the
rootwait was not been passed to the kernel properly.

Now it works fine for me too.  Sorry for the trouble!

-- 
Cheers,
Luca.

