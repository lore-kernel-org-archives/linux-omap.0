From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3] gpio/omap: implement irq mask/disable with proper semantic.
Date: Tue, 23 Apr 2013 16:38:38 -0700
Message-ID: <878v486cn5.fsf@linaro.org>
References: <51728BA6.1090800@ti.com>
	<1366620861-5489-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1366620861-5489-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65305 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab3DWXin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 19:38:43 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so790763pab.35
        for <linux-omap@vger.kernel.org>; Tue, 23 Apr 2013 16:38:42 -0700 (PDT)
In-Reply-To: <1366620861-5489-2-git-send-email-andreas.fenkart@streamunlimited.com>
	(Andreas Fenkart's message of "Mon, 22 Apr 2013 10:54:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: santosh.shilimkar@ti.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com

Andreas Fenkart <andreas.fenkart@streamunlimited.com> writes:

> When a gpio interrupt is masked, the gpio event will still be latched in
> the interrupt status register so when you unmask it later you may get an
> interrupt straight away. However, if the interrupt is disabled then gpio
> events occurring will not be latched/stored.
>
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

The approach seems OK to me, but the changelog is still missing quite a
bit of information.

I know it's been hashed over in the various threads, but the changelog
needs all that discussion summarized.  The changelog should at least:

- describe the problem/bug being fixed
- describe the fix
- answer "why" the approach was taken (not how.)  This part is very
  important to reviewers and maintainers.
- how it was tested, and on what platforms

In addition, I'd like to see a description of how (or whether) this
affects the genirq lazy disable functionality, and how it was tested.

Kevin

