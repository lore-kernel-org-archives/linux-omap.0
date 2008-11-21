From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Place-Holder for a driver
Date: Fri, 21 Nov 2008 22:34:35 +0200
Message-ID: <20081121203435.GH31944@frodo>
References: <1433030405.242931227297877109.JavaMail.root@mbv7.indiatimes.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35883 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYKUUeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 15:34:44 -0500
Content-Disposition: inline
In-Reply-To: <1433030405.242931227297877109.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pavan_savoy@indiatimes.com
Cc: linux-omap@vger.kernel.org

On Sat, Nov 22, 2008 at 01:34:37AM +0530, pavan_savoy@indiatimes.com wrote:
> Hi,
> 
> The OMAP Zoom2 board has a bluetooth chip which needs to be enabled to be used. When running on Android, the Bluetooth service of Android uses the rfkill sysfs entry to turn on bluetooth.
> 
> So I linked the Bluetooth enable GPIO to the sys-fs entry, Now the question is where should/does this driver fit in ?
> 
> I've thought of drivers/misc, Any suggestions are welcome.

how about drivers/bluetooth ??

-- 
balbi
