From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
Date: Fri, 14 Sep 2012 12:44:54 -0700
Message-ID: <CAOSpxdYDbPZXtkdzpyUXN8j1rAvph=VQZCkFfiDA2jN4E=oFBw@mail.gmail.com>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
	<CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
	<20120914122022.f56cd21d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43574 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab2INToz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 15:44:55 -0400
Received: by oago6 with SMTP id o6so3187606oag.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 12:44:54 -0700 (PDT)
In-Reply-To: <20120914122022.f56cd21d.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>

On Fri, Sep 14, 2012 at 12:20 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:

> Given the tested-by's that are rolling in, I will assume that people
> are hitting this problem in 3.5 and perhaps earlier kernels, so I
> scheduled the fix for 3.6, with a -stable backport.

Yes, I just checked an Overo setup here that is running 3.2 and it has
the same issue.

So your plan for 3.6 and -stable is a good one.

Steve
