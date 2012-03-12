From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 12 Mar 2012 15:17:04 -0700
Message-ID: <87boo1wjkv.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<878vj5y7iv.fsf@ti.com>
	<CAC83Zv+8AjCHBOJbtvSQS-URvCE5Xm9oPk9_X7h4Kz7FZ_7Otw@mail.gmail.com>
	<CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
	<CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56939 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753470Ab2CLWTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 18:19:09 -0400
Received: by mail-iy0-f171.google.com with SMTP id j38so8602562iad.30
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 15:19:08 -0700 (PDT)
In-Reply-To: <CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 13 Mar 2012 01:57:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

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

After addressing my comments on the series, please go ahead and rebase
on Grant's gpio/next branch.

Thanks,

Kevin
