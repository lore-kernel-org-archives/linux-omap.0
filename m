From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/3] OMAP: Make OMAP LDP boot succussfuly
Date: Fri, 7 Nov 2008 17:53:41 +0200
Message-ID: <20081107155340.GH21860@frodo>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48182 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYKGPxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 10:53:47 -0500
Content-Disposition: inline
In-Reply-To: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 07, 2008 at 09:41:24PM +0800, Stanley.Miao wrote:
> Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
> up, even crash at boot time(because of omap_hdq problem).
> 
> Add the following patches to fix the boot crash and let LDP boot succussfuly.

I recall seeing patches sending this driver to mainline, could you check
with Evgeniy Polyakov what's status ?? Or resend this series after
fixing my comments and Cc him.

-- 
balbi
