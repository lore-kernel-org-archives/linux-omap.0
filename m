From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-0 v2] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Fri, 19 Sep 2008 09:41:16 +0300
Message-ID: <87y71o3aer.fsf@deeprootsystems.com>
References: <1221753282-18594-1-git-send-email-khilman@deeprootsystems.com>
	<023001c91a0b$936f09e0$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:39524 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYISGlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 02:41:25 -0400
Received: by ug-out-1314.google.com with SMTP id k3so907634ugf.37
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 23:41:23 -0700 (PDT)
In-Reply-To: <023001c91a0b$936f09e0$LocalHost@wipultra1303> (Madhusudhan Chikkature's message of "Fri\, 19 Sep 2008 09\:25\:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

"Madhusudhan Chikkature" <madhu.cr@ti.com> writes:

>> This ensures that each HSMMC block is reset so it will not interfere
>> with retention or OFF-mode.
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

[...]

> This might not be the right place to reset the controllers. You can
> avoid all the clk stuff if you do the reset in the driver probe
> function after the clocks are enabled.

The point is that this needs to be done even when the MMC driver is
NOT built into the kernel, or in the case of a module, before the MMC
driver is loaded.

> BTW, What is the issue you are facing if you dont reset the
> controllers? 

See mail from Jouni where he described it well.

> I have seen that on L-o that suspend/resume works with this driver
> enabled.

Without this patch, suspend/resume may work, but you may not hit
retention or OFF.  As Jouni also described, some boards work without
this patch, and others do not.

Kevin


