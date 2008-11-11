From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Tue, 11 Nov 2008 17:57:15 +0300
Message-ID: <20081111145715.GA11056@2ka.mipt.ru>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.80.65]:50788 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756456AbYKKOsJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 09:48:09 -0500
Content-Disposition: inline
In-Reply-To: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

Hi Stanley.

On Tue, Nov 11, 2008 at 07:50:52PM +0800, Stanley.Miao (stanley.miao@windriver.com) wrote:
> Changes since v1:
> 
> 1, fix all the patch format problem.
> 
> 2, split the defconfig patch from code patches.
> 
> 3, put a twl4030keypad bug fix into a single patch.
> 
> 4, Add a "persistent" bit in the keypad map, and prune off "#ifdef(OMAP_LDP)"
> from the keypad driver.
> 
> 
> Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
> up, even crash at boot time(because of omap_hdq problem).
> 
> Add the following patches to fix the boot crash and let LDP boot succussfuly.

I have no objections against w1 changes.
I have no objections against other changes too, since I do not know what it is.

Feel free to add my ack if needed.

-- 
	Evgeniy Polyakov
