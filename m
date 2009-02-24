From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc5-omap-git] mach-omap2/mmc-twl4030: fix for vmmc
 = 0
Date: Tue, 24 Feb 2009 13:48:56 +0200
Message-ID: <49A3DEA8.1050909@nokia.com>
References: <200902231014.26352.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59719 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbZBXLu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 06:50:27 -0500
In-Reply-To: <200902231014.26352.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Resolve longstanding issue noted by Adrian Hunter:  confusion
> between settting VSEL=0 (which is 1.8V on MMC1) and poweroff.
> 
> Also, leave VSEL alone if we're just powering the regulator off.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

Looks fine to me, but I wonder if you know why the regulator is
turned on (DEV_GRP) and then the voltage is selected (DEDICATED).
Wouldn't it make more sense the other way around?  Doesn't
the new regulator framework do it that way?

