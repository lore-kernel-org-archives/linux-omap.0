From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Thu, 6 Jan 2011 20:12:49 +0200
Message-ID: <20110106181249.GA2466@acer>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
 <87aajg7dzu.fsf@ti.com>
 <1294181154.18162.39.camel@localhost>
 <20110104231721.GO7771@atomide.com>
 <AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
 <87oc7v1eav.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53694 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1AFSNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:13:55 -0500
Received: by fxm20 with SMTP id 20so16247409fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:13:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87oc7v1eav.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Tony Lindgren <tony@atomide.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Wed, Jan 05, 2011 at 08:54:48AM -0800, Kevin Hilman wrote:
> 
> I had assumed it was recent changes since the patch didn't apply
> cleanly, but am glad to be wrong. :)

The patch should apply cleanly on the latest mainline. Do you want me to
rebase it against some other tree and resend?

Thanks,
MW
