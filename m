From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch-v2.6.34 8/9] arm: omap: musb: do not pass clock name to
 driver
Date: Wed, 30 Dec 2009 13:55:06 +0200
Message-ID: <1262174106.28789.180.camel@gandalf>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	 <1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>
	 <4B3B3818.5030804@ru.mvista.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58986 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZL3LzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 06:55:14 -0500
In-Reply-To: <4B3B3818.5030804@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org

Hi,

On Wed, 2009-12-30 at 14:23 +0300, Sergei Shtylyov wrote:
>    It's not so actually. This depends on the matching mechanism 
> established within clkdev: by device, by name, or by both. Not all 
> implementations will match by device, e.g. DA8xx/OMAP-L1x will match by 
> clock name.

then it has to be fixed. The name shouldn't matter. This was a big
discussion when Russell came up with the clkdev stuff and I remember
clearly that clock names shouldn't be passed down to drivers because
they don't matter.

-- 
balbi

