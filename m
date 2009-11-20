From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver support
Date: Fri, 20 Nov 2009 09:02:20 -0800
Message-ID: <20091120170220.GA16447@core.coreip.homeip.net>
References: <hvaibhav@ti.com> <1258642000-2271-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:57471 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZKTRCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 12:02:19 -0500
Content-Disposition: inline
In-Reply-To: <1258642000-2271-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

Hi Vaibhav,

On Thu, Nov 19, 2009 at 08:16:40PM +0530, hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>


If I do:

sed 's/2004/2007/g' drivers/input/touchscreen/tsc2004.c | diff -u
drivers/input/touchscreen/tsc2007.c -

the diff is miniscule so why can't TSC2004 support be simply added to
TSC2007 driver?

Thanks.

-- 
Dmitry
