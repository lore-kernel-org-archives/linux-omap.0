From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch-v2.6.33-rc2+ 01/12] arm: omap: musb: ioremap only
 what's ours
Date: Wed, 30 Dec 2009 01:51:13 +0200
Message-ID: <1262130673.28789.118.camel@gandalf>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
	 <1262127092-14878-2-git-send-email-felipe.balbi@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:32785 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZL2XvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:51:19 -0500
In-Reply-To: <1262127092-14878-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

On Wed, 2009-12-30 at 00:51 +0200, Felipe Balbi wrote:
> omap3430 TRM says the OTG address space is 4k, not 8k.

further explanation is that the address space for musb module is 4k and
the extra 4k is for L4 interconnect. I'll change the description on the
branch Tony will pull from.

-- 
balbi

