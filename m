From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 13:57:22 +0300
Message-ID: <20080923105722.GD24627@gandalf.research.nokia.com>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com> <00b801c91d36$156fd5a0$LocalHost@wipultra1303>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28142 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYIWLEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:04:42 -0400
Content-Disposition: inline
In-Reply-To: <00b801c91d36$156fd5a0$LocalHost@wipultra1303>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: felipe.balbi@nokia.com, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

On Tue, Sep 23, 2008 at 10:07:23AM +0530, ext Madhusudhan Chikkature wrote:
> Balbi,
> Please note that the driver patches were submitted to L-o as RFC initially and all the comments provided by the community are fixed before it is pushed by Tony. 
> 
> There would be a time gap between the day the patches are submitted and before Tony pushes the patches to the tree. Any valid comments provided then would get promptly fixed. This would definetely avoid cleaning stuff which is already in tree to whatever extent it is possible.


That's not the point, since ideally, that driver would be delivered via
Evgeniy Polyakov since he's the maintainer for the 1-wire bus devices
and not via linux-omap.

Well, anyways, I'm not gonna start this discussion again. Just make sure
you can clean the driver and send it upstream ;-)

-- 
balbi
