From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: fix DeviceTree boot
Date: Fri, 7 Sep 2012 11:26:39 -0700
Message-ID: <20120907182638.GJ1303@atomide.com>
References: <20120907175721.GD1303@atomide.com>
 <1347041433-11723-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24047 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753063Ab2IGS0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 14:26:43 -0400
Content-Disposition: inline
In-Reply-To: <1347041433-11723-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [120907 11:15]:
> OMAP Architecture code, passes a few function
> pointers for UART driver to use in order to
> properly implement Power Management and Wakeup
> capabilities.
> 
> The problem is that those function pointers,
> which are passed (ab)using platform_data on
> non-DT kernels, can't be passed down to drivers
> through DT.
> 
> commit e5b57c0 (serial: omap: define helpers
> for pdata function pointers) failed to take DT
> kernels into consideration and caused a regression
> to DT kernel boot.
> 
> Fix that by (re-)adding a check for valid pdata
> pointer together with valid pdata->$FUNCTION
> pointer.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Tony, does this solve the issue ?

Yes thanks console works again now:

Tested-by: Tony Lindgren <tony@atomide.com>
