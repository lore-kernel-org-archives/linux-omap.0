From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [BRIDGE] Rebase and sync with omapzoom bridge patch update
Date: Wed, 10 Sep 2008 15:41:46 +0300 (EEST)
Message-ID: <20080910.154146.234688808.Hiroshi.DOYU@nokia.com>
References: <20080910.065332.170214513.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23263 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYIJMlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 08:41:53 -0400
In-Reply-To: <20080910.065332.170214513.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x00omar@ti.com, h-kanigeri2@ti.com, grgupta@ti.com, juha.m.alanen@nokia.com, felipe.contreras@nokia.com, felipe.balbi@nokia.com

Hi,

It seems that the following site doesn't work with git.
So please use:

$ wget http://4869037.web.fc2.com/tidspbridge-20080910.tgz

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [BRIDGE] Rebase and sync with omapzoom bridge patch update
Date: Wed, 10 Sep 2008 06:53:32 +0300 (EEST)

> Hi,
> 
> I have updated all TI BRIDGE patches and rebased them against the
> latest linux-omap again for easy integration of them. You can get it
> by:
>      git fetch http://4869037.web.fc2.com/linux.git bridge:<you branch>
> 
> Most of the patches come directly from OMAPZOOM(Thanks, TI bridge
> team) and I just collected them;)
> 
> which includes the following patches.
> 
> Fernando Guzman Lugo (1):
>       BRIDGE: Remove sparse warnings from wcd
> 
> Hiroshi DOYU (12):
>       BRIDGE: Kconfig Entry
>       BRIDGE: Header files
>       BRIDGE: Doff image dynamic loader
>       BRIDGE: Generic Utilities
>       BRIDGE: Hardware Interfaces
>       BRIDGE: Platform Manager
>       BRIDGE: Resource Manager
>       BRIDGE: Services
>       BRIDGE: Mini driver
>       BRIDGE: README
>       BRIDGE: Fix header path
>       BRIDGE: Sync omapzoom bridge patches
> 
> Omar Ramirez Luna (6):
>       BRIDGE: Ceanup GT sparse warnings
>       BRIDGE: Cleanup static declarations warnings
>       BRIDGE: Remove unused clk structs
>       BRIDGE: Clean up unusedvariables
>       BRIDGE: Cosmetic changes reported from checkpatch
>       BRIDGE: Checkpatch Cleanup
> 
> Ramesh Gupta (2):
>       BRIDGE: Power management changes
>       BRIDGE: OMAP PM Bug softlockup fix
> 
> ext Ramirez Luna, Omar (1):
>       BRIDGE: OMAP CSL wrappers removed
> 
> x00omar@ti.com (1):
>       BRIDGE: Add wcd table end
> 
> If you find some missing patches against omapzoom, please let me know.
> 
>      Hiroshi DOYU
> 
> 
> 
