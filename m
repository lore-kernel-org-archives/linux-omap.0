From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: 4430sdp board support for proximity sensor
Date: Thu, 23 Sep 2010 11:11:56 -0700
Message-ID: <20100923181155.GP4211@atomide.com>
References: <1283321806-8210-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50766 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab0IWSL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 14:11:58 -0400
Content-Disposition: inline
In-Reply-To: <1283321806-8210-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [100831 23:09]:
> omap 4430sdp board support for the  proximity sensor via GPIO keys.
> The proximity sensor is connected to GPIO and is registered as a
> GPIO key.
> - Making the default state of the sensor off at bootup
> - The init is called before platform_add_devices

Adding this, thanks.

Tony
