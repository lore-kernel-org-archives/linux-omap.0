From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 12 Mar 2012 15:28:42 -0700
Message-ID: <87vcm9v4h1.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<878vj5y7iv.fsf@ti.com>
	<CAC83Zv+8AjCHBOJbtvSQS-URvCE5Xm9oPk9_X7h4Kz7FZ_7Otw@mail.gmail.com>
	<CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
	<CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51125 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757583Ab2CLW2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 18:28:36 -0400
Received: by mail-gx0-f172.google.com with SMTP id i1so3069490ggm.3
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 15:28:35 -0700 (PDT)
In-Reply-To: <CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 13 Mar 2012 01:57:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

[...]

>>> Oops... I am sorry.
>>> I was in the process of updating the branch with latest comments after
>>> base-lining on Grant's:
>>> git://git.secretlab.ca/git/linux-2.6.git
>>> Branch: gpio/next
>>> Because this has all the gpio changes including Benoit's latest gpio
>>> devicetree changes.
>>> Should I go ahead?
>> Anyways, for the time being I am updating on top of your changes as before.
>> You should be able to see the branch shortly.
> Please note that the branch has your following patch:
> gpio/omap: fix wakeups on level-triggered GPIOs

Please be sure to Cc the GPIO maintainer (added now.)

Grant can we consider your gpio/next a stable baseline for further
GPIO fixes?

If so, Tarun, please base your branch there.  Otherwise, continue to use
my for_3.4/gpio/runtime-pm-cleanup, but please test it by merging with
the gpio/next branch.

Thanks,

Kevin
