From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap git 2/2] twl4030-gpio debounce cleanup
Date: Mon, 10 Nov 2008 07:21:30 -0800
Message-ID: <200811100721.31006.david-b@pacbell.net>
References: <200811071159.49679.david-b@pacbell.net> <200811100628.31085.david-b@pacbell.net> <20081110150328.GY7467@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:22731 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752175AbYKJPVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2008 10:21:32 -0500
In-Reply-To: <20081110150328.GY7467@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Monday 10 November 2008, Felipe Balbi wrote:
> I got your patches and build tested them, hsmmc.c still had
> twl4030_gpio_debounce call. Maybe I missed one of the patches then.

Grab  current GIT.

