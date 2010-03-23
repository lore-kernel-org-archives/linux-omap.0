From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] arm: omap1/2/3/4: convert clocksource to a platform_driver
Date: Tue, 23 Mar 2010 19:07:31 +0100
Message-ID: <87iq8mc3oc.fsf@deeprootsystems.com>
References: <1269346981-30147-1-git-send-email-felipe.balbi@nokia.com>
	<1269350966-9311-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42657 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0CWSHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 14:07:35 -0400
Received: by pwi5 with SMTP id 5so3543489pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 11:07:35 -0700 (PDT)
In-Reply-To: <1269350966-9311-1-git-send-email-felipe.balbi@nokia.com> (Felipe Balbi's message of "Tue\, 23 Mar 2010 15\:29\:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> Convert the omap32k clocksource driver into a platform_driver
> and while at that, also remove the ifdeferry around the code.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Looks like a good direction, but it still is rather tied to the 32k
sync timer.  We also have the ability to use a GPtimer as a
clocksource (see the clocksource register in timer-gp.c.)  By default,
we are always using the 32k timer for PM reasons, but we need the ability
to register any timer as clocksource.  This problably means just splitting
a little more the driver part and the device part.

Also, the new clocksource.c file should reference from whence it came.
A lot of that was copy/pasted from the older code so copyrights/author
credits should follow.

Kevin
