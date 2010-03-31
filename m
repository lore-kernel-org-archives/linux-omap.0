From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 0/2] 32k-sync timer patches
Date: Wed, 31 Mar 2010 14:10:35 +0300
Message-ID: <20100331111035.GS30597@nokia.com>
References: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33976 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab0CaLLE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 07:11:04 -0400
Content-Disposition: inline
In-Reply-To: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 01:05:47PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>The following patches convert 32k-sync timer into a platform_driver
>and also remove dead code from timer32k.c
>
>If anyone has a good idea on how to fix-up timer-gp.c, I'll be
>glad to hear. Currently I can't move it to platform_driver
>because it's used the system timer during machine start so I can't
>find a proper location to register the platform_device. If we don't
>register a system timer, we will loop forever trying to calibrate
>the delay loop.
>
>The patches were boot tested on rx51 and compile tested with
>omap_h2_1610_defconfig.

forget this, sent older version. platform_device name is different than 
platform_driver name.

-- 
balbi
