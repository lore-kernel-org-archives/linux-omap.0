From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] 32k sync timer meets hwmod
Date: Thu, 21 Oct 2010 11:00:19 -0700
Message-ID: <87mxq7xw7g.fsf@deeprootsystems.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0JUSAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 14:00:23 -0400
Received: by ywk9 with SMTP id 9so6045ywk.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 11:00:23 -0700 (PDT)
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Tue, 19 Oct 2010 12:22:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <balbi@ti.com> writes:

> Converted 32k-sync timer to platform_driver
> and now using pm_runtime and hwmod.
>
> Tested on 3430 by me and 4430 by Tarun
>
> If someone could test on 2430 and 2420, I would
> be really glad.

Hey, don't you have a 2420 device.  There were some cool 2420-based
tablets a few years ago made by some company in Finland that you may
have heard of.  ;)

Kevin
