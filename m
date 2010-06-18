From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Add OMAP4 Panda support
Date: Fri, 18 Jun 2010 13:01:46 +0300
Message-ID: <20100618100146.GT4237@nokia.com>
References: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com>
 <20100518033636.GL5818@atomide.com>
 <20100618065804.GN4237@nokia.com>
 <64809C8C-FAB5-4540-A47A-B0967B5C3B7F@mac.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55372 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab0FRKEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 06:04:25 -0400
Content-Disposition: inline
In-Reply-To: <64809C8C-FAB5-4540-A47A-B0967B5C3B7F@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Anders, David" <x0132446@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jun 18, 2010 at 11:56:02AM +0200, ext Elvis Dowson wrote:
>When adding support for OMAP4 Panda, and adding the necessary bits to 
>omap3_defconfig, will it be possible to ensure that all OMAP3 devices 
>also work the same, e.g. Gumstix Overo?

it should be possible. Ideally all omap2/3/4 boards should boot just 
fine with omap3_defconfig.

>What about specifics to make Android work in the defconfigs?

I really don't think community should care about Android/MeeGo/Ubuntu 
etc.

-- 
balbi

DefectiveByDesign.org
