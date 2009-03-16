From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH 02/12] ARM: OMAP3: Store reboot mode in scratchpad on
 OMAP34xx
Date: Mon, 16 Mar 2009 19:40:24 +0200
Message-ID: <49BE8F08.3000100@solidboot.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210333.16425.80205.stgit@localhost> <20090315155105.GB10786@n2100.arm.linux.org.uk> <49BE792B.1090901@solidboot.com> <20090316171008.GF31868@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:42338 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZCPRjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 13:39:37 -0400
In-Reply-To: <20090316171008.GF31868@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:

> Right.  You are aware that there is already a mechanism for doing this
> in the generic kernel (obviously not)?

I am. Unfortunately, glibc fails to support this mechanism, as you say. 
I didn't want to start making such intrusive changes for our trivial need.

> sys_reboot() with LINUX_REBOOT_CMD_RESTART2 takes a string in addition
> to the standard parameters.  This string is passed into machine_restart()
> which we currently ignore.  If LINUX_REBOOT_CMD_RESTART is used, this
> string is NULL.
> 
> We could change machine_restart() to pass this parameter through to
> arm_pm_restart() and ultimately down to arch_reset().

Sure. With RESTART2, I could've even used the reboot notifier chain with 
an OMAP3-specific driver to store the string.

Are you suggesting to get rid of reboot_mode altogether? If not, could 
we still have the sysfs mechanism? A one-character reboot_mode would be 
plenty enough for us.

Cheers,
Juha
