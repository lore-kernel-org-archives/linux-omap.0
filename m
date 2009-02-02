From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: new PM branch available
Date: Mon, 2 Feb 2009 19:45:32 +0200
Message-ID: <20090202174532.GJ4954@codecarver.research.nokia.com>
References: <87iqoij2me.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26281 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbZBBRpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 12:45:51 -0500
Content-Disposition: inline
In-Reply-To: <87iqoij2me.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

> Hello,
> 
> The latest PM branch is now available[1].
> 
> I've done basic testing of retention and off-mode (suspend and dynamic
> idle) on Beagle and custom HW.  My SDP has something still keeping
> CORE active that others have not seen, but I have yet to debug.  Any
> other reports from SDP testing would be appreciated.
> 
> Notable changes/updates
> - rebased on latest clock updates and fixes from Paul
> - clockfw pre- and post- notifiers
> - DVFS for VDD2
> 

I tried it on a beagleboard last night, but couldn't get even static
retention to work. Some domains (core, per, dss) stay on, but even mpu
and neon don't go to retention. They only go to inactive. 
So could you send your .config file ? Which rootfs are you using, I'm
using debian, so maybe something keeps the CPU busy. Are you using NAND
or MMC to store your rootfs ? Which beagle HW rev do you have ? I'm
testing on a B5 board. And which u-boot are you using ?

Thanks,

Peter.

-- 
goa is a state of mind
