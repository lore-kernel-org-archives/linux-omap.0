From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] i2c-omap: Don't wait needlessly
Date: Fri, 21 Nov 2008 13:43:53 -0800
Message-ID: <20081121214353.GA4927@atomide.com>
References: <12246059481717-git-send-email-sakari.ailus@nokia.com> <20081024131740.64641d26.jarkko.nikula@nokia.com> <4905EA56.5050309@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59287 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYKUVnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 16:43:55 -0500
Content-Disposition: inline
In-Reply-To: <4905EA56.5050309@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [081027 09:22]:
> Jarkko Nikula wrote:
>> I would rather, if there is no need for such a long delay like
>> OMAP_I2C_TIMEOUT, remove that time_after and msleep(1) stuff and
>> just loop few iterations with udelay(1). Zero thinked & tested diff
>> attached.
>
> I just though of allowing the reset to take longer as I have no idea how  
> long it could take, let alone other versions of OMAP.
>
>> I would say that ndelay(1) just doesn't look relevant to < 1 GHz
>> cpus :-)
>
> Good point. On ARM ndelay(1) seems to be equal to udelay(1) at the moment.
>
> I actually just removed the ndelay(1) and again, "delay" won't get past  
> 1 if I print it after the loop.
>
> It'd be nice to know how it works on other OMAP versions before making  
> such changes. :-)

Let me know if you come up with a refreshed patch for this, ignoring
for now.

Tony
