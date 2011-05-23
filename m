From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Mon, 23 May 2011 10:15:15 +0300
Message-ID: <20110523101515.8c47e7a2.jhnikula@gmail.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
	<20110518114242.GI13908@legolas.emea.dhcp.ti.com>
	<20110523061346.GD3095@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65030 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab1EWHPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 03:15:12 -0400
Received: by eyx24 with SMTP id 24so1719208eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 00:15:11 -0700 (PDT)
In-Reply-To: <20110523061346.GD3095@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, 23 May 2011 09:14:38 +0300
Felipe Balbi <balbi@ti.com> wrote:

> a gentle ping here too. Without this we will have regressions on
> ehci/ohci as the pm_runtime patches have gone in via Samuel.
> 
Does this mean that those regressions happened already when those
patches were made if there is pull request dependency?

Remember bisectability is important. And very important if you are
bisecting something else but which is dependent on this as then you
could mark wrong good/bad points or not able to determine.

-- 
Jarkko
