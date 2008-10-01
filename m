From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Wed, 01 Oct 2008 17:20:53 +0300
Message-ID: <48E38745.8050800@nokia.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <20080926174643.GA9890@frodo> <48DDE2AD.1030202@nokia.com> <200809270804.16788.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28534 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYJAOVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 10:21:17 -0400
In-Reply-To: <200809270804.16788.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi,

David Brownell wrote:
> A question that may well come up when this heads upstream:
> why is this exporting a miscdev, for an ioctl, when this
> could all be done using sysfs and hwmon rules?  That is,
> was this the "appropriate" way to export ADC channels?

We could still do both, right?

> And a slightly more pragmatic question:  does Nokia have
> tools that would break if this were switched to hwmon style?

We've used ioctl() mechanism to get ADC readings to user space quite
some time already.

I believe this is still a better option compared with hwmon/sysfs
approach (Reason: sometimes we do those readings very often and
for many channels. Instead of doing all that fd magic and atoi(),
we just call ioctl() to get raw ADC data available for further
processing).

>> How detailed information would you like to have here?
> 
> Enough to answer the question "what's a MADC?" for someone
> who doesn't have TWL specs and hasn't read even any kind
> of summary data sheet.  Three sentences would likely be
> excessive; one good sentence might suffice.

Perhaps duplicate the comments we have in Kconfig to .c?

-- 
Regards, Mikko
