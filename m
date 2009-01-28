From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Beagle PM hangs
Date: Wed, 28 Jan 2009 08:28:52 -0800
Message-ID: <87zlhbqtrv.fsf@deeprootsystems.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:17635 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZA1Q26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 11:28:58 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3021370ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 08:28:57 -0800 (PST)
In-Reply-To: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com> (Peter Reid's message of "Wed\, 28 Jan 2009 21\:44\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Reid <ppeter.reid@gmail.com>
Cc: Koen Kooi <koen@beagleboard.org>, linux-omap@vger.kernel.org

Peter Reid <ppeter.reid@gmail.com> writes:

> Hi Kevin,
>    I get hangs after boot on beagle with latest PM tree i have quite a
> few scripts that run on boot.
>
>    have you seen this before?

I have not, but I believe Koen has see something similar.  I've mainly
been testing just a minimal rootfs and a minimal set of drivers on
Beagle so I can hit full-chip off in idle.

It would help if you could desribe your setup in more detail.  What
kernel config are you using, what rootfs are you using?  Does it hang
in the same spot every time?  If so, what is going on when it hangs?
Have you written anything to any of the /sys/power/* files?

Kevin
