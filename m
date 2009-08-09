From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH v2 0/2] Nokia n8x0 support for mainline
Date: Sun, 9 Aug 2009 13:27:28 +0300
Message-ID: <da94abde0908090327x58937e54g6ada5f2200a679cf@mail.gmail.com>
References: <20090808095404.4829.43749.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53495 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZHIK12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Aug 2009 06:27:28 -0400
Received: by ewy10 with SMTP id 10so2441054ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 09 Aug 2009 03:27:28 -0700 (PDT)
In-Reply-To: <20090808095404.4829.43749.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Sat, Aug 8, 2009 at 12:57 PM, Kalle Valo<kalle.valo@iki.fi> wrote:
> Here's v2 of n8x0 patches. Added proper commit logs and fixed copyright
> years reported by our patch review machine Felipe Balbi :)
>
> I hope these are now ready for mainline. These patches depend on my serial
> omap tag removal patches.

The patches also depend on the patch below, which I sent earlier this week:

Author: Kalle Valo <kalle.valo@iki.fi>
Date:   Fri Aug 7 15:46:30 2009 +0300

    omap2: compile usb-tusb6010.c

    For some reason usb-tusb6010.c was't compiled, add it to Makefile and
    Kconfig. This is prepraration for upcoming n8x0 support.

    Signed-off-by: Kalle Valo <kalle.valo@iki.fi>

Kalle
