From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 00:11:34 +0200
Message-ID: <CAMP44s0OvrrWnYJzowkMUT7-jHKYS=LZUty=e1d9gM=OZT-0Ow@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab1LGWLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 17:11:34 -0500
Received: by dadv6 with SMTP id v6so980169dad.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Dec 2011 14:11:34 -0800 (PST)
In-Reply-To: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Given that dm timer framework doesn't support request of clocks
> by soft | hard irqs because some recent changes, tidspbridge needs
> to request its clocks on init and enable/disable them on demand.
>
> This was first seen on 3.2-rc1.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

This looks similar similar to this one:
http://article.gmane.org/gmane.linux.ports.arm.omap/61816

Are you sure this is what we want instead of that one?

Cheers.

-- 
Felipe Contreras
