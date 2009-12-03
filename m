From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Fix include problem. Signed-off-by: Marek Belisko
	<marek.belisko@gmail.com>
Date: Thu, 3 Dec 2009 07:29:25 -0800
Message-ID: <6cb013310912030729k2b42e2edqfe7a63f9c046bb89@mail.gmail.com>
References: <e7c6a05e0912030528k1f9c9493y11d55812a054b030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59020 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261AbZLCP3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 10:29:38 -0500
Received: by pwi3 with SMTP id 3so1175424pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 07:29:45 -0800 (PST)
In-Reply-To: <e7c6a05e0912030528k1f9c9493y11d55812a054b030@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thu, Dec 3, 2009 at 5:28 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
>
> Hi,
>
> when make htcherald_defconfig on current linux-omap tree
> (82f1d8f22f2c65e70206e40a6f17688bf64a892c) compilation fails
> in drivers/video/omap/lcd_htcherald.c.
>
> Following patch fixed this problem.

Marek and I talked on IRC about this, and it turns out this is true on
the linux-omap master branch, but for-next compiles without issue,
possibly due to the header changes not having been done on the master
branch yet.

- Cory
