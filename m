From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
Date: Wed, 12 May 2010 11:29:13 -0700
Message-ID: <20100512182913.GC29366@core.coreip.homeip.net>
References: <0680EC522D0CC943BC586913CF3768C003B320A007@dbde02.ent.ti.com>
 <4BEAF03A.2070308@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55014 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab0ELS3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 14:29:25 -0400
Content-Disposition: inline
In-Reply-To: <4BEAF03A.2070308@cam.ac.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 12, 2010 at 07:15:22PM +0100, Jonathan Cameron wrote:
> Hi,
> 
> I was wondering if you could provide a bit more detail on what this
> driver is actually doing?  My appologies if I have missed a
> previous explanation.  If so, please add a Documentation file
> to explain what is going on.
> 
> The driver you have here does virtually nothing itself.  It takes
> both its source of interrupt and read function from platform
> data. Given the value is always 0 or 1, I'm guessing you are
> simply reading a gpio pin. That makes this effectively a button
> and doesn't require any specific code.  The fact it is a
> proximity sensor isn't relevant to anything other than perhaps
> the name.

Excellent point. Maybe it should simply use gpio_keys driver with
SW_FRONT_PROXIMITY code.

-- 
Dmitry
