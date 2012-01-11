From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RFC] I2C : OMAP : make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
Date: Wed, 11 Jan 2012 14:16:10 -0800
Message-ID: <877h0x3mxh.fsf@ti.com>
References: <1326270657-15309-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47476 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932606Ab2AKWQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 17:16:15 -0500
In-Reply-To: <1326270657-15309-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Wed, 11 Jan 2012 14:00:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_resume
> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
> Make the omap_i2c_unidle/idle also depend on CONFIG_PM_RUNTIME flag.

I probably should've done this when I initially cleaned up the
callbacks, but since you're doing it...

rather than move the functions within the file, just remove the
functions and move the code into the runtime callbacks.

Kevin
