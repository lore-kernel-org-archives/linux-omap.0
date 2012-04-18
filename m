From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/9] PM: Create the AVS class of drivers
Date: Wed, 18 Apr 2012 11:29:49 -0700
Message-ID: <87aa28ki5e.fsf@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45527 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537Ab2DRS3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 14:29:51 -0400
Received: by dadq36 with SMTP id q36so11362437dad.8
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 11:29:50 -0700 (PDT)
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 19 Mar 2012 17:12:49 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> AVS is a power management technique which controls the operating

nit: you don't define AVS anywhere here, so those not familiar with the
technique will probably be lost in acronyms.  I suggest you add what it
means after the first use: e.g.  "AVS (Adaptive Voltage Scaling) is
a...."

Kevin
