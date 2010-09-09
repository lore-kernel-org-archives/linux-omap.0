From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 14:42:55 +0300
Message-ID: <20100909114255.GK21060@legolas.emea.dhcp.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59843 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab0IILnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 07:43:43 -0400
Content-Disposition: inline
In-Reply-To: <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi,

On Thu, Sep 09, 2010 at 06:23:10AM -0500, Santosh Shilimkar wrote:
>@@ -308,6 +308,16 @@ static void __init omap4_check_revision(void)
> 	hawkeye = (idcode >> 12) & 0xffff;
> 	rev = (idcode >> 28) & 0xff;
>
>+	/*
>+	 * FIXME: This patch should be reverted later.
>+	 * Few initial ES2.0 samples IDCODE is same as ES1.0
>+	 * Use ARM register to detect the correct ES version
>+	 */

I wonder if it actually doesn't make sense to keep this in tree, the
overhead is minimum when rev is set correctly and it's safe for the
initial es2.0 samples which are buggy.

-- 
balbi
