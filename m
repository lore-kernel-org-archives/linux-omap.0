From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] power button repeat input events
Date: Fri, 11 Mar 2011 11:04:40 -0800
Message-ID: <20110311190440.GC10079@atomide.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54041 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab1CKTEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 14:04:42 -0500
Content-Disposition: inline
In-Reply-To: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Denis Karpov <ext-denis.2.karpov@nokia.com> [110311 08:35]:
> Hi,
> 
> this patchset adds optional generation of repeat input events for
> twl4030 power button. It adds optional platform data for 
> twl4030-pwrbutton and initializes it for RX51/N900 (default 
> behavior kept - repeated input events disabled).
> 
> We are working on an OMAP3 with TWL5031 MFD. In one of the use 
> scenarios userspace wants to receive repeated input events from 
> long press of power button. 

Looks good to me, however please send these to the associated
driver lists linux-input/mfd/i2c etc. I'll ack the second
patch so that too can go with the driver.

Regards,

Tony
