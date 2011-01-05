From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP4 panda gets stuck during reboot
Date: Wed, 5 Jan 2011 16:18:14 +0200
Message-ID: <20110105141814.GF2304@legolas.emea.dhcp.ti.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
 <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38522 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751146Ab1AEOST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:18:19 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so7528052eye.33
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:18:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Jan 05, 2011 at 07:44:31PM +0530, Santosh Shilimkar wrote:
> > What could it be ? Any more debugging I could do to help ?
> >
> This is known and seems to OMAP specific issue. Test patch and

Doesn't look like omap-specific from patch description. Looks like like
CPU1 is turned off and the instruction to flush PMD entry fails. Could
it be that all ARM SMPs are affected ?

-- 
balbi
