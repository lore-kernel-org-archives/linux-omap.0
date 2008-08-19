From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] usb: musb: pass configuration specifics via pdata
Date: Tue, 19 Aug 2008 12:39:03 +0300
Message-ID: <20080819093903.GB23346@gandalf.research.nokia.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com> <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com> <5e088bd90808181643x2fa0c192wefe8eeff7c507f1b@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39262 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbYHSJiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 05:38:15 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808181643x2fa0c192wefe8eeff7c507f1b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 18, 2008 at 04:43:43PM -0700, ext Steve Sakoman wrote:
> Does this patch require all board files to pass in platform_data or
> are there reasonable defaults for boards that don't?
> 
> There are reports that this patch has broken musb on beagle.

It's default for SOC- and for TUSB-based musb boards. Last time i sent
this patch as RFC I asked people to test and everybody (including
beagleboard people) had reported it was ok.

I've been testing this patch for over a month now on an omap3 board.

If you find any issues, please report the problem.

-- 
balbi
